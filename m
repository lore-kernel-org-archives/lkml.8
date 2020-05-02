Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63743C47259
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED382184D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sdeWNaDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEBEhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:37:22 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:16225
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726486AbgEBEhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:37:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHTJFWiW6RyvzA3YAiPMp99Lt8FISQ4tWbaNMtuHMC2ZGifKYWEf6YkjhPMNL8uSrb35S2AQ93WKMrIa3bG322RWd7Q7waTuJ8QTwqBdI6p6kmdkLAyzztHT3n805wLcQSy71788kp2kVIfZ2cdxfacTPxKtOSFU5GmiBO2ydPjW7wtKtshxehjJhBkVd7HrSPlrNisAxystFHx+Tu9e1kQxdeC996boVq5xI+JSLqECOBOYPZb51Hu72rrLhuw8AEZTszcuoQbHTngKr6AayB3KNlGU0pZKaIa0sDdyCJDtwsb3/DRGuezFy7EaN834yAbi1VPUJi0y6hzMewMeaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+88KA8ZxBlZvF3MCD2se+3EwTYWa/GkHmgoIUXmkrM=;
 b=SL4OyK7N01+l7Z6zfRY6wI0SxYlMvJ+ojYPfKU/9lPcQeKEB10imVYyI/nJkFN+KPFxpeEesHmw6bMOPRk/NBSK5hqyu7O2L7etEvupSLB++y/oEjSeKKYZjTrflOU40GdEPQp2NqvxQfg13z6Uv+/4YLSNfRFuzlr+dwKFsdfId8yxDW+ltOPqCAyjgacpBySQRFcj4OdcLCX/sucHRuSjEHHoOxzrHtpsKDzzaomsi959EYSdeshkRmedyrc6bgtyvB+/0pV4CtGxeO/fCgj9a/HZ3zNZG6EYp/ecjLXgJOqNRuQckY747trxs/ihHcw07YnvBfoTmssLZxAayDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+88KA8ZxBlZvF3MCD2se+3EwTYWa/GkHmgoIUXmkrM=;
 b=sdeWNaDI732u+4106AYgtBBdY0QSNdMwDi5lQ8R+M6MrVwEQEI7QQTZVn4P8kwVCCCG6qEjXBMrCv64/WMsZchNO6OtlyG4sDW38T3Gsaq7zx2p3c3KTAfLsl+jckFT3hmq7waA8gWk8ZI7+bzxKa9lcVhBMlKf5VY9xFeVuzks=
Received: from MN2PR08CA0014.namprd08.prod.outlook.com (2603:10b6:208:239::19)
 by SN6PR02MB4365.namprd02.prod.outlook.com (2603:10b6:805:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 2 May
 2020 04:37:15 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:239:cafe::2d) by MN2PR08CA0014.outlook.office365.com
 (2603:10b6:208:239::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 04:37:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 04:37:14
 +0000
Received: from [149.199.38.66] (port=34458 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUjtn-0002fn-Ex; Fri, 01 May 2020 21:37:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUjtp-0004eZ-VZ; Fri, 01 May 2020 21:37:14 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 0424b5Js003804;
        Fri, 1 May 2020 21:37:05 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUjth-0004de-6f; Fri, 01 May 2020 21:37:05 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [RESEND PATCH v2 1/4] drivers: clk: zynqmp: Limit bestdiv with maxdiv
Date:   Fri,  1 May 2020 21:37:00 -0700
Message-Id: <1588394223-257635-2-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588394223-257635-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1588394223-257635-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(316002)(82740400003)(186003)(36756003)(478600001)(426003)(336012)(4326008)(54906003)(107886003)(26005)(356005)(81166007)(2906002)(5660300002)(8676002)(82310400002)(6666004)(47076004)(7696005)(70586007)(70206006)(2616005)(8936002)(9786002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61644f29-80cb-43ea-154d-08d7ee527cbb
X-MS-TrafficTypeDiagnostic: SN6PR02MB4365:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4365C9EE822094FE8FCE9B44A7A80@SN6PR02MB4365.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SiF05vbsofkBuGVPP+gJ6I2fFzyNEnuGiYb2QkGga81leoRz69t5CBgyhada5pKoYgznYHYNTSyJ5CgS+Kc9eXQzv937qfa7v/uR9ylKTlcxq4JzxL5aVLvkjy2UJLHXpHAY7rkW5//0bXvLXNtKVxWJUmpN96D4r2gQ6yHQpNyCN8X1OveeISyDxmfUrE+iBPZPaIk6JpjIrSm8VIuaA6oNQ0S1vQ5ycjHsUod/+vmTTMfwjNCot6Iby+rz/zvztN7CiYmX0sZ1gahWQ1WS56az9sZ1nGGE4NZXGdN6q5dOVNjClk3iVUzK0lKfnqPPd3Oue/Dz9EP52EptY225WvJj7+eEPavdMQf60GrKD5uTpgcz0WnzBlqnAujKKfjiKz/HHQQGUybdRL4n+8yiG5VZY0DL5O7UJVB7cPlhnnpvADviOMk+H41nVv/G5GYZaeE0B+JaLaXw/zryhid6KK/D89m2oYK9z2/RQrrc8dX4mr9Axor/32YScAIXgpJv8YtX5bD1EWs5AlU7W3qdbQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 04:37:14.3479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61644f29-80cb-43ea-154d-08d7ee527cbb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Clock divider value should not be greater than maximum divider value.
So use minimum of best divider or maximum divider value.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 4be2cc7..5c41ddb 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -197,6 +197,8 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw=
 *hw,

        if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_fra=
c)
                bestdiv =3D rate % *prate ? 1 : bestdiv;
+
+       bestdiv =3D min_t(u32, bestdiv, divider->max_div);
        *prate =3D rate * bestdiv;

        return rate;
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
