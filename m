Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14BEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9540B22B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JFwoI3fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbgGaQsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:48:11 -0400
Received: from mail-eopbgr690075.outbound.protection.outlook.com ([40.107.69.75]:9732
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732678AbgGaQsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:48:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkwT/ULnsIzVVRVv1uRBd5f+8Nrtl1bhKjZA5GBEmHKI/HFIKcKI6uw5QDaprj09R2e0u/bpFBUrr1xJqTKV7O/AiiMV+m03SmgNXLLbKneFJBxLN2yXo9LSXV/9RoS5g8bFZCEsopD4SHFAz2a3CO/iFXrEpX32KxerbxA4tFq+y+WnuPMXo549LRw1/FUj2MS4dRpo+dkkFQZoSXXm3dDN3GKH/PDBG20aWrtf8Zw7puyDNxl5LDs4ryOjvNBMFY+jRgwedSFHb5rZ+AE92uPNExY32OT8LwtwzSwiQTMPJyoP+VyAHEssAGFrxeZGJw13fHNYsvk8vdv4aPGm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5xh2iMbOUuYykH3VtoEpRrVeANMsj9APMUlrpsyzW0=;
 b=LfOfvvltbzZ3hpa5UTA99YKEzTIUG5NTeFyTW3AL6mIvn+3xHm4fLryOZLGzxeDOvin+UWvkQj8KbXZQJt0JQT3AyupiprE9uCa3i3bN/Ug9STEjxQtDAgMa5t5YdREyzkhhQWKU6sk4TVRIcDx9RmNjU5vA9QK6PyTOtWYE4Ka9M+ufso47m1K2r7Nk/K7B7FFaY45pdvZQeRvGtL6rbseYp23irjr/yvCl6UO5NRx0o7FmcPxZTVTbb4wwolMrUnMWPTyA+1lwJxCVszQZa5osReLY0jD4q93jASW8aRBtDEJcYsp1CiisPIdhPCUIQinJBM68S1BtCKN+UkTUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5xh2iMbOUuYykH3VtoEpRrVeANMsj9APMUlrpsyzW0=;
 b=JFwoI3fjq1PYfT1vuDpFSA2P10oewLjVBk0ySh5FL9ZyU8BwOv1GGICVoTpxXDgylS5w6iDq7K8nfT1jflh1J7j1QMvy1heHDyINOOeMmVfTLUeDf7g/AiGn6cq3GAfGkANItZsQ5Qk/SdCajjN28W8MXvqFVu3ONTpmBrvKV+I=
Received: from SN4PR0801CA0004.namprd08.prod.outlook.com
 (2603:10b6:803:29::14) by BYAPR02MB4246.namprd02.prod.outlook.com
 (2603:10b6:a02:fc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 16:48:06 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::a7) by SN4PR0801CA0004.outlook.office365.com
 (2603:10b6:803:29::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend
 Transport; Fri, 31 Jul 2020 16:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server id 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 16:48:06
 +0000
Received: from [149.199.38.66] (port=41016 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YAS-0006bp-EO; Fri, 31 Jul 2020 09:46:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YCU-0007o7-1G; Fri, 31 Jul 2020 09:48:06 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06VGltan024125;
        Fri, 31 Jul 2020 09:47:55 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1k1YCI-0007jL-VI; Fri, 31 Jul 2020 09:47:55 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michal.simek@xilinx.com
Cc:     mathieu.poirier@linaro.org, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/5] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Fri, 31 Jul 2020 09:47:50 -0700
Message-Id: <20200731164754.20505-2-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731164754.20505-1-ben.levinsky@xilinx.com>
References: <20200731164754.20505-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f4e07967-c171-485d-e437-08d835717fb4
X-MS-TrafficTypeDiagnostic: BYAPR02MB4246:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4246196280AD00EC91035146B54E0@BYAPR02MB4246.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7RBjFxjtQuOkHdfMs+M5LuVw9+m7k3Fbs9hjyC91BEHw3Lt3JGDRZOZAOO/NsupHZVEKyFvuYp+NayVqBWEOxgt1ZJORdrYOb7uy/rwSWnDkHk+TCyVIAWi3gIn+nfqnx1E/HA+d819uOkbCdUVpVYpp5ZU6JKRjytCTzocRw2z/7vEBGJVM9RyxkuaCjXh7O2PWOMrWzPsHGnOaTO56Xii/Fghy8oSPLNisrpUdw/5GWVyYzi6bGfs6kPAT55LJ4JJFBzQCmR2KSPbZ7knHM4xTN/W25HIK4CHS8BEQYJsKHrrdITjVugKY5H8aTW4GPGpKHDyBLljzm+5s7wQgwjDBucvWp+5fkvwsooX6852yV6IeTgryG8OPmdv1n2L+O+cMLy7qC87i4G/AoKYLS+fo244k0oXgv8VhnKnhhU=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(39860400002)(136003)(46966005)(2906002)(8676002)(5660300002)(83380400001)(6666004)(9786002)(1076003)(478600001)(8936002)(356005)(82310400002)(36756003)(44832011)(81166007)(6636002)(47076004)(70586007)(70206006)(82740400003)(7696005)(4326008)(316002)(426003)(186003)(26005)(2616005)(336012)(42866002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 16:48:06.2973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e07967-c171-485d-e437-08d835717fb4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP firmware ioctl enums for RPU configuration.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
v3:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct
v4:
- add default values for enums
---
 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 5968df82b991..bb347dfe4ba4 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -104,6 +104,10 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE = 0,
+	IOCTL_SET_RPU_OPER_MODE = 1,
+	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
+	IOCTL_TCM_COMB_CONFIG = 3,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY,
 	IOCTL_SET_PLL_FRAC_MODE,
@@ -129,6 +133,21 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_MAX_DIVISOR,
 };
 
+enum rpu_oper_mode {
+	PM_RPU_MODE_LOCKSTEP = 0,
+	PM_RPU_MODE_SPLIT = 1,
+};
+
+enum rpu_boot_mem {
+	PM_RPU_BOOTMEM_LOVEC = 0,
+	PM_RPU_BOOTMEM_HIVEC = 1,
+};
+
+enum rpu_tcm_comb {
+	PM_RPU_TCM_SPLIT = 0,
+	PM_RPU_TCM_COMB = 1,
+};
+
 enum zynqmp_pm_reset_action {
 	PM_RESET_ACTION_RELEASE,
 	PM_RESET_ACTION_ASSERT,
-- 
2.17.1

