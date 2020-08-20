Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2DEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64B52076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSV5hRvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgHTEHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgHTEHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 00:07:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A773C061757;
        Wed, 19 Aug 2020 21:07:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f26so651104ljc.8;
        Wed, 19 Aug 2020 21:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BO9tyh8T8tCTBMaQBV0urXMM6teq8tH6A459y0FQgpQ=;
        b=hSV5hRvoKIvX411//W3s83AN2F0kpoWdN6nMPPCY6RGHkyTgHNlQXQhssEKWDH+smv
         cYmg8h7+lAWv948uBqKrr8tEr7nWcCXkKifSzZrQ+GgtxWuOC4uXn2Z9x9DtcXAhyAvn
         B5vUHqISzRU79Yk/zjY3b4Jpej1yPqx7CaZqpkwAqfirNSssWvaRiOb2caK080+cL4oa
         GGHYEVPoT0zNpMVwFSfa/pfZj2sYXMtBYSY2CALwSCFpOXYWzHiRar9CxNAUuQxPRDYC
         VIFfsYPT/O3Jeo6KxH6i5mx/7YD9wNNi3VLinztfa4Q7awXT/MbWSquw+I9HTukSed40
         pCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BO9tyh8T8tCTBMaQBV0urXMM6teq8tH6A459y0FQgpQ=;
        b=CLlq8UInFii0Yz/hg8vh2adSG7LYJJuci+wrJ8xM58xs3kkEyGyNCP7Tv9ajGWWSH+
         9kx6Q7WxfbhSgu922SNlZC8TunrO+x6orVjlf5yfCcFXrQL0UCwn3CjhKfyKe87oEfzH
         GkR7LP2mGZCDWW/UUPpkdNhwVD0R7OwAyW+HS8tTFf9mmEkMmW7GCM8AvBEMThS9gD65
         T42YMpZ88bxcgYPvh/6nIA2wiEJnsc9VbxwIRJcWzF/N32FpJ93ynjWFGBbPWQq9ixGY
         9BqrjK84paCJJTJYKwqZx4YCqDVKKeBjhkWeqg3j3M+CXp/GbH3cbEHtlMjFGx0kH5o8
         KY3A==
X-Gm-Message-State: AOAM5325Ap673NgOO+93EQbeej7/dna+IF9glWZ5oTSQ5IOkjz5xjbuw
        eeJNc2C/r7CVx36Fj/mXQWYgPowyB8KCM24kUSM=
X-Google-Smtp-Source: ABdhPJwgXZisg/Mfzp4Ub8SEXZ4V4WszrVaQY4jH2nQhnXMUhjDRn9RxHps4ovDq4mOz7ajRxULlYB3qlwTHVGfbu8g=
X-Received: by 2002:a2e:8ed4:: with SMTP id e20mr672312ljl.403.1597896425849;
 Wed, 19 Aug 2020 21:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596025057.git.agx@sigxcpu.org> <b12158087838bf8e78f06024fa65da8d94f5d185.1596025057.git.agx@sigxcpu.org>
In-Reply-To: <b12158087838bf8e78f06024fa65da8d94f5d185.1596025057.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 20 Aug 2020 01:06:54 -0300
Message-ID: <CAOMZO5ANrd2JCmHyxZ0Sv0WNcU9T-q3MbaeADxbOwf+31MQ4LQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] arm64: dts: imx8mq-librem5-devkit: Enable the LCD panel
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Li Jun <jun.li@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Wed, Jul 29, 2020 at 9:19 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> Enable LCD panel output by adding nodes for the NWL DSI host controller,
> the Rocktech panel and the eLCDIF display controller.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
