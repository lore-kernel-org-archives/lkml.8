Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A0EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCF920714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="ij6KPnT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgCXTGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:06:41 -0400
Received: from mail-eopbgr130111.outbound.protection.outlook.com ([40.107.13.111]:48520
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727672AbgCXTGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:06:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9eigv6p5AWwTsoS2f1cFhHQEV4mLIxSHFmfrPp606+VUwJxp5Dzv7hUpB6r5SC//5mwireL3szT/yEEVMt6lrQRGWEIVmkYl1GDtSCeiYH4eSWc3tIl2PuI4cSSzLhDyEpMJOlkn0KbgVBWIT4rukS+8wLxbT0SkRT3/kOBRJU0XqsmW1dk80BEaXS91p7Gj9CkfJb+FcwmVfFCT5DthOSZ8bA5+uFFUruvbOj49rRnLxoyxfSSSknnfwFwxvu1q+DuvPKRvyNHpJYoyYn9GUZp1xPKtKj9WYeMf1kciy0U2DARNObdFwxnrMrmxjxt66QQWSPCAPVrOQTDx1756Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6wmtJ1RgXtHmKF5qH2SmcOIAZp0uHHY0KxsxfHrzEQ=;
 b=jvOodJj+FrSDOpZc/8hES8bwV6oi7MHRXuze+AAxX8sXdidfi02qXx8UTR+FDdhjIZsjpGDOWTTat3fvaoTa0SGH+stwdtokYkbiBnfpJxcZ0+ZRwM4zL4nmCQuTdaj1y0qFdkmOUdrzjWJvSOM4H2y0xNfub6JIJRkuBCq8QQWS0QSZdzZImk7AQ16sXQoxy18jUp43kcCkXIeH3cVnRpTdW38/iEZmoCGwI61kYbtUFxCJi8fw0ruwDMwxhpWsrc5V3FAu3BqLcbIG0H55UUvyvTLfg9zCV2xWL9i/A2MUFdlxrvM/UDKThaPQqJOHdhUXTRoZ327/VMH4SJIUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6wmtJ1RgXtHmKF5qH2SmcOIAZp0uHHY0KxsxfHrzEQ=;
 b=ij6KPnT7X/EB+NSZ9gPyU0VtYRADRVfZ2Bs/g5Ixwrg0Sy/3/PRhYCilf1uMnJX7315ndptmj+KF8FN9GCCKTefQ+nhDDkpfP1EBHNUGobtM+SFWymy3ZYLLUbiHO9m7dsHzRjBitPQ9mz6IsYYHAsTtw5EXwDPlNDKkwJTTV3Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vadym.kochan@plvision.eu; 
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (10.165.195.138) by
 VI1P190MB0768.EURP190.PROD.OUTLOOK.COM (10.186.157.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Tue, 24 Mar 2020 19:06:37 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::f983:c9a8:573a:751c]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::f983:c9a8:573a:751c%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 19:06:36 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Gregory CLEMENT <gregory.clement@free-electrons.com>,
        linux-kernel@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH] bus: mbus: export mvebu_mbus_{add,del}_window for modules
Date:   Tue, 24 Mar 2020 21:06:23 +0200
Message-Id: <20200324190623.26482-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM6PR08CA0047.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::35) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6PR08CA0047.eurprd08.prod.outlook.com (2603:10a6:20b:c0::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend Transport; Tue, 24 Mar 2020 19:06:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f21e2a64-9477-4ebf-83bc-08d7d02679c6
X-MS-TrafficTypeDiagnostic: VI1P190MB0768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1P190MB0768D7A72CE4B22D840726B795F10@VI1P190MB0768.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(366004)(39830400003)(316002)(81156014)(81166006)(508600001)(6486002)(66476007)(66556008)(52116002)(86362001)(6506007)(26005)(186003)(8936002)(16526019)(8676002)(1076003)(36756003)(66946007)(4326008)(2906002)(107886003)(956004)(5660300002)(44832011)(2616005)(6666004)(4744005)(6512007)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1P190MB0768;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: plvision.eu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umcWtqVDj6HhDqFVeyO8Y0bhfti7Aq8ETPvbNrnj0N7LuOLDfJlMCr2jcRqw8/h73cvXOzRhVVPYqfUUQGUF3zKoqErfcN7726k3V/3x96Cawejo7ubenxcGrWO1DPocwu+IwcEbwaTDSr7+4ityzHfv5K0FQsqNvDmS/lG0+Uzahe3o4bKRNCuMb6UFozIZCU1p+atmC0EEdc6tohYETy3X7eptbvfw3Ar9lfeKHIbGYdprai+cr/UQoDQ2gvnBER9UBUmrJDEu562IFH5GOHVE4EMcGLgViG2WJtZ69iJRs+7kFvGoadj6BNZ68uMVblzCpIrJO83WUbZHrURF3ynsRGbgbFkZZk1+AWB0JyVg8lAP1EmiAAydn21MxWtcunWrU+s0kaU3yFmK1uri5gKsNMWTD3wQPjJAEXKuBWQRjpufzjw35ihLasl5UMh7qa6qcav891xzSM8xRduy7RCYQw6YT+XdDco9GeMVwOoW1qLte5qIrHn24lCdh+uq
X-MS-Exchange-AntiSpam-MessageData: qrsy31AgYJLLaV3JJfmtZmzg+43lRL09Ch0dQIVgo2LEU80DroOHP+mJpBQ2e243uQx/OHIYjrYHXARqcqYGfB4zJGbhFQBdEQsR8T5A3VvSQXaLqD9slN6lFyKc3vNdlJpsiQR1OZffe5Twuj108g==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f21e2a64-9477-4ebf-83bc-08d7d02679c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 19:06:36.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edpZqNHqozn5UrxlQfkqdlATVWTGvvvPz15kc9oDTDilf9p0AplJtLCO+EbPOcQKMtl0uvUHej8HuZ0M449NhZVl1THk/M4wqKQsfw0hIQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to add/del remap window by external modules at runtime.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/bus/mvebu-mbus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 5b2a11a88951..3b443748a469 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -914,6 +914,7 @@ int mvebu_mbus_add_window_remap_by_id(unsigned int target,
 
 	return mvebu_mbus_alloc_window(s, base, size, remap, target, attribute);
 }
+EXPORT_SYMBOL_GPL(mvebu_mbus_add_window_remap_by_id);
 
 int mvebu_mbus_add_window_by_id(unsigned int target, unsigned int attribute,
 				phys_addr_t base, size_t size)
@@ -933,6 +934,7 @@ int mvebu_mbus_del_window(phys_addr_t base, size_t size)
 	mvebu_mbus_disable_window(&mbus_state, win);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mvebu_mbus_del_window);
 
 void mvebu_mbus_get_pcie_mem_aperture(struct resource *res)
 {
-- 
2.17.1

