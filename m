Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A0DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF9B2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JdtW/YSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgFLJ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:26:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41732 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLJ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:26:40 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05C9QWNO042251;
        Fri, 12 Jun 2020 04:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591953992;
        bh=plg66SGaAwE+4oegw51dtOB9rPV3OE8eIAPCaci5HNM=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=JdtW/YSlg86wXbEQgxn2L0qNpVB2zuM5aY5zJHKuQ2Osl+OGFcqRJn+skJj7vtOnv
         nkLEwuacDCchzDj5ZCYw/oreRxQxIALwBZgcoaav1iQ0wjgPRc+mzdsH2b+zEIicm1
         ahdnVgPmrRw4OwAxQwwggc87OKer9Inw1fR9/uMQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05C9QWwp051439
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 04:26:32 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 04:26:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 04:26:32 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05C9QU3Q104797;
        Fri, 12 Jun 2020 04:26:30 -0500
Subject: Re: [PATCH v3 3/3] ASoC: ti: Add custom machine driver for j721e EVM
 (CPB and IVI)
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200612085909.15018-1-peter.ujfalusi@ti.com>
 <20200612085909.15018-4-peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <7f2c4297-3ad9-5b8f-c9a5-5120078120c6@ti.com>
Date:   Fri, 12 Jun 2020 12:27:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612085909.15018-4-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/06/2020 11.59, Peter Ujfalusi wrote:
> The audio support on the board is using pcm3168a codec connected to McA=
SP10
> serializers in parallel setup.
> The pcm3168a SCKI clock is coming via the j721e AUDIO_REFCLK2 pin.
> In order to support 48KHz and 44.1KHz family of sampling rates the pare=
nt clock
> for AUDIO_REFCLK2 needs to be changed between PLL4 (for 48KHz) and PLL1=
5 (for
> 44.1KHz). The same PLLs are used for McASP10's AUXCLK clock via differe=
nt
> HSDIVIDER.
>=20
> Generic card can not be used for the board as we need to switch between=

> clock paths for different sampling rate families and also need to chang=
e
> the slot_width between 16 and 24 bit audio.
>=20
> The audio support on the Infotainment Expansion Board consists of McASP=
0
> connected to two pcm3168a codecs with dedicated set of serializers to e=
ach.
> The SCKI for pcm3168a is sourced from j721e AUDIO_REFCLK0 pin.
> It is extending the audio support on the CPB.
>=20
> Due to the fact that the same PLL4/15 is used by both domains (CPB/IVI)=

> there are cross restriction on sampling rates.
>=20
> The IVI side is represented as multicodec setup.
>=20
> PCMs available on a plain CPB (no IVI addon):
> hw:0,0 - cpb playback (8 channels)
> hw:0,1 - cpb capture (6 channels)
>=20
> When the IVI addon is present, additional two PCMs will be present:
> hw:0,2 - ivi multicodec playback (16 channels)
> hw:0,3 - ivi multicodec capture (12 channels)
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/ti/Kconfig     |   8 +
>  sound/soc/ti/Makefile    |   2 +
>  sound/soc/ti/j721e-evm.c | 887 +++++++++++++++++++++++++++++++++++++++=

>  3 files changed, 897 insertions(+)
>  create mode 100644 sound/soc/ti/j721e-evm.c

> diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
> new file mode 100644
> index 000000000000..096f045a1120
> --- /dev/null
> +++ b/sound/soc/ti/j721e-evm.c

=2E..

> +static int j721e_get_clocks(struct device *dev,
> +			    struct j721e_audio_clocks *clocks, char *prefix)
> +{
> +	struct clk *parent;
> +	char *clk_name;
> +	int ret;
> +
> +	clocks->target =3D devm_clk_get(dev, prefix);
> +	if (IS_ERR(clocks->target)) {
> +		ret =3D PTR_ERR(clocks->target);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to acquire %s': %d\n",

Looks like I have extra "'" in the prints...

> +				prefix, ret);
> +		return ret;
> +	}
> +
> +	clk_name =3D kasprintf(GFP_KERNEL, "%s-48000", prefix);
> +	if (clk_name) {
> +		parent =3D devm_clk_get(dev, clk_name);
> +		kfree(clk_name);
> +		if (IS_ERR(parent)) {
> +			ret =3D PTR_ERR(parent);
> +			if (ret !=3D -EPROBE_DEFER)
> +				dev_err(dev, "failed to acquire %s': %d\n",
> +					prefix, ret);
> +			return ret;

It should be like this to really not fail with single PLL (from DT), but
it is not documented and supported officially.

if (ret =3D=3D -EPROBE_DEFER)
	return ret;

dev_dbg(dev, "no 48KHz parent for %s: %d\n", prefix, ret);
parent =3D NULL;

> +		}
> +		clocks->parent[J721E_CLK_PARENT_48000] =3D parent;
> +	} else {
> +		return -ENOMEM;
> +	}
> +
> +	clk_name =3D kasprintf(GFP_KERNEL, "%s-44100", prefix);
> +	if (clk_name) {
> +		parent =3D devm_clk_get(dev, clk_name);
> +		kfree(clk_name);
> +		if (IS_ERR(parent)) {
> +			ret =3D PTR_ERR(parent);
> +			if (ret !=3D -EPROBE_DEFER)
> +				dev_err(dev, "failed to acquire %s': %d\n",
> +					prefix, ret);
> +			return ret;

and here

> +		}
> +		clocks->parent[J721E_CLK_PARENT_44100] =3D parent;
> +	} else {
> +		return -ENOMEM;
> +	}

then:

if (!clocks->parent[J721E_CLK_PARENT_44100] &&
    !clocks->parent[J721E_CLK_PARENT_48000]) {
	dev_err(dev, "At least on parent clock is needed for %s\n",
		prefix);
	return -EINVAL;
}

> +
> +	return 0;
> +}

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

