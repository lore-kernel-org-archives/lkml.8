Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB42C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1147020714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="Pf96SI55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgG0FAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:00:08 -0400
Received: from mail-mw2nam12on2117.outbound.protection.outlook.com ([40.107.244.117]:24992
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbgG0FAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:00:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsvWSZXCtH4CIS/0PwVZb41VoNhX2vUwEY6S8whxbzSsMGErTV5YgaMZg8sPo4gOuOSUfcw4/7WcppOVur/OIQsszPi2YQ7aRqvk2MEk/DOVs4oN+9thyN6YX2NtowXHu1usWerljzuglPQyWbZ/FyrbeHsAzNSUavurHKUlOGS2Yy4Fv5fEBJBoHiL8OHURw48lm05sCXqn/ZbHFZxfoXii0/fOYHvumX02KT1fWuwHjqtw5RBd7502b2Umdpg7EG+ZVkTWNXC6Etz5J9tcqFvoSwr908WjfuLqWNbCcOX7otH3p4WKs3yZjZl9neqD8jEW6oySQLAfu7xPjhe0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQNHTtxIzShBvGtIlMKkz9O/8pQkqF0MvUCX51cxJLI=;
 b=UifOplsIkCY5z5ps5pz77mONkfNXFWaTH3CituWbTNTPHzFMrI52kUgXI7EuxB835Ga9ART/u4j6VVj/y6q0qnDtY9qcyR02Gi/wJkLJENm/Fri0IiTyXbFG1LOsfamNG1AsBPqCNd5S9AK3GBtmxPP9NKr8JrHbYjjzFJW1YgLOlsnsaOjGBHr2609lZaFodATsXnpl/QFdAC8qCN+i/+mSzDsxd6dtvKDgR2LlSLkk/cEXuawTbQ1yWqXXBlVRdq78NSCvXnlmagcMiTx2NefbvP9ZYH16ISI18AiWjXIQlpWK/npJ8IOVusMXqbpRKm/YNYVEZoZAApumnbpQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQNHTtxIzShBvGtIlMKkz9O/8pQkqF0MvUCX51cxJLI=;
 b=Pf96SI55JgoRFujz/YhIu4eevynnpXmsSYUVgsLewr5zBMwl8mOFUbJ4b2fNh8H/DaqFb3jSUPpQVrrWhLPhJE5fAuVovDYSsH+FYnKQAH6gsjfHjEuv2nb+LOgzygqzXsuuQGJDJNAzAGfZVLWfA0nUewDKL7sT+VZxURUoUHY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=maximintegrated.com;
Received: from MWHPR11MB2047.namprd11.prod.outlook.com (2603:10b6:300:2a::12)
 by MWHPR11MB1600.namprd11.prod.outlook.com (2603:10b6:301:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Mon, 27 Jul
 2020 05:00:03 +0000
Received: from MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::d9e8:a3eb:4f08:e795]) by MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::d9e8:a3eb:4f08:e795%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 05:00:03 +0000
From:   Steve Lee <steves.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        shumingf@realtek.com, srinivas.kandagatla@linaro.org,
        krzk@kernel.org, dmurphy@ti.com, jack.yu@realtek.com,
        nuno.sa@analog.com, steves.lee@maximintegrated.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
        steves.lee.maxim@gmail.com
