Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A03C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C2020748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="nx/gpwMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgGJPt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:49:57 -0400
Received: from mail-db8eur05on2108.outbound.protection.outlook.com ([40.107.20.108]:30784
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726950AbgGJPtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:49:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIgj8tv0AI53AvBGa2SutPBL/Uw7xMuZBCbX4C0YDHfB1HM0BOZ+U+sC5zYaX8d7cFG1wz8RHwWkyojyVMBdGepVGwWiRzjEpNXGoPInAE1mAWBEHsuSYahTG0g+LiY0d9P9Nm1e+JjlsfTLVJXtdiKbWeW72CVNlLstFmNw2SYTu74ZN6SVycQAD4EZ9C/JNXfxI/o+zNoDEyBEERgTfeOACqL0tl6Nwmy51+QQTd6zuv+Z5kuqeBXhU25GB6oAvj76hJwcUU4fFRxrdeKjhmSm8dcmnMAqHaEOFTH5J8AVxiwkLjF8cSrLSXNBiSLloiHfD/c3gxjUCAmkUzSCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7VZ/lscJR0Q5fXY/y8VWvdcz2ufoRTZzeCN0LVp/6s=;
 b=g7+IdGn64n8H+Mz2l9Mdktdhpv7ed4PM0nvWV1kjgaq6LStv4zBqAggZ7SSOEgjpMZW1pEyoi+eZ1ZiRJuYlgG/1yGqk7ZarZXSvpXIMU6xmrkXLp2qEuDcV4apT7YvnnBSmf6BubFQsSatd54u6IWPT9yx6hF1fKIZxA77hiD2Umv80i9cZ6UciJfe0rm83b58Rdqo5+Ur/G3m7UcfpvHsn6dMPXbAYvPBRcObWXRlyI/Ijyh1N4uCzSezjmbTgXBpbXxnDaLQpE+cn5vdXz3MBUwn+j9hA8aG4MR5FjzMTR5i8VVcFIu5Z27zlaDMqDILAumTEH6BxQ0dejUz0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7VZ/lscJR0Q5fXY/y8VWvdcz2ufoRTZzeCN0LVp/6s=;
 b=nx/gpwMp5XlkL3qXGrXNsGbKkBxK9nrD9EcrQzymqmW2v0Vqd40LrFSvsSZXrsoRzV+Pvk/EgTK+VnkUQW1e7DXUagYi3eC7cszc/SIelZCmy2VwU4S+MJz4QHF1Ws4Sj0wwkyUfVdrbBag6w2yZ5cY/pZwOCQrYPPCVmnwbAfc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB5879.eurprd05.prod.outlook.com (2603:10a6:20b:a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 15:49:45 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 15:49:45 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Peter Chen <Peter.Chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: colibri-imx6ull: disable runtime pm
Date:   Fri, 10 Jul 2020 17:49:34 +0200
Message-Id: <20200710154935.697190-3-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710154935.697190-1-philippe.schenker@toradex.com>
References: <20200710154935.697190-1-philippe.schenker@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::16) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by GV0P278CA0047.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:29::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23 via Frontend Transport; Fri, 10 Jul 2020 15:49:44 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09073e39-6fe8-492b-5152-08d824e8de48
X-MS-TrafficTypeDiagnostic: AM6PR05MB5879:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB5879703E116830737ED66A84F4650@AM6PR05MB5879.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0vW4diXeCXKZdVPHU+8MfSI+EdWYT5IJC6/ayB1AOTuYHIog8V45ju7XgPxtHuXnK8qKjdBwiB9tfzqz+j1Efs72BL9/inlQxv6YGnxHkCWzdyL4Ga5CZQlqrPtEqyXVlKTgpMJnC0LHR15ommpvC8emeHrVcT5XDx6pS7y8/l55jXMa0rEI49XJTOeezGjX5bPPm460iaa5kQmQ8FW2D1yFv0S3QZwPmxN3VBUDYRSNtjeJMJ3pON1S/qPBMhJctXM6ga30bi/Oogb7Dzm7kgOrWteV1yPYteF6yboJFWOExFabTrywQqHI3zery98U5IRKuOUDWy3oHNFFOdbtR9+ZjQLg1YxyfTUp4TovgdcLa3BhfCXpbNiIu0Q1w30
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39850400004)(54906003)(66946007)(86362001)(52116002)(478600001)(110136005)(1076003)(6666004)(4326008)(6486002)(316002)(6506007)(26005)(7416002)(2906002)(8936002)(44832011)(36756003)(5660300002)(16526019)(6512007)(8676002)(66476007)(66556008)(956004)(2616005)(186003)(4744005)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3V2JP85FpzvMpYLYWYcUbqCLvwwApr7O4YV5JkLhxilc43qq1QCfVxS11ZqKqj6K+1cg8ojB2VC7WGn5klBmXFlbpTBMF6JRjrQoEXSmwhgX74YkM8qO3oOea9TwtdfPJSC5vLNvZthDfXytKBdEE+v5zZBU6iXXrGcDvWnHqiMvD3kSpg1QXo17hI4TPtYsYmU5tpbbU8zT/MZaADKqx8G7HoJCdwXSMFxlB+70SmyWyOUZFaDzYlaDcrb42TfNao8RMgKSRokIM3YwKaNud23h4REdnBTiOQVILGZ2/o1TFLsxG0Z3ZpCbH8hXPOI+ub7TU5QAealZfupxYo8uq/4b4R9uDZi6FJs6xxrtNgG5/nRscFy91Oirl0jhO0WpiTosW2vSaAdEYMKZPeSWRh9qa5HmqI7rIa6gocv9w/iGNeUFtLAmoPj19We+UCi2txALQCVrbrjGeGN1Vpcakz7Y/JCVPXy0tIJ4xvXZyyw=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09073e39-6fe8-492b-5152-08d824e8de48
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 15:49:45.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIziJ+6Rq8dWgNRj8eRNFGzkSpLKOcYY/pxcRA3Rw4/vYkFau+0XQn8BHoXyv/J+MAixlL8JJtwB/7bHZqOYx9EvhOyYnsrk+tIQ62NXsLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Colibri iMX6ULL has a somewhat special hardware design due to some
legacy decisions regarding USB OTG. This leads to different issues
when runtime PM is enabled.

Disable runtime power management on colibri-imx6ull USB.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 9145c536d71a..1c6692237506 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -195,6 +195,7 @@ &uart5 {
 };
 
 &usbotg1 {
+	disable-runtime-pm;
 	dr_mode = "otg";
 	srp-disable;
 	hnp-disable;
@@ -202,6 +203,7 @@ &usbotg1 {
 };
 
 &usbotg2 {
+	disable-runtime-pm;
 	dr_mode = "host";
 };
 
-- 
2.27.0

