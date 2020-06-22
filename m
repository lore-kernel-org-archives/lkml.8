Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17069C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA582076A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1DlWOIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgFVUCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgFVUC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:02:28 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4867DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:02:28 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s13so14201315otd.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlYKYXzcMv9BOPw1annEKLuHXEQQjMbSoxaUi+SHOLc=;
        b=a1DlWOIFce+lAwR9uUnCAaEdNUPzRDELBo3GobG/t4Q+sUpyoCJht8jshG1hqpAlWI
         wJUMVq+s9I5abhW13Mnkw6fMzEuC7otNASbPgnZPUp3Up9hzUudS3AB/SoXjQuvVSIRx
         x8O5WT5bmaSiFj4R09vAr7aG6InGEa5JUVU9mm+nmOlpSKhDlsjSe+RyArqpzT1H3RuK
         tLoxQP4HEKImhvYk+Py0UpbGvr50L66L6hgAZCH4fcXq4vnI+lTPXuKzELmJGggm8GR7
         jHaJ5WXa4VYFcnRLqilmTQAgJv/x0VzLc75ZpuLeSOe7m4gj1GrV/n0gw72myXxagRRi
         o9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlYKYXzcMv9BOPw1annEKLuHXEQQjMbSoxaUi+SHOLc=;
        b=ttKq3iOumUYCM1fTXZd8wUild5TXbAYs2UUNWYUSn3lPVw+sCi1vGbUhXwCLuBBp3k
         YDqd4g8/vXE7NV44JWkrQfZMKxS3+34q2E3r5eriPRhH/+ofzpB687jGgHDjf/j/iOSI
         oamhJmk0buKdX0r33EDurqklMLOffcpe+mMVyJhT+88y+FsuebhwnT3/8b8tjlMrskwh
         uifTk2IZEUzCaxKhdXb6Li+p0jVIYRHZjI/odU/kbP7XZEZy5SxiI2K0DBB+Gfj32kNj
         i4TgQ98EOXb4g0o2VEPspDv3g5tTLnhCJv2DuHg6Zp2+IjJcmNG3IAYCbU7FDhKf66NV
         K5Eg==
X-Gm-Message-State: AOAM5319yEZSJsBk2HzY7RnrRIYBYfO7h5UyZJSXSpbuOk1PmbKCDz8T
        W+KJAUSYBK6OVQCPJ1ITFuou62mC3bYzSPWMoL74v81qSnE=
X-Google-Smtp-Source: ABdhPJw9iMpvNLp/TRxRoZmJOlM7QF3eTJlY6d4DZ3NjVE9nvNFE1yhiDkcHC4tSBPGGKwanZYXFmZdToTpf7zr+TmE=
X-Received: by 2002:a9d:1722:: with SMTP id i34mr14357502ota.6.1592856147416;
 Mon, 22 Jun 2020 13:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200619143056.24538-1-trini@konsulko.com>
In-Reply-To: <20200619143056.24538-1-trini@konsulko.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Mon, 22 Jun 2020 13:02:16 -0700
Message-ID: <CAP6exYJ64Hy9y3Dzh9Asrq8Y0oDWYk+tf4UAcasEc-ZxTY8DAw@mail.gmail.com>
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

The other thing you ought to consider fixing:
initrd is documented as follows:

        initrd=         [BOOT] Specify the location of the initial ramdisk

for bootloaders only.

UEFI consumes initrd from the command line as well. As ARM servers
increasingly use UEFI, there may be situations in which the initrd
option doesn't make its way to the kernel? I don't know, UEFI is such
a black box to me. But I've seen this "initrd consumption" happen.

Based on docs, and the growing use of bootloaders that are happy to
consume initrd= and not pass it to the kernel, you might be better off
trying to move to the new command line option anyway.

IOW, this comment may not be what people want to see, but ... it might
also be right. Or possibly changed to:

/*
 * The initrd keyword is in use today on ARM, PowerPC, and MIPS.
 * It is also reserved for use by bootloaders such as UEFI and may
 * be consumed by them and not passed on to the kernel.
 * The documentation also shows it as reserved for bootloaders.
 * It is advised to move to the initrdmem= option whereever possible.
 */

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
