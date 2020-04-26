Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CC3C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4C520706
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgDZQCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:02:17 -0400
Received: from mail-oln040092255019.outbound.protection.outlook.com ([40.92.255.19]:26223
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbgDZQCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:02:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyKFOuTlMNiVLnPADuGi7Oi3jfpkdWOGIHlTbD7Xz0nO9lxXfD7WLApXSaKTgWOHq2xASpGW7frhKAJeQvZ7wUsfDR7V08Wz6KcYG4IeGhYMuLt2LyyxlbGjaTSeX/ONq/LRJqcjph/kFkB4QbrkElm3Q/iwCDzZCzcvPMU1iiZzvLRc73dDPist8PYbfsfb+64XU+BoVzSWTK8tIktcI4ePGQ+ODh0Rj2W6QUVRt7RmkrABuMkSv8GiLZ8UEUrmzDWCjSPJoV+p73KkBNK0/kF4kkP6F+j2aKqCYGWCrhzpzZHgJaplxDAW+zwxKPLz4bfBmsKNMDM5y/NPIsqMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOzwNL9tTyekZAssO3apDo6f2yvpR8WZFk613LHUTwY=;
 b=Av2Ane0Syh3Zo54wGc0gNiMclmniIPBZLuPKaplMIjmJ+Z/yqXVfCxV1OKEL/n978OiK78exDghziJxJhWThwMMUi71mRg0LRJVnGfXex2/zrC442ke9ZMenB6EGddmuYYbxW5Vmu95QesTwS3FS/T7KRCPY6dopi/4tZvvkozXUIU3owFZO2Z0/tsp7oIQb9vSa5uh8iTderhkRoLOk1fzt3JA6h/gOw38rm5R7EPUAzN4zmquQgR+FfiM7w5fudkADVc0JUPPiy6iceQ0ff8obEP68YiguQQS5C5atBkgOC3OFXF2D9s0oopx8Hysa7S8rfup0rh2uWGN5CNeUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=outlook.com.au; dmarc=pass action=none
 header.from=outlook.com.au; dkim=pass header.d=outlook.com.au; arc=none
Received: from SG2APC01FT028.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::46) by
 SG2APC01HT120.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::365)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 16:02:13 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.53) by
 SG2APC01FT028.mail.protection.outlook.com (10.152.250.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.15 via Frontend Transport; Sun, 26 Apr 2020 16:02:12 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:6E5542C01274137A5BE4B33782E1C1684FD391119EE3C5D7C483587BECDD632F;UpperCasedChecksum:7FD3F8FBBA336AB4CF84C07A55F8E0D152F3FCF2AFE13CCE3FC6DE9EF2D5F23B;SizeAsReceived:7728;Count:46
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::21f1:20fb:d1f:8e25]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::21f1:20fb:d1f:8e25%7]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 16:02:12 +0000
Date:   Mon, 27 Apr 2020 00:02:04 +0800
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH 0/1] Fiji GPU audio register timeout when in BACO state
Message-ID: <PSXP216MB0438D2AF96CE0D4F83F48C4D80AE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ME2PR01CA0097.ausprd01.prod.outlook.com
 (2603:10c6:201:2c::13) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
