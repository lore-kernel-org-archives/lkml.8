Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CE0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A057D206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxYm9HFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgFBHh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:37:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53632 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725907AbgFBHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591083444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWdIjEOd9/I1E+xgzOUq4yJlQRPtA00peLd2/YfHFQs=;
        b=LxYm9HFHeHfh3VeFwZCxuYABzNOysVgVLZdYABHnptFj2sVxYIvAu3BMjp8fvDAgOkomiK
        v68NQupO0nFIOWEo3zJYpwO0602iAyLCsvUjjlk5OaPRLrs2fQwxmNqNWJl0PBNxREnoV9
        cDg1zduLfq/mw4+L6eqAVyXkIoSWwbE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-m9bOKbgsOMWCjgbwbSdKeQ-1; Tue, 02 Jun 2020 03:37:21 -0400
X-MC-Unique: m9bOKbgsOMWCjgbwbSdKeQ-1
Received: by mail-wr1-f72.google.com with SMTP id a4so1021979wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 00:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EWdIjEOd9/I1E+xgzOUq4yJlQRPtA00peLd2/YfHFQs=;
        b=Oh95QIYlGuvhJnCe1oBZbNiXocqr1Tg+mURYLHk0c1eb0Q2zqBfmrgLpUClEv04uvS
         tFrBk/tIcOAaVdxaTSp7AwtlPvX4O2HCqvKPnqaXq6bN81nDE5tG/iAEf2AlbozeoF4x
         OWi3yxN/SBu1kfmUmtCEv1J4mogzVA//tQUDjh5c7Ajlzt48vlvkqVYOF0AcvM1INh70
         LHDweSxDI6aff4trwP2DK/w+56qaL5ZC64W+QR7MtmdTEiUMuF4jV3eMViUkO7JEv443
         k0oqHGbiVy23/yUCi5nA+cdZAP9lYrB3kpni+VG8HFVXCGJh5f4ssC6NmkvQHxv/ZHDt
         Cjcg==
X-Gm-Message-State: AOAM531ukcpyzbw2fKiCoAb0YHz/M6WDlfUGMv6mlXRmYoB81SWFZ418
        Tyhm69GWMwnTq5XDsFoOxOPJj2brkAQqsBKaKBNoXPD+2AeP27OamEefGhEFahrhYuYx5JbW6eE
        hxa3NJFZpquylsfxKZkif9wOF
X-Received: by 2002:a7b:c204:: with SMTP id x4mr2850694wmi.22.1591083440122;
        Tue, 02 Jun 2020 00:37:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW00SyN3i1y2DE60zidzIbHqpyCIRigSqwfVXBSPi6+8OJ9QWObRrDLiWtsHNYV6O/lEX2WA==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr2848946wmi.22.1591083409945;
        Tue, 02 Jun 2020 00:36:49 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id s8sm2584112wrg.50.2020.06.02.00.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 00:36:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] objtool: Add support for relocations without addends
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1590785960.git.mhelsley@vmware.com>
 <af8b5d5bffc64af00ad88e0b7bd216e91cbfdb36.1590785960.git.mhelsley@vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <a7ce0b8a-557b-01e6-9a0a-d986c3dbd639@redhat.com>
