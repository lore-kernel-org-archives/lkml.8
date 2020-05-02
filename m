Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD149C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D65216FD
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZipQEaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgEBLFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 07:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726741AbgEBLFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 07:05:52 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0678C061A0C;
        Sat,  2 May 2020 04:05:51 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id v9so230688ybq.13;
        Sat, 02 May 2020 04:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjQODkBNf8/RYh8t9ztjsCcxLdPW3ecYjs5ApkMHPaM=;
        b=FZipQEaZRKjDoNHBlJJ5shFekNyb9zW8JSACeCww1NiBj40ZbsvExD+UAYINDsC8eb
         CTqX2fZRipOPTyMrrIQWAiGZqkTeFS3dW5uudPoTjGIOWmekWKscQCmpvPf7/LAn1nSU
         8nrRcMbY2mDGpLq3k2y15BzgsZimxvaC4ugPCZBdsjJMvpM5dnyOi4fOK35vLVTrW8cJ
         4VWuJgJ9U6K+BRiaE/d5Q8cm3yuOnpz4Ru+39CWNqcHQmBieueUlDXMReg4P6CvmOexV
         ibfehUNH/+0s1N2WBjURaoOH4TZtsP6JLuo0BffR4NwA6ov3fBB4nP6EU9t27jcLcwvW
         ZhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjQODkBNf8/RYh8t9ztjsCcxLdPW3ecYjs5ApkMHPaM=;
        b=Eaxu6ZwWht7qOOuO3unE/icdxMoJ9nKKVPPqXpr9HpcKhj5iG/IXGtlLE+YiZytZWC
         aB6zdz0Ex7sboRJmqbWc3lC3yKYmh7lDHPtgFEkD6QCNhIHz+n5GmJPHarKWPFbNMMsG
         gT6edZDgtfAurwecuKhLGjOaiwPjjvWMFc7+wEwJareT+MJ/+grgQlqEsbFSJHLQ1SZS
         f+VSnQDLLwfjSMRmcDW5iKIVroreZtHNdApXh6wy2U/wDqCGCOYWhsDdgfPcqIIlK9GS
         CeYZWVSRWVIRdjOSE9MKX1/sojz9kRGpZJQ6Jz+0aImQ22ymg6i9IoXosSzrA/RpQSH/
         raRw==
X-Gm-Message-State: AGi0Pualnj9i8AXKIdlohjjAWMU2PjL2rVQEMHbhkCJH48F+ypOV6SVZ
        s7E+QqDGMxyCFXp21BFFGZddEDMlVGXCCxcZlSA=
X-Google-Smtp-Source: APiQypLZAySvmPVCqf1EJbPe2OgIVGiEgKhhS2c8vWg/hGf7zotof7tB0svp3etBsbPSLhIYDbUMBdFF0mT36QRqdCs=
X-Received: by 2002:a25:d8d0:: with SMTP id p199mr13179303ybg.152.1588417551191;
 Sat, 02 May 2020 04:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <1588393643-31499-1-git-send-email-bmeng.cn@gmail.com> <CAMuHMdVd3s46o5VXZqAHuQt5qYsbDMOonVWjEqd2nu8OON97Xw@mail.gmail.com>
In-Reply-To: <CAMuHMdVd3s46o5VXZqAHuQt5qYsbDMOonVWjEqd2nu8OON97Xw@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sat, 2 May 2020 19:05:40 +0800
Message-ID: <CAEUhbmWjrnRLXUd3Au2f7fnZtRVgdYzMvFn-RrdOodfFq4r=Lg@mail.gmail.com>
Subject: Re: [PATCH] sh: Drop CONFIG_MTD_M25P80 in sh7757lcr_defconfig
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Sat, May 2, 2020 at 6:09 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Bin,
>
> On Sat, May 2, 2020 at 6:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > Drop CONFIG_MTD_M25P80 that was removed in
> > commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> Thanks for your patch!
>
> Blindly removing config options from defconfig files that haven't
> received much love for a while is IMHO not such a good idea, as it makes
> it harder to see what the affected platform needs, or needed.
>
> > --- a/arch/sh/configs/sh7757lcr_defconfig
> > +++ b/arch/sh/configs/sh7757lcr_defconfig
> > @@ -36,7 +36,6 @@ CONFIG_IPV6=y
> >  # CONFIG_FW_LOADER is not set
> >  CONFIG_MTD=y
> >  CONFIG_MTD_BLOCK=y
> > -CONFIG_MTD_M25P80=y
> >  CONFIG_BLK_DEV_RAM=y
> >  CONFIG_SCSI=y
> >  CONFIG_BLK_DEV_SD=y
>
> MTD_SPI_NOR became a dependency for MTD_M25P80 since commit
> 03e296f613affcc2671c1e86d8c25ecad867204e ("mtd: m25p80: use the SPI nor
> framework") and commit e43b20619bdb6c851dd7b49cbd15e52875a785d4 ("mtd:
> spi-nor: shorten Kconfig naming").  Hence CONFIG_MTD_SPI_NOR=y should be
> added to avoid breaking the platform's SPI FLASH support.
>
> Just removing CONFIG_MTD_M25P80=y from the defconfig makes this less
> visible for someone who wants to build a kernel for this platform using
> "make sh7757lcr_defconfig": it can no longer be seen that
> CONFIG_MTD_M25P80=y won't be present in the resulting .config file.
>

Thank you for the review! Sorry I missed that.

> I think the platform would be better served with a proper refresh of the
> defconfig file.

I am not sure if doing a defconfig refresh should be a separate patch.
I felt mixing the refresh with the real changes makes the code review
a little bit hard. I just sent v2 without the refresh. Please let me
know if it is okay.

Regards,
Bin
