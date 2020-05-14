Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDDCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EAC2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="VANDckqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgENIJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:09:30 -0400
Received: from smtp1.axis.com ([195.60.68.17]:8269 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgENIJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1901; q=dns/txt; s=axis-central1;
  t=1589443769; x=1620979769;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-transfer-encoding;
  bh=lawWfUyOQrdLpw+zeoVZeDBdYrpx8vxSo3sYmVlA0eI=;
  b=VANDckqbsEk1onDomGvg6eFYIZCSSnq9E8DhAIaCSQ4XM4k+3/Uh8xS/
   7f+34tOxYYAI0Q4KMpESbQiBc/AK6X61WTnQ57iQrBdhc3MwhpVQ2ydi0
   yAF5iliz02anJ16EB2/HfgcW8D/Ea0X9XKpxS4Hxfwad/Hytt8Pubbg8n
   clT3mise1hBkA5QDNRWkoevOIhBjwzaruzobDGwOU+57CNRD3TCCykvUe
   +OVisK8Ketr7ZyfmIOs0i5DZ6ypyIveYuOpWtofkxk7jCajJkENYWPJUD
   p2jhET++gDz6E9S2FAmVh4n+nQoGRzUi2LcQEbSQ07L8we3ul+zo62V2x
   Q==;
IronPort-SDR: 0Y3Pv7UCp3mAT5TEROn3U+48T2Mv/N55yt1fR9rJQRmJlK/PMkWzNEGKvJysBdH929zw56q+Jy
 N7QO8c+FdD2bF5b7dpsE62No91JOJpywRYEMMESqLi2y1RQ90MnAKtCckp4RBFCTA7ttAepP5/
 0bAwdvgvngpCTIr7RzS0YSFqJAVJ3M/VnXbs4vJW0yjhm2D7k24LETC3/qvfRVQ9MVTTl4Phfh
 SQcT8z4jiQSK6sfC+bQVbgvZhoNFCRFXCepH8H0QdPtKWRc2D2Xd3gJUEqERAsMM7B2xGFEzFz
 IRg=
X-IronPort-AV: E=Sophos;i="5.73,390,1583190000"; 
   d="scan'208";a="8713783"
Date:   Thu, 14 May 2020 10:09:23 +0200
From:   Ricard Wanderlof <ricardw@axis.com>
X-X-Sender: ricardw@lnxricardw1.se.axis.com
To:     Dan Murphy <dmurphy@ti.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: tlv320adcx140: Add device tree property
 for PDM edges
In-Reply-To: <20200513200549.12213-2-dmurphy@ti.com>
Message-ID: <alpine.DEB.2.20.2005141006450.30387@lnxricardw1.se.axis.com>
References: <20200513200549.12213-1-dmurphy@ti.com> <20200513200549.12213-2-dmurphy@ti.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX03.axis.com (10.0.5.17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 May 2020, Dan Murphy wrote:

> Add a device tree property to configure the PDM sampling edge for each
> digital microphone.
> 
> CC: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/sound/tlv320adcx140.yaml   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> index ab2268c0ee67..55668c7d261d 100644
> --- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> +++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> @@ -63,6 +63,19 @@ properties:
>        - $ref: /schemas/types.yaml#/definitions/uint32
>        - enum: [0, 1, 2]
>  
> +  ti,pdm-edge-select:
> +    description: |
> +       Defines the sampling edge configuration for the PDM inputs.  This is
> an
> +       array defined as <PDMIN1 PDMIN2 PDMIN3 PDMIN4>. 0 (default) is
> negative
> +       sampling edge and 1 is positive sampling edge.

A bit of a nitpick, but I would think of the edges as 
negative-going/positive-going, or rising/falling. Not sure if anyone would 
misunderstand 'negative edge' in practice though.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 1
> +        maxItems: 4
> +        items:
> +          maximum: 1
> +        default: [0, 0, 0, 0]
> +
>  required:
>    - compatible
>    - reg
> @@ -77,6 +90,7 @@ examples:
>          compatible = "ti,tlv320adc5140";
>          reg = <0x4c>;
>          ti,mic-bias-source = <6>;
> +        ti,pdm-edge-select = < 0 1 0 1>;

Should there really be a space between < and 0 ?

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
