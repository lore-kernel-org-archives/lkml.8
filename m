Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C06C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C482071A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="KSvS6x9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgE0W47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0W46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:56:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E511C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:56:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nr22so13633316ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwGU2uQiVzC2IW1d4XSgnAmDLz6dVOd0vO60zHVlzOo=;
        b=KSvS6x9pGnU336XAjSEy2Gk8ZiLnXQf+5DAP7Svh82mYjA1dYIGgElASJQZ12fQTI0
         njv6EpY0sGtmVzQuWlZAv/DApYjfP9FJH4pTeQYSZbDxLJvoeOy9VJsuU8jYZshthfLV
         oW+b9h7z5MNMzG+ZXEbPbQ8zV+q6B/HysBpenZGULORU5qsQ/D0hw+8lSgGTJPG53DAj
         ncwpjAHUWdIS05VTTosKfSEwLAxMmYOKrNoa6v4tUOIDRiySFpHVzBqwpJFDo2P2zOfF
         l27BHoULc166seGg+/gnS+F4Ie2SU9aLgyYxOMIpnSFp5W5PVqZdOuGKBYq48im1D9z1
         nRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwGU2uQiVzC2IW1d4XSgnAmDLz6dVOd0vO60zHVlzOo=;
        b=oo/9sCHrvyqCkGS9hV2F1NwSaY+GEhxMOObG0MuiTN9Atzr1eSDwWXfcWJ0eCkZNIh
         lLi/Pb/1grdJPPeCIAhUzrLSU2PGxYfJZJQL9tQhjcdUgL9Xj21DkR/OYsEvaTPDnPJf
         PsNmkwWg2Bs6reZDshYDZEaGaoNRKvJX5FOob3djgYDpshkwL/UR8ZlYc7FTW2onR4kq
         iLA8a7pnr5oFhm6mQjsd1zYJGTLLmSUSArDSRz9M5S3lfjvBT6lHMwOQrfTQYUQBeahh
         3STaJRz2FEmEDgnQC6yb7LI8hcxA/4RN7npGtq89dqxlkJhN63fyhzEv0WT7nbd7CUPx
         guhw==
X-Gm-Message-State: AOAM532dxKHntrV/oQTLgiO6xCcKw5+3ijUW44Eognu9BQRfytfs2NNt
        9CtYL1a8OIel/a85fbKyzA+mUERc+x/jswHIA4aAkQ==
X-Google-Smtp-Source: ABdhPJzifeTbqLEgFw8mAxsZqyIiMiAysH0JILvagDOdSAmeTZcZsPKvsacGAbZ5HtpGbNjkqmFFEIQEKYYEmRknmzk=
X-Received: by 2002:a17:906:fb0e:: with SMTP id lz14mr491849ejb.237.1590620216822;
 Wed, 27 May 2020 15:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200508180157.1816-1-ardb@kernel.org> <20200508180157.1816-9-ardb@kernel.org>
 <10a1c7fcea861f5d45dff81cba673e970d686bc2.camel@intel.com> <20200527224657.GA3568142@rani.riverdale.lan>
In-Reply-To: <20200527224657.GA3568142@rani.riverdale.lan>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 May 2020 15:56:45 -0700
Message-ID: <CAPcyv4jOCY=kxeZVWsS0Xc36jmPr7DSR_sFrsMeoiEs+iEfbEA@mail.gmail.com>
Subject: Re: [PATCH 08/15] efi/x86: Move command-line initrd loading to efi_main
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "joe@perches.com" <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:47 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, May 27, 2020 at 10:30:18PM +0000, Williams, Dan J wrote:
> > On Fri, 2020-05-08 at 20:01 +0200, Ard Biesheuvel wrote:
> > > From: Arvind Sankar <nivedita@alum.mit.edu>
> > >
> > > Consolidate the initrd loading in efi_main.
> > >
> > > The command line options now need to be parsed only once.
> > >
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > Link:
> > > https://lore.kernel.org/r/20200430182843.2510180-9-nivedita@alum.mit.edu
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Hi,
> >
> > This patch patch in tip/master as:
> >
> > 987053a30016 efi/x86: Move command-line initrd loading to efi_main
> >
> > ...regresses my nfs root configuration. It hangs trying to mount the
> > nfs root filesystem "root=/dev/nfs ip=dhcp".
> >
> > It does not revert cleanly.
> >
> >
>
> Does this fix it?
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index defeb6035109..f53362efef84 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -771,10 +771,12 @@ unsigned long efi_main(efi_handle_t handle,
>                         efi_err("Failed to load initrd!\n");
>                         goto fail;
>                 }
> -               efi_set_u64_split(addr, &hdr->ramdisk_image,
> -                                 &boot_params->ext_ramdisk_image);
> -               efi_set_u64_split(size, &hdr->ramdisk_size,
> -                                 &boot_params->ext_ramdisk_size);
> +               if (size > 0) {
> +                       efi_set_u64_split(addr, &hdr->ramdisk_image,
> +                                         &boot_params->ext_ramdisk_image);
> +                       efi_set_u64_split(size, &hdr->ramdisk_size,
> +                                         &boot_params->ext_ramdisk_size);
> +               }

I'll give it a shot, but my guess would have been something related to
the fact that this patch moves the initrd loading relative to when the
command line is being parsed. In this case it's a dracut initrd built
by:

    dracut -m "nfs network base"

...with a kernel built with:

CONFIG_IP_PNP_DHCP=y

...and a built-in network interface. The behavior seems to be that the
kernel gets an IP address just fine, but there's no initrd userspace
to mount nfs and the kernel eventually gives up looking for root.
