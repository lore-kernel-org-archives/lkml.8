Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA90ACA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD49D206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fpz/s2Sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgELRFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:05:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30463 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726465AbgELRFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589303099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLHEG7EdM8b0tl+foDcZcXI3wJwu5RrDTNPT3yWr9qc=;
        b=Fpz/s2SyxALH/oz8Oh4wOfxiLOobsEpwCYd08i/BdCXtoN7JT2PDZLPgorg1yzWG4tgtnw
        4b7QAINgI7Auh5VQLCa0P95XrBH26e4VLkyFS3z0sXNbiOz+I2qBEuixk5Er8cFUtvnEQs
        eMTYyweDeSpVxpw8L1tbLl7O0LlHMCI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-tSk2wHEfMfG2YJ1Afgc1Fg-1; Tue, 12 May 2020 13:04:58 -0400
X-MC-Unique: tSk2wHEfMfG2YJ1Afgc1Fg-1
Received: by mail-wr1-f70.google.com with SMTP id x8so7219530wrl.16
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NLHEG7EdM8b0tl+foDcZcXI3wJwu5RrDTNPT3yWr9qc=;
        b=T/UbPkYIDYr1PvxAEp7P/9WtVSBbXdhDo8dp9KbRWaOEz4X66TKPdnujs0CniHU9W4
         ZC+dYleAGNY28JOml435YLoddkX7Yjp9b7iDVzv3ht2PEPtxCMhq0NZtcDK8T3EvAKr6
         AITkEffGOCT4Tep2215vIPSpNRk67w6ZC1lsCqW0VK9Pbdv0+pOW05pyB86si3cGEGg8
         /Bt/zG716jnAkKteca1r3+Sn2o/Y0Ln6tEnIfLmdco/mOc6Y1enP7kH4qo8lKdT8/Cd7
         k1V+0n/jQnElMvoygnHXn2cXRvNmeCKLDAObSgT+13ApHDiyzBFTOpUDLjJ3Obd6atPE
         JcCw==
X-Gm-Message-State: AGi0Pubk7XO7avyoXmyDE0JKjx8Ib/at/fKZfKjaT+GScMD/ueELTYaj
        MZxSsPOSqcQ2bNxS1EcHkJLYAsTwA2lh8HLMsUUE5cvvL6D0bwwfh5B2VgThR0TRwQ30xpn5DYN
        pHpRPI2i6y4ECuN3ahdgbDocg
X-Received: by 2002:a1c:a557:: with SMTP id o84mr18315898wme.165.1589303093649;
        Tue, 12 May 2020 10:04:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypJCSS5zTIBv0mTZ4ZIgMNO70Idi5Bfhl/WvMyOE2irH8sMqN+FY4cw7au7hHhUFFJfTcalw8g==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr18315879wme.165.1589303093421;
        Tue, 12 May 2020 10:04:53 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id n13sm3379791wrs.2.2020.05.12.10.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 10:04:52 -0700 (PDT)
Subject: Re: [RFC][PATCH 3/5] objtool: Add support for relocations without
 addends
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <17ee3f6f2a246008aaae70f92df24ae92fa0e21e.1588888003.git.mhelsley@vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <f79a3872-b9ad-a966-71fb-4451e0901281@redhat.com>
Date:   Tue, 12 May 2020 18:04:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <17ee3f6f2a246008aaae70f92df24ae92fa0e21e.1588888003.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 5/11/20 6:35 PM, Matt Helsley wrote:
> Currently objtool only collects information about relocations with
> addends. In recordmcount, which we are about to merge into objtool,
> some supported architectures do not use rela relocations. Since
> object files use one or the other the list can be reused.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> ---
>   tools/objtool/elf.c | 55 ++++++++++++++++++++++++++++++++++++---------
>   tools/objtool/elf.h |  5 ++++-
>   2 files changed, 49 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index c4857fa3f1d1..cd841e3df87d 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -465,12 +465,14 @@ static int read_relas(struct elf *elf)
>   	unsigned long nr_rela, max_rela = 0, tot_rela = 0;
>   
>   	list_for_each_entry(sec, &elf->sections, list) {
> -		if (sec->sh.sh_type != SHT_RELA)
> +		if ((sec->sh.sh_type != SHT_RELA) &&
> +		     (sec->sh.sh_type != SHT_REL))
>   			continue;
>   
> -		sec->base = find_section_by_name(elf, sec->name + 5);
> +		sec->base = find_section_by_name(elf, sec->name +
> +				((sec->sh.sh_type != SHT_REL) ? 5 : 4));
>   		if (!sec->base) {
> -			WARN("can't find base section for rela section %s",
> +			WARN("can't find base section for relocation section %s",
>   			     sec->name);
>   			return -1;
>   		}
> @@ -486,13 +488,26 @@ static int read_relas(struct elf *elf)
>   			}
>   			memset(rela, 0, sizeof(*rela));
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
>   			}
>   
>   			rela->type = GELF_R_TYPE(rela->rela.r_info);
> -			rela->addend = rela->rela.r_addend;
>   			rela->offset = rela->rela.r_offset;
>   			symndx = GELF_R_SYM(rela->rela.r_info);
>   			rela->sym = find_symbol_by_index(elf, symndx);
> @@ -717,17 +732,27 @@ int elf_rebuild_rela_section(struct section *sec)
>   	struct rela *rela;
>   	int nr, idx = 0, size;
>   	GElf_Rela *relas;
> +	GElf_Rel *rels;
>   
>   	nr = 0;
>   	list_for_each_entry(rela, &sec->rela_list, list)
>   		nr++;
>   
> +	/*
> +	 * Allocate a buffer for relocations with addends but also use
> +	 * it for other relocations too. The section type determines
> +	 * the size of the section, the buffer used, and the entries.
> +	 */
>   	size = nr * sizeof(*relas);
>   	relas = malloc(size);
>   	if (!relas) {
>   		perror("malloc");
>   		return -1;
>   	}
> +	rels = (void *)relas;
> +	if (sec->sh.sh_type == SHT_REL) {
> +		size = nr * sizeof(*rels);
> +	}

This looks a bit error prone to me.

What about having:

     void *rel_buf;
     [...]
     size = nr * (sec->sh.sh_type == SHT_REL ? sizeof(GElf_Rel) : 
sizeof(GElf_Rela));
     rel_buf = malloc(size);
     [...]

And then casting rel_buf to the correct pointer type in the fitting 
switch cases?

>   
>   	sec->data->d_buf = relas;
>   	sec->data->d_size = size;
> @@ -736,9 +761,19 @@ int elf_rebuild_rela_section(struct section *sec)
>   
>   	idx = 0;
>   	list_for_each_entry(rela, &sec->rela_list, list) {
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
>   		idx++;
>   	}
>   
> diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
> index 0b79c2353a21..71bd47055963 100644
> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -61,7 +61,10 @@ struct symbol {
>   struct rela {
>   	struct list_head list;
>   	struct hlist_node hash;
> -	GElf_Rela rela;
> +	union {
> +		GElf_Rela rela;
> +		GElf_Rel  rel;
> +	};
>   	struct section *sec;
>   	struct symbol *sym;
>   	unsigned int type;
> 

-- 
Julien Thierry

