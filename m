Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E70C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8648020714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCQLzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:55:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:33474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgCQLzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:55:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1877FAC5B;
        Tue, 17 Mar 2020 11:55:02 +0000 (UTC)
Date:   Tue, 17 Mar 2020 12:55:01 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 05/16] objtool: Optimize find_symbol_by_index()
In-Reply-To: <20200312135041.699859794@infradead.org>
Message-ID: <alpine.LSU.2.21.2003171253180.2339@pobox.suse.cz>
References: <20200312134107.700205216@infradead.org> <20200312135041.699859794@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -27,7 +27,6 @@ struct section {
>  	struct list_head list;
>  	GElf_Shdr sh;
>  	struct list_head symbol_list;
> -	DECLARE_HASHTABLE(symbol_hash, 8);
>  	struct list_head rela_list;
>  	DECLARE_HASHTABLE(rela_hash, 16);
>  	struct section *base, *rela;
> @@ -71,7 +70,7 @@ struct elf {
>  	int fd;
>  	char *name;
>  	struct list_head sections;
> -	DECLARE_HASHTABLE(rela_hash, 16);
> +	DECLARE_HASHTABLE(symbol_hash, 20);
>  };

Not that it really matters, but what was rela_hash in struct elf for 
before this?

Miroslav
