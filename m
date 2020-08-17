Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF54C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D1F2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="f9X4K+Ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgHQJFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:05:19 -0400
Received: from mail-eopbgr30104.outbound.protection.outlook.com ([40.107.3.104]:54086
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbgHQJFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:05:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOiBtOlCM72vFXTsobp7+fZeB4IpI5Z6phds9+l6bugiDP9dORg+VcirxFqbtobsVa40cnJhzGmoAtYp8zKBxWLS5YIDPhjxgRsfttQkz1fQqsAGrgWx4yBE3z56LVuYlX5ioX20HuZ8NH9j771mSWvNfBsgFlrrLljr4/emUU27bO0YMAlnOUzIjS0Zy/eQ4J2OkvG0IeFxFDYRL2+SfwFCaj/Bb484Ly7iyFOfuqQyje3W858cKaq8i2AYwkzCrYpCTpflZKYSI//NVFW6QK3y1olfaSOobZvHpUuiKeveb2LwdfHV4c0oNdEjFYCB8ouJP11HCCI3ycQGr8WZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNY4H3hp6EYYx4nq3amwiAQT73w5TpX69fmuf6c1GLg=;
 b=BpfAHwVAeXHYv8ti+/IJVxx8G5PLYca3I6GkRypSoL5Zei1LboLNih6IuoTLo/kgD7y2McHvZ6Si2j3x+78TxJ4fNCuQeFQo6qaKNXNdGf7UhNUoKBZMWLDRBAsaVF3VjBASBoGxyN+hTwPpLZxaDZqxDqKRNvLtblMM2FFkQqer+8J+c9b9iPolDnDNYZLS7CIYxyTj81g2mOwnD3KM5aNC/6S0ty11E5OQJizo2EKvbKGbjl8Iy3JbIy9SzLj3dPighVBxy+eVq0xKE6Soes3a72aTIMl0/Hai6yKEclVqC+SDjnTRjDnGXkyBiWXjFoiMc4nSPBrD6mlxT8g1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=zytor.com smtp.mailfrom=nokia-sbell.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia-sbell.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNY4H3hp6EYYx4nq3amwiAQT73w5TpX69fmuf6c1GLg=;
 b=f9X4K+ZeF6HJ33PLXVmUwDuiGajnZRlB8dEBxqTM+zdszmAvhbhgyctaCV10w9fH9x5nHGHdI2dW71iNyEYlejvc3s/2V8ny3kWq7Uh/FHCRSCz2Lak22mhtjkCPhMCU77SN5WwA+cx38vVTkra+rBkxMPcD9MLj+ExwP2fRJX4=
Received: from AM0P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::19)
 by HE1PR07MB3212.eurprd07.prod.outlook.com (2603:10a6:7:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.16; Mon, 17 Aug
 2020 09:04:58 +0000
Received: from AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:190:cafe::7e) by AM0P190CA0009.outlook.office365.com
 (2603:10a6:208:190::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 09:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia-sbell.com; zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=pass action=none header.from=nokia-sbell.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-sbell.com
 designates 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 AM5EUR03FT037.mail.protection.outlook.com (10.152.17.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 09:04:58 +0000
Received: from hzling45.china.nsn-net.net (hzling45.china.nsn-net.net [10.159.218.88])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 07H94tYP013975;
        Mon, 17 Aug 2020 09:04:55 GMT
Received: by hzling45.china.nsn-net.net (Postfix, from userid 61462992)
        id B874640F28; Mon, 17 Aug 2020 17:04:49 +0800 (CST)
From:   Libing Zhou <libing.zhou@nokia-sbell.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, bp@suse.de,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, libing.zhou@nokia-sbell.com,
        hpa@zytor.com
Subject: [PATCH] x86/nmi: Fix nmi_handle duration miscalculation
Date:   Mon, 17 Aug 2020 17:04:41 +0800
Message-Id: <20200817090441.44501-1-libing.zhou@nokia-sbell.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 66822b1a-b2a9-4746-1fa6-08d8428c9dec
X-MS-TrafficTypeDiagnostic: HE1PR07MB3212:
X-Microsoft-Antispam-PRVS: <HE1PR07MB32120BB8184DB425156B6C0AAF5F0@HE1PR07MB3212.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPgi7nijOZwcLfOVLxMD0uH3MaEVTbSJinUrgF1hGmO/rnzv93BFqvMFKUZ6PlCsATTVcnKKK6xZvWnINjbqHfj+9I70roU2PoJHZzIfIHygYKA8Wnq+awOjesExjXJWpUuYpI5t8VTpnO/eNgWdwNnPYqmHeRZpHvuSUexRxF/8JzVfXeJ2DTCK7CTxSwfuDxuwpJIS93aEp3fsqjDjSJjPL1HpJDD0/L0bfhh0kyMhAEwcLuCORHr8RrAWXySWpMTmACxVjAVdEFqftkzvAZtXt4HF6yKfFJBnfzNL8k/C0Jhl23hUh3G22xRloKauScbCvTSu/kIuvlb4pWAz65bnGp7SMUZEBhye2MIkd8abT6I0ZI+NBc6tOY4RgVYS/irgm5fg0iUT0yJzWufy/A==
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966005)(8936002)(186003)(86362001)(6666004)(5660300002)(2616005)(36756003)(42186006)(316002)(478600001)(47076004)(82740400003)(336012)(1076003)(4326008)(4744005)(81166007)(8676002)(70586007)(6266002)(83380400001)(44832011)(26005)(2906002)(82310400002)(356005)(70206006);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:04:58.4658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66822b1a-b2a9-4746-1fa6-08d8428c9dec
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB3212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nmi_check_duration(), the 'whole_msecs' value should
get from 'duration' to reflect actual time duration,
but not 'action->max_duration'.

Signed-off-by: Libing Zhou <libing.zhou@nokia-sbell.com>
---
 arch/x86/kernel/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4fc9954a9560..c51ee659e520 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -102,7 +102,7 @@ fs_initcall(nmi_warning_debugfs);
 
 static void nmi_check_duration(struct nmiaction *action, u64 duration)
 {
-	u64 whole_msecs = READ_ONCE(action->max_duration);
+	u64 whole_msecs = duration;
 	int remainder_ns, decimal_msecs;
 
 	if (duration < nmi_longest_ns || duration < action->max_duration)
-- 
2.22.0

