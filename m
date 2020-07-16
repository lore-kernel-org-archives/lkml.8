Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159C8C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D847320739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="HQ4AGJ95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgGPM6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:58:51 -0400
Received: from mail-eopbgr40119.outbound.protection.outlook.com ([40.107.4.119]:47723
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728337AbgGPM6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:58:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd1oFdls+lGKbgT/i0ISvWc+fHum3OkATolfA6bpSGi7KHYvtw7b73eDQuPnVysOBMQ30ocojz85C1NAYgCHjphqTZjVcB2Nn79FpWoOnxEUh7LG7v8qQeTjGdRM/Vk7z+9gbBcpVOjydO3QSPyJrWkV6yE0HVBnPyIpGjUaKvvEy2DdGlWDzwGMufykaztFw0vT9v8o75LmNgUhS1MVLfoisVDvF9nq4WkoXTTTQdvrX8yUu0qyEi0e1M3xEyZD/5mgXmykndw1MTImIDio6t9WpiDsfRi6j9N+dOcnU/CEFDJ86LaBhaCtSu555nBZbr8Ghyd/DsG0G/vZMsIM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9riHpQw3WEke/9gDoYP5xi6m6Vp4atFP13WcKUo4kg=;
 b=oAKD12QiPU3/omH+6IjLCyGB4TZ8NhY5n4mkA0US7rXgePPU6PAZrlAP/vEVsqa2K5VrtHjh3pCS70TsAaz80RhL8Pm8SZKuAcW+C2PObU0FJ3tLc2zMEpyPgU9w0C0TdP8GlxaNlOtZlRq73X1JXlgbwFAZXS4umulTsKcHU4FIVMJvSvXuD8y8OUTPp+wtX0/98ise7KSEnuT8lJOlzAAiPTS6Ea3sjx9KDnZhf9qOiVtY/enZt1dfYpcC/2AUO3RDTGjIsTWBz9ifCCcdVejmrOcRePockgnhSWtSNWrS4x7L0twXPpRBgqsUSmT/iSv8A+zuUwlMrjJqztPA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9riHpQw3WEke/9gDoYP5xi6m6Vp4atFP13WcKUo4kg=;
 b=HQ4AGJ95etxIoBbd8l0lDKgcVV/f8u6J6c1FI/vx9wkMyot/IImwv3jEhOvdUlRuMt/garpueqw/+qVnx9amFlywujfuv76rygyfJ43+ej3aIh7k7LJD80rG1Ent9lKju2F+iqEa5/7AUF1zvKT3A28wDJClqa1s557iJTfs5Dg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB4885.eurprd05.prod.outlook.com (2603:10a6:20b:b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Thu, 16 Jul
 2020 12:58:42 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3195.019; Thu, 16 Jul 2020
 12:58:42 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 1/2] ARM: dts: colibri-imx6: add usb dual-role switch capability
Date:   Thu, 16 Jul 2020 14:58:29 +0200
Message-Id: <20200716125831.796904-2-philippe.schenker@toradex.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716125831.796904-1-philippe.schenker@toradex.com>
References: <20200716125831.796904-1-philippe.schenker@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::16) To AM6PR05MB6120.eurprd05.prod.outlook.com
 (2603:10a6:20b:a8::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from philippe-pc.toradex.int (31.10.206.124) by GV0P278CA0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 12:58:42 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [31.10.206.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d95c21c4-48fd-46b2-429e-08d82987f7a5
X-MS-TrafficTypeDiagnostic: AM6PR05MB4885:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB488580209C97D674B06790C1F47F0@AM6PR05MB4885.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11QzZ2CIM4fwzdA6ePnCZpH8rQXxP5Ysobr8enEWvMahB7dLXgp7FliDY1HnGXX0qhulKeSj0x+Cx5KcxD/QTe6bZb7Kkp5QwttocBoEPUDbNzXFbQXANJlFe8MoNi1lI42V8qYamX0dwAhPMwnSUev8T5bBVxmeBUQtJdHRCytnQS6SQUasVUsmEexCtAm9oFjzlStlDFCD8ravX/CkYeuPQk00BwOHmH+eg3Jqd9QesEH+/0nBP7nuvVmMqgDC45ugxnVUGiqGC3V7A89kx3eudhHp47DrZkVNCCt4PWex8k1DlJUQlLQB/Lx2xombq8oWApr6Qh3L0YWlq7mGmPMRkM9BRlCCQtYMH3kwMgQhj5mnKzCat6Red24GnjKS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39850400004)(8936002)(36756003)(44832011)(6506007)(5660300002)(86362001)(52116002)(83380400001)(186003)(66946007)(6512007)(4326008)(6666004)(66556008)(66476007)(16526019)(2906002)(6486002)(8676002)(1076003)(26005)(7416002)(316002)(110136005)(956004)(54906003)(2616005)(478600001)(16060500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QDoVHlXGmunifkLGt9WZ/YrMJpCHVbRS34mwTXxPcqmfYw67JeG2dDITVywodjL5i9sAMppqkDT+oko42d+9v+N1+DAs/Evdqby2k0Wezg0Z/wqhfd/aqhS8BBE/TA2gE+AdYPVQ1PpDjYZaIraws+yREOfpbFWqv+f3xTbQloBzuQH4ab65x7DEZOPeUq3fJJGo6Rbd/rYVSo34EmZq3RBbDqBE7ombYAWBa0ymbcIWIRRdGYznB4WFWlQB8mdJmK07cSJ3DQpvpf7Ym9iMlm9epFUwpnYoJaZLkymkZ63XlPz8dzL6wOBN3RImHfBwLkffPFhGGX677pTXu+dkcJwK4SaTRodgL6DRW00g8kC8vM4VHqKZnYtwW3+m4AHjtK3dc+v0CGs31hz3fahnX96vZ8tXv5VmWqjx3BjR13nnMS/e2RwuzXdUZqqTWo7wItzBGw89lmfPpFOeoemJO7zYDFZ19VC18PRMMqVmgxg=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95c21c4-48fd-46b2-429e-08d82987f7a5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 12:58:42.6490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilEEiWasYAANODGoR1u/rl97ScjwUQ3ORY+PJnc0KE7IVgv6J79HevJJIba7Q6gYERL9ItwxzNhpQTRK/rN7XDdcN87HVs/hqHMWf0rpgMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the runtime-pm wakeup bug was fixed in
drivers/usb/chipidea/core.c usb dual-role host/device switching is
working. So make use of it.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 8 ++++++++
 arch/arm/boot/dts/imx6qdl-colibri.dtsi       | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index 65359aece950..c978b3f19a2d 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -45,6 +45,13 @@ clk16m: clock-16m {
 		clock-output-names = "clk16m";
 	};
 
+	extcon_usbc_det: usbc_det {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbc_det>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -220,6 +227,7 @@ &usbh1 {
 };
 
 &usbotg {
+	extcon = <0>, <&extcon_usbc_det>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 240b86d2eb71..34130f23ceaa 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -364,7 +364,7 @@ &uart3 {
 &usbotg {
 	pinctrl-names = "default";
 	disable-over-current;
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 	status = "disabled";
 };
 
-- 
2.27.0

