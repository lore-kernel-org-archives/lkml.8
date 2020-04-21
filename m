Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855EFC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618352072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jwIdppR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDUUHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgDUUHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:07:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC03EC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:07:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j7so3712080pgj.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pWKxxgFRfnsF+4l9GKAXNDzmfYjij2q89EepXiRZFL0=;
        b=jwIdppR+DUefzU0GnGykZeZu7kOWWJ/reiq6H9pgpuRK4DmnIiTZrud7Fji6th1z5i
         Ye10x8qXqiJKei1Nsh6M0sZ8uAM1mhAGxoMJa3a+BVV9bPT74R0h56tlhcvTzfoM+hMK
         4OcAtCzTV9xAkO+QRV8ITzwy2dRMiAdTVe2uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pWKxxgFRfnsF+4l9GKAXNDzmfYjij2q89EepXiRZFL0=;
        b=XaMSaPlqWZx1fMMJV1t6J0HTuTcVgAOLooQvBsyYyD1k4w6hQGDPlqxB+7V07liTF4
         JmBZBKj7n4k+++sYHcl9nWXqzlAtX4h8MNM0AXjD9qgUTxtWYzxEoNwCHi5Eqeg1UhPw
         bU1BB/y5IHnhYmGpVfwUd2gIIcZJ95E6dU/gpgPWLXKbDtgZwRJ2j9po+b6eAg/SxL6j
         Mj+rvaO7i7R+CLPkuqE4To8TEBf+abOaOaE6JU25iE1G3OQHZ5RbHfSuPe1gXhwj7B8i
         JScT34vNHgwLawnVlb1uaHryys9byVZdzMesY2fiKpFTnqqClpSIQwAI+VqoNWadeSKw
         VOmw==
X-Gm-Message-State: AGi0Pubfx7O+EpsGxDPVCN3oiDagIY/Zd7HsSppuAUXqBnl/WtdMdS5x
        7HekOG/+mGZAxVxENB+BxMup6A==
X-Google-Smtp-Source: APiQypIR99wXeLGnGhV4Ds5DnUaCtWxjJ9pFAlirYL1hu1Aw+kKSDT3RGu5fEVexzE5VP5jW0a/sqg==
X-Received: by 2002:aa7:819a:: with SMTP id g26mr8876857pfi.193.1587499673330;
        Tue, 21 Apr 2020 13:07:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 135sm3208617pfx.58.2020.04.21.13.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 13:07:52 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:07:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: use sh_info to find the base for .rela sections
Message-ID: <202004211307.C8E3AC87@keescook>
References: <20200421182501.149101-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421182501.149101-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:25:01AM -0700, Sami Tolvanen wrote:
> ELF doesn't require .rela section names to match the base section. Use
> the section index in sh_info to find the section instead of looking it
> up by name.
> 
> LLD, for example, generates a .rela section that doesn't match the base
> section name when we merge sections in a linker script for a binary
> compiled with -ffunction-sections.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/objtool/elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 09ddc8f1def3..73cfe45975c8 100644
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
> 
> base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 

-- 
Kees Cook
