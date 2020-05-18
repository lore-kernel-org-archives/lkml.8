Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4C7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92AC1204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="HrW9TwsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgERLU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:20:28 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:28652 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726499AbgERLU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:20:28 -0400
Received: from [100.113.5.63] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id 81/7C-40482-67F62CE5; Mon, 18 May 2020 11:20:22 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wbZRjHee8XN6TmVkr6ygBnAzPDtoBMOJJ
  hiLjYRMfmpiQuA7zCSRvKtesPBywhTF0CZQ0o2xQGFhgQ+aGb0A3sJkodhmEcrGzWHyEbUg0F
  2TJACILDXq+b+t/neb7P832/7+U9EhX7iCiSLTWzRo7RyYgwTJOIpykselde0vvenfTNGy6EP
  j3tJej+6ydxeuVmFUJPOpsIutpZi9NT89n0hdVPQSapurD0DqEanGoHqi8ap0JVfd3VhGpooZ
  NQnXfcwlRLfbH7Qw/hWk6tL30T15z7eI4w1KaV9o5/jlSCebkVhJGA6kDhxsYkLhTfYtB5/zt
  CKPoBXLetBQqMGkXh8sIlxApIUkzZEXjuMN8XU7cBbK//BbOCLSRB0bB+9E5gQUI5APxksQvh
  C5TqRODf1U0EPxVBZcGFa9M4zxLqRXirZgAT+Fk4+64T4Rmj4qHjmy6UZxGVC1cGThDCyRXQu
  f46395C7YHDI1UBS0DFwOXjPYFxlJLCn732gA2kKNh+ZRwVOBL6Zh4E71kP4OqyAwiCHH7v8Q
  ZZBtcn64ILMdBtrwn298K7tjpc4AToHVsKFZiG7TUnMD4bpOLgA1eZ0NbB5YGvgqs74PhxDyF
  wNOxcqwnaxMJu2zRWBxIb/xNbYDlsubxICPwM7GydRxsDX2IrvNbgxVoA1g3S1UZtkcZcwmh1
  iuSkJEVycoriOT+lKZlyhVrJWhQFLGc2Mn5VyRw1KU1lJQW6QiXHmvuA/70VHsGLB8FF+z2lC
  zxBIrJIkW2fK0/8uFpfWKZhTJp8o0XHmlwgmiRlUNTH+bWtRraILX1Lq/O/2ocyJMNlEpGDl0
  UmA1Ni0hYJ0hhIIet8zW0o2d/c0YaKMU7PsVFS0VP8KMWPaizcI6OHf4AbxERFiEBISIg43MA
  aS7Tm/+tzQEoCWYTIw7uEaznzo/Pm/FEQf5Q9N4b4KGbmXymqEpG+3Zo+0jpU/IpcmpUxP3jf
  us14FdPvGl+34G0TvqqJ3aO9B2Nzfo3Xj+y9/Ye8bP/SvZWSPIsjJ3V3nTm2xZ6Z717NPshIG
  pgPf3j12J0fX7rYMFyxKzHOdsamsxzZ0ZSxFpf5U7m3+8CX6mpP6m/MqVOw/GTGzAQTb0v+aE
  26/XDXQvjyocLchNrNr72RtfnS4tZE64xbtvHGk5KZns2n/8q57EC0mitZZ9HolPMzkZ+lT9h
  ydza43enD1zfl3Mj2Hs9rG1clLw+Ke12+P8MKHkt974UDY02XEo42zXo6PL3OlbvHKjjD75W5
  aWdmP5h93q43VK8uss3b2Ibsfe7Ns6dlmEnDJCegRhPzD0EVwhh8BAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-5.tower-239.messagelabs.com!1589800819!3362408!1
