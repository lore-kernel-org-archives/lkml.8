Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6BDC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0745A20706
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDZQDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:03:01 -0400
Received: from mail-oln040092253012.outbound.protection.outlook.com ([40.92.253.12]:36234
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbgDZQDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYyyhd28UvU28JP204e64TOCMGZLmN8WfNfOEBhX6Dp9iJas74r4StKOs06x4bEfPD0Ck4MhxP/lKRmjOZKhdxtmUajUtgrzlM3wbVA8raWmBYi7WpWa6cE2qXS8nTb2AVCTg8eBGGuWXyr7TWkPc3yhzacc82GI2LMYuOpHip8DWnps5niJYGhEfZGxKEsgxHxB73lB99ogxCZHKdk76qhAk9NLbGIU+XXqql34ckagvPDQ9vHjqJOrJNk8KwZCbrxEdJriZhbqJrcbtXRP1ygdvzfUPuW6qBSUypYT4yUz4UeNEcblfWkXoOOm5PV0KviQJXxMUIHWwcm7sF/RBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DZgZ5QWuaT2peg9EqcOPsry4+CKogcxj31SjEIgyrE=;
 b=jtXegz0yo6GrPCbuC7B7xrBZ31k/jg7i1qAmgJVPI712JAmzRqbaCD96uBaDFlnMItVTlHPxyW5+6tHnjlZZBcFivEgNyKgCwI4fmExyzgeryQYmB2GEYZsQf9fCpai1ppcuGRkXbrGlnc0msYR2On4tuSc0xgtpIhVZpJCFg+ODY7PSSorcaokkvQOhNqp64yE07EO6C7PZn/80lD6eJqxVh+3VKD+FAbduLvNUCIi6zGtESpsjs07JG77aT0srJh9vecLwlzgYcvw8gNZSey1qdR76Pw5Y/2gPt0Wl1Ft2ineUKz5KywIJEgVB8R979JFXSnA7dIu5pweridOXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=outlook.com.au; dmarc=pass action=none
 header.from=outlook.com.au; dkim=pass header.d=outlook.com.au; arc=none
Received: from SG2APC01FT028.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::4e) by
 SG2APC01HT028.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::484)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 16:02:55 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.53) by
 SG2APC01FT028.mail.protection.outlook.com (10.152.250.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.15 via Frontend Transport; Sun, 26 Apr 2020 16:02:55 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:643432F3B1398E6AF89134093AC97D5B4D3623BEE4874DF0704FD7E2C3CC0761;UpperCasedChecksum:010E43D6B0FE1052C873B96D003C89BFF55FC34E6F5FA4781B01DB250EF1D6BC;SizeAsReceived:7847;Count:47
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::21f1:20fb:d1f:8e25]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::21f1:20fb:d1f:8e25%7]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 16:02:55 +0000
Date:   Mon, 27 Apr 2020 00:02:47 +0800
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH 1/1] drm/amdgpu/runpm: Disable runpm on Fiji due to audio
 register timeout
Message-ID: <PSXP216MB04385D035401937E999DA60F80AE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0438D2AF96CE0D4F83F48C4D80AE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
X-ClientProxiedBy: ME2PR01CA0104.ausprd01.prod.outlook.com
 (2603:10c6:201:2c::20) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
