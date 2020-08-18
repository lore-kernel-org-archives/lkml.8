Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65411C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364F020825
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="aD4v5buc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHRGXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:23:13 -0400
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:29071
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbgHRGXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:23:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrnfNT1TrKngAn67qb4/zpjuB6GOcZ0/6+6PABJmsg2SiPxJqxCW9R+etLZNb5qpOzhn7R+WhPBV509UF73tl+xVpTvJGvzKWCdHdJHtloxJcxJhDNwnNjrqWRHZ+w7Qyf2wJC+GGBeCGCw7/jl/2dXP1pB9DLN9XpftQmZI00gHkQ4Wg7WxwaESSN21Q06KFgfltilj3Z2QxCzHqByOzl0fhW3i22D1d4PiZMH8PHbwvRD2vJPV6mwQEoZkoEtlDubgZiDOG/OeFTE5ULsB3ldDp0mwAJKy+qdcAxeuXeqbseKk1XvcUhoJmg5xayMtUlhgrDw9ykzgvnyOZBzmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW7OlGYbquDA4dCFpQ8Dfd24jGf0YQM3WQTRenFnLTI=;
 b=cV6r5y1RyOS2/w1sNQSFK8hNQHGkNRU6mNKBmvj59YYmAJvBbRqMLgxJKKJeAZKulh0P3jFXkcg2pdaXc8S2ZlJRrMtTTmprdxGajj5DoWcAhynq12osgQOVKYg6ZS8NdtdKFVcS9Cj+lIG2ezQnmVVAVN+c8Ws3hbkllrEq8KW3+7YI9UQ1UBCirFU7WyEO2PVO4Q7U7DSiReDizxTOxTXl1dCkmgdxsqoSig4gXAPnVh8tKeql8LQGp3m6clue1EB8VzeRWFP/aWF5Dp5Q6Qa8ImStR+s0MIW9QDoQFUnHVXe13CWnw/VbvVlGuiLDxF8SBi1VW9lBJ5VKI8pw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW7OlGYbquDA4dCFpQ8Dfd24jGf0YQM3WQTRenFnLTI=;
 b=aD4v5buc9mC/CmUCwVJPawmcTUKDLWbgSmPyVzSiQTKtwJGZsDnKjc/S9GR6n/Pzp4T8Dy0eSsyKmZ/MIoJKvuGyBKcMQ9u5+Q9SANoRXbv2kTXZ7Od8c7QPsEeI5hTLsiw1KXWgLkzZJVdvCRhYgI2oA2PuKd5yUUJxFoM421s=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kococonnector.com;
Received: from AM0PR09MB4067.eurprd09.prod.outlook.com (2603:10a6:208:194::14)
 by AM0PR09MB2627.eurprd09.prod.outlook.com (2603:10a6:208:e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Tue, 18 Aug
 2020 06:23:04 +0000
Received: from AM0PR09MB4067.eurprd09.prod.outlook.com
 ([fe80::f9a5:ed5f:e58e:d4db]) by AM0PR09MB4067.eurprd09.prod.outlook.com
 ([fe80::f9a5:ed5f:e58e:d4db%9]) with mapi id 15.20.3283.026; Tue, 18 Aug 2020
 06:23:04 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     aisheng.dong@nxp.com
Cc:     fabio.estevam@nxp.com, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Sebastien Fagard <sebastien.fagard@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8qm: added lvds pwm
Date:   Tue, 18 Aug 2020 08:20:47 +0200
Message-Id: <20200818062051.16817-1-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200813084547.20875-1-oliver.graute@kococonnector.com>
References: <20200813084547.20875-1-oliver.graute@kococonnector.com>
X-Patchwork-Bot: notify
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0121.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::26) To AM0PR09MB4067.eurprd09.prod.outlook.com
 (2603:10a6:208:194::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2.207.138.2) by AM0PR01CA0121.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 06:23:03 +0000
