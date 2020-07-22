Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCAEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F3A22BEF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Zh4ahZeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbgGVX0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:26:17 -0400
Received: from mail-eopbgr770042.outbound.protection.outlook.com ([40.107.77.42]:22925
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726447AbgGVX0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:26:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W293ufAuZSJg9+kKbMpeKdgWb+Eg02bknTLf5jtfxxybeA5OUbfmoLd4R0C1s8L2AtMSa5dRdkWP9GOJQwwKTu/qq1aV89ru9tFwU6ZzAMmbnOULiHvGHxEYoC1hyKBFWdSZRlHO1BaNAa7jMjPOXgRTMFdvijWb0/ewiu870j+ELmduIHjHy5Rxv7hJtAu61K9OjsWF1KIaXizLCaBpWs0m+00+nYUem0kz/DmYBzqGAAPbTBA9zpNZ78xb2KWV0US5i1UqRrKHmjOxsKyoQ5OG3XZHEFxRTjXIln1rtGqAQY1LA1pCqXllQkielJwEd5gyOpVyirSXGkNDC8Zpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o88HONAvYczZcYSNTG60tYJIGieR9ZY/CEg/UWL1ePs=;
 b=EOj/Vb/np7eyy3/UvcOqwNGDDKc+YnlzGZ3tSS1dOVgHpW4KLNeW/XFqqNgr4lRonOzZPTvcGdgsieopCQFHWrSGRqRQWL36JPJCZerjK42eIFHZsW4IFqwjEVdwUjuHOuAUizjmCASVn5KkFHhIhgi7906YBl4yEFPP9peZCstZczGm3TWh9KB4QYBeoijV9fjwIGudomfldr89pceIDM1E/f7wZSTuWRRviWH+6ZV1K32OqBoNeCFQDy0P7hGXMDjMcskwk+x5GCtbVzIXjjTCDezRKqka29WawHUrDECl//CguwxGWKTh6v0MwSzVwkMIc+uUe1IthEc7L/bHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o88HONAvYczZcYSNTG60tYJIGieR9ZY/CEg/UWL1ePs=;
 b=Zh4ahZeLiIvMtYOj8EWQJbIXqhH5oGjUa48+gHhxGdQJWoE0jFaxelDJF8HFc/tC/dmXAn9XpvLDtR8OE7OtOoZkkuwgw+vZ1YkOAVgJ2jcihQCnYGATWdH6yumotIKnuX3L6Mh+wlFLx6NpmY+hJ6ZCVixgMvJpZBhKEB9rXSc=
Received: from MN2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:208:23c::30)
 by CY4PR02MB2279.namprd02.prod.outlook.com (2603:10b6:903:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Wed, 22 Jul
 2020 23:26:13 +0000
Received: from BL2NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23c:cafe::61) by MN2PR18CA0025.outlook.office365.com
 (2603:10b6:208:23c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Wed, 22 Jul 2020 23:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT024.mail.protection.outlook.com (10.152.77.62) with Microsoft SMTP
 Server id 15.20.3216.10 via Frontend Transport; Wed, 22 Jul 2020 23:26:13
 +0000
Received: from [149.199.38.66] (port=33167 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jyO5z-0005t0-Q7; Wed, 22 Jul 2020 16:24:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jyO7o-0005fc-VN; Wed, 22 Jul 2020 16:26:13 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jyO7k-0005e7-Mh; Wed, 22 Jul 2020 16:26:08 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tejasp@xilinx.com, jollys@xilinx.com,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH] drivers: soc: xilinx: Call InitFinalize from late_initcall_sync instead of probe
Date:   Wed, 22 Jul 2020 16:25:51 -0700
Message-Id: <20200722232551.29549-1-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ff19ef54-f700-4dfa-0ec9-08d82e969fc8
X-MS-TrafficTypeDiagnostic: CY4PR02MB2279:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2279B5871838C59322F627CCA7790@CY4PR02MB2279.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viiACrkmksHhrJVvU/VeEvwWEfDyzHJ4PPiPIeOTU4ZKOOKhH1nCs4AXU+uuY3E4krFaFTBsy4abrUxbuMfEw2qch4EEbqkq2+mCEgEAwGC/b4OzDh+WRdpZCM7XOJMyEjIAZ88xOqYv/fteKLKyQUekTVfhISwcBFdkwOK4iTocG5LUhIduRDQP/z7aTc/MBhLd5DUQiIHzpBdVvDfRiEHviiAS/2xMs0RKiui2R5jfD8UhBAvtmS36bsmMx3nMw0kVyb6tDIt0Hj6VZaa7FGY1lSYAzTsiHoa5oli6wam/x0uXyyHsh9eirdhk+RaCTY9WFQbUcJ+t2X5G+CJCIAaGOTP0fEbaBZlI1EhVYIIad63YtwFDdWsZmyxgpkPxoo21iS6ViaI9Sf5l8UdTGw==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(346002)(39860400002)(136003)(376002)(46966005)(82740400003)(47076004)(336012)(36756003)(478600001)(6636002)(7696005)(426003)(107886003)(81166007)(7416002)(316002)(2616005)(6666004)(54906003)(1076003)(4326008)(82310400002)(83380400001)(26005)(5660300002)(70206006)(70586007)(186003)(103116003)(9786002)(2906002)(8676002)(356005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 23:26:13.3455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff19ef54-f700-4dfa-0ec9-08d82e969fc8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2279
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
 drivers/soc/xilinx/zynqmp_power.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_=
power.c
index 31ff49fcd078..fa05cf12d5f3 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -178,7 +178,6 @@ static int zynqmp_pm_probe(struct platform_device *pdev=
)
        u32 pm_api_version;
        struct mbox_client *client;

-       zynqmp_pm_init_finalize();
        zynqmp_pm_get_api_version(&pm_api_version);

        /* Check PM API version number */
@@ -246,6 +245,13 @@ static int zynqmp_pm_remove(struct platform_device *pd=
ev)
        return 0;
 }

+static int __init do_init_finalize(void)
+{
+       return zynqmp_pm_init_finalize();
+}
+
+late_initcall_sync(do_init_finalize);
+
 static const struct of_device_id pm_of_match[] =3D {
        { .compatible =3D "xlnx,zynqmp-power", },
        { /* end of table */ },
--
2.23.0

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
