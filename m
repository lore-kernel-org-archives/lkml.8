Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07404C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D12EA20714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hXvwXmyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDYOGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:06:00 -0400
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:32738
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbgDYOGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:06:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT4silFKbwZj6KlFzXi82hhXq8MjMQm5KyCOXx/Wf0drPzHRWO/GWwnonVMpJA36r/9JeQnvIr+0B36qdZBSt5I07pYYel+bFdNdpE5h9VQSC9dBBBTEP575Bs7a/Eq+xHIcJHKNarBHc11s2QEfDgocueBVlkYWPmxGkl6zuAkBBLsRphRkMbSXB+nu8l3+wSNjuv6reweXlmZicklGjTcRXKP05BcfPLNnYKrizDDwcas6y2EVvaKF98m8saqrNMZFC+vN15Kxm0FvHqzgRrhgAOc278WhaXgQJLHtHiicdtjjr9zjJwqUkJ2Sc9Ulftou8ZIA7DF5EpoXM3AWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+i64As6Mf4HVjW4jkhQGIZgyAwdSDQE2KEc+vzCXvk=;
 b=WawRZ+vE1y/Gqy0XIqOSvacCT5YIp1+KrdXUav0rIHuA047IvIMUrEcEp9oCVNp13nW0bWZgC+et2YKckuRvOxETVgbfK8I/4HGoFSgmMqVpfXOukLhuWcO9Zzs1CbS1DManLaPN83RmdT2rDtcleMZvzYdVjyYe71epgBs12qkBAv/ePYzI1bkl+Uz9KRIJyZkqAr+E/I+8xYtv3LSy6gPgoz3v+fzLPv1pSwke2LS0UeZWmxt5dlWEZ4H1cjGk11QeID1ahEsSaH3MrRBAXDeL40LP/bKB3NFzah8kLSHw+axKPSZ6HoMhiBLXTPM0aGnKcpwRiyovoqqiVMB7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+i64As6Mf4HVjW4jkhQGIZgyAwdSDQE2KEc+vzCXvk=;
 b=hXvwXmyrZ+QZCmoSje4FoY6Nkou6D7RtvOlUCp7DbnLMy9I8arc9m7dTIrz/k5UuNKpL1rPLCDBeZjVCg8QBO90tEtghdDSRTJAT5ya4TOyjFFugEpQQWRiQ0SsPsN2uYG0+3FA4omtqsfNqu6RGuD1bsnlJIuIl0GsLt8KDXlI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6653.eurprd04.prod.outlook.com (2603:10a6:803:122::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sat, 25 Apr
 2020 14:05:56 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.2937.020; Sat, 25 Apr 2020
 14:05:55 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, Anson.Huang@nxp.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: freescale: imx8mm: correct VDDARM@1.6GHz
Date:   Sun, 26 Apr 2020 06:06:48 +0800
Message-Id: <1587852408-6483-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0001.apcprd06.prod.outlook.com (2603:1096:3::11)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR0601CA0001.apcprd06.prod.outlook.com (2603:1096:3::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2937.13 via Frontend Transport; Sat, 25 Apr 2020 14:05:52 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2a8e3a4-3869-477e-2453-08d7e921c593
X-MS-TrafficTypeDiagnostic: VE1PR04MB6653:|VE1PR04MB6653:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB665307F04E95DCCBAADB6DFF89D10@VE1PR04MB6653.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 0384275935
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(2616005)(956004)(66946007)(66476007)(52116002)(66556008)(8676002)(6512007)(6506007)(86362001)(26005)(8936002)(5660300002)(6666004)(2906002)(4744005)(81156014)(478600001)(6486002)(186003)(16526019)(36756003)(6636002)(4326008)(316002)(32563001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnyjQ4bSJ2H4/3c1bv+uFfK3qa76jEg+PxOze8a7FG1KOyCS7qmeT7mkG0QosB9LqcQoMs8A16pUUG+444xsZX5GpNY8oHzbmaJBKUZUQSKEHxoyQMdamC+yIhSNSVfP2BRiAVcO+7jwlJ2Bl9q+aboBxJEze37lUl9CJkMk0Gf/l2mwweK6jtH5V3zgA2V0eWiAVbNjDkGsHetgYa/LSQ1dzEYkEieIcCVxUl4ppcASkteTuX5w66TODhLP8rYuzS54GPYYoJKU8jveVZjAPn64EDdnkoiqWAYF3O46QMSYIn8FbiUfEYdbBlt5TXm79/4PSlt9VBxS0+h+YG4JuhVU8J1Pevo0PN15sCCqH06vKLjfW3WM6/7NKWF6nJCH+xODOJm+w97msiwxp/h7x9EUMtIxxd5QYp+o/WWqH7UaM8rGogMMebGmL4dTPL0veNbZzwP6veJ3RMCuJ5wuQPxJa5vo7GsWKNZLS9cvZPFilR+8xBfzx1B4pC37wUPh
X-MS-Exchange-AntiSpam-MessageData: URKIo9yAL8S9xJoDtQOireneU4QhvqknlPpR9LPmbINHquP8f7r9PYC9uP2gyJ2CyrKRTvFsEy531NraGpvXlzIHwQ98LkvG9Zz1IT4scMLCqGzDqLTpoqcPI15AhQswNzSySCMOA3uHoWVo92gmRx1jEK/HX+XGA4v91AesWuSHguEjYG8EblXFoFmhhoQZ7+wFZFBfa27Vbi6Twbjq/iZncHZxLgRqQkqLb/LKrduBkMV1JpO2VIma5/oRd2cp095ioyi1tkLhqh8V2/e7KH3yJTOHQqOqgKrI8G0Ex7PqCrSlmwvlVvJKPagF4tc3klPbZudgTcUQI9zdS/3neY/Z6n/FJbdEKKecBieEmZ1SOb9go3buM4l+S7B5QpymhYp+lVuWdYdxOxN3duzG7vtHs6pdvCTzmjX7+BCnfIKuaLVX+2khiSOeXaouOXlxIXEJHaincAV1B81AUgYZk/tkrwKG76CUiqmrh8SIzlQr0NDqYvwz8uvjULQCeEo8CjZqOf3YB3obDAQO6HwhB+TvbkSPP8VTjtG2JdgvovUU8wiL/CpX/2sJ598YQOhhHZNDpsMwHZtwVxpQnPx+Uu77LjBYy2RSUaJB8YKI2H5KIps6SE4ZytsGKeuelkLSrmMj9cQQTJrKRTA8xrwncmZXmDQdmmdcinQlYtTwM1u9B44auOlIbiXgr/Rv+XtDM26hHTI9gptyhcw0nPiJUgM5o0+JOHiEZdXYxFVtPMEAnJ4PXBSKdBovnhTdKIX8QOf0Ajo5JcR3JtJgJvP8gTx1SKG4zzyB9FwQ2PqWD20=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a8e3a4-3869-477e-2453-08d7e921c593
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 14:05:55.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbAi7N1q01UsAVkf7bpZ4ZE5/Kmo2l/b1xGnThuoRqkQxb51pHq0IlmnhnkYOXCxWzRVRq0Mi2qzM3yjFjZvOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6653
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct VDDARM to 0.95V@1.6Ghz with datasheet.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index cc7152e..a226030 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -129,7 +129,7 @@
 
 		opp-1600000000 {
 			opp-hz = /bits/ 64 <1600000000>;
-			opp-microvolt = <900000>;
+			opp-microvolt = <950000>;
 			opp-supported-hw = <0xc>, <0x7>;
 			clock-latency-ns = <150000>;
 			opp-suspend;
-- 
2.7.4

