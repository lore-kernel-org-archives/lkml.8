Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C30C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B7E206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnUTJulO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgDTSZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:25:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46807 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726838AbgDTSZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587407125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHKvl33Abr0fTYth11HDGBq8eZzlB7XRZhJAHr6xvHU=;
        b=BnUTJulOfS8vvfBqcyfpVcWnBRYlugD2t/aETFK96iPR+tmPXfiK/g9tjMSUhvTxZ6M18K
        CigN/CNVXhD3c7jEjVLN1HLoI5TEzBshWJif7syk3uvYKF77uT0OY/x9mGZq6h8WR/LFRn
        chaoy8K5NBSZdfU01E1HfkQoUhSGC5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-x0b4Iy8sNiq2TcpjLUSREA-1; Mon, 20 Apr 2020 14:25:23 -0400
X-MC-Unique: x0b4Iy8sNiq2TcpjLUSREA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 952C910753F5;
        Mon, 20 Apr 2020 18:25:22 +0000 (UTC)
Received: from treble (ovpn-118-158.rdu2.redhat.com [10.10.118.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C58535D9E5;
        Mon, 20 Apr 2020 18:25:19 +0000 (UTC)
Date:   Mon, 20 Apr 2020 13:25:16 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v2 2/9] livepatch: Apply vmlinux-specific KLP relocations
 early
Message-ID: <20200420182516.6awwwbvoen62gwbr@treble>
References: <cover.1587131959.git.jpoimboe@redhat.com>
 <83eb0be61671eab05e2d7bcd0aa848f6e20087b0.1587131959.git.jpoimboe@redhat.com>
 <20200420175751.GA13807@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200420175751.GA13807@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 01:57:51PM -0400, Joe Lawrence wrote:
> On Fri, Apr 17, 2020 at 09:04:27AM -0500, Josh Poimboeuf wrote:
> > 
> > [ ... snip ... ]
> > 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 40cfac8156fd..5fda3afc0285 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > 
> > [ ... snip ... ]
> > 
> > +int klp_write_relocations(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> > +			  const char *shstrtab, const char *strtab,
> > +			  unsigned int symndx, struct module *pmod,
> > +			  const char *objname)
> >  {
> >  	int i, cnt, ret = 0;
> > -	const char *objname, *secname;
> >  	char sec_objname[MODULE_NAME_LEN];
> >  	Elf_Shdr *sec;
> >  
> > -	if (WARN_ON(!klp_is_object_loaded(obj)))
> > -		return -EINVAL;
> > -
> > -	objname = klp_is_module(obj) ? obj->name : "vmlinux";
> > -
> >  	/* For each klp relocation section */
> > -	for (i = 1; i < pmod->klp_info->hdr.e_shnum; i++) {
> > -		sec = pmod->klp_info->sechdrs + i;
> > -		secname = pmod->klp_info->secstrings + sec->sh_name;
> > +	for (i = 1; i < ehdr->e_shnum; i++) {
> > +		sec = sechdrs + i;
> 
> Hi Josh, minor bug:
> 
> Note the for loop through the section headers in
> klp_write_relocations(), but its calling function ...
> 
> > [ ... snip ... ]
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 646f1e2330d2..d36ea8a8c3ec 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -2334,11 +2334,12 @@ static int apply_relocations(struct module *mod, const struct load_info *info)
> >  		if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC))
> >  			continue;
> >  
> > -		/* Livepatch relocation sections are applied by livepatch */
> >  		if (info->sechdrs[i].sh_flags & SHF_RELA_LIVEPATCH)
> > -			continue;
> > -
> > -		if (info->sechdrs[i].sh_type == SHT_REL)
> > +			err = klp_write_relocations(info->hdr, info->sechdrs,
> > +						    info->secstrings,
> > +						    info->strtab,
> > +						    info->index.sym, mod, NULL);
> > +		else if (info->sechdrs[i].sh_type == SHT_REL)
> >  			err = apply_relocate(info->sechdrs, info->strtab,
> >  					     info->index.sym, i, mod);
> >  		else if (info->sechdrs[i].sh_type == SHT_RELA)
> 
> ... apply_relocations() is also iterating over the section headers (the
> diff context doesn't show it here, but i is an incrementing index over
> sechdrs[]).
> 
> So if there is more than one KLP relocation section, we'll process them
> multiple times.  At least the x86 relocation code will detect this and
> fail the module load with an invalid relocation (existing value not
> zero).

Ah, yes, good catch!

-- 
Josh

