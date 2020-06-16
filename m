Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90CFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F38207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WDs3XP+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbgFPSBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730823AbgFPSBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:01:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9460DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:01:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e18so9551511pgn.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5GCoVo3uSDTWQdQpZhO042AIJ0zFlBqyDGrSyWAiePU=;
        b=WDs3XP+J3ALMihggY9JVpUa4ZbnzxJIUYt17zfaqy4aZfhpfFWZ8eisdsc+D9uZ+Qh
         oyrf1b9w/CjZxuNfDOJx8mVHk/fULXeKXDyD7NCRpjnDvNzuTdgoUHBR9BWzOly5em3t
         1gnbPzqoyH/5uuABy4M7C7ROENSCevi+NKSGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5GCoVo3uSDTWQdQpZhO042AIJ0zFlBqyDGrSyWAiePU=;
        b=M8iuNnwzV/w8j6hm/VmVr9pE8OI1ogVLQ2E3rB7EwDK8pGWaUbu/+Kgc62PNlMZhU6
         E9PmPYJmmBM6aKXFfuYFjYHDFuwI5XMcAPigUKgRHOe85SOUYI6+VBNV8laYVMoHH3vK
         oTj/1soi046mTxEuRQC0eFpYq/L8bcr6EDn+YLhkEYxcyj0nNfAqPE8minBX9oMNrLKN
         Dl+kPxKroIavCDNiLY66GtVRbgi3myqSqFTxHXzXWdvIV5ieHLXObd9eFWjrzv9X2aoU
         xscjUM9/xA6Y46Wv2WjmqXmQB9HucyhaQ3aeN3H1+30NTqkgKQ/xIP9PeCLJioqQoU82
         a10g==
X-Gm-Message-State: AOAM533ZCoEBlElJVXXS309ZE0Tf/RGjSnTQNoT7TeGkJUdo4jBGCVyf
        mqCjJn2oeljjoc8iTwin8SpLYg==
X-Google-Smtp-Source: ABdhPJzt1gHmWoNLYadZ8B/Bl+/WxivybW57fLERVIucPwVkj8rz4lMFMIHrw0GZ4ySHeU7bQohkVA==
X-Received: by 2002:a63:124a:: with SMTP id 10mr2942412pgs.336.1592330462065;
        Tue, 16 Jun 2020 11:01:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y3sm17239435pff.37.2020.06.16.11.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:01:01 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:00:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: objtool/core] objtool: Use sh_info to find the base for
 .rela sections
Message-ID: <202006161057.E6D5D84@keescook>
References: <158759428485.28353.15005772572257518607.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158759428485.28353.15005772572257518607.tip-bot2@tip-bot2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 10:24:44PM -0000, tip-bot2 for Sami Tolvanen wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     e2ccbff8f02d6b140b8ee71108264686c19b1c78
> Gitweb:        https://git.kernel.org/tip/e2ccbff8f02d6b140b8ee71108264686c19b1c78
> Author:        Sami Tolvanen <samitolvanen@google.com>
> AuthorDate:    Tue, 21 Apr 2020 11:25:01 -07:00
> Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
> CommitterDate: Tue, 21 Apr 2020 18:49:15 -05:00
> 
> objtool: Use sh_info to find the base for .rela sections
> 
> ELF doesn't require .rela section names to match the base section. Use
> the section index in sh_info to find the section instead of looking it
> up by name.
> 
> LLD, for example, generates a .rela section that doesn't match the base
> section name when we merge sections in a linker script for a binary
> compiled with -ffunction-sections.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Hi!

Where did this commit end up? It seems to have vanished (404 on the
Gitweb link) and isn't in -next nor Linus's tree.

This is needed for LTO, FGKASLR, and link speed improvements[1]. Is it
possible to get this landed in -rc2 so all the things depending on it
can rebase happily?

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/CAK7LNARbZhoaA=Nnuw0=gBrkuKbr_4Ng_Ei57uafujZf7Xazgw@mail.gmail.com/

> ---
>  tools/objtool/elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index c4857fa..c20dfe1 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -468,7 +468,7 @@ static int read_relas(struct elf *elf)
>  		if (sec->sh.sh_type != SHT_RELA)
>  			continue;
>  
> -		sec->base = find_section_by_name(elf, sec->name + 5);
> +		sec->base = find_section_by_index(elf, sec->sh.sh_info);
>  		if (!sec->base) {
>  			WARN("can't find base section for rela section %s",
>  			     sec->name);

-- 
Kees Cook
