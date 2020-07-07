Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D513C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF252065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Qz0jTXmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGGKka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:40:30 -0400
Received: from crapouillou.net ([89.234.176.41]:48484 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgGGKk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594118427; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TIqqTb/7DiiTF0NvBRzZ1q2LCcTShKFtonmzu/HJhnw=;
        b=Qz0jTXmWVy9vRXaNcwXnU6oFqCbH3OIE27MWw/sS4VBkSRqDHfkj8+2rYlCH1Ai3EHmulg
        WssaXt1UqbizS/BqeHnnkfOqUlBvwwATd5MVXcjbE4cAxWNgspDQN2tyltqGXQNrJGXiuF
        vmiR360yG4uPQP8sfRBAI9YFuDg0ALs=
Date:   Tue, 07 Jul 2020 12:40:16 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 24/28] ASoC: codecs: jz4770: Remove defined but never used
 variable 'mic_boost_tlv'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        ter Huurne <maarten@treewalker.org>
Message-Id: <4NH3DQ.1N2VLULE2ZMG2@crapouillou.net>
In-Reply-To: <20200707101642.1747944-25-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
        <20200707101642.1747944-25-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mar. 7 juil. 2020 =C3=A0 11:16, Lee Jones <lee.jones@linaro.org> a=20
=C3=A9crit :
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  In file included from include/sound/tlv.h:10,
>  from sound/soc/codecs/jz4770.c:19:
>  sound/soc/codecs/jz4770.c:306:35: warning: =E2=80=98mic_boost_tlv=E2=80=
=99=20
> defined but not used [-Wunused-const-variable=3D]
>  306 | static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
>  | ^~~~~~~~~~~~~
>  include/uapi/sound/tlv.h:64:15: note: in definition of macro=20
> =E2=80=98SNDRV_CTL_TLVD_DECLARE_DB_SCALE=E2=80=99
>  64 | unsigned int name[] =3D { | ^~~~
>  sound/soc/codecs/jz4770.c:306:14: note: in expansion of macro=20
> =E2=80=98DECLARE_TLV_DB_SCALE=E2=80=99
>  306 | static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
>  | ^~~~~~~~~~~~~~~~~~~~
>=20
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: ter Huurne <maarten@treewalker.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/codecs/jz4770.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
> index 34775aa624024..4dee585761c24 100644
> --- a/sound/soc/codecs/jz4770.c
> +++ b/sound/soc/codecs/jz4770.c
> @@ -303,7 +303,6 @@ static int jz4770_codec_digital_mute(struct=20
> snd_soc_dai *dai, int mute)
>  static const DECLARE_TLV_DB_MINMAX_MUTE(dac_tlv, -3100, 0);
>  static const DECLARE_TLV_DB_SCALE(adc_tlv, 0, 100, 0);
>  static const DECLARE_TLV_DB_MINMAX(out_tlv, -2500, 600);
> -static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
>  static const DECLARE_TLV_DB_SCALE(linein_tlv, -2500, 100, 0);
>=20
>  /* Unconditional controls. */
> --
> 2.25.1
>=20


