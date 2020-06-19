Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3430C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B4F207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="LKg+PWRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgFSKqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:46:36 -0400
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:38496
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732399AbgFSKqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:46:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0bGjwboSzl9I3h4xrBa/kEljZcCfpC8YZKFcnQ182B50Ytk700rAwFVubLHlfLoJOYs/D6n1P/OP8HG4fIiIYCVvSAk8qLfRKd2isGN1pLD4LLpyxeFT0GYpL26WWM6C5zayxgo1BLDLJDLCUuppVvLKWJRW7Y6iVxwD7MhxNlIf7Sm60K+fRjdksu3efzk9SNclSEudI5Vm6P8vMhP/iY2uM1ndfApBtEOBnXBeMm875/2nVPqEG52Newg3PikftsCgUNO1u4/p7oIvZeaUWmhwmW9iMtyACKCVibmd3QT2S96t7YllMv+fJKSQqaaXlMLxdM7ntNLHHavzTHV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRuX8siAhQBLaj437WkZhe3Gmckltza0HY6lxcVeW4Q=;
 b=kvVJ29055g6Q9KV9SCiUGYYJ7xcs23y3on9521WH93nIuDfwcdVtsunZUMfJN8P4kPUBtOY79NeHeATiAO2xn6xF0/MU93IU2AAwanOOpAbC3zb3SeUqI2LCr+vZ7sC8mOc5tUesmXH3wySr1BrIUfv88uNlKA7uloyIjMfR+tmNyLg6b7kD6TMtduIPCT9Qv0YmsnRemPVSFM0xKhL6yPFu5IxzBRYF+CxzpAAVzXONuHMBuKdpB6Ll0ukKiXTpI8323nLoitXSjnhwO/ndLR5F/xhlLAhkhxPu+FgvtrZpghFoQoLsawjOv89KZU+1e0/48LfzFGVdYotB+kZnfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRuX8siAhQBLaj437WkZhe3Gmckltza0HY6lxcVeW4Q=;
 b=LKg+PWRngS9VcoLKQXLedD7f6upyg5JYlopOcJrozdlDNxSstQpaSOC5VjD6ReHzWqtAMfn2Y4BzJ8dRRWT/MvghK+7FcGJBWHxR4OsTzbtsSbW66HiJcqzJicfR2qcR8UF9VjRMqzSH6rtpdIEN1Sk7Lrg0QcmvMCKofF7jWpw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB3580.namprd03.prod.outlook.com (2603:10b6:5:b2::14) by
 DM6PR03MB3481.namprd03.prod.outlook.com (2603:10b6:5:af::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21; Fri, 19 Jun 2020 10:46:32 +0000
Received: from DM6PR03MB3580.namprd03.prod.outlook.com
 ([fe80::3122:b605:87fd:339e]) by DM6PR03MB3580.namprd03.prod.outlook.com
 ([fe80::3122:b605:87fd:339e%6]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 10:46:32 +0000
Date:   Fri, 19 Jun 2020 18:44:37 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: perf: add support for Cortex-A55/A75/A76
Message-ID: <20200619184423.5e61a838@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYBP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::28) To DM6PR03MB3580.namprd03.prod.outlook.com
 (2603:10b6:5:b2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYBP286CA0040.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:10a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 10:46:29 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9173a735-979c-49d5-2a56-08d8143e07b3
X-MS-TrafficTypeDiagnostic: DM6PR03MB3481:
X-Microsoft-Antispam-PRVS: <DM6PR03MB3481FBA8A9DD3C0867FEED21ED980@DM6PR03MB3481.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyaQm4IrveS/AiSh8Iyl0DOhW/RagtxYnaT6oUhc4bwPAOj8kePeheF6PL4MqRBSPu4+BUMmdvKiubBcKcR6duMNAsQGzUdt71nIkW0qynh49olSN5yvt3ACzK4CZv3HHV283S3NLaIO09/o3UTtMq0IqPLBxJYC+Mc2lRn3/uwJ+YZIeYczWi7wCTNbLATp5cUuxNcGimG70O9owl5DHK22n3NwziVi1Ybwhe4wEhvPA/8j09VIOLFetPIujoGf/5KldtCWgN4GVHc/mitVhhC7zWC1Apl9T9k3iN+rzaU4eafYc6MpSJB87s7WDDuTmRHvSe+tDYG+BtkK0tSH4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB3580.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(66476007)(6666004)(66946007)(66556008)(5660300002)(86362001)(52116002)(16526019)(7696005)(186003)(55016002)(9686003)(4744005)(956004)(8676002)(2906002)(6506007)(1076003)(26005)(83380400001)(110136005)(316002)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0w+L1WVUPlehHiypeJ7o1ibsC/7pRHCC4FHhAoKawwK5KUhWeGVTXDFwo+SwhTLD0Tz2bPLPFgX5JIfgsBZCKO5fby3r4BKoCAT0dc/vvtxL8DMm3HFqALQ5Sj0sfAJbRxxoZhSiFUYIzAhVYCDGeR0aa4/Iu6NyxsIF/loWXlt7i/V7MeFwuvJbBEqwgl45F70BqvLkdi4hefPQXXVnx0pxiLUpbjpP+Y8SJi9VZNiKo7LEIvU9JFw6HDHeJNPULNQEo2iQlj8q5sHklGMlrHIM/7z/+LdfiAEADlgex+89Bnmc6R8sUsmjFH8qyAFrVz2O7YgxLLNfTfX9XcXaFE0MTjU2+B0PREdjPx9a/B8DCmhXSeMgetR0zgeLH/EzYbfnGyF3sjv0IsVM/z5VeqCkUZvBwAEgcqai/D1Neu3Fr4QS6Wmd5L8YiIlweSfDHcwSeL0ObMJqzyi5R/laoPXOlTiK0WQxa8JGm/suqvpNlBKP+xdD0za4gVhe6B2K
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9173a735-979c-49d5-2a56-08d8143e07b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 10:46:32.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n59/9kYHbA5llGvfBMgmLB9PuBRuSIcffTiuedfo6O8EgOtE2LmNNzH4zpenTqy2sz6DGlyPKECHrWcDTH6i3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3481
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cortex-A55/A75/A76 use some implementation defined perf events.
Add the support.

Jisheng Zhang (3):
  arm64: perf: add support for Cortex-A55
  arm64: perf: add support for Cortex-A75
  arm64: perf: add support for Cortex-A76

 arch/arm64/kernel/perf_event.c | 49 +++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

-- 
2.27.0

