Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09ECC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EA624650
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLVtOPey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBLRYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:24:54 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34767 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLRYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:24:53 -0500
Received: by mail-ua1-f67.google.com with SMTP id 1so1178964uao.1;
        Wed, 12 Feb 2020 09:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCGxfylxy3MldAt/reEr7p2HcESXZ2SEVCL7ze7sb8M=;
        b=mLVtOPeyTrlGTAOEBO32ZUHoFId8CdOxxgdZYat1MHSCbZKEoRcEDicBnpT71GntOI
         jE9GscwR8WoZBDG3NW2w5NV4KY4Y8KfFRmaVsjrpAkVgBIy1+dNvlJV4eDDZDPfUqKVK
         oorEhZlJcQWCPlGU6yTKKyzkjd8lVDC09X8BRQFifOVlbdeW8BUCX8oUY+gdFrqV43ve
         A7HVKdPyoFHMCkXVqFcQSKxCEkspuET12AzZarmTfBeGT1hUgL0I2kOfIADygzgcXX0I
         HilyTVF18ofv8eL17GJwyyCw6bLnd7ieFA+NvVspb+P0wA90z7swiFmFjYi2DXaQkKOH
         2Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCGxfylxy3MldAt/reEr7p2HcESXZ2SEVCL7ze7sb8M=;
        b=KBcoofSdsZBPCXwqDwvfsx2OFZGhpGqfvSjS/0luzx4qe9h1NLHCPGcQnMzMEt1Vsd
         mncszrkchSVB50iY1p2OqxoRKF49UPqyWwI4l01wB9sk5cv/hh5DDftqr5jBPvA4lelZ
         Fi1xLTcpSjWNP/SzESJyWQvMAVqIA4iNJJTomEPXW65es3jTVgR2Ll1Db9kT32y7V+EV
         NWV3YC6du45Cxnbta11CpkhKgrYQp4LDVeBeLNmKlyulkpEhowvyD7gVMvOhcQtXthg2
         UbfI8h25izvycMHsBY6/hgivFTruUhKJVmJt8jQ4a7qfe0V+1vnXfS8jjT7pBVFrUYhM
         e3Xg==
X-Gm-Message-State: APjAAAVerJ5jEi5PMl2rK8MVAROpjCnwvpD3isLjRhExSS0aO9f/MEMp
        aeViCftYeUNFpTc0O9y5sXLhkj5K/ZcYTSID99g=
X-Google-Smtp-Source: APXvYqyAepvFaN7GJfHPGtS87hCZr+gc51607hAiqYlgiF4eorNgglWZn4G42TMyi4n7UoLDOJ1DHv82wxTfkbU3tGs=
X-Received: by 2002:ab0:66d6:: with SMTP id d22mr5082237uaq.92.1581528292397;
 Wed, 12 Feb 2020 09:24:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581475981.git.shengjiu.wang@nxp.com> <1ae9af586a2003e23885ccc7ef58ee2b1dce29f7.1581475981.git.shengjiu.wang@nxp.com>
In-Reply-To: <1ae9af586a2003e23885ccc7ef58ee2b1dce29f7.1581475981.git.shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 12 Feb 2020 14:24:40 -0300
Message-ID: <CAOMZO5Do=dzh4WXvm44mB7-PeesWuA6qRtMXwHCH9piXd1dZEw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: fsl_easrc: Add document for EASRC
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 1:35 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> IP module found on i.MX815.

i.MX815 in an internal terminology. Please avoid it on the commit log.

>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,easrc.txt   | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.txt b/Documentation/devicetree/bindings/sound/fsl,easrc.txt
> new file mode 100644
> index 000000000000..0e8153165e3b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.txt
> @@ -0,0 +1,57 @@
> +NXP Asynchronous Sample Rate Converter (ASRC) Controller
> +
> +The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a
> +signal associated with an input clock into a signal associated with a different
> +output clock. The driver currently works as a Front End of DPCM with other Back
> +Ends Audio controller such as ESAI, SSI and SAI. It has four context to support
> +four substreams within totally 32 channels.
> +
> +Required properties:
> +- compatible:                Contains "fsl,imx8mn-easrc".
> +
> +- reg:                       Offset and length of the register set for the
> +                            device.
> +
> +- interrupts:                Contains the asrc interrupt.
> +
> +- dmas:                      Generic dma devicetree binding as described in
> +                            Documentation/devicetree/bindings/dma/dma.txt.
> +
> +- dma-names:                 Contains "ctx0_rx", "ctx0_tx",
> +                                     "ctx1_rx", "ctx1_tx",
> +                                     "ctx2_rx", "ctx2_tx",
> +                                     "ctx3_rx", "ctx3_tx".
> +
> +- clocks:                    Contains an entry for each entry in clock-names.
> +
> +- clock-names:               "mem" - Peripheral clock to driver module.
> +
> +- fsl,easrc-ram-script-name: The coefficient table for the filters
> +
> +- fsl,asrc-rate:             Defines a mutual sample rate used by DPCM Back
> +                            Ends.
> +
> +- fsl,asrc-width:            Defines a mutual sample width used by DPCM Back
> +                            Ends.
> +
> +Example:
> +
> +easrc: easrc@300C0000 {
> +       compatible = "fsl,imx8mn-easrc";
> +       reg = <0x0 0x300C0000 0x0 0x10000>;
> +       interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
> +       clock-names = "mem";
> +       dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
> +              <&sdma2 18 23 0> , <&sdma2 19 23 0>,
> +              <&sdma2 20 23 0> , <&sdma2 21 23 0>,
> +              <&sdma2 22 23 0> , <&sdma2 23 23 0>;
> +       dma-names = "ctx0_rx", "ctx0_tx",
> +                   "ctx1_rx", "ctx1_tx",
> +                   "ctx2_rx", "ctx2_tx",
> +                   "ctx3_rx", "ctx3_tx";
> +       fsl,easrc-ram-script-name = "imx/easrc/easrc-imx8mn.bin";
> +       fsl,asrc-rate  = <8000>;
> +       fsl,asrc-width = <16>;
> +       status = "disabled";
> +};
> --
> 2.21.0
>
