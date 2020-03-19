Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D36EC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B912137B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FUIQinlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCSOH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:07:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38310 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgCSOHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:07:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02JE77L3048046;
        Thu, 19 Mar 2020 09:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584626827;
        bh=F8cnBozYX8/iF9YH+60dq/RPVSZvGKSsyeEtA3GUHiY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FUIQinlxjeigNZMn1OTmCITKd7pTLCtLHdjpqObiI5xXQgpEQT2Wo5ZRTHr02bDpR
         m00TJZbPf6va34eqFVVpqQaBkhh0SQar92NarCwP468LvJ4ZCqMdYD3BJwrdwd2xU5
         edsOfZgPicfvccrirHYADFMd+WtyTTISsX6abwRc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JE77UJ026756;
        Thu, 19 Mar 2020 09:07:07 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Mar 2020 09:07:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Mar 2020 09:07:07 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JE76v3049010;
        Thu, 19 Mar 2020 09:07:06 -0500
Subject: Re: [PATCH] ASoC: tas2562: Fixed incorrect amp_level setting.
To:     Jonghwan Choi <charlie.jh@kakaocorp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20200319140043.GA6688@jhbirdchoi-MS-7B79>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <0b4a59c9-6af7-a34f-fb08-f5200fbe5926@ti.com>
Date:   Thu, 19 Mar 2020 09:01:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319140043.GA6688@jhbirdchoi-MS-7B79>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonghwan

On 3/19/20 9:00 AM, Jonghwan Choi wrote:
> According to the tas2562 datasheet,the bits[5:1] represents the amp_level value.
> So to set the amp_level value correctly,the shift value should be set to 1.
>
> Signed-off-by: Jonghwan Choi <charlie.jh@kakaocorp.com>
> ---
>   sound/soc/codecs/tas2562.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
> index be52886a5edb..fb2233ca9103 100644
> --- a/sound/soc/codecs/tas2562.c
> +++ b/sound/soc/codecs/tas2562.c
> @@ -409,7 +409,7 @@ static const struct snd_kcontrol_new vsense_switch =
>   			1, 1);
>   
>   static const struct snd_kcontrol_new tas2562_snd_controls[] = {
> -	SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 0, 0x1c, 0,
> +	SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 1, 0x1c, 0,
>   		       tas2562_dac_tlv),
>   };
>   


Acked-by: Dan Murphy <dmurphy@ti.com>

