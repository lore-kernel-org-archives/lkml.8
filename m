Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64BBC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B30D20732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCWH10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:27:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgCWH1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:27:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5EF6AC11;
        Mon, 23 Mar 2020 07:27:23 +0000 (UTC)
Date:   Mon, 23 Mar 2020 08:27:22 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        brgerst@gmail.com
Subject: Re: [PATCH v2 17/19] objtool: Optimize !vmlinux.o again
In-Reply-To: <20200321161151.GB3323@worktop.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2003230826570.23992@pobox.suse.cz>
References: <20200317170234.897520633@infradead.org> <20200317170910.819744197@infradead.org> <20200318132025.GH20730@hirez.programming.kicks-ass.net> <alpine.LSU.2.21.2003201719200.21240@pobox.suse.cz> <20200321151421.GD2452@worktop.programming.kicks-ass.net>
 <20200321161151.GB3323@worktop.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Mar 2020, Peter Zijlstra wrote:

> On Sat, Mar 21, 2020 at 04:14:21PM +0100, Peter Zijlstra wrote:
> > On Fri, Mar 20, 2020 at 05:20:47PM +0100, Miroslav Benes wrote:
> > 
> > > I think there is one more missing in create_orc_entry().
> > 
> > I'm thikning you're quite right about that.... lemme see what to do
> > about that.
> 
> ---
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -472,6 +472,14 @@ static int read_symbols(struct elf *elf)
>  	return -1;
>  }
> 
> +void elf_add_rela(struct elf *elf, struct rela *rela)
> +{
> +	struct section *sec = rela->sec;
> +
> +	list_add_tail(&rela->list, &sec->rela_list);
> +	elf_hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
> +}
> +
>  static int read_relas(struct elf *elf)
>  {
>  	struct section *sec;
> @@ -519,8 +527,7 @@ static int read_relas(struct elf *elf)
>  				return -1;
>  			}
> 
> -			list_add_tail(&rela->list, &sec->rela_list);
> -			elf_hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
> +			elf_add_rela(elf, rela);
>  			nr_rela++;
>  		}
>  		max_rela = max(max_rela, nr_rela);
> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -127,6 +127,7 @@ struct section *elf_create_rela_section(
>  int elf_rebuild_rela_section(struct section *sec);
>  int elf_write(struct elf *elf);
>  void elf_close(struct elf *elf);
> +void elf_add_rela(struct elf *elf, struct rela *rela);
> 
>  #define for_each_sec(file, sec)						\
>  	list_for_each_entry(sec, &file->elf->sections, list)
> --- a/tools/objtool/orc_gen.c
> +++ b/tools/objtool/orc_gen.c
> @@ -111,8 +111,7 @@ static int create_orc_entry(struct elf *
>  	rela->offset = idx * sizeof(int);
>  	rela->sec = ip_relasec;
> 
> -	list_add_tail(&rela->list, &ip_relasec->rela_list);
> -	hash_add(elf->rela_hash, &rela->hash, rela_hash(rela));
> +	elf_add_rela(elf, rela);
> 
>  	return 0;
>  }

Yup, looks good.

Miroslav