X-Microsoft-Original-Message-ID: <20200426160204.GA8993@nicholas-dell-linux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nicholas-dell-linux (2001:44b8:605f:11:45ec:d37e:a989:bf24) by ME2PR01CA0097.ausprd01.prod.outlook.com (2603:10c6:201:2c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 16:02:10 +0000
X-Microsoft-Original-Message-ID: <20200426160204.GA8993@nicholas-dell-linux>
X-TMN:  [KaNz4fH4ngAjfx7I4zxPbiFJvSvHp+qAaxkqWCAFszjH/ym1njYoCH7ptN41LqmD]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 46
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: a4111465-f372-4eec-e688-08d7e9fb2e70
X-MS-Exchange-SLBlob-MailProps: gjx25WM8ZNUOze3FI6XN1jcfSUfN7+AKvvyu2JDkY1OPHFFDUa6Rjo3rpds/zeKB8TRvkZ8MrmW0EMzH4fFqrJTgv+PaNkZcqKM1+mbLqJipu/5MbylXU34kN6uFgko9dZTChCkPCab5GTe1h29hWc+Z9usM78LK5QZtziQpAiwFRBJ77smDaR4ty6v+ZXLyqBeHxg/YdnS4To1/d1qF9yqR8ketxkTTQMg7cH7oZw91gSE1i1eO159f8Hmk3zzmtuGwxBDs0xYWg1ushSuMWEu15wdwEOULICSEbKrgKV00rCzxDlhkz54m8MM1W806AiDnnTUDjoabrG3swAoyEpFXV+YqhH+57/GJEMM4OF+KErlm37jR1cRwCfA8ySClhUNZJnDqr0cc40GsxeQ87iAAJiPDJKE93s/tPhCULGWF/QSzo25eiHdPXMck8eEeFDqa1srpcg+5jEEga5+XMkdBauebJUulflIfVDPtR3hZoKFYMKcjQn9SfgA/HvtRJSEm1I+8EwCzAxb8BjgNYpU73+IysSMWveSeleItdfunC6l3+brzcUvHtso1ML3fFLLcGa345stcCCDB+xMp//n1yHSNKWcob8j15LK2/aV6jlpsMLbzDfslxh1q4opwFLZYok4X38Zh3cWPR1uwyHkmPO7T7GhTw5+56/sAxJ9sILisECWulumj7iLVdh41D+zD9DFNBx5JXe/Xa5oYClFmiQ8WVi3WUoHQ+xsXFRU=
X-MS-TrafficTypeDiagnostic: SG2APC01HT120:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxExrwiTYyU2m9N5k4iM5IYxL1Ru7V824/+HZ8gEzaXsRRB95iNqo8zV5UMHyW2NTWruQlmKjVpyuNmRZcc2rFZSfAHQM/x1UBdQFtm9IYwfExSXpKTx5911xDTlooDu2o/BagEPmQAh1SrMPH6MGaPC0CJHqBCNoVuGhrt2aep3ONzg5DrsX4drmE9ejaqBBG+c4iexsziTQXHCRRdcwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:PSXP216MB0438.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: s0XPdrXipyHsyg+PreWYlyHBZAkOXqSt58ljvxHUC4bKi+T4XQjjbXc9w+KAMjc9JYefF0AVva52ulrsxikiJgsynkXzbFPG/l//wbRXHcSlvPWSM8D9L5CsnalzHrzHbJGfqmhO8MhL/duETKkiBBkGG3DdKJC7MadB7TQQoZl+X16cptAStRD61vpXYO9T6BqGv3iwSNgBqSb6sFOZag==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4111465-f372-4eec-e688-08d7e9fb2e70
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 16:02:12.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since Linux v5.7-rc1 / commit 4fdda2e66de0 ("drm/amdgpu/runpm: enable
runpm on baco capable VI+ asics"), my AMD R9 Nano has been using runpm /
BACO. You can tell visually when it sleeps, because the fan on the
graphics card is switched off to save power. It did not spin down the
fan in v5.6.x.

This is great (I love it), except that when it is sleeping, the PCIe
audio function of the GPU has issues if anything tries to access it. You
get dmesg errors such as these:

snd_hda_intel 0000:08:00.1: spurious response 0x0:0x0, last cmd=0x170500
snd_hda_intel 0000:08:00.1: azx_get_response timeout, switching to polling mode: last cmd=0x001f0500
snd_hda_intel 0000:08:00.1: No response from codec, disabling MSI: last cmd=0x001f0500
snd_hda_intel 0000:08:00.1: No response from codec, resetting bus: last cmd=0x001f0500
snd_hda_codec_hdmi hdaudioC1D0: Unable to sync register 0x2f0d00. -11

The above is with the Fiji XT GPU at 0000:08:00.0 in a Thunderbolt
enclosure (not that Thunderbolt should affect it, but I feel I should
mention it just in case). I dropped a lot of duplicate dmesg lines, as
some of them repeated a lot of times before the driver gave up.

I offer this patch to disable runpm for Fiji while a fix is found, if
you decide that is the best approach. Regardless, I will gladly test any
patches you come up with instead and confirm that the above issue has
been fixed.

I cannot tell if any other GPUs are affected. The only other cards to
which I have access are a couple of AMD R9 280X (Tahiti XT), which use
radeon driver instead of amdgpu driver.

Kind regards,
Nicholas Johnson

Nicholas Johnson (1):
  drm/amdgpu/runpm: Disable runpm on Fiji due to audio register timeout

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.26.2

