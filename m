Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD04DC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C68C20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjNFeugv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgEEMf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728233AbgEEMf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:35:29 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4CFC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 05:35:27 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z2so1707088iol.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xU2E5RWU+v/O63KwrznJs9ME6XQVHcJaNfzZd/NFGcU=;
        b=QjNFeugvRO/sPhDqDLHDZlvfKXMUjn82ZrSh6In3OuK1a+nHKsJUQNeICDGu6XB5jM
         t5k94Kwr37SVcgq3xxIyqrCTdbd5bLdIk9Qlhn+rJ6N101+nvnwI3M3Ru9eH1EYd53Ea
         2UB+93FxjvS1LHT9AETdpUUugdYs745dt/KUoNrK7DJ4u/ISBVNCLR2q/7DkB70KuW6j
         4sGtDI9S3DSdV0VirRhfGHPOMzuMOkwOtdZL+8V+WtSK+Z/yPyPKAkMW9IhoZfX9riyY
         YeC8xX6mV3MFjTeP/xwvuBm1vIVb13sXd1jM5icwBiqAzDW3i80aYXmxWyrVHge9jbYY
         lCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xU2E5RWU+v/O63KwrznJs9ME6XQVHcJaNfzZd/NFGcU=;
        b=eGiqlUfONTzehBXnWPY6Pk/OLhg+FidzgS8yDYmD3O0qQkW4NpgQuFVZ7p8WcOxsZD
         IjoLysaEBMAnOB8lBpEMGZLDosjA5ZI7Rx15Z6MvcETSkeMyrJELSpo6sKJmKByt2dxT
         qcDLAIm4OYyobYca8jMfP7+78LakuxY2SOflAn0EWMA31dN8DcnAUNtZUmSX9T+LOhMQ
         H+OjclOZUxS7Vgk4whG6kiuqQDSoZbMi2ITfdbv/pe05zploUHFkfWCMLgfsguvQCSIL
         /+8odRpk35cJm5TIzxocnDxZQs3hxUSO4kfAXms+jNjoXnYOb0ePb/u8uq41IreaHuwi
         sIdQ==
X-Gm-Message-State: AGi0PubTTIeySWnm6nbkcnpLHCU2jW1gqafWEBFSfUFJzY/EWWnoQwDu
        G9fA20dW6eZjpiM2VhdprTR2Acz/waRMDrMAnrE=
X-Google-Smtp-Source: APiQypJ2oCsId1Lc2YIzI3C27X9rrLwWndm6CFuY13/7SoqY9rHXmxj4sbnrW5I7LDMSIsHjGk/F9RUxCQyKGjFH4OA=
X-Received: by 2002:a5d:8613:: with SMTP id f19mr3075508iol.173.1588682126509;
 Tue, 05 May 2020 05:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200430130433.11248-1-nsaenzjulienne@suse.de>
 <20200430130433.11248-3-nsaenzjulienne@suse.de> <0958ece3-feda-65c0-b0e2-893e2dfeb508@suse.com>
In-Reply-To: <0958ece3-feda-65c0-b0e2-893e2dfeb508@suse.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Tue, 5 May 2020 13:35:14 +0100
Message-ID: <CALeDE9NhcXUVG-ZyCw_qLvyeA18XhqmEEpgeXD5Wt2+WO93xCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        u-boot@lists.denx.de, bmeng.cn@gmail.com, marex@denx.de,
        linux-kernel@vger.kernel.org, Simon Glass <sjg@chromium.org>,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On 30/04/2020 15:04, Nicolas Saenz Julienne wrote:
> > When needed, RPi4's co-processor (called VideoCore) has to be instructed
> > to load VL805's firmware (the chip providing xHCI support). VideoCore's
> > firmware expects the board's PCIe bus to be already configured in order
> > for it to load the xHCI chip firmware. So we have to make sure this
> > happens in between the PCIe configuration and xHCI startup.
> >
> > Introduce a callback in xhci_pci_probe() to run this platform specific
> > routine.
> >
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >
> > ---
> >
> > Changes since v1:
> >  - Create callback
> >
> >  board/raspberrypi/rpi/rpi.c | 12 ++++++++++++
> >  drivers/usb/host/xhci-pci.c |  6 ++++++
> >  include/usb/xhci.h          |  3 +++
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > index e367ba3092..8aa78d1f48 100644
> > --- a/board/raspberrypi/rpi/rpi.c
> > +++ b/board/raspberrypi/rpi/rpi.c
> > @@ -14,6 +14,7 @@
> >  #include <lcd.h>
> >  #include <memalign.h>
> >  #include <mmc.h>
> > +#include <usb/xhci.h>
> >  #include <asm/gpio.h>
> >  #include <asm/arch/mbox.h>
> >  #include <asm/arch/msg.h>
> > @@ -494,3 +495,14 @@ int ft_board_setup(void *blob, bd_t *bd)
> >
> >       return 0;
> >  }
> > +
> > +#ifdef CONFIG_BCM2711
>
> This won't work with rpi_arm64_defconfig.
> Can't we just evaluate at runtime if we need to do anything in xhci_pci_fixup.
>
> I wonder if the newer RPi4 have also a newer revision ID (see get_board_rev). If
> so we could add another bool to struct rpi_model which will indicate us if we
> need to notify VideoCore about vl805's firmware.

I believe they're ones ending in 03112:
https://github.com/raspberrypi/documentation/tree/master/hardware/raspberrypi/revision-codes