Subject: [RESEND 1/3] ASoC: max98390: Fix dac event dapm mixer.
Date:   Mon, 27 Jul 2020 13:59:32 +0900
Message-Id: <20200727045932.20877-1-steves.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SL2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:100:2d::15) To MWHPR11MB2047.namprd11.prod.outlook.com
 (2603:10b6:300:2a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2001:2d8:ed2b:74dd:b4b1:36e4:d148:7e35) by SL2PR04CA0003.apcprd04.prod.outlook.com (2603:1096:100:2d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 04:59:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2001:2d8:ed2b:74dd:b4b1:36e4:d148:7e35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d0a5520-4826-4312-784f-08d831e9ebed
X-MS-TrafficTypeDiagnostic: MWHPR11MB1600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR11MB160015B8D48804A38E59528992720@MWHPR11MB1600.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFRArY3ECcAcczKCSPuEU540SkDA6hYwE8gyyI8mPWrxcbZQHeAL01KBCK6uFHt+HlKHLH+uRx7cVZN6P9o+u9jtVOivdnwqFg+Qv/8gwjy+/FTQiBsQImnI4iNRBzjv7gXnGqrVwIxAhPK+xVBpCQ98+HiZy2Yy3GRzTpbkrP4/v/jOqavA/nVMgO4Hvrbgeor1+N9DeFb2GZFkNViM5ycz6oau+xwPQ7MTRQrH3GlAJ2XC3DaIVBEmofM/i9pe5eUkNip+ANdmsQwpY9Za7Y9G8/yn1bBJaMEaIRqkymK4ZRJRNbzQwJkf0+dfSYmdf+4RUs6eQj5UYXGK2pj1CKVmzKe5twWi+3kfCWmRzkomeVgEQBZBbDglEWm3o/rhUxG5aYF3k+taJWqx0BUtDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB2047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(66946007)(2906002)(6512007)(8676002)(66556008)(83380400001)(66476007)(7416002)(478600001)(6486002)(86362001)(186003)(16526019)(1076003)(69590400007)(6666004)(4326008)(4744005)(8936002)(36756003)(316002)(52116002)(2616005)(6506007)(5660300002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: aG4qphtL05KpNrX/D+Qqb32LjiI32OHcnuHPRVAnimtmwTVSBwtkLquRbAVg7wPVFTTS7cwg1omEAFlv8SNhBEGMXunSpZp6tWMwuC5gvizhrd1aDTbX719RONNBsmN/5jYLbLTUI7Fji4MtjjHpBVlsF1Pr88rm3e4Jqzl5qClFSjein8zH5QEPH5Yjp2OnHlHyay5FhP65ikyyxp4eN+P/ZrHl4nB1z1ADZTcur8EDntltAcPjGGn/jca+yzZMp2R4lV/8Rkg6fEd/hFqgsf7t6NAJoJ9n55t34rJP2AaPM7QbhoeKeDCJhZkNmmumJfInjSX+8ymbWMccvZ+MNVUKPYscKMTiTB0pXg1No9ytpHtYMBOPPcp8jfdSo9d6FrSbOubi3D8RJgah8O1MR8s7ix9WLtuA9pkazbyRYwMFf6hHsWdcNnaAy25tZlLG4psSRQ5WMIaBPWQfzHQXFFm78dgntmNUMsxJ3KXqwkhJ0kXbWFXzw8Ds+kqMt5WIB0a1Th9kFE54BrgTW7hSBXhShq4vrMK8pdAb1icbHfFk6aTQ5Z6yWtJY1jrX5/yz
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0a5520-4826-4312-784f-08d831e9ebed
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB2047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 05:00:03.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhOmTndpuy0SJbYdQCn+OEW9M6Imu6ySFO7JBAh/mjd1LJhvM0G/QsxoSOidG/XwPT1UgFGAVGts9Nqvci/MP1cABrhX3YSbnkyh0LnR2ZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Global EN register guide to off before AMP_EN register
 when amp disable sequence.
  - remove AMP_EN control before max98390_dac_event call

Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
---
 sound/soc/codecs/max98390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index 3e8094241645..44ffebac15ad 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -678,7 +678,7 @@ static const struct snd_kcontrol_new max98390_dai_controls =
 
 static const struct snd_soc_dapm_widget max98390_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC_E("Amp Enable", "HiFi Playback",
-		MAX98390_R203A_AMP_EN, 0, 0, max98390_dac_event,
+		SND_SOC_NOPM, 0, 0, max98390_dac_event,
 		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX("DAI Sel Mux", SND_SOC_NOPM, 0, 0,
 		&max98390_dai_controls),
-- 
2.17.1

