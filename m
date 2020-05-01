Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAB6C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E593F208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DlXlkLF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgEAXnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:43:55 -0400
Received: from mail-eopbgr750058.outbound.protection.outlook.com ([40.107.75.58]:39296
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbgEAXnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:43:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/yRLSaQBdv189wVmdZzqX2NPl8u6iHXiNzjWReyUe/9QtqS4doUFarRcNUgXvR2Qg6YOR6V+ezcZVPwHeYtMrSxtoeL3TcZdrZg/krcj/cVlkE7VQ98WTULry5eKL8gJNLx7SNTpuOnm/FZmuEgmzX9F6z0E9jJ6n/17DN9rTD/toY28eh01CV1/FnUvbJbgt9rzwA/eGxevuqvBTWgdsWDgr42TBgAP/YR+1tlGdkyltTxx5mo6SUIIUy4pv64yRs68wvXDCkbneuXP7sBvKlji1A134YMeTd1qP8X+DPxYSRgnktrTUp+SQc/yL6RvGxmD+m5d79fjpE0DCJ1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlwoRETXK8dK1LUyYeUzMX/A0nSc1vZw3PgFadZZ4hQ=;
 b=MaaNzI6AnGTOHi7VhXnEZiVA+SlUm2pbqRWB9ULXCzROlDXgJbR92tdJkhqnSB6gWZIngrQAu6AmEQ4ok4FkS1YDTHV0bvQZVfYrAiq1fxroRsobPoJszDXZ43qx8pMjcuNr/cfFKwu4XUXza3/y6b4z30B3mA3lWPayDMKlmjToAQ9gBK0qzABlgGYfHHOjVd6fMzguJZyRCdNqyUIHiRfnB8yzblZ1SVPeI49xTBpq7dd1txPCB4/aaNQkO8DkeahxTODdXjZA3A5YFh/O4PGYwQdnntd3OPgBE7PVON2nrToIhZQFq2FfiKHaf0qCBzNyaCVVTeUgwnRTM4kWRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlwoRETXK8dK1LUyYeUzMX/A0nSc1vZw3PgFadZZ4hQ=;
 b=DlXlkLF2epZN1gQR6qwXjuysJC1jvpi+X3tMW/PJ2aqYQ4SjXvIU5LNSY9RN/wZz+Gau0khPgW5lAJgQ5rExdJnpV5ToAGnDWqmLx7Zj+Bcobl0n2b3t6woiEMOMOQfP7DwCP7SHX1bzcSAyuK4mFg5gk42f7HfeuduPpOi3YYk=
Received: from SN1PR12CA0059.namprd12.prod.outlook.com (2603:10b6:802:20::30)
 by CY4PR02MB2229.namprd02.prod.outlook.com (2603:10b6:903:c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Fri, 1 May
 2020 23:43:48 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::46) by SN1PR12CA0059.outlook.office365.com
 (2603:10b6:802:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Fri, 1 May 2020 23:43:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Fri, 1 May 2020 23:43:48
 +0000
Received: from [149.199.38.66] (port=36400 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfJp-0005UR-NL; Fri, 01 May 2020 16:43:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfJr-0001S2-Ux; Fri, 01 May 2020 16:43:48 -0700
Received: from [172.19.3.8] (helo=xsjamitsuni50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1jUfJm-0001RY-WE; Fri, 01 May 2020 16:43:43 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     mturquette@baylibre.com, sboyd@codeaurora.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     rajanv@xilinx.com, jollys@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [RESEND PATCH v2 0/2] drivers: clk: zynqmp: Update fraction clock check from custom type flags
Date:   Fri,  1 May 2020 16:43:28 -0700
Message-Id: <1588376610-253693-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966005)(356005)(36756003)(478600001)(26005)(81166007)(4326008)(8936002)(2906002)(107886003)(7696005)(966005)(15650500001)(316002)(186003)(82310400002)(2616005)(9786002)(70586007)(70206006)(8676002)(6666004)(426003)(47076004)(5660300002)(82740400003)(336012);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d0eae8f-765d-4624-788f-08d7ee297eaa
X-MS-TrafficTypeDiagnostic: CY4PR02MB2229:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2229F1FC0310C88CA702E646A7AB0@CY4PR02MB2229.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgX/0AAbFnEqJQpZUdzxK/n94SY26hewX1kxB28Wkc/upuwW4NruI/Q5Q/EdsjdGDx50UokegVyvd2/Q6CguXimWfvTeeYSuF80xTQ76O0sj5+nRTpJm4NBxwAtHmdJ7O5QrIriI+nN+rcCFoln6DPSimPc9vC2kKKnsBfGqhWG2Zq43uqh+S4M8kkmEI5O2umahZjMEz6PERtxQUhLCF49VcaNr2u/7K+tasAs8jB9ZMlB1AaZauHGoMT2IyfYNiWYp9GUAqAG1eNTQrf5R32FGdh2jY0vilQtcFuSh3JXEi02j3yGlHZZsXa/NpS3hHy9FFsKCVP7Nqc/zXppeCxAaoIQsPZyVy3++rZnyLxwM3INHARR4AAhS7sBNYMEVgXMrSlBqwq0wCEMf7C9u+G2PPV9tLUeb53xMa2WNe+H8xD4r4PnPfjv26D1LUuPtc/ZTiIw/3vQeiJvxETj9+nII3LlXqV3e73tTjjXtVxnlGOwviBWN2XG5vfkp/WOivIGKLvV+626cAby58jg1FYiLaCH2Kcs0lW1rSzBCzmUKYeCnkuBh15MVISGyQp/H3n6qKGsDBAaNxZcFaFWkAA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:43:48.2290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0eae8f-765d-4624-788f-08d7ee297eaa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for custom type flags passed from
firmware. It also update  fraction clock check from custom type
flags since new firmware pass CLK_FRAC flag as a part of custom flags
instead of clkflags as CLK_FRAC is not common clock framework flag.

This patch series maintains backward compatibility with older version
of firmware.
v2:
 -PATCH[2/2] Correct BIT index of CLK_FRAC in custom_type_flag
Resend v2:
 -We have tried to ping Stephen several times over email. Link:
  https://lore.kernel.org/lkml/70D64AAE-668B-4699-8BDB-41CFC755C373@xilinx.=
com/
  and also we tried to pinged him over IRC this week without no reaction
  that's why we are sending that patches again


Rajan Vaja (1):
  drivers: clk: zynqmp: Add support for custom type flags

Tejas Patel (1):
  drivers: clk: zynqmp: Update fraction clock check from custom type
    flags

 drivers/clk/zynqmp/clk-zynqmp.h | 1 +
 drivers/clk/zynqmp/clkc.c       | 4 ++++
 drivers/clk/zynqmp/divider.c    | 6 ++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
