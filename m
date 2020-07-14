Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B44C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBD2223FB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="NqUDJylO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgGNPSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:18:51 -0400
Received: from mail-eopbgr60113.outbound.protection.outlook.com ([40.107.6.113]:11653
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgGNPSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:18:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ys1oD5TZpuLGFdYc+W+lX5qupd0nJAVx/uXMyDr/iSLQtv1U1mAVePDdtGpE1Q9K276J1UbISWMVn4MlOPskY22yhBLvwQBCNQcoIaJeY/e8joHSdz+juTE5WkLaRvmEEbQLB48n1swDPUltI4dBn1Obnf99QagoyHf4fcS8IwZutpUHaVdlNP5qHoSbS8dtokl50+EraxVkxM1aVakHTV1NXNZYGdt2ek3SKMJ6rmoDCVeXKMhFgFcFpcRuZVvKhdhWo9awhaW0nFA+9SLAfNjZhOgRhJLeOBOxH9GZX9bbML25klh5/SXEBqp6Xvw0DP1ox5qORfGtst85Bgdkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1qePeighLYZBdGgVpONpJ/bncdGzDKQCGsnUqfn6N4=;
 b=iy6xtp4V1LOAA6XNud7nsatUIW2NvX+kGwgzfsBl1aMGFH6Oy1wfKSZWfEeuirC9seEgezt6zR//ZyxqPkgc52xKOWMgSNwcloATI+31qrvsuMfLiWvacbbSbZ6BaWTk7tWMua7yQxP8A+k0awSW+pWFOPHFEK0tdMzONh+VI6AuI4woK243Llbxfrwv8rRP/i543rx5b+nTyh8q7MB04TzTAmjqcIBIhttHnAuk2UybWJ2ADAiYoJSpihRRWPe8EHh9DBhyoFef4N2M9yvs/ihtpiJKQc5fM2xmEhQk6ck1NfNdghm5TJQLkW9h0GnzAjKiIuvU8zRuqHT8WOB68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1qePeighLYZBdGgVpONpJ/bncdGzDKQCGsnUqfn6N4=;
 b=NqUDJylOLjRxt43k03K16o9HccgJFR8e9U3bVtbBW50SAAeXuZyc/FpVdnAIXHYMaVD1e2SOkVnK0zr7MJEaSoD7a6i6IhauvG13vGZJHpA8q7vp9ec1AowGuc/umi0le7JPr9hsn+V8zYDmv01xbbicNH6flhC9TN7D0k5bR58=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB5174.eurprd05.prod.outlook.com (2603:10a6:20b:66::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Tue, 14 Jul
 2020 15:18:39 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 15:18:39 +0000
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
Subject: [PATCH v2 3/3] ARM: dts: colibri-imx6ull: disable runtime pm
Date:   Tue, 14 Jul 2020 17:18:22 +0200
Message-Id: <20200714151822.250783-3-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714151822.250783-1-philippe.schenker@toradex.com>
References: <20200714151822.250783-1-philippe.schenker@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::6) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by GV0P278CA0019.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 15:18:38 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 444b7346-4b33-4c4b-7ecc-08d828092f7c
X-MS-TrafficTypeDiagnostic: AM6PR05MB5174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB51747FBB6433C47373645E2FF4610@AM6PR05MB5174.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5af6HB3h4H5qQIp1xJwJ/rJtsdU1baZRHu5BP561QbxTFMcIrlFIzrGsDdcqAv6lj2vV6Vbq5eW7TLqY9hUAUNPxDPLsDYjR3wvy4F1EoC5YKSophZ02qiF+QVBBLCjKNOrSEh7Ab1tnyQtfJ3kKQUbPQWO7/cnpR4ZiOL37DqsliGn5KYnoewK8zki1O7TL+2vcq1wqO0twHsuFL2/if921BOfNgL/xGZiBGKVBjsg+UDQNnqJH7zcBIaAtpWyT4L9XdKRCoAa89np8jyOC3TWy4RNl5Blzjd5sYE92BgGIkysVPg4y/Jn16CkBmVimUC+Ve9z3Ort7Pp7n0sQrvSHToS0dj8wZYv1DXOI7DZ+FOpiMsH0Ds0N+S9oJtgGs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39850400004)(110136005)(316002)(86362001)(4326008)(5660300002)(7416002)(8676002)(6666004)(1076003)(4744005)(6506007)(186003)(2906002)(6512007)(26005)(66556008)(6486002)(2616005)(956004)(478600001)(36756003)(16526019)(66946007)(66476007)(52116002)(8936002)(44832011)(54906003)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: F9DZ0H5fs4dIPjEjrDVCfBEnhiet4EA1uDGhyylieoJhkaSsR5OprE5yZG06e6WQhQ6FMkaRlrUGWaS/CCnqnxST2qQFKrTqY9OppFMyusGpJTgpwjjlQF6Rs2vFxnv0eIfJiNo7ZO1kGlwLl8izuhSOrY64CdCHS4mmZ3YoKHKQhD4t9nQwjXTE5dwROwUTD5RsdRG9SqGH7SJdbPfCc8XGbz3CSaeqvqEJZTPkx7KF6V8eO5BZndwtRO6Km7k1gqIbZpi7OMxL/5jb5Wpol/OzJQNZV6+YPUinhGLDuZBgWxIRu85AYh4iqTicwRys8RMbvR9jyXUhiUqs2kIiN/R+sg5iCkpeOhHiMcTsgyTHGMdWMrA7GK2NVNvT/ury933UeIdJMg/06sgz0Z8fDAc2YGyTqzhz+JzvfdcCiXSl11yhFKan/fHBd2slq3fcfSycnELveVd4f6hm9L5IljhrJj5vDbC+rrtzsR3sh54=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444b7346-4b33-4c4b-7ecc-08d828092f7c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 15:18:39.1698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSzuqVRj8LdvLxs8zpBxVdS2ku79O5PuXuXiwaLinuUMIDUluDV8trFalUiFiF9r7x5t0W28i+r8mNr0WshME2mQufQhzGdTdVwylJurs1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5174
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

Changes in v2: None

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