X-Mailer: git-send-email 2.17.1
X-Patchwork-Bot: notify
X-Originating-IP: [2.207.138.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73980d17-846a-4585-767c-08d8433f29e4
X-MS-TrafficTypeDiagnostic: AM0PR09MB2627:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR09MB26271F554A928BBD87E14ADCEB5C0@AM0PR09MB2627.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0reuO6HaZiRBDb+O5ZgQMkpAQdBYdFLZk89ghcIirAKZ/G7qbXigfijYYZ9NCqKhuFnMpzTr+dENe97SyUcdWbpfwjY9qaQBlwFTrtsWrS025HLRBQ315LGbsL7o9ixlDq+UahrMy3Y7M3ltF+zu93EJt3nNunYTfdOONXPUSKoUnFN7uCwB2CuiG/O1NF5I8CW/+Lbw4gtYGbrtrhseWnz5pGX1dTv6Ihdl4icrH+vgj0Hacx2K1h3iZY0y1zzHRz3+UTIWqW8+8g69FBji1GjD+eLerBSUfJF1utuo+nyu7Q5LtqzpztiJ5HxyZCLlI1jecAAxIB3t6SKr5T/93VLmDuD+aPilBdkQS/wH9LQ8NwUmP73Blp+A6Qj28PD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR09MB4067.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(346002)(39830400003)(26005)(52116002)(86362001)(36756003)(44832011)(6496006)(186003)(54906003)(6486002)(6916009)(4326008)(16526019)(7416002)(8936002)(316002)(8676002)(478600001)(66476007)(6666004)(66946007)(1076003)(5660300002)(83380400001)(2616005)(2906002)(956004)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RKT8Cwp5cjmFpoQc/NhL9TDVspki2wynZMJSXNZkn5hkrmc9UQsmsxR+Rmx7GCpwb5e4JkgZwbC2macTL2n1MDfMKdmAK0BAZXioUq9riZO0OTrKIaHuq4FshBEAXD0lFzrb3C4Bvjt6NwEoY/ajUU/eHUD6g2N+4Hl+LSTHsyZvtN3J0Uy6f6PooaB2DVRKeVImnXwgBA7uIeI+TaP3FbApcbmzy7VwneBBPzXZeyrBt2tg1ciiuNl+BtxOoUS2LgZ/lT19R2HylNXAGlymDUlqKOqYMD+cCy++4DvVWngm9wdXSFOj4TTcX7p1FwUzoXNc9BPFs02IYIOohuLw1bDbzEZBeh6nUEwRcRkPfq0cKixoFPeHjWnK9Fvo0AuANm1rv7rxe5EkpywCwiVSCTMDkN5If4VWgSbAQEjbNs+mgEL/dt2iPcLJuGZrxRgu380QLCyjk3QkuvwBZ4n0AR5X1YjWgdzoOO8VC52g/veLXcySnE/1pQUJ6t3f0tyt3I/delerAvlIW0pTtF2XgXwnLWB9SPwcEqGsXY9yEddVlI4Q52bT+VEZ+Yzv78EYEFAMhugTHSNVSINlDlgArQeD/mm/9sM7Qt20qqkX5r2NbxupJU6AR9kcSTBLkrwFa2doBHzTk6CtWWbv8rnE2g==
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73980d17-846a-4585-767c-08d8433f29e4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB4067.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 06:23:04.0362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfAgH47Cu5CYrbAEekCY8fuXqdWCFWqnT2Mb8GIEdlYdk042cZ/cwBkYpYglAH/t+0hLb9/nKrYf9C9XTo1VtSBFpSL0D1Z0RfYTKZRMPT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2627
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for lvds pwms

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      | 84 +++++++++++++++++++
 drivers/clk/imx/clk-imx8qxp.c                 | 14 +++-
 drivers/firmware/imx/scu-pd.c                 |  6 +-
 include/dt-bindings/clock/imx8-clock.h        | 12 +++
 4 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index c21e0818887b..be241813fbea 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -7,6 +7,90 @@
 #include <dt-bindings/clock/imx8-lpcg.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 
+lvds0_subsys: bus@56240000
+{
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x56240000 0x0 0x56240000 0x10000>;
+
+	lvds0_ipg_clk: clock-lvds-ipg {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-output-names = "lvds0_ipg_clk";
+	};
+
+	lvds0_lpcg: clock-controller@5624300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5624300c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_0_PWM_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds0_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds0_pwm_lpcg_clk",
+					     "lvds0_pwm_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_0_PWM_0>;
+	};
+
+	lvds0_pwm: pwm@56244000 {
+		compatible = "fsl,imx8qm-pwm", "fsl,imx27-pwm";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x56244000 0x1000>;
+		clocks = <&lvds0_lpcg IMX_LPCG_CLK_0>,
+		 <&lvds0_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_0_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <2>;
+		power-domains = <&pd IMX_SC_R_LVDS_0_PWM_0>;
+		status = "disabled";
+	};
+};
+
+lvds1_subsys: bus@57240000
+{
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x57240000 0x0 0x57240000 0x10000>;
+
+	lvds1_ipg_clk: clock-lvds-ipg {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-output-names = "lvds1_ipg_clk";
+		};
+
+	lvds1_lpcg: clock-controller@5724300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5724300c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>,
+				 <&lvds1_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_pwm_lpcg_clk",
+				     "lvds1_pwm_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
+	};
+
+	lvds1_pwm: pwm@57244000 {
+		compatible = "fsl,imx8qm-pwm", "fsl,imx27-pwm";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x57244000 0x1000>;
+		clocks = <&lvds1_lpcg IMX_LPCG_CLK_0>,
+			 <&lvds1_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <2>;
+		power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
+		status = "disabled";
+	};
+};
+
 lsio_subsys: bus@5d000000 {
 	compatible = "simple-bus";
 	#address-cells = <1>;
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index a6b690d94025..45b63ed06619 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -97,8 +97,6 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	clks[IMX_ADMA_FTM0_CLK]		= imx_clk_scu("ftm0_clk",  IMX_SC_R_FTM_0, IMX_SC_PM_CLK_PER, clk_cells);
 	clks[IMX_ADMA_FTM1_CLK]		= imx_clk_scu("ftm1_clk",  IMX_SC_R_FTM_1, IMX_SC_PM_CLK_PER, clk_cells);
 	clks[IMX_ADMA_ADC0_CLK]		= imx_clk_scu("adc0_clk",  IMX_SC_R_ADC_0, IMX_SC_PM_CLK_PER, clk_cells);
-	clks[IMX_ADMA_PWM_CLK]		= imx_clk_scu("pwm_clk",   IMX_SC_R_LCD_0_PWM_0, IMX_SC_PM_CLK_PER, clk_cells);
-	clks[IMX_ADMA_LCD_CLK]		= imx_clk_scu("lcd_clk",   IMX_SC_R_LCD_0, IMX_SC_PM_CLK_PER, clk_cells);
 
 	/* Connectivity */
 	clks[IMX_CONN_SDHC0_CLK]	= imx_clk_scu("sdhc0_clk", IMX_SC_R_SDHC_0, IMX_SC_PM_CLK_PER, clk_cells);
@@ -130,6 +128,18 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	clks[IMX_CSI0_I2C0_CLK]		= imx_clk_scu("mipi_csi0_i2c0_clk", IMX_SC_R_CSI_0_I2C_0, IMX_SC_PM_CLK_PER, clk_cells);
 	clks[IMX_CSI0_PWM0_CLK]		= imx_clk_scu("mipi_csi0_pwm0_clk", IMX_SC_R_CSI_0_PWM_0, IMX_SC_PM_CLK_PER, clk_cells);
 
+/*LVDS*/
+	clks[IMX_LVDS0_PIXEL_CLK]       = imx_clk_scu("lvds0_pixel_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_PER, clk_cells);
+	clks[IMX_LVDS0_I2C0_CLK]        = imx_clk_scu("lvds0_i2c0_clk", IMX_SC_R_LVDS_0_I2C_0, IMX_SC_PM_CLK_PER, clk_cells);
+	clks[IMX_LVDS0_I2C1_CLK]        = imx_clk_scu("lvds0_i2c1_clk", IMX_SC_R_LVDS_0_I2C_1, IMX_SC_PM_CLK_PER, clk_cells);
+	clks[IMX_LVDS0_PWM0_CLK]        = imx_clk_scu("lvds0_pwm0_clk", IMX_SC_R_LVDS_0_PWM_0, IMX_SC_PM_CLK_PER, clk_cells);
+	clks[IMX_LVDS0_PHY_CLK]         = imx_clk_scu("lvds0_phy_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_PHY, clk_cells);
+	clks[IMX_LVDS1_PIXEL_CLK]       = imx_clk_scu("lvds1_pixel_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_PER, clk_cells);
+	clks[IMX_LVDS1_I2C0_CLK]        = imx_clk_scu("lvds1_i2c0_clk", IMX_SC_R_LVDS_1_I2C_0, IMX_SC_PM_CLK_PER, clk_cells);
+	clks[IMX_LVDS1_I2C1_CLK]        = imx_clk_scu("lvds1_i2c1_clk", IMX_SC_R_LVDS_1_I2C_1, IMX_SC_PM_CLK_PER, clk_cells);
+	clks[IMX_LVDS1_PWM0_CLK]        = imx_clk_scu("lvds1_pwm0_clk", IMX_SC_R_LVDS_1_PWM_0, IMX_SC_PM_CLK_PER, clk_cells);
+	clks[IMX_LVDS1_PHY_CLK]         = imx_clk_scu("lvds1_phy_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_PHY, clk_cells);
+
 	/* GPU SS */
 	clks[IMX_GPU0_CORE_CLK]		= imx_clk_scu("gpu_core0_clk",	 IMX_SC_R_GPU_0_PID0, IMX_SC_PM_CLK_PER, clk_cells);
 	clks[IMX_GPU0_SHADER_CLK]	= imx_clk_scu("gpu_shader0_clk", IMX_SC_R_GPU_0_PID0, IMX_SC_PM_CLK_MISC, clk_cells);
diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index e6ed965c2134..1c51a22bb72c 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -136,8 +136,6 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "ftm", IMX_SC_R_FTM_0, 2, true, 0 },
 	{ "lpi2c", IMX_SC_R_I2C_0, 4, true, 0 },
 	{ "adc", IMX_SC_R_ADC_0, 1, true, 0 },
-	{ "lcd", IMX_SC_R_LCD_0, 1, true, 0 },
-	{ "lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
 	{ "lpuart", IMX_SC_R_UART_0, 4, true, 0 },
 	{ "lpspi", IMX_SC_R_SPI_0, 4, true, 0 },
 	{ "irqstr_dsp", IMX_SC_R_IRQSTR_DSP, 1, false, 0 },
@@ -163,6 +161,10 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 
 	/* LVDS SS */
 	{ "lvds0", IMX_SC_R_LVDS_0, 1, false, 0 },
+	{ "lvds0-pwm0", IMX_SC_R_LVDS_0_PWM_0, 1, false, 0 },
+	{ "lvds1", IMX_SC_R_LVDS_1, 1, false, 0 },
+	{ "lvds1-i2c", IMX_SC_R_LVDS_1_I2C_0, 2, true, 0 },
+	{ "lvds1-pwm0", IMX_SC_R_LVDS_1_PWM_0, 1, false, 0 },
 
 	/* DC SS */
 	{ "dc0", IMX_SC_R_DC_0, 1, false, 0 },
diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
index 003b0293c9b5..d8d07833fbc2 100644
--- a/include/dt-bindings/clock/imx8-clock.h
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -135,6 +135,18 @@
 #define IMX_A72_CLK					191
 #define IMX_SCU_CLK_END					192
 
+/*LVDS*/
+#define IMX_LVDS0_PIXEL_CLK				200
+#define IMX_LVDS0_I2C0_CLK				201
+#define IMX_LVDS0_I2C1_CLK				202
+#define IMX_LVDS0_PWM0_CLK				203
+#define IMX_LVDS0_PHY_CLK				204
+#define IMX_LVDS1_PIXEL_CLK				205
+#define IMX_LVDS1_I2C0_CLK				206
+#define IMX_LVDS1_I2C1_CLK				207
+#define IMX_LVDS1_PWM0_CLK				208
+#define IMX_LVDS1_PHY_CLK				209
+
 /* LPCG clocks */
 
 /* LSIO SS LPCG */
-- 
2.26.0