X-Originating-IP: [104.47.5.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5445 invoked from network); 18 May 2020 11:20:20 -0000
Received: from mail-he1eur02lp2055.outbound.protection.outlook.com (HELO EUR02-HE1-obe.outbound.protection.outlook.com) (104.47.5.55)
  by server-5.tower-239.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 May 2020 11:20:20 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McOwmHTAaGi1HQpLM5lHXlnWSjscDAVvRnicLLZtnnX0V+z5D4fDzDKJ+zBNZuPRDGIkE3XHRfFHmjxyOpYldcM43BPUU4J8EG3iJvjpU7bteqphl7tDOhaUHVXcCjvOoDF1ohj4TIuj1hIOTKr9TOUnJpQDYpYX7Esnr6gcqeFTYWq1eKvKihdf4MHQUS/osu3SbHZ1e5ql0eiz96waglMN94+eYkLQ3UVvkqX6K64hytBi2pWeqd7vWPjW6bVDL5d4FqHR4CcQ0KRZ8PYqchByvaLlQtbPohqDp6q2gbtUucCkKNSms+QhJXWG12IcNP8Ari6GHSkXkwtx1NfY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaptN4UyGbPyCwpZYIOTegTKOD0LZPEGniOORBf4I9c=;
 b=eCBMZNty8cFGxf0RbQzNdnenQtDx5XUE8epk3nHx+YlKRcJTm+bZ3A0dt4sSVeZV3R9gUcUvcBZ1qb3GSAcizUJ+WFirlcptG7Ix8Hr0Cavu7RSPpf5tZbFBBrcwmoANkyfhbJy+5ionQQtnScLsVnyJUuiUOjeKJldOmnozh6XOUIkFqkiQ9xhxqJ69Y7wqhbTv60ICxIzNhZwS1JWkvsQ8DDueKXV2ggplPgwh5XuPMZ9aNr7lJr1h4/DRtqGepFfzJrAQ+ErPKvtIn85gFV/Ntd4A1FS8fQMFWSuOvFdT9O6xhyl+coBYHEkG/YVMLWbf91kEu/aDgzWu6YjBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaptN4UyGbPyCwpZYIOTegTKOD0LZPEGniOORBf4I9c=;
 b=HrW9TwsM+NM6O/sPZywwe3bN76tpQrFpFPnB0bsrljS5UkPXSL5rkAjRStvbu2h277oHpIksU5Q8NcLdJnbcwoGfCKYZ1IrxI4MfShiR2liCeqqF30Scu4f1sXY8qbqeKZFWolbwsofkIbEMBowPexS53CxspTRm/WiLZtRZQAY=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52::13)
 by AM6PR10MB2821.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:aa::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Mon, 18 May
 2020 11:20:18 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2539:e4b7:445f:13b6]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2539:e4b7:445f:13b6%5]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 11:20:18 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [PATCHv3 5/5] ASoC: da7213: add default clock handling
Thread-Topic: [PATCHv3 5/5] ASoC: da7213: add default clock handling
Thread-Index: AQHWJ5fBTHyu4DrsokekKYU/ucPtgKitvUuw
Date:   Mon, 18 May 2020 11:20:18 +0000
Message-ID: <AM6PR10MB2263094DD176499308EC8B2A80B80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <20200511132544.82364-1-sebastian.reichel@collabora.com>
 <20200511132544.82364-6-sebastian.reichel@collabora.com>
