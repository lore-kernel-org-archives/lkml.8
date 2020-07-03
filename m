Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28C6206BE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RJajxqja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgGCH7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:59:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57510 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:59:52 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0637wv62049460;
        Fri, 3 Jul 2020 02:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593763137;
        bh=hRJk4qExkZmvzEg1cgK9sURYCcpGTnP5CZ1jdi0sLm0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RJajxqjaSvfdCZBLLTpNvGjpgM/SJyVwjTHopxbF9qAscEtreGY/BkVdSmtCsaZFm
         uZXD1wAfnH9GLc/FOS1l0yi0hlp0ilj/Y+BYaUFuOy2a4fT15LJ21bDwVx0DL5NSnD
         R1lbKGGSLer/UIZRLSZjEHqnBlLq9AdL0p6Fha+w=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0637wvJH090818
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Jul 2020 02:58:57 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 3 Jul
 2020 02:58:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 3 Jul 2020 02:58:57 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0637wtXp122879;
        Fri, 3 Jul 2020 02:58:55 -0500
Subject: Re: [PATCH -next] ASoC: ti: j721e-evm: Fix missing unlock on error in
 j721e_audio_hw_params()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
References: <20200703030910.75047-1-weiyongjun1@huawei.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <8ab2ddf8-88db-a5e5-b97a-76b4fe014bdd@ti.com>
Date:   Fri, 3 Jul 2020 10:59:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200703030910.75047-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/2020 6.09, Wei Yongjun wrote:
> Add the missing unlock before return from function j721e_audio_hw_param=
s()
> in the error handling case.

I'm not sure how that return made it in there in the first place..

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Fixes: 6748d0559059 ("ASoC: ti: Add custom machine driver for j721e EVM=
 (CPB and IVI)")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/ti/j721e-evm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
> index 3a2a8b1f3aa3..174306cf53ad 100644
> --- a/sound/soc/ti/j721e-evm.c
> +++ b/sound/soc/ti/j721e-evm.c
> @@ -330,7 +330,7 @@ static int j721e_audio_hw_params(struct snd_pcm_sub=
stream *substream,
>  		ret =3D snd_soc_dai_set_tdm_slot(codec_dai, 0x3, 0x3, 2,
>  					       slot_width);
>  		if (ret && ret !=3D -ENOTSUPP)
> -			return ret;
> +			goto out;
>  	}
> =20
>  	ret =3D j721e_configure_refclk(priv, domain_id, params_rate(params));=

>=20
>=20
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

