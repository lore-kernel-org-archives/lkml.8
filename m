Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631E0C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C282082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM+vDHpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgBCOWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:22:45 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42389 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgBCOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:22:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so9819810lfl.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 06:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cQyJZrqDrPD9QQGrUv31P1u0hJiwjVoo5AE0F4uuGCQ=;
        b=aM+vDHpiHu7ZsP9uDCCkEBBjYhrgy6/xxq12THpUqTWsI7iZ+ha8+f2DUT/mgRoIOk
         GJ1cP3I5cf8FnLeqU98LZvLmNys2gevwmDWhWAvr4iGNlkTSdHOCC/j0jGUN6YXuyHR1
         OyE1zXcPvWfmNOWhwybZcPG1xzYo2aOoK3hrsjUlnvPcTWTX1DayvpleSvTg7qhRUvjr
         t/9YPUT7lbSx6q54nf1EtBO/tr/Ov9M2XIAN/srNDz54BpYSaBou9f/QFqVV1YvRN4f4
         s6jDsGcUf+m5j2CSUBKyzmrx/37bsztcQRKUWG8Bt1FwUSp83I7Fn6FCpfnYLgExGhkf
         1njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQyJZrqDrPD9QQGrUv31P1u0hJiwjVoo5AE0F4uuGCQ=;
        b=Zp+3jIFQPbgtL5tJM0RpirxzrFUdVYuU4b4UScjZkmmNCOWFy6KAssx3w96nRcS1Tr
         sByYq2QqSoqHeag/nGDM5du7dif3MlM9WZZnsae6YTaQYtXsIpqFoKG15yzsFgQ/70pS
         PpJLjZ3O2McC/GpzPBOMwvONv1wyqqH82e/77NeOGvARxm2Q+IBuJKMhFgjda7hAPRgG
         orbbw9Azyd0IbVZA7RDE2o/rSEUBxUGvBKj2haEf+31jureNMUcEmOEhVw2+CAVik1pf
         N5c7o/wBh0lGUZVNJtxaK039Y7sr/tUNONT9aQ2FHonbcf+VwhC9WY01qivrpXoxAFlN
         51ww==
X-Gm-Message-State: APjAAAUO6eQiusOZAhGcn3ITT0APC69UEGfVQCsZfThyVafp8xI+0Rl4
        pqUlQhVRNVaY1Mynn2DQZnnkNheVwOJY7069f2I=
X-Google-Smtp-Source: APXvYqxu3RquYZLbeVnhZXAa2l6u5wyw7ijwh/U3Xd58fv1kHVLoV2qoyvjjNMMdryAAt03QZsjjKAB8CVu91pU+HeE=
X-Received: by 2002:a19:3f51:: with SMTP id m78mr11975049lfa.70.1580739762842;
 Mon, 03 Feb 2020 06:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20200202193014.107003-1-stefan@agner.ch>
In-Reply-To: <20200202193014.107003-1-stefan@agner.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 3 Feb 2020 11:22:33 -0300
Message-ID: <CAOMZO5CRwOpNUtUqTmdvV0Yz=fRadjYwpv19KZyhdc-ea0+_ZA@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: limit errata selection to Cortex-A9 based designs
To:     Stefan Agner <stefan@agner.ch>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yongcai Huang <Anson.Huang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Sun, Feb 2, 2020 at 4:30 PM Stefan Agner <stefan@agner.ch> wrote:
>
> From: Stefan Agner <stefan.agner@toradex.com>
>
> The two erratas 754322 and 775420 are Cortex-A9 specific. Only
> select the erratas for SoC which use a Cortex-A9.

Change looks good.

It is not clear from the commit log, which SoC selects the errata
incorrectly though.

I would mention that i.MX6UL is based on Cortex-A7 and hence should
not select them.

Otherwise, only by looking at this patch context and commit log, we
cannot notice the problem.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
