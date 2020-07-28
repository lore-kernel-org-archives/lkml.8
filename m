Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64A1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29012065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BhoOPapJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgG1Txl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgG1Txk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:53:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6A7C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:53:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so10510912ply.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M4QobJGk9dlE330lE7DgROWIsDgwRridwjflFvvj77I=;
        b=BhoOPapJanyvJ0SluMNCkyz+xSdkAZyVwi0sRykgI9PuhjbZxMFkeD3pCMftznEDo/
         yv6RToHZRM9XhatTU1ftPJRDVSGnu/rhtlThDqTrfe2Kn11Ssoo0Df/l8EyjfFhOKOMb
         E2m1RNQPZDk4ejYDhy4NABHcdKbZYDRyVNZi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M4QobJGk9dlE330lE7DgROWIsDgwRridwjflFvvj77I=;
        b=AV3nozsPRtBoDIul2BrjIkxzQmGMDNhzNLWAwmdCF21PF6ah4gog9g8gSeNMZ4Oswf
         22DCiRHvkoPwLfeeSWTKO1X6mYxuNqNurtQwIk8gQ5QAs7nIcPN27zLVbLi902so7wof
         Kfu4OvJ45m0+J3/YSA7XCSd6w6BC7y8YJLyQv1PoSeLgh02JHcUq5E/rvRzR6251vdQj
         YCDsPjvNa9beqygH2BqIrDuNYxGVZv6sl2s5GXaIPATYkso3JVbyJeIzLk44f+V0ZnBf
         T82huoIYu5p8ntC7ZD0x9SnKZS3o5rIGJTtCeW8Wb1nWRA3TxqcmklmqyPnwwKN1SbH6
         hLmA==
X-Gm-Message-State: AOAM531JjY8dVPGwJm4pgG1tN/qcM7CGY81y6RQquZLl3bu9Hy8xNaAO
        Nv94cIXreeDYU3t/b3++qyFIMA==
X-Google-Smtp-Source: ABdhPJwjKdZHkwmjwC85YCbaOdS4pGSZ/aTX5aooDoEqPGYTudrqIHcFVLMAbdSL500eWww7ndQs4Q==
X-Received: by 2002:a17:90a:c207:: with SMTP id e7mr2313446pjt.172.1595966020011;
        Tue, 28 Jul 2020 12:53:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 186sm19096548pfe.1.2020.07.28.12.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:53:38 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:53:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <202007281253.A003D16E62@keescook>
References: <20200727165539.0e8797ab@canb.auug.org.au>
 <20200727101738.GA1923289@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727101738.GA1923289@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 12:17:38PM +0200, Greg KH wrote:
> On Mon, Jul 27, 2020 at 04:55:39PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the driver-core tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > In file included from include/linux/dmi.h:5,
> >                  from drivers/firmware/efi/embedded-firmware.c:8:
> > drivers/firmware/efi/embedded-firmware.c:25:38: error: static declaration of 'efi_embedded_fw_list' follows non-static declaration
> >    25 | EFI_EMBEDDED_FW_VISIBILITY LIST_HEAD(efi_embedded_fw_list);
> >       |                                      ^~~~~~~~~~~~~~~~~~~~
> > include/linux/list.h:24:19: note: in definition of macro 'LIST_HEAD'
> >    24 |  struct list_head name = LIST_HEAD_INIT(name)
> >       |                   ^~~~
> > In file included from drivers/firmware/efi/embedded-firmware.c:17:
> > drivers/firmware/efi/embedded-firmware.h:16:25: note: previous declaration of 'efi_embedded_fw_list' was here
> >    16 | extern struct list_head efi_embedded_fw_list;
> >       |                         ^~~~~~~~~~~~~~~~~~~~
> > drivers/firmware/efi/embedded-firmware.c:26:33: error: static declaration of 'efi_embedded_fw_checked' follows non-static declaration
> >    26 | EFI_EMBEDDED_FW_VISIBILITY bool efi_embedded_fw_checked;
> >       |                                 ^~~~~~~~~~~~~~~~~~~~~~~
> > In file included from drivers/firmware/efi/embedded-firmware.c:17:
> > drivers/firmware/efi/embedded-firmware.h:17:13: note: previous declaration of 'efi_embedded_fw_checked' was here
> >    17 | extern bool efi_embedded_fw_checked;
> >       |             ^~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Caused by commit
> > 
> >   2d38dbf89a06 ("test_firmware: Test platform fw loading on non-EFI systems")
> > 
> > CONFIG_TEST_FIRMWARE=m for this build.
> > 
> > I have used the driver-core tree from next-20200724 for today.
> 
> Thanks, I've reverted this from my tree now.

Ugh, my mistake; sorry for the hassle! I will get this corrected and
re-sent.

-- 
Kees Cook
