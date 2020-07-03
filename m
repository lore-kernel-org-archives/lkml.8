Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	SUBJ_BRKN_WORDNUMS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEDFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB9C207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgGCHvz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:51:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59954 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgGCHvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:51:54 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0637pe993017804, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0637pe993017804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 3 Jul 2020 15:51:40 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 3 Jul 2020 15:51:39 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 3 Jul 2020 15:51:39 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8]) by
 RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8%5]) with mapi id
 15.01.1779.005; Fri, 3 Jul 2020 15:51:39 +0800
From:   Kailang <kailang@realtek.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Takashi Iwai <tiwai@suse.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>
Subject: RE: [PATCH v2 1/3] ALSA: hda/realtek - Enable audio jacks of Acer vCopperbox with ALC269VC
Thread-Topic: [PATCH v2 1/3] ALSA: hda/realtek - Enable audio jacks of Acer
 vCopperbox with ALC269VC
Thread-Index: AQHWUQ050FyI+tJN2U+7kMSQrGQS26j1elRg
Date:   Fri, 3 Jul 2020 07:51:39 +0000
Message-ID: <aa62a43d4f1f458fb11794c26d373528@realtek.com>
References: <20200703073753.185147-1-jian-hong@endlessm.com>
In-Reply-To: <20200703073753.185147-1-jian-hong@endlessm.com>
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

Hi,

Please modify ALC269_FIXUP_HEADSET_MODE to ALC269_FIXUP_HEADSET_MIC for 3 patches.
ALC269_FIXUP_HEADSET_MODE was used for Jack detect codec.

Kailang.

> -----Original Message-----
> From: Jian-Hong Pan <jian-hong@endlessm.com>
> Sent: Friday, July 3, 2020 3:38 PM
> To: Takashi Iwai <tiwai@suse.com>
> Cc: Kailang <kailang@realtek.com>; alsa-devel@alsa-project.org;
> linux-kernel@vger.kernel.org; linux@endlessm.com; Jian-Hong Pan
> <jian-hong@endlessm.com>; Chris Chiu <chiu@endlessm.com>
> Subject: [PATCH v2 1/3] ALSA: hda/realtek - Enable audio jacks of Acer
> vCopperbox with ALC269VC
> 
> The Acer desktop vCopperbox with ALC269VC cannot detect the MIC of
> headset, the line out and internal speaker until
> ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS quirk applied.
> 
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>  sound/pci/hda/patch_realtek.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 737ef82a75fd..dfb4bca07d3f 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6149,6 +6149,7 @@ enum {
>  	ALC236_FIXUP_HP_MUTE_LED,
>  	ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
>  	ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
> +	ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS,
>  };
> 
>  static const struct hda_fixup alc269_fixups[] = { @@ -7327,6 +7328,17 @@
> static const struct hda_fixup alc269_fixups[] = {
>  		.chained = true,
>  		.chain_id = ALC269_FIXUP_HEADSET_MODE
>  	},
> +	[ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS] = {
> +		.type = HDA_FIXUP_PINS,
> +		.v.pins = (const struct hda_pintbl[]) {
> +			{ 0x14, 0x90100120 }, /* use as internal speaker */
> +			{ 0x18, 0x02a111f0 }, /* use as headset mic, without its own
> jack detect */
> +			{ 0x1a, 0x01011020 }, /* use as line out */
> +			{ },
> +		},
> +		.chained = true,
> +		.chain_id = ALC269_FIXUP_HEADSET_MODE
> +	},
>  };
> 
>  static const struct snd_pci_quirk alc269_fixup_tbl[] = { @@ -7346,6 +7358,7
> @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x1025, 0x1099, "Acer Aspire E5-523G",
> ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432",
> ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500",
> ALC299_FIXUP_PREDATOR_SPK),
> +	SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox",
> +ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
>  	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G",
> ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G",
> ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G",
> ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> --
> 2.27.0

