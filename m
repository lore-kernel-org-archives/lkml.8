Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A25C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB4C2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="IN0Ja54i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgHKQ53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:57:29 -0400
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:40000
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728975AbgHKQ52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:57:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0v2J/37CGQ3d4bSjkXtgnIXB4G1jI8VSurBjsaQw6gUqYLpqTpGbPdEAvOAkTgUh072wIWi+8FFXC2oozOunoV1F8uaZYHTdxPVOjTHAyqucFvjjB5mWztsCkOvP5JcqpQ6xB5+3fzx802CPpDf+62CSj1Gl2YxkgasYN74yRFDvtWYGPIyz2A0q6GRhgm3fX7C2cjlkKQSg9q0qMspa1nxTSJRL6l5xOYIas6Wr8NvU4acdYnC9rJ4wyXGLq0AnLRSKwFMPaLJCs9NwmOexExk8MK4FAw+9r0l/v3ozS4h2O5T7ofB/Cek7k8Fyb7eulADBB1hStWmY1A73AWZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw0xafDtwv027Qsh9wkR5zgsCwR3/eiXEqTpTAuyHoU=;
 b=malQEMEKVmeXqpPDT2b/PHU5mOoff22Z+qVdxN8+ripPqY2qtdmmzforwiJ21oa9u9vqC3UeWtOvQksOk53xhd4cqi5M/Y+meUijvIFLsHdWg94cEHfEWaHSEWBxYv+7VsgcAuKII9204YYadH4szWRbhmK0EuKLHSFKwIlzc8Uhpntd934IzPFwBpzyT25pv0BVWg0+SfBjcj2uzt4JAXTv8kCfK4708Be0voGmb4kLtdkW+kwJvf/uI0uHuKtg/uPHNbwnKcQ/Hv5QnfVJ0zEfzvAMO7cseSmWhnZ5n1ScCh2AqvfA++7/7q19XniHmQdybiO0uk1XIdnebxgd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=perex.cz smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw0xafDtwv027Qsh9wkR5zgsCwR3/eiXEqTpTAuyHoU=;
 b=IN0Ja54i4lOzPhrHwrkl03kP54+G13UON47UpeIU5DBsxN6DZERHXOf6R5y7o3roBU0A4CydcuWO6pcWw8nGMQJ2+b3wi9MnqgITEr2VBVRWM6z7rFgyQa8n5CvwbUk3jALQwwdTUPQWgZsU9ngOhjHCltNIEdhh5cY+P3Qq6EI=
Received: from AM6PR02CA0002.eurprd02.prod.outlook.com (2603:10a6:20b:6e::15)
 by VI1PR10MB3120.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:de::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 16:57:25 +0000
Received: from HE1EUR02FT053.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::3f) by AM6PR02CA0002.outlook.office365.com
 (2603:10a6:20b:6e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Tue, 11 Aug 2020 16:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; perex.cz; dkim=none (message not
 signed) header.d=none;perex.cz; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT053.mail.protection.outlook.com (10.152.11.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3261.16 via Frontend Transport; Tue, 11 Aug 2020 16:57:24 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 11 Aug 2020 18:57:22 +0200
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 C37773FB82; Tue, 11 Aug 2020 17:57:22 +0100 (BST)
Message-ID: <cover.1597164865.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 11 Aug 2020 17:57:22 +0100
Subject: [PATCH 0/3] ASoC: da7219: Reorganise device/codec level probe/remove
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
CC:     Yong Zhi <yong.zhi@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f75375e-bc62-4d05-60d1-08d83e179f0d
X-MS-TrafficTypeDiagnostic: VI1PR10MB3120:
X-Microsoft-Antispam-PRVS: <VI1PR10MB3120A4F23776C3EAAF889281A7450@VI1PR10MB3120.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAzsnvI6u3JyZx/ZRab6ONnoDueU0U0lDEGiipV/S1YzG99n5mvKEKDY7K9RLGicg7WFXFTNqgkEObCp8uDWtlK7riLmdnBNI8seWVH95BO5lu+evQ1gsIk3KByOjF1vQEbQ9WNVDEykCNdwNE1JXJAg7Mg9BDqCJBGF9muMkhF84RjQYgVYAX6OQEIhlN4KkgXHIx91B0n7N0/f3AARTbZT9F0K6uqIm2vClOOxaaHn8KkmqhL2bDSp9q7PdnHXX844cjoF0xbODo1JcZB7MJl3kP8xDAFl8mWDpXXzo0MZ8jYE7uA7OdQfFQ2Sc9Ixgyi1S9Q+LKTjOh0xOIUJbMVwLTtMHhgfqhaAPcocfJHQHTheYQmGov9BBz1sNZ+ahPu5Od+tltqM941n6DsQPgNt+PaQcCyk79YWn6hk7XsNLBy+aQ4JuKjUSxtX4GQg4TI7F6Gz/Fy/mmQsvMuLRA==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(376002)(136003)(346002)(46966005)(316002)(4744005)(4326008)(107886003)(2616005)(478600001)(36906005)(426003)(70586007)(42186006)(336012)(83380400001)(356005)(86362001)(186003)(36756003)(2906002)(82310400002)(26005)(8676002)(5660300002)(110136005)(47076004)(82740400003)(81166007)(8936002)(54906003)(33310700002)(70206006)(6266002)(136400200001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 16:57:24.3710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f75375e-bc62-4d05-60d1-08d83e179f0d
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT053.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set reorganises and fixes device and codec level probe/remove
handling within the driver, to allow clean probe and remove at the codec level.

This set relates to an issue raised by Yong Zhi where a codec level re-probe
would fail due to clks still being registered from the previous instantiation.
In addition some improvements around regulator handling and soft reset have
also been included.

Adam Thomson (3):
  ASoC: da7219: Move required devm_* allocations to device level code
  ASoC: da7219: Move soft reset handling to codec level probe
  ASoC: da7219: Fix clock handling around codec level probe

 sound/soc/codecs/da7219-aad.c |  85 +++++---
 sound/soc/codecs/da7219-aad.h |   3 +
 sound/soc/codecs/da7219.c     | 493 +++++++++++++++++++++++-------------------
 sound/soc/codecs/da7219.h     |   1 +
 4 files changed, 328 insertions(+), 254 deletions(-)

-- 
1.9.1