In-Reply-To: <20200511132544.82364-6-sebastian.reichel@collabora.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de19b420-bc59-441e-a11f-08d7fb1d7239
x-ms-traffictypediagnostic: AM6PR10MB2821:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB28212A77D9C400173AEA839EA7B80@AM6PR10MB2821.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VvhroTdDgRsnCTt+MdV7mhmy2b0vdAv0B6cLeQh5COoWMOuSctqUgGGkBHanXq87+rnYOC55ZJegxGoG6E3zAl6/zzA92KtPSHsAybP6HAFkr7u9/Wlea76pDDbPMwsIqpjMiiPEFioqh0adAx1WepEv9Y4IZY6TAGntqs2/NlgBrGxjHV1zuwEYJ97RV87hK+GbH1jUOAgJjI1TeVYtt3PzNUaJBodv8MCDGQXqtYsxiY07F74wPSY3FNYUwurZ84V7D54IaRaAQppV8dbpFaatIYiPAltC1z1mqUsaDjT5vgCRigIDI5a+s+siSCjlEPn6rTHNJ+kkK+tSQZEMxywBE3ut9xSZs6mZwgZzcDmUb1m3k8Vu7V7wWkHRClw+TGaQAZxqywFQshHdlh5x0ITkEfyueFAvP7a6g/T20PRETpy7rwTFCnv2Rz/zI3n0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(366004)(5660300002)(55236004)(186003)(7696005)(110136005)(54906003)(66476007)(33656002)(6506007)(86362001)(64756008)(66946007)(66446008)(66556008)(71200400001)(52536014)(76116006)(26005)(4326008)(316002)(9686003)(8676002)(55016002)(8936002)(53546011)(478600001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XsSMrK7INEsEjSWBeMJ4ISDBo+WRZA0JAzeHz+pg9cgfEYqioHWU1+PEmE2CzFVN6ui0s0whtIKa39I7BCOVSZhH22+CgFVyYqvdpLneOkITOLk7Ftxdn28gOoEvbAcAB1t4Ni8mdGGi7dqmsucDOgwG7LYaWSAI7xO/5/Za/GzXV/Lbh2IPupMK3vdwpniYyPVAS/mvO8nuaszQvD99qE8JUksYUDbL0YcTaG6K1HePjJ0qqHKdsM6dS3a8KICe3kzyYwQUeTP1eGRHxaMno8R3BcEC12qccrBdKxkRG0vyBJFJjYVGd5n4FVgcuBjNiPXHq9MoL0QjDGP+uCCaB3ZNGc4fddWgztdxsztHUqQwJZPc7RkC5TjH2J9G7CcEdazZT6ZIWJx/2my7dy/srzZMY0aOAdS5qCuj2uE2vPLH8Hf/xbKzPy3rQ+33J9A3F+FJ5DUjEtYr1e8kee9iDLAUlDXYWdFvEMJ4gq8diXkZ/+yNlIM36RWV0pHLUQ44
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de19b420-bc59-441e-a11f-08d7fb1d7239
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 11:20:18.3548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iuJO90MRw6zGI2bXVzrMrI+g1S4N9NMWFQszQFzJA+ed7NObE9jEL6WxO/4b+tWMPLx2gKzAWVRxlNhTHL/BncGzCjQZ/1/0WYpNkNce90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 May 2020 14:26, Sebastian Reichel wrote:

> This adds default clock/PLL configuration to the driver
> for usage with generic drivers like simple-card for usage
> with a fixed rate clock.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  sound/soc/codecs/da7213.c | 76
> ++++++++++++++++++++++++++++++++++++---
>  sound/soc/codecs/da7213.h |  2 ++
>  2 files changed, 73 insertions(+), 5 deletions(-)
>=20
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index 3e6ad996741b..4a0edd3b7f83 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -1156,6 +1156,7 @@ static int da7213_hw_params(struct
> snd_pcm_substream *substream,
>  			    struct snd_soc_dai *dai)
>  {
>  	struct snd_soc_component *component =3D dai->component;
> +	struct da7213_priv *da7213 =3D
> snd_soc_component_get_drvdata(component);
>  	u8 dai_ctrl =3D 0;
>  	u8 fs;
>=20
> @@ -1181,33 +1182,43 @@ static int da7213_hw_params(struct
> snd_pcm_substream *substream,
>  	switch (params_rate(params)) {
>  	case 8000:
>  		fs =3D DA7213_SR_8000;
> +		da7213->out_rate =3D DA7213_PLL_FREQ_OUT_98304000;
>  		break;
>  	case 11025:
>  		fs =3D DA7213_SR_11025;
> +		da7213->out_rate =3D DA7213_PLL_FREQ_OUT_90316800;
>  		break;
>  	case 12000:
>  		fs =3D DA7213_SR_12000;
> +		da7213->out_rate =3D DA7213_PLL_FREQ_OUT_98304000;
>  		break;
>  	case 16000:
>  		fs =3D DA7213_SR_16000;
> +		da7213->out_rate =3D DA7213_PLL_FREQ_OUT_98304000;
>  		break;
>  	case 22050:
>  		fs =3D DA7213_SR_22050;
> +		da7213->out_rate =3D DA7213_PLL_FREQ_OUT_90316800;
>  		break;
>  	case 32000:
>  		fs =3D DA7213_SR_32000;
> +		da7213->out_rate =3D DA7213_PLL_FREQ_OUT_98304000;
>  		break;
>  	case 44100:
>  		fs =3D DA7213_SR_44100;
> +		da7213->out_rate =3D DA7213_PLL_FREQ_OUT_90316800;
>  		break;
>  	case 48000:
>  		fs =3D DA7213_SR_48000;
> +		da7213->out_rate =3D DA7213_PLL_FREQ_OUT_98304000;
>  		break;
>  	case 88200:
>  		fs =3D DA7213_SR_88200;
> +		da7213->out_rate =3D DA7213_PLL_FREQ_OUT_90316800;
>  		break;
>  	case 96000:
>  		fs =3D DA7213_SR_96000;
> +		da7213->out_rate =3D DA7213_PLL_FREQ_OUT_98304000;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1392,9 +1403,9 @@ static int da7213_set_component_sysclk(struct
> snd_soc_component *component,
>  }
>=20
>  /* Supported PLL input frequencies are 32KHz, 5MHz - 54MHz. */
> -static int da7213_set_component_pll(struct snd_soc_component *component,
> -				    int pll_id, int source,
> -				    unsigned int fref, unsigned int fout)
> +static int _da7213_set_component_pll(struct snd_soc_component
> *component,
> +				     int pll_id, int source,
> +				     unsigned int fref, unsigned int fout)
>  {
>  	struct da7213_priv *da7213 =3D
> snd_soc_component_get_drvdata(component);
>=20
> @@ -1503,6 +1514,16 @@ static int da7213_set_component_pll(struct
> snd_soc_component *component,
>  	return 0;
>  }
>=20
> +static int da7213_set_component_pll(struct snd_soc_component *component,
> +				    int pll_id, int source,
> +				    unsigned int fref, unsigned int fout)
> +{
> +	struct da7213_priv *da7213 =3D
> snd_soc_component_get_drvdata(component);
> +	da7213->fixed_clk_auto_pll =3D false;
> +
> +	return _da7213_set_component_pll(component, pll_id, source, fref,
> fout);
> +}
> +
>  /* DAI operations */
>  static const struct snd_soc_dai_ops da7213_dai_ops =3D {
>  	.hw_params	=3D da7213_hw_params,
> @@ -1532,6 +1553,43 @@ static struct snd_soc_dai_driver da7213_dai =3D {
>  	.symmetric_rates =3D 1,
>  };
>=20
> +static int da7213_set_auto_pll(struct snd_soc_component *component, bool
> enable)
> +{
> +	struct da7213_priv *da7213 =3D
> snd_soc_component_get_drvdata(component);
> +	int mode;
> +
> +	if (!da7213->fixed_clk_auto_pll)
> +		return 0;
> +
> +	da7213->mclk_rate =3D clk_get_rate(da7213->mclk);
> +
> +	if (enable)
> +		mode =3D DA7213_SYSCLK_PLL;
> +	else
> +		mode =3D DA7213_SYSCLK_MCLK;
> +

We still need to address the handling of the PLL when the codec is slave, a=
nd
the MCLK rate is not harmonic. In that scenario we need to use the SRM feat=
ure
of the PLL to synchronise the PLL with the incoming WCLK signal on the DAI.
Right now your code will allow for slave mode where the PLL is enabled with=
out
SRM, regardless of whether we're acting as slave or not. Either we just don=
't
allow for slave mode with non-harmonic frequencies or we add a bit more in =
this
function to determine if SRM is required which shouldn't be much more code.

> +	switch (da7213->out_rate) {
> +	case DA7213_PLL_FREQ_OUT_90316800:
> +		if (da7213->mclk_rate =3D=3D 11289600 ||
> +		    da7213->mclk_rate =3D=3D 22579200 ||
> +		    da7213->mclk_rate =3D=3D 45158400)
> +			mode =3D DA7213_SYSCLK_MCLK;
> +		break;
> +	case DA7213_PLL_FREQ_OUT_98304000:
> +		if (da7213->mclk_rate =3D=3D 12288000 ||
> +		    da7213->mclk_rate =3D=3D 24576000 ||
> +		    da7213->mclk_rate =3D=3D 49152000)
> +			mode =3D DA7213_SYSCLK_MCLK;
> +
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	return _da7213_set_component_pll(component, 0, mode,
> +					 da7213->mclk_rate, da7213->out_rate);
> +}
> +
>  static int da7213_set_bias_level(struct snd_soc_component *component,
>  				 enum snd_soc_bias_level level)
>  {
> @@ -1551,6 +1609,8 @@ static int da7213_set_bias_level(struct
> snd_soc_component *component,
>  						"Failed to enable mclk\n");
>  					return ret;
>  				}
> +
> +				da7213_set_auto_pll(component, true);
>  			}
>  		}
>  		break;
> @@ -1562,8 +1622,10 @@ static int da7213_set_bias_level(struct
> snd_soc_component *component,
>  					    DA7213_VMID_EN | DA7213_BIAS_EN);
>  		} else {
>  			/* Remove MCLK */
> -			if (da7213->mclk)
> +			if (da7213->mclk) {
> +				da7213_set_auto_pll(component, false);
>  				clk_disable_unprepare(da7213->mclk);
> +			}
>  		}
>  		break;
>  	case SND_SOC_BIAS_OFF:
> @@ -1693,7 +1755,6 @@ static struct da7213_platform_data
>  	return pdata;
>  }
>=20
> -
>  static int da7213_probe(struct snd_soc_component *component)
>  {
>  	struct da7213_priv *da7213 =3D
> snd_soc_component_get_drvdata(component);
> @@ -1829,6 +1890,11 @@ static int da7213_probe(struct snd_soc_component
> *component)
>  			return PTR_ERR(da7213->mclk);
>  		else
>  			da7213->mclk =3D NULL;
> +	} else {
> +		/* Do automatic PLL handling assuming fixed clock until
> +		 * set_pll() has been called. This makes the codec usable
> +		 * with the simple-audio-card driver. */
> +		da7213->fixed_clk_auto_pll =3D true;
>  	}
>=20
>  	return 0;
> diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
> index 3890829dfb6e..97ccf0ddd2be 100644
> --- a/sound/soc/codecs/da7213.h
> +++ b/sound/soc/codecs/da7213.h
> @@ -535,10 +535,12 @@ struct da7213_priv {
>  	struct regulator_bulk_data supplies[DA7213_NUM_SUPPLIES];
>  	struct clk *mclk;
>  	unsigned int mclk_rate;
> +	unsigned int out_rate;
>  	int clk_src;
>  	bool master;
>  	bool alc_calib_auto;
>  	bool alc_en;
> +	bool fixed_clk_auto_pll;
>  	struct da7213_platform_data *pdata;
>  };
>=20
> --
> 2.26.2

