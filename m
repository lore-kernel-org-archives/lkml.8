Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412E1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B54820707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbgFOSet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:34:49 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:43909 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729124AbgFOSet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:34:49 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 15 Jun 2020 11:34:48 -0700
Received: from localhost (unknown [10.200.193.92])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id EB10A1B8009;
        Mon, 15 Jun 2020 14:34:48 -0400 (EDT)
Date:   Mon, 15 Jun 2020 11:34:48 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <dvyukov@google.com>, <elver@google.com>, <andreyknvl@google.com>,
        <mark.rutland@arm.com>, <rostedt@goodmis.org>,
        <jthierry@redhat.com>, <mbenes@suse.cz>
Subject: Re: [RFC][PATCH 1/3] objtool: Clean up elf_write() condition
Message-ID: <20200615183448.GD25598@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, dvyukov@google.com, elver@google.com,
        andreyknvl@google.com, mark.rutland@arm.com, rostedt@goodmis.org,
        jthierry@redhat.com, mbenes@suse.cz
References: <20200612143034.933422660@infradead.org>
 <20200612143553.953897818@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200612143553.953897818@infradead.org>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 04:30:35PM +0200, Peter Zijlstra wrote:
> With there being multiple ways to change the ELF data, let's more
> concisely track modification.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Would it make sense to set the relocation section's "changed" flag in
addition to the elf struct's changed flag in elf_rebuild_reloc_section()?

Right now I think the code is  assuming that it's a newly created section
but it would be more defensive to set it during a rebuild too I think.

Otherwise looks good to me.

> ---
>  tools/objtool/check.c |    2 ++
>  tools/objtool/elf.c   |    8 +++++++-
>  tools/objtool/elf.h   |    3 ++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2779,7 +2779,9 @@ int check(const char *_objname, bool orc
>  		ret = create_orc_sections(&file);
>  		if (ret < 0)
>  			goto out;
> +	}
>  
> +	if (file.elf->changed) {
>  		ret = elf_write(file.elf);
>  		if (ret < 0)
>  			goto out;
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -746,6 +746,8 @@ struct section *elf_create_section(struc
>  	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
>  	elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
>  
> +	elf->changed = true;
> +
>  	return sec;
>  }
>  
> @@ -862,7 +864,7 @@ int elf_rebuild_reloc_section(struct sec
>  	return elf_rebuild_rela_section(sec, nr);
>  }
>  
> -int elf_write(const struct elf *elf)
> +int elf_write(struct elf *elf)
>  {
>  	struct section *sec;
>  	Elf_Scn *s;
> @@ -879,6 +881,8 @@ int elf_write(const struct elf *elf)
>  				WARN_ELF("gelf_update_shdr");
>  				return -1;
>  			}
> +
> +			sec->changed = false;
>  		}
>  	}
>  
> @@ -891,6 +895,8 @@ int elf_write(const struct elf *elf)
>  		return -1;
>  	}
>  
> +	elf->changed = false;
> +
>  	return 0;
>  }
>  
> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -79,6 +79,7 @@ struct elf {
>  	Elf *elf;
>  	GElf_Ehdr ehdr;
>  	int fd;
> +	bool changed;
>  	char *name;
>  	struct list_head sections;
>  	DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
> @@ -121,7 +122,7 @@ struct elf *elf_open_read(const char *na
>  struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
>  struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
>  void elf_add_reloc(struct elf *elf, struct reloc *reloc);
> -int elf_write(const struct elf *elf);
> +int elf_write(struct elf *elf);
>  void elf_close(struct elf *elf);
>  
>  struct section *find_section_by_name(const struct elf *elf, const char *name);
> 
> 
