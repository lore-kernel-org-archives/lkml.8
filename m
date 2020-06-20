Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1060C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66F022515
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDoK69EO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgFTADs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgFTADr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:03:47 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B12C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 17:03:46 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a21so9980941oic.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 17:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUI/X+XaTy7YmlY8/Qle+Cm+8V+wGNkORO/Z4T3Yg6c=;
        b=XDoK69EOzxRswhIIvqCsXZZe2WxOXmHjchm+/+v0VavaeK3M8YsjMlVk5lpYcx31ut
         7jfx2Aa6OheFZDeUAqkQAO5vNpfwqz2c75R1dG/hPd6q4ncNxNTBXV09aqOv7beUi9hk
         AG0cpAoc+9yMqEHn+GB5zLHlBrj642tDbbUUfNVqvKXub/L3/UDZRMdIocOlS4oE05W0
         EVfzuXrD6B6TMWnxDD5u9s6vdjLWVRW4w6cc+WcL01cOIg9YdhDoZfms02mWO1rNCbic
         HK2IY+OKWjHGv1e+Y0GPNwmEd81wqhZHqsw15ekzKWZCd2u8xVpcYKw2ctyL5lUm8psC
         wkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUI/X+XaTy7YmlY8/Qle+Cm+8V+wGNkORO/Z4T3Yg6c=;
        b=LJHV/ewabCq2iFypOv5ERfJf2wC6G7wGorDt5E3BY/OqC8Offq2i6bVO++RBmqkf5g
         QXGVj8dkaApR1th93mTfLmPxYKFgE86C7km/PMgOsCkOhhxhi3JpEpY6mwMS0pCfZwIk
         o52caXIkK6fzeighFH7243QmznFj0BKdLtfnrpOn4lBiD7vA67BXdVsCKvV12n34pplv
         hXFiJfHUv0ATpujwr+p4NcDFcy0vYECTVXreGuOR2DlDHo0YUQ/B1hOxt5bNOxFKOmyd
         iFPbuYU7b6P3PLvh0o1JkEzl1e6ssxZGBkrYT88ddWr2knUmbFBALrI8s9/4Jmm8Q+Pl
         gXiw==
X-Gm-Message-State: AOAM532o+XOOT5IWxxeA3n4EMVA1LWajCnuXg2vT52zSJS/TRVwlYP1t
        +7KlQAuAfSvi6xrfF70EI/INVuLybWBarLlymoB3mdS6
X-Google-Smtp-Source: ABdhPJyXDd7seVZuiR6wa/dtfPfxpjuJHr2K/zZ9ksF9esu3zHVqE/ho3MrBqjoPbDePB9VCMDFg9ZcuW0Eqg//TC00=
X-Received: by 2002:aca:75c1:: with SMTP id q184mr4912191oic.49.1592611424062;
 Fri, 19 Jun 2020 17:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200619143056.24538-1-trini@konsulko.com>
In-Reply-To: <20200619143056.24538-1-trini@konsulko.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Fri, 19 Jun 2020 17:03:33 -0700
Message-ID: <CAP6exY+oyEXt3YGf-f8vwwbQSMkokz=MsWazaekA4F0ZDo1qoQ@mail.gmail.com>
Subject: Re: [PATCH] initrd: Remove erroneous comment
To:     Tom Rini <trini@konsulko.com>
Cc:     lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems fine to me, but I did not initially object to the use of that
name anyway. hpa, what do you think?

On Fri, Jun 19, 2020 at 7:31 AM Tom Rini <trini@konsulko.com> wrote:
>
> Most architectures have been passing the location of an initrd via the
> initrd= option since their inception.  Remove the comment as it's both
> wrong and unrelated to the commit that introduced it.
>
> Fixes: 694cfd87b0c8 ("x86/setup: Add an initrdmem= option to specify initrd physical address")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: H. Peter Anvin (Intel) <hpa@zytor.com>
> Cc: Ronald G. Minnich <rminnich@gmail.com>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> For a bit more context, I assume there's been some confusion between
> "initrd" being a keyword in things like extlinux.conf and also that for
> quite a long time now initrd information is passed via device tree and
> not the command line on relevant architectures.  But it's still true
> that it's been a valid command line option to the kernel since the 90s.
> It's just the case that in 2018 the code was consolidated from under
> arch/ and in to this file.
> ---
>  init/do_mounts_initrd.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
> index d72beda824aa..53314d7da4be 100644
> --- a/init/do_mounts_initrd.c
> +++ b/init/do_mounts_initrd.c
> @@ -45,11 +45,6 @@ static int __init early_initrdmem(char *p)
>  }
>  early_param("initrdmem", early_initrdmem);
>
> -/*
> - * This is here as the initrd keyword has been in use since 11/2018
> - * on ARM, PowerPC, and MIPS.
> - * It should not be; it is reserved for bootloaders.
> - */
>  static int __init early_initrd(char *p)
>  {
>         return early_initrdmem(p);
> --
> 2.17.1
>
