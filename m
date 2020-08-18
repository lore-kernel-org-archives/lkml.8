Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1ADC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B449A207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkB6XyJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHRAiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 20:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHRAiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 20:38:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B184C061389;
        Mon, 17 Aug 2020 17:38:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i10so19494777ljn.2;
        Mon, 17 Aug 2020 17:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fam7mYoJXPako+JuYRNzyOdMjKGVEPSxTqRdK5tFFp8=;
        b=EkB6XyJmgU39PWJmCj8qriZyH8Xe7RfffXsrFZKZCn/3lSpS9EMLCKksnxJm+dfjsX
         1r4iyQorYuvlqjhrJz6zvbCn63hAKrqEnNhKDms/OUVPY+gk3M0iB3R4D0h48XHpfVpd
         zuTbVAD988wXIalA4+9gccW1YzbzpzhIGtwKNPPsUr6S+0RpAZeoYXrwk0e7TIjMRrGC
         iCQ8e/1xnfYiF4Sz/n8Q1A9nXUqGwVCNPxLy/qehPu9SZTQEbOTX5HvBipZ4qaCmzMyt
         hJbCRasW/qBLb4AkgvpL5qMSxxxQF8p41gYanAOxnIH6RM/jXnI/5a2IF9r1Y7RMUvUR
         tdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fam7mYoJXPako+JuYRNzyOdMjKGVEPSxTqRdK5tFFp8=;
        b=quLR/Z7KcR9aXxFEbnMEX2laJUftQL/Bh/g8Gpl+cTfXJyMdZJvOgvvStuGjJTTHlF
         /Grh5w4MDkhI+49ZnvlrGXOTKpNkyYUR7qKso96JF/QFh9JNCT49Y03Rr3IP/Y+Q4sQv
         +IDvR5x3ruYteBebMVSVGXf29BpabrdhsSklpTE8Fuu8mk3Cj6Lpc1xP3TL12hW6/RV1
         m93QpHAB4Z3Yt5sATw56YS3PXHr2j9Z9+fyJ2vrTB1xiY6RbiTwg4fBJGxLhuUiuPfio
         +a7f+Ix55clbiwKpTN81Or88sx3HFnCL4ETVs4OkJoPstXpXHdjnAzNCVVgnmDcBbliL
         cKuQ==
X-Gm-Message-State: AOAM5315KQHFytWenYnrJhUXlNo8Cq9OaaZBygx5R13i40JdfCJ4RNIG
        F4rA/k/Lt6pUTy5rDERLXWqovpOpUanl02zm1ypiyJhI5Ko=
X-Google-Smtp-Source: ABdhPJwpXxw3TIqu2RUzMKpopNwAEX9axJtRN7QLIK5dAaUX7yJRMcLnDUEo2Z9E/+dOEhoojkFd3pSyGoLVD6A+3UE=
X-Received: by 2002:a2e:8ed4:: with SMTP id e20mr5687359ljl.403.1597711092498;
 Mon, 17 Aug 2020 17:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR0402MB334219C2EDDB25D1493DEC7EE35F0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB334219C2EDDB25D1493DEC7EE35F0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 17 Aug 2020 21:38:01 -0300
Message-ID: <CAOMZO5A6w96XOes-FUfLuGbV=-o9FVh4UWN8vX1M=aWh=Gg3Qw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Add headphone detection for sound card
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 10:57 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:

> I didn't put headphone detect GPIO in audmux group in imx6sl-evk patch,
> Still in hog group.

Ok, sorry. You grouped it with MX6SL_PAD_AUD_MCLK__AUDIO_CLK_OUT,
which I also think should not be part of the hog group.

> And I think headphone detect GPIO is not belong to audmux group, it should
> Be in hog group.

The hog group is better suited when there is no driver that can be
associated with that particular pin.

For the headphone GPIO detect, I think it makes sense to group it with
the other audio-related pinctrl pins.
