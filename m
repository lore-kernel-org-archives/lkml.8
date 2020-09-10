Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E772CC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF32521D90
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VNrKtroQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgIJB7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 21:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgIJBhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 21:37:31 -0400
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (mail-sn1nam04on0626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4c::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A399C061343
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 17:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqdUYRsx9yXavQhrKs+qzhZi1J1sLgaAv3OjfERjcQ8K1aDcZ0qX4+ZlIQ+llaNpiixf/ObNN+LXiPc7JnxLwGOEdTR0GZx3ZoM3An1JlSj9fxT9Y4Pu+EWMqIYftOSUACBaUWb6qR8x4Z9NlHE74FH7/Mbxoa/yhfrBG0ftzhh8nYdyW+EQhJIlCw/cCryzCx0RuN3ogUaSz511ZBJQon6EX4lRcYwRtvWXIji9Yyg6pSpyy2WL3MxpsSrKYm7gvyt4cEiOLqkRRNUqfr0bUObB5/wONz+8BHvcDvreCFAT/sITKZdXgn8ybe5XI5mBtaoNzJx8G59y4Npxi4U9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oJbVftP5GZ8OS1xyRkZm/DV0t/DZEYm/aH36t+sg8U=;
 b=Z3RoimXiD0MNRFisV7AXOPgEkiY8CdAHNfTwdfyGi3pw7alYbkny+VWNR3yvWyqEXYSjkwQ5YFQfxpKszkEIio6xRv4lHlPCvjZSpw3fOmpTpKIEFZjOlpaqVfS1+Ow0XVBGKjpB9Jtbl6tb7iiRCJLUnoluTXP9QxVRHL4+pJtcLWqCuVtsyK58/yRoC/nCtv1T0gc+EEljZF0pVcRUi1Za5LkxpvEfirDWOsrt7rxsMeIhMOhfjm+Wnx2JjHLPfkCJa3KkRD8DMMoJYBip8wEiiDoSGMuTNiEkSZmBSZpW0RpUJOqXAlWAx2WL6hP4SVZGcfzDdL9FeceSKwuOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oJbVftP5GZ8OS1xyRkZm/DV0t/DZEYm/aH36t+sg8U=;
 b=VNrKtroQaZGJnre/6IX9kUIZm2DBZcLSThYeJzq3I0gj7WcjJWRt9hIPKOmL/ddWxxZ1iSaVSZilIXaVJchueU+LwaJd3CLt0B4eC9IYWjGf1KRgXynXrd5YfO30Ki3H9/qDS/7r9j8U2/KTCwU3AQsh0L0zULfRRUmE82t/MO8=
Received: from SN6PR05CA0002.namprd05.prod.outlook.com (2603:10b6:805:de::15)
 by SN6PR02MB5357.namprd02.prod.outlook.com (2603:10b6:805:75::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 10 Sep
 2020 00:20:11 +0000
Received: from SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::e9) by SN6PR05CA0002.outlook.office365.com
 (2603:10b6:805:de::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend
 Transport; Thu, 10 Sep 2020 00:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT051.mail.protection.outlook.com (10.152.73.103) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 00:20:11
 +0000
Received: from [149.199.38.66] (port=46184 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kGAJe-0007Ly-SI; Wed, 09 Sep 2020 17:19:54 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kGAJv-0006Qx-8v; Wed, 09 Sep 2020 17:20:11 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08A0K6aH001929;
        Wed, 9 Sep 2020 17:20:06 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kGAJq-0006Dg-50; Wed, 09 Sep 2020 17:20:06 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, tejas.patel@xilinx.com, jollys@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, jolly.shah@xilinx.com,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH 3/3] firmware: xilinx: Add sysfs to get last reset reason
Date:   Wed,  9 Sep 2020 17:20:04 -0700
Message-Id: <1599697204-32103-4-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599697204-32103-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1599697204-32103-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 85746a71-5ab6-49d1-8ae8-08d8551f4836
X-MS-TrafficTypeDiagnostic: SN6PR02MB5357:
X-Microsoft-Antispam-PRVS: <SN6PR02MB535718DAD321BD49CF884220A7270@SN6PR02MB5357.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yllcl5yFj5B/GoCaZedNtqqHrkJwLSDnCXMDC64HKU/w0KAbCxh3/FASGDhzp1SUQA8DYZY3WBPAo6wpnadNE2KKakAfUu5yoa/UCFspRPi1zsfwV06rommNY15qbcKv8VLZXD66+/89OhSpvLAMr4z0I+fLur5oYTJ+w4VUtfnf7h9uuygoJE1fVyHUjTJ4SfwoQNjiOTFEXQ5jENt68AJkyNeJcQqrLf6NrvCrGOJMVB8q/8f5Xq5WTbuGnybXfC3ExLvLToxYcBk0exfFHLDgTSHlehczd/Ks9GNWYLgNBdrv7VQzcXpfPqmF0ChmhEpF6xxpZtMP/RPnHYwoGvVIeIoU11aKNK5GMus+GuSggZEMoIOeOnHsOH4IsnHi2YfsZUgHq+ODpRaRiDMV3XuGVHYfyB5S5Um41vEIw3Y=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(346002)(396003)(39860400002)(136003)(46966005)(81166007)(36756003)(70206006)(9786002)(2616005)(2906002)(47076004)(8936002)(82310400003)(7696005)(426003)(70586007)(8676002)(356005)(6636002)(4326008)(316002)(83380400001)(186003)(478600001)(7416002)(107886003)(82740400003)(5660300002)(336012)(26005)(921003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 00:20:11.6676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85746a71-5ab6-49d1-8ae8-08d8551f4836
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

Add sysfs to get last reset reason.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 .../ABI/stable/sysfs-driver-firmware-zynqmp        | 13 ++++++++
 drivers/firmware/xilinx/zynqmp.c                   | 37 ++++++++++++++++++=
++++
 include/linux/firmware/xlnx-zynqmp.h               | 11 +++++++
 3 files changed, 61 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Docume=
ntation/ABI/stable/sysfs-driver-firmware-zynqmp
index 00fa04c..96a5760 100644
--- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
+++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
@@ -101,3 +101,16 @@ Description:
                # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/=
health_status

 Users:         Xilinx
+
+What:          /sys/devices/platform/firmware\:zynqmp-firmware/last_reset_=
reason
+Date:          June 2020
+KernelVersion: 5.9.0
+Contact:       "Tejas Patel" <tejasp@xilinx.com>
+Description:
+               This sysfs interface allows to get last reset reason.
+
+               Usage:
+               Get last reset reason
+               # cat /sys/devices/platform/firmware\:zynqmp-firmware/last_=
reset_reason
+
+Users:         Xilinx
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zyn=
qmp.c
index c5db34f..f590856 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1266,6 +1266,42 @@ static DEVICE_ATTR_RW(pggs1);
 static DEVICE_ATTR_RW(pggs2);
 static DEVICE_ATTR_RW(pggs3);

+static ssize_t last_reset_reason_show(struct device *device,
+                                     struct device_attribute *attr, char *=
buf)
+{
+       int ret;
+       u32 ret_payload[PAYLOAD_ARG_CNT];
+
+       ret =3D zynqmp_pm_get_last_reset_reason(ret_payload);
+       if (-EINVAL =3D=3D ret)
+               return sprintf(buf, "Feature not supported\n");
+       else if (ret)
+               return ret;
+
+       switch (ret_payload[1]) {
+       case PM_RESET_REASON_EXT_POR:
+               return sprintf(buf, "ext_por\n");
+       case PM_RESET_REASON_SW_POR:
+               return sprintf(buf, "sw_por\n");
+       case PM_RESET_REASON_SLR_POR:
+               return sprintf(buf, "sl_por\n");
+       case PM_RESET_REASON_ERR_POR:
+               return sprintf(buf, "err_por\n");
+       case PM_RESET_REASON_DAP_SRST:
+               return sprintf(buf, "dap_srst\n");
+       case PM_RESET_REASON_ERR_SRST:
+               return sprintf(buf, "err_srst\n");
+       case PM_RESET_REASON_SW_SRST:
+               return sprintf(buf, "sw_srst\n");
+       case PM_RESET_REASON_SLR_SRST:
+               return sprintf(buf, "slr_srst\n");
+       default:
+               return sprintf(buf, "unknown reset\n");
+       }
+}
+
+static DEVICE_ATTR_RO(last_reset_reason);
+
 static struct attribute *zynqmp_firmware_attrs[] =3D {
        &dev_attr_ggs0.attr,
        &dev_attr_ggs1.attr,
@@ -1277,6 +1313,7 @@ static struct attribute *zynqmp_firmware_attrs[] =3D =
{
        &dev_attr_pggs3.attr,
        &dev_attr_shutdown_scope.attr,
        &dev_attr_health_status.attr,
+       &dev_attr_last_reset_reason.attr,
        NULL,
 };

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/=
xlnx-zynqmp.h
index 90c8664..f7cb0a9 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -302,6 +302,17 @@ enum zynqmp_pm_shutdown_subtype {
        ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM,
 };

+enum pm_reset_reason {
+       PM_RESET_REASON_EXT_POR =3D 0,
+       PM_RESET_REASON_SW_POR =3D 1,
+       PM_RESET_REASON_SLR_POR =3D 2,
+       PM_RESET_REASON_ERR_POR =3D 3,
+       PM_RESET_REASON_DAP_SRST =3D 7,
+       PM_RESET_REASON_ERR_SRST =3D 8,
+       PM_RESET_REASON_SW_SRST =3D 9,
+       PM_RESET_REASON_SLR_SRST =3D 10,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:       query ID
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
