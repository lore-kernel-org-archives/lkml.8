Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F01C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392C4208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgGCHKG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:10:06 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57248 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:10:06 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06379jJC2032263, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06379jJC2032263
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 3 Jul 2020 15:09:45 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 3 Jul 2020 15:09:45 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 3 Jul 2020 15:09:44 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8]) by
 RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8%5]) with mapi id
 15.01.1779.005; Fri, 3 Jul 2020 15:09:44 +0800
From:   Kailang <kailang@realtek.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Takashi Iwai <tiwai@suse.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: RE: [PATCH 2/3] ALSA: hda/realtek: Enable headset mic of Acer C20-820 with ALC269VC
Thread-Topic: [PATCH 2/3] ALSA: hda/realtek: Enable headset mic of Acer
 C20-820 with ALC269VC
Thread-Index: AQHWUQiCbJr6/HdOAk2ka1fKSuRSn6j1b4Ig
Date:   Fri, 3 Jul 2020 07:09:44 +0000
Message-ID: <5f49308c3090463791abddb12e12258b@realtek.com>
References: <20200703070512.174394-1-jian-hong@endlessm.com>
 <20200703070512.174394-2-jian-hong@endlessm.com>
In-Reply-To: <20200703070512.174394-2-jian-hong@endlessm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.211]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please also link model ALC269_FIXUP_HEADSET_MODE on this.

> -----Original Message-----
> From: Jian-Hong Pan <jian-hong@endlessm.com>
> Sent: Friday, July 3, 2020 3:05 PM
> To: Takashi Iwai <tiwai@suse.com>
> Cc: Kailang <kailang@realtek.com>; alsa-devel@alsa-project.org;
> linux-kernel@vger.kernel.org; linux@endlessm.com; Jian-Hong Pan
> <jian-hong@endlessm.com>; Daniel Drake <drake@endlessm.com>
> Subject: [PATCH 2/3] ALSA: hda/realtek: Enable headset mic of Acer C20-820
> with ALC269VC
> 
> The Acer Aspire C20-820 AIO's audio (1025:1065) with ALC269VC can't detect
> the headset microphone until ALC269VC_FIXUP_ACER_HEADSET_MIC quirk
> maps the NID 0x18 as the headset mic pin.
> 
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
>  sound/pci/hda/patch_realtek.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index dfb4bca07d3f..3255da8b3849 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6150,6 +6150,7 @@ enum {
>  	ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
>  	ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
>  	ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS,
> +	ALC269VC_FIXUP_ACER_HEADSET_MIC,
>  };
> 
>  static const struct hda_fixup alc269_fixups[] = { @@ -7339,6 +7340,15 @@
> static const struct hda_fixup alc269_fixups[] = {
>  		.chained = true,
>  		.chain_id = ALC269_FIXUP_HEADSET_MODE
>  	},
> +	[ALC269VC_FIXUP_ACER_HEADSET_MIC] = {
> +		.type = HDA_FIXUP_PINS,
> +		.v.pins = (const struct hda_pintbl[]) {
> +			{ 0x18, 0x02a11030 }, /* use as headset mic */
> +			{ }
> +		},
> +		.chained = true,
> +		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
> +	},
>  };
> 
>  static const struct snd_pci_quirk alc269_fixup_tbl[] = { @@ -7354,6 +7364,7
> @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x1025, 0x0775, "Acer Aspire E1-572",
> ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572),
>  	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G",
> ALC282_FIXUP_ASPIRE_V5_PINS),
>  	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860",
> ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
> +	SND_PCI_QUIRK(0x1025, 0x1065, "Acer Aspire C20-820",
> +ALC269VC_FIXUP_ACER_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14",
> ALC283_FIXUP_CHROME_BOOK),
>  	SND_PCI_QUIRK(0x1025, 0x1099, "Acer Aspire E5-523G",
> ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432",
> ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
> --
> 2.27.0

