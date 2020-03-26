Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9813C2D0EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D1920848
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J3jrCa0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgCZPkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:40:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44728 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgCZPkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:40:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id i16so6379247edy.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VQc7P8VY+5XsYW/q9fSaKw3tAVjuhPWecyw2BKtLuE=;
        b=J3jrCa0tFr4pwLXuXWbuCGiOBBZpWlVmlwn1FsYpqmHmJE3e83vXUWsqu4NQ4nX0MT
         t2NPbVEay6HMFtgrvQXYGz5cgSR+ZS6BfeiJA8mQO1TMiCrfU8rFfwq03L5XeH8a8a/V
         Xzc4GCiOCh7S6cmmyTQ97kHpFqVlo5FgHwHn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VQc7P8VY+5XsYW/q9fSaKw3tAVjuhPWecyw2BKtLuE=;
        b=aPs7kuQUMsSureLUcyGQ0Km3SMdi4aLh2k99Q8wtsNbZk0AimUldVMmMkdO5XRBjzs
         /XxSD2Ynf0VgRngCazZlhl0hJV1vPMUNBQqCykfaFn0BRloRLMowUV91xNFqJsIwvQIQ
         5inTEA3Ck/AfDiz+JHC8KjjyWrNCdCKJZdOoMrRGbvQopXWElkFbds6FIwCMgkNIUDJ7
         v3h3TummbWJuYLOKMK2ODaGrmbFtADmpxYKNH4SKaRiInZFjRY1AwaiZSFOHQ4QMC5ti
         1vBF3bcf+xVy9X1m63VvzJLRGuIiuigMu+rnbMyCNBTfnhTyEyN1IVaz58aoqElUmSg8
         VPkQ==
X-Gm-Message-State: ANhLgQ3+UwIxtHcAt5FYgnROO9cvvpfQqQ4kC5D5DuotelqTzTNGuI3g
        ECVG9zl8gLqx0DBjastiKeYzeDnBTj287iEOe2JPxA==
X-Google-Smtp-Source: ADFU+vsJp1fQnpYw9Capue287rBN86xbyCVnw5heNA1CFBWynQnZYV9F3U+M+h6o+gbtj6xxJpvFgkswkFldUAadwGo=
X-Received: by 2002:a17:906:d18e:: with SMTP id c14mr8569496ejz.120.1585237235110;
 Thu, 26 Mar 2020 08:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <1585206447-1363-3-git-send-email-srinath.mannam@broadcom.com> <20200326153318.GA11697@google.com>
In-Reply-To: <20200326153318.GA11697@google.com>
From:   Roman Bacik <roman.bacik@broadcom.com>
Date:   Thu, 26 Mar 2020 08:38:30 -0700
Message-ID: <CAGQAs7xFY2Xp5fWBMFtzLDpP4zMFUNsddYXQk7QC0OS3oozXtw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: iproc: fix invalidating PAXB address mapping
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 8:33 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Mar 26, 2020 at 12:37:26PM +0530, Srinath Mannam wrote:
> > From: Roman Bacik <roman.bacik@broadcom.com>
> >
> > Second stage bootloader prior to Linux boot may use all inbound windows
> > including IARR1/IMAP1. We need to ensure all previous configuration of
> > inbound windows are invalidated during the initialization stage of the
> > Linux iProc PCIe driver. Add fix to invalidate IARR1/IMAP1 because it was
> > missed in previous patch.
> >
> > Fixes: 9415743e4c8a ("PCI: iproc: Invalidate PAXB address mapping")
> > Signed-off-by: Roman Bacik <roman.bacik@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index 6972ca4..e7f0d58 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -351,6 +351,8 @@ static const u16 iproc_pcie_reg_paxb_v2[IPROC_PCIE_MAX_NUM_REG] = {
> >       [IPROC_PCIE_OMAP3]              = 0xdf8,
> >       [IPROC_PCIE_IARR0]              = 0xd00,
> >       [IPROC_PCIE_IMAP0]              = 0xc00,
> > +     [IPROC_PCIE_IARR1]              = 0xd08,
> > +     [IPROC_PCIE_IMAP1]              = 0xd70,
>
> And paxb_v2_ib_map[] has a comment saying "IARR1/IMAP1 (currently
> unused)".  Is that comment now wrong?
>

The comment is still correct, IARR1/IMAP1 is unused in Linux. But it
may need to be invalidated in case it was modified by bootloaders.

> >       [IPROC_PCIE_IARR2]              = 0xd10,
> >       [IPROC_PCIE_IMAP2]              = 0xcc0,
> >       [IPROC_PCIE_IARR3]              = 0xe00,
> > --
> > 2.7.4
> >
