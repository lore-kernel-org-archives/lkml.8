Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB49C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5DE20737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="AWTYy8y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403946AbgDCM1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:27:06 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35998 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390839AbgDCM1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:27:06 -0400
Received: by mail-vs1-f66.google.com with SMTP id 184so4795866vsu.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wo2EZUNeB9SsWLhfGdO4NXUFfi3h/ZgSDOZGnGz/M8M=;
        b=AWTYy8y4zaClO/E3QrKZnMlUQae7ZWH/UnD3yozTj2BZivUYWSNVsWc8JkBuB+NIwf
         AcFYWWGWuvb5i0nj0fsftLGlbHooXGodA2QURbiI2wVxmFMdYgWV40LlgLU7RkFFbYH0
         BBfpXYmdxE1q8oIPu2qSSY2PCA4Hg8AC7+NjwcFXnZ+uzmT1GFk0+qJsuqaZ/VLfWvDP
         LtxO+i/cfEYCZJ0Dc291wQomb4Dr/uxJut004AZ4gePqeNQlV0MNbRWIlTi98WZwK0Nh
         S0XOkLvPsAPN0fdRxmYIW22+eTeJ2K4lq75U2VFpcDlB5KBDN9/cg/dvLyc7F52R4M7E
         sasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wo2EZUNeB9SsWLhfGdO4NXUFfi3h/ZgSDOZGnGz/M8M=;
        b=pmSTtimK67PIZ0oh80wiZvBBLnoZ9n3CNvsddiT3Yg0MpUVLT98U8kHHfOeWYET79b
         dcLjVCWqKu00aV5P26kHE1EEfiRIrZgtDSA0dYBus/H1h2N2E7olQJlbCyPzQnyXSgoX
         hIlnlYsMK6w9Qvva8PdaiduyYmo8W0G6Gy+HvWJPMRQoPNC0oy2577fcuOQxDWVqOk/X
         Rbmp9seZE7kEfdEybn2SOReaze8J4n0x6b4UhXsLW3dSUQMZt85oVOf4l9nGKqdsIrdH
         MB+sQbLSEIMSWHWB0vaa1ROmKddPA1ycfclhqVYC1A+RKkeWVVM8Mn5XM3HoheKMQkvq
         gWNQ==
X-Gm-Message-State: AGi0PuaQe+86R0r+aEinpjSRrkTz7Z4pMfXEF5+UEBoo5FwbX1Wq3vgi
        Y6gh0u6h6XURNUJP/fxGwrGmwvo64JaRwJ8tyURUkA==
X-Google-Smtp-Source: APiQypK3zlebDaHIYf3xJ0SdPkARdWrQq4THbXVO5Hj6xfMPT8VmYGqXxqVDetDL0Cu8CSgCsMIkNhk2Qk2txrZ2Wlo=
X-Received: by 2002:a67:870f:: with SMTP id j15mr5889031vsd.95.1585916825114;
 Fri, 03 Apr 2020 05:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <1584966504-21719-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1584966504-21719-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 3 Apr 2020 17:56:53 +0530
Message-ID: <CAHLCerPVuZrNiSh45w4TF6jKmZ+aD5aBZCcCK87i4Txdfh_Z2g@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: thermal: imx8mm-thermal: Add support
 for i.MX8MP
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Mon, Mar 23, 2020 at 6:05 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Add thermal binding doc for Freescale's i.MX8MP Thermal Monitoring Unit.
>

I realise this got merged already, but please send a patch converting
this binding to yaml at some point.

Regards,
Amit

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> index d09ae82..3629d3c 100644
> --- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> @@ -1,10 +1,10 @@
>  * Thermal Monitoring Unit (TMU) on Freescale i.MX8MM SoC
>
>  Required properties:
> -- compatible : Must be "fsl,imx8mm-tmu".
> +- compatible : Must be "fsl,imx8mm-tmu" or "fsl,imx8mp-tmu".
>  - reg : Address range of TMU registers.
>  - clocks : TMU's clock source.
> -- #thermal-sensor-cells : Should be 0. See ./thermal.txt for a description.
> +- #thermal-sensor-cells : Should be 0 or 1. See ./thermal.txt for a description.
>
>  Example:
>  tmu: tmu@30260000 {
> --
> 2.7.4
>