Date:   Tue, 2 Jun 2020 08:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <af8b5d5bffc64af00ad88e0b7bd216e91cbfdb36.1590785960.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 5/29/20 10:01 PM, Matt Helsley wrote:
> Currently objtool only collects information about relocations with
> addends. In recordmcount, which we are about to merge into objtool,
> some supported architectures do not use rela relocations.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> ---
>   tools/objtool/elf.c     | 146 +++++++++++++++++++++++++++++++++++-----
>   tools/objtool/elf.h     |   7 +-
>   tools/objtool/orc_gen.c |   2 +-
>   3 files changed, 135 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index c21e8417637b..5034918494b6 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -490,6 +490,32 @@ void elf_add_reloc(struct elf *elf, struct reloc *reloc)
>   	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
>   }
>   
> +static int read_rel_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
> +{
> +	if (!gelf_getrel(sec->data, i, &reloc->rel)) {
> +		WARN_ELF("gelf_getrel");
> +		return -1;
> +	}
> +	reloc->type = GELF_R_TYPE(reloc->rel.r_info);
> +	reloc->addend = 0;
> +	reloc->offset = reloc->rel.r_offset;
> +	*symndx = GELF_R_SYM(reloc->rel.r_info);
> +	return 0;
> +}
> +
> +static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
> +{
> +	if (!gelf_getrela(sec->data, i, &reloc->rela)) {
> +		WARN_ELF("gelf_getrela");
> +		return -1;
> +	}
> +	reloc->type = GELF_R_TYPE(reloc->rela.r_info);
> +	reloc->addend = reloc->rela.r_addend;
> +	reloc->offset = reloc->rela.r_offset;
> +	*symndx = GELF_R_SYM(reloc->rela.r_info);
> +	return 0;
> +}
> +
>   static int read_relocs(struct elf *elf)
>   {
>   	struct section *sec;
> @@ -499,7 +525,8 @@ static int read_relocs(struct elf *elf)
>   	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
>   
>   	list_for_each_entry(sec, &elf->sections, list) {
> -		if (sec->sh.sh_type != SHT_RELA)
> +		if ((sec->sh.sh_type != SHT_RELA) &&
> +		    (sec->sh.sh_type != SHT_REL))
>   			continue;
>   
>   		sec->base = find_section_by_index(elf, sec->sh.sh_info);
> @@ -519,16 +546,17 @@ static int read_relocs(struct elf *elf)
>   				return -1;
>   			}
>   			memset(reloc, 0, sizeof(*reloc));
> -
> -			if (!gelf_getrela(sec->data, i, &reloc->rela)) {
> -				WARN_ELF("gelf_getrela");
> -				return -1;
> +			switch(sec->sh.sh_type) {
> +			case SHT_REL:
> +				if (read_rel_reloc(sec, i, reloc, &symndx))
> +					return -1;
> +				break;
> +			case SHT_RELA:
> +				if (read_rela_reloc(sec, i, reloc, &symndx))
> +					return -1;
> +				break;
> +			default: return -1;
>   			}
> -
> -			reloc->type = GELF_R_TYPE(reloc->rela.r_info);
> -			reloc->addend = reloc->rela.r_addend;
> -			reloc->offset = reloc->rela.r_offset;
> -			symndx = GELF_R_SYM(reloc->rela.r_info);
>   			reloc->sym = find_symbol_by_index(elf, symndx);
>   			reloc->sec = sec;
>   			if (!reloc->sym) {
> @@ -716,7 +744,38 @@ struct section *elf_create_section(struct elf *elf, const char *name,
>   	return sec;
>   }
>   
> -struct section *elf_create_reloc_section(struct elf *elf, struct section *base)
> +static struct section *elf_create_rel_reloc_section(struct elf *elf, struct section *base)
> +{
> +	char *relocname;
> +	struct section *sec;
> +
> +	relocname = malloc(strlen(base->name) + strlen(".rel") + 1);
> +	if (!relocname) {
> +		perror("malloc");
> +		return NULL;
> +	}
> +	strcpy(relocname, ".rel");
> +	strcat(relocname, base->name);
> +
> +	sec = elf_create_section(elf, relocname, sizeof(GElf_Rel), 0);
> +	free(relocname);
> +	if (!sec)
> +		return NULL;
> +
> +	base->reloc = sec;
> +	sec->base = base;
> +
> +	sec->sh.sh_type = SHT_REL;
> +	sec->sh.sh_addralign = 8;
> +	sec->sh.sh_link = find_section_by_name(elf, ".symtab")->idx;
> +	sec->sh.sh_info = base->idx;
> +	sec->sh.sh_flags = SHF_INFO_LINK;
> +
> +	return sec;
> +}
> +
> +

Nit: Extra new line.

Otherwise:

Reviewed-by: Julien Thierry <jthierry@redhat.com>

-- 
Julien Thierry

