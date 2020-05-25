Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC41C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA7F206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389538AbgEYJgh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:36:37 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45303 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbgEYJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:36:36 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MJEAX-1jIbkG0uh1-00Kdix for <linux-kernel@vger.kernel.org>; Mon, 25 May
 2020 11:36:35 +0200
Received: by mail-qk1-f173.google.com with SMTP id v79so6884992qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:36:35 -0700 (PDT)
X-Gm-Message-State: AOAM531SK/kJSZpxQjb8FPDyAlsL6g1DUJcPcBn3rE8HJGhi8Z0+PMWh
        PicisxoVySrBprdcX+geIpyLo6xiTv0xt0hpTQs=
X-Google-Smtp-Source: ABdhPJy5tWgrzNvawFlsQuCKqQp9MJRKR+wqG22I7JCg5q2HGzyERYxtW9+HspCIMVmd/XlJ8+YbkOHd3MiDKxjzlLs=
X-Received: by 2002:ae9:ed95:: with SMTP id c143mr26071755qkg.394.1590399394127;
 Mon, 25 May 2020 02:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <1589875163-3367-1-git-send-email-rui_feng@realsil.com.cn>
 <20200522091646.GA1201234@kroah.com> <CAK8P3a3Uk_fmJ3UA1nuChHLC6w3p_wZfkqqRLvB01W0uLEE3-w@mail.gmail.com>
 <2A308283684ECD4B896628E09AF5361E59ACF600@RS-MBS01.realsil.com.cn>
In-Reply-To: <2A308283684ECD4B896628E09AF5361E59ACF600@RS-MBS01.realsil.com.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 May 2020 11:36:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a13P0NuogaQtvSAZRbJb5OaccVxegvqKpynWO65Ye3iKA@mail.gmail.com>
Message-ID: <CAK8P3a13P0NuogaQtvSAZRbJb5OaccVxegvqKpynWO65Ye3iKA@mail.gmail.com>
Subject: Re: [PATCH] [V2] mmc: rtsx: Add SD Express mode support for RTS5261
To:     =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:OEUdXi9yToKJ8kLiHyI9RAtuCImUx4uAR8g0AC6PxXDatS0XAWO
 Wz2zvbuuOEXErv+fArKFtX6bmsxI/RvEWFw9J1nSWMmmcJ/suQc6mxfcXo3cTVFG4LHCfui
 mHTB4s5qidRPeZA75P4GYLk1dKug/Dwius+YubcvQ/4a+GTgnvMfTbBRrdvjoT4H5WIPV5N
 qrPy4mS6HHBv4svc70Evg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4VgbVF18F2I=:F/ecGO+BY0Zo+CNp1SlYnC
 z37lRaS/bxhQS8BHYGtPvXhACSRxSMNE+k5tf+xARalucxQR2hhGFOIOF1CfEqGke21DtdQeB
 DTWu4klI5VehJHkIwkDsAboMfyLhkTwViy2ZFec6Gqf1+Ecl+SxcC8vh3ibClBD9zCUqfDIZh
 gmWbvOBPdcj0wn4vNOFu0zIXBE/ROBAUaPVBOaUFogswUKklE+GQXIBTyfZ/29tLXL9h95VKv
 jFUcjhHWqAeFfxR4+CX0ivIiPFPr7fe6o2dF7bzr8AjMy/V1XOMj3Un1R7Kt8nmu3a5Jh5HiF
 4K3PvRjRzDiYzDyXU1jiyPABzH3W6Jp6rgFWXqiSvJpK4KIHNxcE0hgKLmGQrfoCxqg4t+4dX
 d+sfJkOkSy1I+2yYdbnN10anmfliWNHWl/8vTwD5FeLLPfQmqHJkqIVXnxwCgHc1NsLg7AnSP
 ECOFXHcooX7lMzVEywejIOowjK6GFWx9QL5QggcznIpL3V/NgSbwW+ETZ20VY3qrMxffv3L/a
 iab9B47b7JtPV/MYeyL88mpXBWunGxVgdKX9awf6olSlGLdidAcbN8kkDCEmcRGl65z5Sub2J
 pBM1I2GxygtHN6v257d67xAtxGGP8fCpgkkGoOAqtSP6sGedWjAMOf3Mi/2CnXISzKKMkgOkt
 ncp0oXhXS6m6NszTtensIFMplJ0gVso+JOOqXqNNe+PX7i/0HVsLB9dhbI3ElJQFUvDvsWRiS
 r/AG/ZnNsU1XbEMHfpQ54iWPYG7PPIyeB7B48MQe7L75H4VVaKFn2BRR2JPF6nzedKtPmryQE
 8Cy8XgPSKSnV+EYmEo2WE93WhXRxPK2L9YVMp0cz7fWLWzXekw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 8:58 AM 冯锐 <rui_feng@realsil.com.cn> wrote:
> > On Fri, May 22, 2020 at 11:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > If I can get an ack from the MMC maintainer, I can take this in my
> > > tree...
> > >
> > > {hint}
> >
> > I think this feature needs much more discussion to make sure we get a good
> > user experience when it gets added to all mmc controllers.
> >
> Only RTS5261 is affected by this patch. Other vendor's reader won't be affected.

That sounds like another problem with this patch:

The transition should probably be handled by the MMC core checking whether
the kernel, the mmc host and and the card all support SD express mode, and
then start the transition as well as falling back to SD mode if it doesn't come
up properly.

         Arnd
