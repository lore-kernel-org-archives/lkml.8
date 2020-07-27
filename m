Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA24EC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904C120714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="ZgqKyLnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgG0FBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:01:12 -0400
Received: from mail-dm6nam11on2108.outbound.protection.outlook.com ([40.107.223.108]:3293
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbgG0FBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:01:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg27tascH40J8GVLlMXRDQDeTGGuv0cJLwHSyZxvPMShDN1sSdcpIhk0DcJw9cIO6r+2r2o4Z8iv5ZuKDGEjSFzT7UWe5txXvgLtnEBy/C9BEaEfcN3sUAL/qOhr7kHpOp+F0kvfTq7ekHws66u1KUQ4HGL7DV6ladvgK4vLK1GHmbn+ZDx69xwqjeDyYSc5UYCmdSbEaJaEZz7tJk4VdfoXVn39cnBE/s4Xcx2tIqCjA8Ln2PlMl0xTCQejzJQpXK5IUm58cBBETRiDuN3yywdf+o4y+M41SeDjQJ9neookjUF8A7/lj+Se1Woju7e/oiC3zhrms4PFcezY0F5JBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDRH4qiL700yFDtGPrFJoisOMBcGYtSiOud1ZsmG/XE=;
 b=bK6onDZ//aXT83a3vFBQufacgDyZu25wu/pxwuf02e3W8YoaJk2VOEsFs/qXn+8QlYqDnE7tM7+6CGWPccupOvVAWBzMp+AmUBdRkKMBPeQrwAE4cZ/YhiEXegk/jvf9/mTDCQnqAfdCUjVa3ramKFTf6k9imKQbiCXYBsR50qlbV3wSzVtR+APJQGzeDplq7zROC0hWt/av++PMz6/vWMuyp8hrADFgs0IN/4+tTcTv5eAsVmdm9hY//ZTq8lLnQPkbEBCv0h9Q5jJ880VnRrD45mDRCouuQJDr9Wz0Cad87TtZTny9GxTKmpkZVYIAEJwitl3DVxXuNPHbs83jWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDRH4qiL700yFDtGPrFJoisOMBcGYtSiOud1ZsmG/XE=;
 b=ZgqKyLnGJINtuzcE0xPKBXGGb37upVjzhXVADa3HApb7lLsfysZadlvdMPWB2NRitdC7FYuIqTffRSOQXSKMcsd9p+Xuvp7GKOIDzXwRTwWccymuODnQEGaeECLczxoKk7pWvFn60HhH0Dt/DwGbIgf2w4iYQNsiHV1Wqo8l8RI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=maximintegrated.com;
Received: from MWHPR11MB2047.namprd11.prod.outlook.com (2603:10b6:300:2a::12)
 by MWHPR11MB1600.namprd11.prod.outlook.com (2603:10b6:301:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Mon, 27 Jul
 2020 05:01:09 +0000
Received: from MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::d9e8:a3eb:4f08:e795]) by MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::d9e8:a3eb:4f08:e795%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 05:01:09 +0000
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
Subject: [RESEND 2/3] ASoC: max98390: Update dsm init sequence and condition.
Date:   Mon, 27 Jul 2020 14:00:45 +0900
Message-Id: <20200727050045.20957-1-steves.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SL2PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:100:55::23) To MWHPR11MB2047.namprd11.prod.outlook.com
 (2603:10b6:300:2a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2001:2d8:ed2b:74dd:b4b1:36e4:d148:7e35) by SL2PR03CA0011.apcprd03.prod.outlook.com (2603:1096:100:55::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10 via Frontend Transport; Mon, 27 Jul 2020 05:01:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2001:2d8:ed2b:74dd:b4b1:36e4:d148:7e35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79e9c781-a417-419d-5c38-08d831ea135d
X-MS-TrafficTypeDiagnostic: MWHPR11MB1600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR11MB16009D01D3ABDD631D5E31EE92720@MWHPR11MB1600.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuy8QefXwucjvfsxqYYjLEtS4qUI9sO3ZqMKoPr/7V8bddvl+Hs2Z6Ll+AYWFskWTR5qFPOLhE9XnOj8IQmf8pBeHOmHBAEI+zvbmQSeKm3X1c4fGv7qP+bCLWmNFGX7yBTq2bcEzN6m6CZ3uxhk2Qn0cZ4PQGwDQJ1F+sMTyBSfDvE0gkxtixXfUZ4vh2NJLHN9T5xW/uSS0f6EV7FCFH0OcZSbeMw5aUVYsmP1Y6bIQmExFDRdKQn9oylw4tegi06ZruJFjX0o+S9kyqjBDyMhbECBCVo1jSqa3yhNpIcb93nZM6e0XN6DR9kiKGQ5KpNYmw/l9HYLI7KY1WsA1tO64d1YCedg3RAy8L8i4eRPndtgeYTN6qxa7egCp+1OUHI6Z5iH+Tre5cM0u8Hfuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB2047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(66946007)(2906002)(6512007)(8676002)(66556008)(83380400001)(66476007)(7416002)(478600001)(6486002)(86362001)(186003)(16526019)(1076003)(15650500001)(69590400007)(6666004)(4326008)(8936002)(36756003)(316002)(52116002)(2616005)(6506007)(5660300002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: RPaT6uune9uxaPeYWkOn3kU7OpB2Jk9v2u7rxf4+Pk9362wb2xOl5bxgYIFJIp0tdQwtwUrzS6CT+7ONMxBqcm4iY2WJ8PmBJxmCIG+P8w+SxDy8lzueK+KP5aGIXZKgTSvCy6xkm4Ul0txwcVHIrPkyJi3r3bhJz2mXhJlH1NE2O2DQCW+CrojLSH0ZotHBLf0t4I9AS8YtDaoHPU2fx6gmdZv2c+VzZkrCV05B+PjEovuJg7TUv2rErpMJWYS3F4MSPLv3aqw0ptbah3FUPTrcjg6BTR1P3tqCHfqtno0CASsbxnuxFGfycSDQXehhh8xyY7qOoRWQxV9cgBE/jlK2hlTRCsfyk7vDT4xKkPdepG5lFwr/mS6G8ewP0NRtV7RnObklPa0aCTsBfBJMW9FYG7Y80Q1IC1PlvgRO/ACfmx0gpr4N2JUA/p2954it9EVrREiflEkQOy4luLma3liscTELNgxOq7ebhNi5FUk0tNzWbQf2SL0vi60M15R0SkaDB/CTXh+dReYfivF+rP9Js7J7ZJP2BRXyhwyRe2w=
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e9c781-a417-419d-5c38-08d831ea135d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB2047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 05:01:09.3217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KY5jOz2zTg1A7AorbIEddhRUG3L+60aoAFpZEZu6LMyk/vxLrCe56eAB3F/o6rSHkyhDV6lQ0KLZ7AeRfDpKpKoq9NWDpSqz/EGhgvAlBII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Modify dsm_init sequence and dsm param bin check condition.
  - Move dsm_init() to after amp init setting to
    make sure dsm init is last setting.
  - dsm param bin check condition changed for extended register setting.

Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
---
 sound/soc/codecs/max98390.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index 44ffebac15ad..ff5cc9bbec29 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -790,7 +790,7 @@ static int max98390_dsm_init(struct snd_soc_component *component)
 	param_start_addr = (dsm_param[0] & 0xff) | (dsm_param[1] & 0xff) << 8;
 	param_size = (dsm_param[2] & 0xff) | (dsm_param[3] & 0xff) << 8;
 	if (param_size > MAX98390_DSM_PARAM_MAX_SIZE ||
-		param_start_addr < DSM_STBASS_HPF_B0_BYTE0 ||
+		param_start_addr < MAX98390_IRQ_CTRL ||
 		fw->size < param_size + MAX98390_DSM_PAYLOAD_OFFSET) {
 		dev_err(component->dev,
 			"param fw is invalid.\n");
@@ -864,11 +864,11 @@ static int max98390_probe(struct snd_soc_component *component)
 	regmap_write(max98390->regmap, MAX98390_SOFTWARE_RESET, 0x01);
 	/* Sleep reset settle time */
 	msleep(20);
-	/* Update dsm bin param */
-	max98390_dsm_init(component);
 
 	/* Amp init setting */
 	max98390_init_regs(component);
+	/* Update dsm bin param */
+	max98390_dsm_init(component);
 
 	/* Dsm Setting */
 	if (max98390->ref_rdc_value) {
-- 
2.17.1

