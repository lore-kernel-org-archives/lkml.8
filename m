Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E11AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8A820720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO7YgCFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbgF2Uk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbgF2TOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:09 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A42FC0A893A;
        Mon, 29 Jun 2020 00:38:08 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k6so13574332ili.6;
        Mon, 29 Jun 2020 00:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTLnTytmqwPo2QrVotAhwjgdIikFCW3Y9V9c+Ul628k=;
        b=hO7YgCFEdPYQrvp3kFZV2OXX7bnz/HWxL/I8M9F3srON/2EpwrjADVZaSmO3wpR10e
         xShjxgypbemlvSD4Bz2KZS86mWY4elE17aaWa4OOf7VRrcaMFZDnWR2kmmozvactxe8V
         vM+6Leu3iiG3sATYROu72hMLLm2MvJ+916wUcSNvcmS/VTVDrNw4lnWf+BAIOfmSaLzi
         0DWQpAEbhPYF8NHE2JoIR9A36MthArCCdlrbViQbFS8mqlUIyyL6FA3raDQc22IukKk8
         hRi7ulSD+AEVcXSzY1xkQF/eQcZYVfkoF4U4jwu4IMEjvmBXghP0hrkbuxAD1I/tQvV6
         mi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTLnTytmqwPo2QrVotAhwjgdIikFCW3Y9V9c+Ul628k=;
        b=cNaE0ttekSHwOIIfqsCLdzL+DKkW2lyjXcYGQH18Ro8/3pd0iT0Ru5nPnHpwbcayg4
         g+CYWeZSxCXijoODh2ywCQtehaxUEK7tbGnjctTGKPExf8jt1DpTbC/kuCsIFiK4NjkT
         /elxKQJG7ZtJOc1e3DRKONK+4GtIbQDRle2+NU42RRv6+eZWlmmO5WAjSQKJUWLg0Gk+
         o6RPPt1wZJWl5wW80kGrrtHJBl7xfnSjEd+ubUsySb4xUXYlUvdfh/jqouhiOIupvLq4
         lC9cLHWjNjWeD8JA6kd4pO4lypcv14SVBTdDj99uPQ76Vy2ZmdBbaPyLiewnMvvNAab5
         5f0w==
X-Gm-Message-State: AOAM5300mW8CXUI/OO5fkm26IgnI39xs+Xa01vGy1EBJmM/UHkO765Wq
        a10E1mn+53yGO4VOKNrwJbDgNQUrLTZnJJtzBjQ=
X-Google-Smtp-Source: ABdhPJzyfEuSvsvqAyieDmK4mMBIE5np8Cjw7UhIz6L0NfvR0InXzI9MesOfgOM7McMyA0mnJHM4y1HqDRacRIX8BDg=
X-Received: by 2002:a92:940f:: with SMTP id c15mr15673200ili.204.1593416287611;
 Mon, 29 Jun 2020 00:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <1593410434-19406-1-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1593410434-19406-1-git-send-email-chunfeng.yun@mediatek.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Mon, 29 Jun 2020 15:37:54 +0800
Message-ID: <CAL411-qVjxYk7f+b74XHfj7jpxALS4LYUKe0XdSfwRZcQibNfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: mtu3: disable USB2 LPM
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        USB list <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 2:04 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> A SuperSpeed device shall include the USB 2.0 extension descriptor
> and shall support LPM when operating in USB 2.0 HS mode(see usb3.2
> spec9.6.2.1). But we always don't support it, so disable it by
> default, otherwise device will enter LPM suspend mode when
> connected to Win10 system.

Linux also supports USB2 LPM. Besides, USB-IF CH9 test will check
LPM support if the device is USB 2.1, how could you deal with it?

Peter

>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/mtu3/mtu3_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
> index 9dd0216..50d6a40 100644
> --- a/drivers/usb/mtu3/mtu3_core.c
> +++ b/drivers/usb/mtu3/mtu3_core.c
> @@ -604,6 +604,8 @@ static void mtu3_regs_init(struct mtu3 *mtu)
>         mtu3_clrbits(mbase, U3D_MISC_CTRL, VBUS_FRC_EN | VBUS_ON);
>         /* enable automatical HWRW from L1 */
>         mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, LPM_HRWE);
> +       /* always reject LPM request */
> +       mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, LPM_MODE(1));
>
>         /* use new QMU format when HW version >= 0x1003 */
>         if (mtu->gen2cp)
> --
> 1.9.1
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
