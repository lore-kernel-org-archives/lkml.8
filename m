Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD43C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88C62078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyQv9W0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgFOUiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgFOUiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:38:51 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98256C061A0E;
        Mon, 15 Jun 2020 13:38:51 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 190so10141434vsr.9;
        Mon, 15 Jun 2020 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/Mp7iKWT7GJmgr8/QHDR53t1KgWn8P7FwKRZ54fDz4=;
        b=nyQv9W0a7BcbzNqTfK4QHt1nuHWmFDxJhtl708ayOpYUemDeK7k75l5Bf93A91FNb6
         baIlDVjAqMEECZ3IJ25V9nnjghtCdIDkK0QLVxt4lVZH6ALhXhDsE9fqbI1PRIR05Hie
         5HjxZ6b5D7stefT+VAckIZlUB7XBoYTH2IPw71fkpWNYRXCOxD/o4d0Qe1q2nZ87zmdd
         98/uCSMolaEe9jGaVGM/3MbQC8GW4GmMMaZE73Rlu15AInwdzqJQQKC1cKCqGSfys/39
         oR2kRMx/Isi/I7sdkuJtBdnwSOsxIo/lIMbWkttPmAkuNYhdFW5+xg5b3WK6x/MZCUYE
         Zp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/Mp7iKWT7GJmgr8/QHDR53t1KgWn8P7FwKRZ54fDz4=;
        b=HMV6kQZpn05NjrNwDDTiDyijx+zS5Dr/DGwFIrj7N9tbBOY8WBBGSTp/0D4CASd7iY
         mGyKGmm1cu0TY2+ude4UB5gFXhO2uf0qVkEDeRhpLhv5qa3n9DluHbQMJyAn3+P70Nwo
         f8IBm1YicCWFuk5PSfaY9SyPWPsRKCKwg4uL+CgW+XutIRcEL7iXyObrqJlS4TSoKAg9
         HJ4vpLiChS7EutK/N/nixBXFA51wxacl5OspPXmRT/xBsUwmY0/W2Ono1MRuuI1sIZ1f
         NJpioFhjUXH56Q7yr9/HEFHQlJk5q6XebcLiHFF+0cP1iuKRlYbG9j0vbWh/bmZcuTy1
         aaNg==
X-Gm-Message-State: AOAM533ApZ+ULaOjqS9+RmHnRvKLef8d3SRmZZyEAVeE0VpXrdQEEpqH
        LNw6qundjksdfV5FDLBRr84E8Ranp4NzQcJiYYs=
X-Google-Smtp-Source: ABdhPJylTOxLG8Jwa648uPABoZk5EHApkaRAi7nl5VMQvz4nQKzBl2iyQVBq0cmqvnQMufm+VlBoYXAVYt/TWvSA0JA=
X-Received: by 2002:a67:3291:: with SMTP id y139mr21083280vsy.37.1592253530812;
 Mon, 15 Jun 2020 13:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com> <839133dd-8ed4-5fec-c311-ce9f8abf3d5f@samsung.com>
In-Reply-To: <839133dd-8ed4-5fec-c311-ce9f8abf3d5f@samsung.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 15 Jun 2020 21:35:10 +0100
Message-ID: <CACvgo50HieMRRb1kK3X0XWXtNmgidYi_OWW9DGCrxT+1q14RWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: fbdev: amifb: remove dead APUS support
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev <linux-fbdev@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

On Tue, 2 Jun 2020 at 11:37, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> On 5/14/20 10:21 PM, Geert Uytterhoeven wrote:
>
> > These #ifdefs are relics from APUS (Amiga Power-Up System), which
> > added a PPC board.  APUS support was killed off a long time ago,
> > when arch/ppc/ was still king, but these #ifdefs were missed, because
> > they didn't test for CONFIG_APUS.
>
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/video/fbdev/amifb.c |   63 --------------------------------------------
>  1 file changed, 63 deletions(-)
>
A quick look through my checkout (drm-misc/next aka 5.8 ish), shows
multiple other places which check for the define.
And a single place where it's being set - the Makefile below.

Should those be addressed as well? Or perhaps they are and I've got an old tree.

HTH
Emil

$ git grep -c __mc68000__
arch/m68k/Makefile:1
drivers/block/floppy.c:2
drivers/ide/ide-probe.c:2
drivers/input/misc/hp_sdc_rtc.c:1
drivers/input/serio/hp_sdc.c:3
drivers/input/serio/hp_sdc_mlc.c:1
drivers/net/ethernet/i825xx/82596.c:8
drivers/tty/vt/keyboard.c:1
drivers/video/fbdev/amifb.c:11
include/linux/a.out.h:1
include/linux/hp_sdc.h:1
include/uapi/linux/a.out.h:1
lib/fonts/fonts.c:2
lib/mpi/longlong.h:1
