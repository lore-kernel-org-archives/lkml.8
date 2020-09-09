Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF71BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C9121941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ipduMG0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgIJCl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbgIJCHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:07:31 -0400
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (mail-bl2nam02on0617.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe46::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBB5C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 16:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4mJN5ZHPewRzPck3atcj/n297MNjreTNVnt23r+A2LFs7zTGoIK0rcswgR4qr0LuNhugYUK6V8scs5gDaNPLG3gaAly/IxoNkg78MCebgXTV/JmBgAis1EWsQ/Rx5bYKFeT3Sol3gP17NKSHuh/GYmEkCgzqwpnWGWYg1h3V0sDtMS78bjtM2qHAh53ujSlsIKgIlfff9ZSPvOZLroKD6qeBMGirvepChOFs5n5C92EJntAnSrv7tbNKrEWLVQt6G/LVPnPpxZ/y4fi2wllW3pmKXRGlLxc5oz2q85LyIzst5cyKvnqe9VjIyq9Vgur9g3mToykQfknJRJfOixfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LzcoqAlH4iO6jIGM92kDsG45vR3hzsdE8S9FsehYlk=;
 b=iL4pNoDtd0Y3NOJ3poW0nxfYs8GqkfXi65p1b7G2yxf9YECkl5z+EOlqX/WIbqvbSct7njxX3uVriPb71CC6RwVWyP7VZ5IGUGkkjHxn3hv4gRCnELcc73rOunOsBkk1YlpYinjAvw5GBjfZysXREqCGXcfXdwjv18D1bvCTtseGsNv3l6Rarx0vTWKK37iX+/8U7oGqWbcCMTbvAtk37Fl+Ax75g+OR21j7vmmVHqCNcb3C2+gSCLR4+X7VAVu2peHNdHIjX7HPoCABrkyAtrFN1qJobU3+6wJ6P3wcgFhVBQI1V1kL7AOYrkARBzxz5pqIwDKFfXUq2zQa83OwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LzcoqAlH4iO6jIGM92kDsG45vR3hzsdE8S9FsehYlk=;
 b=ipduMG0iEOF1CdZjCnCxtRXWSzggRfD3AVMe1Tv7Xd/Ucsas2faS7OWbnQa3GiiYEa2pIZBM8Ai+tYk/1X+6j1Hc17IykSE/5zxNsBn+HwJUakTpGCafnzDfEVBotddhWYTIBvc0onnQ3Ws3qIB318rX8ackVCkONh72XRYIac0=
Received: from CY4PR21CA0038.namprd21.prod.outlook.com (2603:10b6:903:12b::24)
 by BN8PR02MB6001.namprd02.prod.outlook.com (2603:10b6:408:b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 23:10:19 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:12b:cafe::28) by CY4PR21CA0038.outlook.office365.com
 (2603:10b6:903:12b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.0 via Frontend
 Transport; Wed, 9 Sep 2020 23:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.60.83) smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message
 not signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 23:10:17
 +0000
Received: from [149.199.38.66] (port=53398 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG9E0-0005XP-Dp; Wed, 09 Sep 2020 16:10:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG9EG-00076o-Pc; Wed, 09 Sep 2020 16:10:16 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 089NA2kB005031;
        Wed, 9 Sep 2020 16:10:02 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kG9E2-0006Zq-62; Wed, 09 Sep 2020 16:10:02 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tejasp@xilinx.com, jollys@xilinx.com,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH v2] drivers: soc: xilinx: Call InitFinalize from late_initcall_sync instead of probe
Date:   Wed,  9 Sep 2020 16:10:00 -0700
Message-Id: <1599693000-25641-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 81f44f60-bedf-49a8-3feb-08d85515848e
X-MS-TrafficTypeDiagnostic: BN8PR02MB6001:
X-Microsoft-Antispam-PRVS: <BN8PR02MB60018EED2B314E1A9B2DAB5CA7260@BN8PR02MB6001.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEvQYLV43lCJErm9O1sFyypEl5rY3YDzrWixijUZ95gcM4NX/H6605PB8u60dzRddAyKX7OzjDnZ/XGh9ipdbwdH3nqu3XZbinoI3xJZhrsxCjNmvQ9z9y4Iua+eqMaWR/5fMpJez3Nvc332B6gaAAZhP8xvfHvTTlCWlcoNDrDntNP6J3rcOv/iAUZ/JgobYo/Aa9PuKeGspH/Pxxdnkq7PQmkvchg/eDV05FbKSFaK3FocJa0TBYeO/Tlb3OzcQZvCy0J+nYC34r9926BRuxJIiGtf0B7r/1N5HUqK80HCT7FysrKXXd/bJ/pK7q09fiXKb9ivHvLW4J4eX45v6hQlPdon+SuyyTDGtyVWVdDJ8JGX6fKk41pyf3cE6L2SDCWceF2tAWk+x+GdDOv8dA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(376002)(46966005)(478600001)(2616005)(82740400003)(2906002)(47076004)(26005)(36756003)(316002)(186003)(63350400001)(5660300002)(9786002)(6636002)(54906003)(70206006)(82310400003)(70586007)(107886003)(336012)(7696005)(8936002)(356005)(4326008)(83380400001)(81166007)(426003)(7416002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 23:10:17.9404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f44f60-bedf-49a8-3feb-08d85515848e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB6001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Initially all devices are in power up state. Firmware expect that
processor should call InitFinalize API once it have requested devices
which are required so that it can turn off all unused devices and
save power. From Linux, PM driver calls InitFinalize to inform the
firmware that it can power down the unused devices. Upon
InitFinalize() call firmware power downs all unused devices.

There are chances that PM driver is probed along with or before other
device drivers. So in that case some of the devices may not be
requested from firmware which is done by genpd driver. Due to that
firmware will consider those devices as unused and firmware will power
down those devices. Later when any device driver is probed, genpd
driver will ask firmware to power up that device using request node
API. So for those devices, power transition will be like on->off->on
which creates unnecessary power glitch to those devices.

To avoid such unnecessary power transitions and as ideal behavior
InitFinalize should be called after all drivers are probed. So call
InitFinalize from late_initcall_sync.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
Changes in v2:
 - Check for compatible string for zynqmp or versal platform before
   calling init finalize.
---
 drivers/soc/xilinx/zynqmp_power.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_=
power.c
index 31ff49f..22d2d2e 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -178,7 +178,6 @@ static int zynqmp_pm_probe(struct platform_device *pdev=
)
        u32 pm_api_version;
        struct mbox_client *client;

-       zynqmp_pm_init_finalize();
        zynqmp_pm_get_api_version(&pm_api_version);

        /* Check PM API version number */
@@ -246,6 +245,23 @@ static int zynqmp_pm_remove(struct platform_device *pd=
ev)
        return 0;
 }

+static int __init do_init_finalize(void)
+{
+       struct device_node *np;
+
+       np =3D of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
+       if (!np) {
+               np =3D of_find_compatible_node(NULL, NULL, "xlnx,versal");
+               if (!np)
+                       return 0;
+       }
+       of_node_put(np);
+
+       return zynqmp_pm_init_finalize();
+}
+
+late_initcall_sync(do_init_finalize);
+
 static const struct of_device_id pm_of_match[] =3D {
        { .compatible =3D "xlnx,zynqmp-power", },
        { /* end of table */ },
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
