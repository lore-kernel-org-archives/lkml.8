Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A3DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5493A206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InESy3K+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgEOUdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:33:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26407 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgEOUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589574824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0URSfyjQn+MHlcb800j3Sa3BIzicVCgeHSk6dmzRT8=;
        b=InESy3K+u8jzOQ6CX/pr6qE/0SnI6NssTCnmlSqSeI47uHbHdvh3XKI3P+4eOrXhSA2/CU
        tn0shBUDb+quGkQ6vswygCVGlayuZ+WvWeb5PQiqo6CVc6v03g6Yn5VJ6bAOb/sh35NjgI
        q0OOBOg/BYnu9ajbk8gUsXbH6+wEris=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-9teukHFTM2KeaYrqquK1iw-1; Fri, 15 May 2020 16:33:42 -0400
X-MC-Unique: 9teukHFTM2KeaYrqquK1iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B13418A0760;
        Fri, 15 May 2020 20:33:41 +0000 (UTC)
Received: from treble (ovpn-117-151.rdu2.redhat.com [10.10.117.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B1BA5D9D3;
        Fri, 15 May 2020 20:33:40 +0000 (UTC)
Date:   Fri, 15 May 2020 15:33:38 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 3/5] objtool: Add support for relocations without
 addends
Message-ID: <20200515203338.ehdgnvh7nqcczj4t@treble>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <17ee3f6f2a246008aaae70f92df24ae92fa0e21e.1588888003.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17ee3f6f2a246008aaae70f92df24ae92fa0e21e.1588888003.git.mhelsley@vmware.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:35:11AM -0700, Matt Helsley wrote:
> Currently objtool only collects information about relocations with
> addends. In recordmcount, which we are about to merge into objtool,
> some supported architectures do not use rela relocations. Since
> object files use one or the other the list can be reused.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> ---
>  tools/objtool/elf.c | 55 ++++++++++++++++++++++++++++++++++++---------
>  tools/objtool/elf.h |  5 ++++-
>  2 files changed, 49 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index c4857fa3f1d1..cd841e3df87d 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -465,12 +465,14 @@ static int read_relas(struct elf *elf)

This should probably be called read_relocs() now.

And 'struct rela' should probably be 'struct reloc'.  And I hate to say
it but all the 'rela' based variable/function names should also probably
be changed...

All the renaming might be disruptive for backports, but still I think it
would be a good idea.  It probably belongs in its own commit.  If it can
be done programmatically with 'sed -i' or so, with the exact command in
the commit log, even better :-)

>  	unsigned long nr_rela, max_rela = 0, tot_rela = 0;
>  
>  	list_for_each_entry(sec, &elf->sections, list) {
> -		if (sec->sh.sh_type != SHT_RELA)
> +		if ((sec->sh.sh_type != SHT_RELA) &&
> +		     (sec->sh.sh_type != SHT_REL))
>  			continue;

The alignment is slightly off, should be:

		if ((sec->sh.sh_type != SHT_RELA) &&
		    (sec->sh.sh_type != SHT_REL))
			continue;

>  
> -		sec->base = find_section_by_name(elf, sec->name + 5);
> +		sec->base = find_section_by_name(elf, sec->name +
> +				((sec->sh.sh_type != SHT_REL) ? 5 : 4));

I think there's actually a cleaner way to do this, which we probably
should have been doing in the first place:

		sec->base = find_section_by_index(elf, sec->sh.sh_info);

(completely not tested, btw)

> @@ -486,13 +488,26 @@ static int read_relas(struct elf *elf)
>  			}
>  			memset(rela, 0, sizeof(*rela));
>  
> -			if (!gelf_getrela(sec->data, i, &rela->rela)) {
> -				WARN_ELF("gelf_getrela");
> -				return -1;
> +			switch(sec->sh.sh_type) {
> +			case SHT_REL:
> +				if (!gelf_getrel(sec->data, i, &rela->rel)) {
> +					WARN_ELF("gelf_getrel");
> +					return -1;
> +				}
> +				rela->addend = 0;
> +				break;
> +			case SHT_RELA:
> +				if (!gelf_getrela(sec->data, i, &rela->rela)) {
> +					WARN_ELF("gelf_getrela");
> +					return -1;
> +				}
> +				rela->addend = rela->rela.r_addend;
> +				break;
> +			default:
> +				break;

The default should never happen, but might as well return -1 for extra
robustness.

> @@ -717,17 +732,27 @@ int elf_rebuild_rela_section(struct section *sec)
>  	struct rela *rela;
>  	int nr, idx = 0, size;
>  	GElf_Rela *relas;
> +	GElf_Rel *rels;
>  
>  	nr = 0;
>  	list_for_each_entry(rela, &sec->rela_list, list)
>  		nr++;
>  
> +	/*
> +	 * Allocate a buffer for relocations with addends but also use
> +	 * it for other relocations too. The section type determines
> +	 * the size of the section, the buffer used, and the entries.
> +	 */
>  	size = nr * sizeof(*relas);
>  	relas = malloc(size);
>  	if (!relas) {
>  		perror("malloc");
>  		return -1;
>  	}
> +	rels = (void *)relas;
> +	if (sec->sh.sh_type == SHT_REL) {
> +		size = nr * sizeof(*rels);
> +	}
>  
>  	sec->data->d_buf = relas;
>  	sec->data->d_size = size;
> @@ -736,9 +761,19 @@ int elf_rebuild_rela_section(struct section *sec)
>  
>  	idx = 0;
>  	list_for_each_entry(rela, &sec->rela_list, list) {
> -		relas[idx].r_offset = rela->offset;
> -		relas[idx].r_addend = rela->addend;
> -		relas[idx].r_info = GELF_R_INFO(rela->sym->idx, rela->type);
> +		switch(sec->sh.sh_type) {
> +		case SHT_REL:
> +			rels[idx].r_offset = rela->offset;
> +			rels[idx].r_info = GELF_R_INFO(rela->sym->idx, rela->type);
> +			break;
> +		case SHT_RELA:
> +			relas[idx].r_addend = rela->addend;
> +			relas[idx].r_offset = rela->offset;
> +			relas[idx].r_info = GELF_R_INFO(rela->sym->idx, rela->type);
> +			break;
> +		default:
> +			break;
> +		}
>  		idx++;

There's a lot of trickiness going on here, in a valiant attempt to share
code, but really most of the code ends up not being shared anyway.

I think it would be a lot cleaner to just create a new "rel" version of
this function.

Then there could be a top-level

	elf_rebuild_reloc_section()

which calls the appropriate "rel" or "rela" variant.

-- 
Josh