X-Microsoft-Original-Message-ID: <20200426160247.GA8996@nicholas-dell-linux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nicholas-dell-linux (2001:44b8:605f:11:45ec:d37e:a989:bf24) by ME2PR01CA0104.ausprd01.prod.outlook.com (2603:10c6:201:2c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 16:02:53 +0000
X-Microsoft-Original-Message-ID: <20200426160247.GA8996@nicholas-dell-linux>
X-TMN:  [47KDSM8oqXfub5R1EF0pX2w8dpijdBC7WpO4lOhmHLrOii3/EUH8cW4536qqYuUi]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 88ce2e36-aa3d-411a-224d-08d7e9fb4838
X-MS-Exchange-SLBlob-MailProps: S/btQ8cKWiT4Pkfzu6B+glnkCY9YUmtcttqISdudqBoMTqz1AephexnXZRcRasY0M8Sd2mn7Qi08HejU3qCWXbepElryqbYZUf/Pkx3Y8Z/zptXO7eHuV4w7vc5JmPdAB9xpRQAx3Cq5aOlxTF1iljg9HR4+sYFh4bqCNPyJyiIQSAkvvOhz9l8Ox+DV29/PuSdL7OPcq7NMvtijFpfMxdFj1O/lFO1b5yq09U86fzHs33zt/FsJgaUglKpQfqj9tELHbKLN2X9ocB2zDLsDGrvUv7MGm0RS0vsaW55ait6bY+5qLQ4FesscUH/9KJzzW4bu33aYO03deDYZ2gvzTyO2n7jJ3P22oFfgPwV5PUPziPijImllimITGtVNDF8EkL/7RG7bhJZM+nNXsR3ysWbANNT1y/UqW1O8kqs6NChaivUAXwQoZ8meQgH3/hyfVV1HPXFLbzA/vRz1FZ5Uf+qhHcX0iN0DyKXjCzb9UaN6e5/QTERYg8tot7ie3mvBVS7F+ttvjvCO88DUbioj4RJNYXLB5XTid3wdyVopXG83cexTc8Jp/iv50MYonen+6eTcVEUdLVO/WwieYp+lTu2zWsoeU0pM9QO9SwRrP8fE1MUMJ8JDT2TM2NywGejjwCrtiEUiFSAEBRkcNPxpaKpGFMyLDhs7nMaVCP+d+PEU075Fw7ZXUwAeMX2rG12LyYjOVvuqgHIQBRTsUo9qYLmO6K3Egf0UZiUBziin8XaCQxtVfSwg0wbCUi+KIaP1RfVqikRxjbA=
X-MS-TrafficTypeDiagnostic: SG2APC01HT028:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eh9utSnS6n5tDdGDYwqqbv9izapLCpmfv872KSb4DFqdEb8TYNe4JX3Uqqz5JNfzZW2gxq1QVSaGT8ZtQZZR0l42e26KmoiaDNcRiBS11vZgdSLCC9uBcc8AktA1G78AVSnU9sYQW9awaMnPWqqf08K+xlJMzG+akA3inBMron7cuLRxVGZY23zR07GNSYvGSkqfvjwcg0CJE4numwxbCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:PSXP216MB0438.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: CBtoOuBOo3IrGAj4mf13len4ITgzgZgbEnpq9FCT2F4aiKyFfaSVc3vQqsuqggkycRlaxRWF0Ji61O+uAj9gNqPlgmdCHF+FcLakHrvNXZusDLDBFgZhCFSCyi2oHw80sLxt7B7b2DCtAbHLD9gJeUqpgf4ordz/bMsf3/Xa3RJviyjUAVPtx9bbeKogp+9rwW61eQUA17i6trc3MXFStA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ce2e36-aa3d-411a-224d-08d7e9fb4838
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 16:02:55.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4fdda2e66de0 ("drm/amdgpu/runpm: enable runpm on baco
capable VI+ asics"), runpm has been enabled on AMD Fiji GPUs. This
allows the GPU to enter BACO state, as evidenced by the fan on the
graphics card turning off. When it is in this state, accesses to the
registers of the PCIe audio function on the GPU time out, leading to
dmesg errors such as the following:

snd_hda_intel 0000:08:00.1: spurious response 0x0:0x0, last cmd=0x170500
snd_hda_intel 0000:08:00.1: azx_get_response timeout, switching to polling mode: last cmd=0x001f0500
snd_hda_intel 0000:08:00.1: No response from codec, disabling MSI: last cmd=0x001f0500
snd_hda_intel 0000:08:00.1: No response from codec, resetting bus: last cmd=0x001f0500
snd_hda_codec_hdmi hdaudioC1D0: Unable to sync register 0x2f0d00. -11

Pending a fix for the above problem, disable runpm on Fiji.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index fd1dc3236..cbb55d2f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -172,6 +172,7 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	else if (amdgpu_device_supports_baco(dev) &&
 		 (amdgpu_runtime_pm != 0) &&
 		 (adev->asic_type >= CHIP_TOPAZ) &&
+		 (adev->asic_type != CHIP_FIJI) &&
 		 (adev->asic_type != CHIP_VEGA10) &&
 		 (adev->asic_type != CHIP_VEGA20) &&
 		 (adev->asic_type != CHIP_ARCTURUS)) /* enable runpm on VI+ */
-- 
2.26.2

