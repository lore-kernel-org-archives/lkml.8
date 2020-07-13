Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99725C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7E02075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="nZxVsPjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgGMJjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:39:02 -0400
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:5737
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbgGMJjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:39:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMH74DtCVGVxdd9Yexb671KLu47MME090qaNiFZvRwS72b4/u/zEtp7ezTF+WZG6d+yP3ADrvLmrDkG4t0ZBRagFSL6NzZE9lnqYqYAJXbf8CqZFe27ExK0eKJ6R6eefjy6J2UaV3kXjUTAo7GlyJLXmB4yh8ZQwxj7E+aPKA7Awh73mYqCjzdSJjF4IPxEZIyalKJbJ5ArsgDMN+ZYWVwydKeEHxzJnSQX7j+5vcIpjC8ZHO614mBqBQDPioC4Kp1+q0ECoQSqGywr16UOlF3BIKGod4lqdJmIdCHGnGBY4Pz8t1dhXHnOlEDO2+MxhnRSBiKpj2FNLlgJEFYePXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILGyhg1QnPlR/fJo5t+LbRjykwDiGagRtlxF1ard5bc=;
 b=YDS2lVV2Kt5eoZg+1vZtlN0etB/s+kZD3GOqdIO9rezRYf4VRLftq4eQw6cZ6mtE1nOCoix1EAFHPVa1AMeMhOE5qiqF6gfKyxYfPeb/tflxiSKj56MOLvDRe0dO6H4m5W26hStjBfHBGHdyjN4Jf0Hi7j3svk3P2tYvlS664OotkHQQfneoy5OKj1UflUPtoEFdvTJcUlO6xI8sgTP3wsaAVwgQFO3fTlYaHs0ov1zWZyMr6+oL70QExWCP4ssjVdXrtoUqkRgQtpo9AUcO6k7S5QOga2E1EQLnufr4pk1xLQbmCuiS+pAfmeJR6KQ1OS3gKgS57Ze131DliIbYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=diasemi.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=diasemi.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILGyhg1QnPlR/fJo5t+LbRjykwDiGagRtlxF1ard5bc=;
 b=nZxVsPjU6YF9Xv7cY8LkK8O2qzvGq7TUjkwS44StoWB8kPjxQEqFlxlXfA0YpUMcJ1qH6k7gyTmzzytkSsS/OSonyZj/s4v0swlqQ596uTSa3EJTH/dnVarBzxAESu+3AtoPREvxhcJz+u4h++9Vw9EACdrMbCQpQ6KGUu93Dwc=
Received: from AM6PR0502CA0048.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::25) by DB6PR1001MB1334.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:b2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 09:38:58 +0000
Received: from AM5EUR02FT030.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::57) by AM6PR0502CA0048.outlook.office365.com
 (2603:10a6:20b:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Mon, 13 Jul 2020 09:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; vger.kernel.org; dkim=none
 (message not signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT030.mail.protection.outlook.com (10.152.8.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 09:38:57 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 13 Jul 2020 11:38:57 +0200
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 F405C3FB8D; Mon, 13 Jul 2020 10:38:56 +0100 (BST)
Message-ID: <cover.1594632559.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 13 Jul 2020 10:38:56 +0100
Subject: [RESEND PATCH v3 0/2] Resolve revision handling and add support for DA silicon
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(39850400004)(346002)(46966005)(356005)(336012)(478600001)(82310400002)(426003)(8676002)(2616005)(54906003)(26005)(70206006)(70586007)(5660300002)(86362001)(107886003)(33310700002)(4326008)(36756003)(81166007)(8936002)(6266002)(82740400003)(6916009)(186003)(36906005)(42186006)(316002)(4744005)(47076004)(2906002)(83380400001)(136400200001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90438caf-690b-491b-cfbd-08d827109108
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1334:
X-Microsoft-Antispam-PRVS: <DB6PR1001MB1334AE17E6C2F79B11B7BA27A7600@DB6PR1001MB1334.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SoPepmp/lKQn+9jdpfCXTgE0k6CxiQb/vjEZXE9jXVfJXSc11y/T5GVK7YVjz4cxcv6qNjtmmcM/Me8n5nsOOlokXXeU7CHiP+emRluKsVsxZteydGsPKTQ1PADce215Qtv+LX2L54Rs/NFKarWkHYghro/+N/Htuxi1fBiO5vxpQSAEM6B8c2Gx40xAfrvSSIE8RlPk5KWVMsDpUB/aArhcWganXgG/lhK993rfjCnE+xsugtwkNrwPvvL4nK3y7r1o//cGoLvCsA7TFtibLWJTCFY3cX0qf74yzvUXDvDjcN0Jwl0mKRBfV3GUyDcbWRcSKv0NAziRiT3zRUwTmGWSyLm+De7wS7Bj9qv/7uMwsmcrbTAsLCbTWQC1eKmve4T9GhsJkLNQvwsbmPuUnI6jF06DRnkcQlOXQeDj9DDqxBqp9ZFiycnskS057Pp4hesLDOnotpq6yh5gJsJFQ==
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:38:57.6700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90438caf-690b-491b-cfbd-08d827109108
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT030.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes the currently broken revision handling in the driver's
i2c_probe() function and then adds DA support to existing permitted revisions.

v3:
 - Replaced magic numbers around I2C paged access code with enums and defines
 - Small style tidy ups as requested by Lee Jones

v2:
 - Use raw I2C read access instead of a temporary regmap to interrogate chip and
   variant id registers

Adam Thomson (2):
  mfd: da9063: Fix revision handling to correctly select reg tables
  mfd: da9063: Add support for latest DA silicon revision

 drivers/mfd/da9063-core.c            |  31 ----
 drivers/mfd/da9063-i2c.c             | 271 +++++++++++++++++++++++++++++++----
 include/linux/mfd/da9063/core.h      |   1 +
 include/linux/mfd/da9063/registers.h |  15 +-
 4 files changed, 257 insertions(+), 61 deletions(-)

-- 
1.9.1

