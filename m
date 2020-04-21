Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63BEC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EE9206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T2fTkkrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDUULt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgDUULt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:11:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2C2C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:11:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n24so5663002plp.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZLCRVdOYaY79GBQDd4gM3vbZQs0tBXlYUNi78RGki1I=;
        b=T2fTkkrEZzJgQlNopZ8dWCyn6z5ZG9dtL0+x6LZ0qwj2DC7npigkLQ5s5aYvrRd2eI
         sR+r0pM1IlCG51/H4LK1O+1cBPXMAY14WKcLlVSdYKrJpFVjqtysIyYu3eweorHPLLY4
         4OPw+EuY0yuH8TiPxnQMMJrgTTrv1J2l6Ec6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZLCRVdOYaY79GBQDd4gM3vbZQs0tBXlYUNi78RGki1I=;
        b=WklF/fs/wNrND08no4pfY9883IwoMtn0rq1RCguWEYyqAru7m0AIUwST35AASmu4fF
         lnkS27GvUIkO62ThnKVbtznbvLLOQZqO/Gom6tEzZqunHOrEe7g+yLusI0oEWv+o6h6j
         mKoxbD8vOn+WAmwPhd5mBmyQ6s/U6TKuXbD3e6SKbrzp8y54O/+sffkzK2AV4s6FcfVG
         m8z49ahZFt98Vu/Ig2ddAypy4j2AqKdX+X+8SFkBINiTwX/ViNFfKPFCk2GH8MQhZU1i
         KjGAAB+Rnlc7OEsWtV4sBT9oL6LC179PbXbj4InVs3ors9quuH4e5eMFKJy7bEvC5lPN
         bnTA==
X-Gm-Message-State: AGi0PuYl+BrrNbvw34so0nSUfHZp4NuGFT92q0RAwPPMhlvOCVkOdiO4
        EHTOLCtbq2+kamfE8ZOHNtOgUw==
X-Google-Smtp-Source: APiQypI5nKF/ggrgiXaBayK1l8BLneFcJv1qRWKI53gqpcmK/pmOkkl5D2Twba3yLWbdce99PuhIVg==
X-Received: by 2002:a17:902:444:: with SMTP id 62mr23010683ple.301.1587499908826;
        Tue, 21 Apr 2020 13:11:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w125sm3027860pgw.22.2020.04.21.13.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 13:11:48 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:11:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] objtool: use gelf_getsymshndx to handle >64k sections
Message-ID: <202004211311.EF577DFD13@keescook>
References: <20200421180724.245410-1-samitolvanen@google.com>
 <20200421180724.245410-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421180724.245410-2-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:07:22AM -0700, Sami Tolvanen wrote:
> Currently, objtool fails to load the correct section for symbols when
> the index is greater than SHN_LORESERVE. Use gelf_getsymshndx instead
> of gelf_getsym to handle >64k sections.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/objtool/elf.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 09ddc8f1def3..887445e87380 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -327,12 +327,14 @@ static int read_sections(struct elf *elf)
>  
>  static int read_symbols(struct elf *elf)
>  {
> -	struct section *symtab, *sec;
> +	struct section *symtab, *symtab_shndx, *sec;
>  	struct symbol *sym, *pfunc;
>  	struct list_head *entry;
>  	struct rb_node *pnode;
>  	int symbols_nr, i;
>  	char *coldstr;
> +	Elf_Data *shndx_data = NULL;
> +	Elf32_Word shndx;
>  
>  	symtab = find_section_by_name(elf, ".symtab");
>  	if (!symtab) {
> @@ -340,6 +342,10 @@ static int read_symbols(struct elf *elf)
>  		return -1;
>  	}
>  
> +	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
> +	if (symtab_shndx)
> +		shndx_data = symtab_shndx->data;
> +
>  	symbols_nr = symtab->sh.sh_size / symtab->sh.sh_entsize;
>  
>  	for (i = 0; i < symbols_nr; i++) {
> @@ -353,8 +359,9 @@ static int read_symbols(struct elf *elf)
>  
>  		sym->idx = i;
>  
> -		if (!gelf_getsym(symtab->data, i, &sym->sym)) {
> -			WARN_ELF("gelf_getsym");
> +		if (!gelf_getsymshndx(symtab->data, shndx_data, i, &sym->sym,
> +				      &shndx)) {
> +			WARN_ELF("gelf_getsymshndx");
>  			goto err;
>  		}
>  
> @@ -368,10 +375,13 @@ static int read_symbols(struct elf *elf)
>  		sym->type = GELF_ST_TYPE(sym->sym.st_info);
>  		sym->bind = GELF_ST_BIND(sym->sym.st_info);
>  
> -		if (sym->sym.st_shndx > SHN_UNDEF &&
> -		    sym->sym.st_shndx < SHN_LORESERVE) {
> -			sym->sec = find_section_by_index(elf,
> -							 sym->sym.st_shndx);
> +		if ((sym->sym.st_shndx > SHN_UNDEF &&
> +		     sym->sym.st_shndx < SHN_LORESERVE) ||
> +		    (shndx_data && sym->sym.st_shndx == SHN_XINDEX)) {
> +			if (sym->sym.st_shndx != SHN_XINDEX)
> +				shndx = sym->sym.st_shndx;
> +
> +			sym->sec = find_section_by_index(elf, shndx);
>  			if (!sym->sec) {
>  				WARN("couldn't find section for symbol %s",
>  				     sym->name);
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 

-- 
Kees Cook
