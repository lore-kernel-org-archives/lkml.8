Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972B1C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651DD218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="aL94PdYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBDLMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:12:15 -0500
Received: from mail-db8eur05hn2224.outbound.protection.outlook.com ([52.101.150.224]:29465
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726898AbgBDLMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:12:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/H4kMqdNUQdlK9A3V6SQKvo2JFi+ndWG+agEn5ptsitwEUS16hH9QW9Z3K2p0jCShrxq10tmADb7sXCzAXNBs6wfn40QMcBRIdxf5DWYCfrI03JkjS5m0DjjXgFp7Wd+aHI+AI3nLcpDdszS1njTA57jRtnd0HtBS45oW4/dwT9B1/ZKAwxIMLZuJZl6PwsvJm2Io8kctCH3w0f2noXQoTsFJ5VyObFgw1cEeKydqFyWuvvkP/DKZNnPc3m2rAe7Qc2wBop8Byy/8IIb2m/4R3dzfRHLiVbOj/mJJgdgAETH7Pm8hU4Vu+4Md3F+tV7bZok9cE+nwbH0E+nJvkoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAV49Hwb3+4rVgEnJL1pEw5uavLoAiHfUSe5tfDXeQQ=;
 b=QdQPRtW4ct4A5PahmeC78HeaP7FdX6c5u6ta8nyYzZQ2ZMl3RtmDWLHpOr1hg5ukTFE2zPyu1kGSx52RbOEihs3r23ltaZgbPQDkGgIKPtFZ5RfzhiDegtzD8pvWlTTkPPd6nIgXFi/RfGMiSKHVFC3lKiKTRSUrXkKutklkZYG6SuzQMOq8+8Qc8YWcuHgqbHBBvK3yPalYsxgY+2lBxIv1OUQWHN5/d/Xjwx4WFAzPn13Ps72qEECTcskt1DhIVTWhuuA0flk7/gn1Xqo8EwOsmYG47/ZuHWkNbhOhtmVddMp8MVbL/wR214JDn0HVkoebKDpLjf5FQZWnvrUo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAV49Hwb3+4rVgEnJL1pEw5uavLoAiHfUSe5tfDXeQQ=;
 b=aL94PdYcIkT69OBwdpPIlM3i1jVVmPDALqCZa1u4YBvEbD1lnN+CbiFs1G/4nBXL3jXSjekBEwoaMCCPk8aWtswZ3ts3btzgNetbG+dG7Xl4/7SghYM34QMdNzeCla9QWN6sxZq+mtisPaxrCAF3OESbTT2DqLVfqgpb3OIgv4g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB7039.eurprd05.prod.outlook.com (20.181.33.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 11:12:00 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 11:12:00 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     devicetree@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] ARM: dts: imx7-colibri: add alias for RTC
Date:   Tue,  4 Feb 2020 13:11:46 +0200
Message-Id: <20200204111151.3426090-2-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204111151.3426090-1-oleksandr.suvorov@toradex.com>
References: <20200204111151.3426090-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0064.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::28) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
Received: from localhost (194.105.145.90) by PR0P264CA0064.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend Transport; Tue, 4 Feb 2020 11:12:00 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [194.105.145.90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 947a4d50-63b4-4596-c67a-08d7a9630e40
X-MS-TrafficTypeDiagnostic: VI1PR05MB7039:|VI1PR05MB7039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB703982E7FADFF7CE47173937F9030@VI1PR05MB7039.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(4636009)(346002)(136003)(39840400004)(366004)(376002)(396003)(189003)(199004)(186003)(66946007)(36756003)(478600001)(8676002)(81156014)(2906002)(81166006)(66476007)(6486002)(8936002)(5660300002)(66556008)(4744005)(16526019)(1076003)(6666004)(956004)(44832011)(7416002)(4326008)(2616005)(54906003)(86362001)(6916009)(316002)(26005)(6496006)(52116002)(23200700001);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR05MB7039;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;CAT:OSPM;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DM0Cb4zYPK3OzBH4EShGhLVHJTdasKSAbRmXueA7FMwaBhQtVik3YbBPhdGCHsSSuIvC+r+AtNK+ZWCgKtiUjfWPU4hEnJEOGO0m81ImD/W6ChNjLMJSrM9bF8aVYKWD2f1nuWUXFP0X/0l371AacNQrttbfys1m2ynSyeLLe2cIoRlbN9FQ3Jz4mgoHZ5nOdqO/u1Rw+CP0WoZ8HMKFo/A+CYu8odBlc+MgXWudorHYQf1TNc4+JIfrvQFxbFo0dmrHct6bEw///N/2kwQkQVuixO+Sq/0+rSLT8IM9cbIdClmc6/q2ax5kav6QU+477HpiELKlWpiaD4kk/3g9vmG367G4l8bxHYUC+v45IXd5lMTXkd/97pyMe/MeZ30jrv3pXeeyxo+p6ivLZ3tcqJhFfz5Bz/IA89lik6EQIMd2HllglQnHYVgPJMNL2aIK+ztzkEaFecAbHTs2gpYCoy62P/ni+fpwcCSklApacCLJkF9l+fapI5lBwnajPN9Pdyqr8oJxr9uoDZm1ydx2I32lpCHIt6NBJ+26HVg0SKT+gwECJauqpSMXRPFZlSVr+17AlC2r7uStxBIbdPrhkjzmZaWoGDkqtZCVrogwjZ6CEDK1TbyokJWOG5oqlDWeEJjnPR6yE3HPQ7OKyZuhCiBHc1jGJvswee3m4nlb0M4gXI10Sx9YsVpva6+ELYlqWGqT0gyurXEPTqfCWBlez8UPg00+KuehYTA/fTGAlqz2WMS55nf7v0SSG2EpIs3QyPESSYMgbgqJ+qJo9R9VXw==
X-MS-Exchange-AntiSpam-MessageData: NPCJwXNwcNhZAYb4RT6BG3k4De4f6XHl9VwB8Ikb/6BMiHymTeb2SvIL7ln68xvI3W0MxwI7EOJlIKYmqsSIbeBOU7ZjpWsx4EMsvukwbhf8HFXBduqmRHizoOZ/tdCs+la2TmQJxjweGk6/kygE8w==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947a4d50-63b4-4596-c67a-08d7a9630e40
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 11:12:00.3936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWbLWGV82oVZdkr8Z1M2FlgbE1OYAbeVnre8KFAs/WarQ3DYMV0LQmDUkKc3uiGeaWmaO19S8zto6sKmrQdNS5E1yXrimL1tnvHXMluwCRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the priority of the RTCs is defined.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 6aa123cbdadb..9e9e85c10acb 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -41,6 +41,11 @@
  */
 
 / {
+	aliases {
+		rtc0 = &rtc;
+		rtc1 = &snvs_rtc;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.24.1

