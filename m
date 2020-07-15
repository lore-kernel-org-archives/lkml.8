Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EC0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64859206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbusgmbh.onmicrosoft.com header.i=@kunbusgmbh.onmicrosoft.com header.b="a6Pe9Ahy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgGOOvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:51:15 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:53686
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726431AbgGOOvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:51:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nT27LxK4k7LiG2XCCHFQDKwKBXccpU4iSAIEEF+tE89cX48kTi0HOv8AGbQ5RhbeDN0aAX/G/+Ok39QafzV6PpPnjdwuCT9QlUKWi8VmKI8jdgpGV1vK3pvxib27PN/EM7Q+/h/wV6n1E5Ab/XGfBKIAuEsJOPwBQBFf09VoxqqP9Fii7k7oLD9lHLaPISuNUSLqvSq1kuDm1QnFwt7WFHYYGQ4sX8s5/2PF/ExAjUDEOiZ8URWIhoue4nDzWdPXbZxBgWqqD6CC1lm5UT3V++22HThfN3hhXzxVtiC+41xjILQ8UsXCehblTbXwKdTYrYqtZ23Kcf3AYLO9NoFs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XwANTVQL4x+G6zfQNnfDDio08zBlW4d4skikYHLpMk=;
 b=DZIjnt6GcSO3+/gEQRUn4HpTUcYYLZaraQvfk+N6tdPCe/77fS36q35QNKM1i2FoAr9SaBGU7BFDaYcbHcGJFZ7SK42ye8YOFnv1DCkqhVVcp0p412LDWLJ8ZKBRGTtRSF5fCrIp3R1XpNTsEv7oRpbzpe8UYU06qov0Xd98s/dV8oZtIRVMXa+dVah8FJODDpI1EW6mduMNjFoDQRUnpRPkby7zxQETBB9Z22kswnmbOovkArgPCIsOTrrXGbH5PyC0zhWVSVhHc9KxaK9Gb8t+UkUbcQ5lkGg+dvLhJrhFBPS274xk6NBBHlvAVbAkIXVEPA9X4adJZ87oQvtYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kunbusgmbh.onmicrosoft.com; s=selector2-kunbusgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XwANTVQL4x+G6zfQNnfDDio08zBlW4d4skikYHLpMk=;
 b=a6Pe9AhyZR4cxBw/L1vHjCqBaU5oE6mFmqtLb4MNPJRebflMgVbUIxmYk7BNoIdaOKPibBedpVcCdB9rKkegrNiDxPZzP+jgI+fRVXGfR13nMbINWIt0nJ1iR6cRV/zhclSNU4h70ACq86noujlhZkNQZk57QnOQA1E5ZhUbhLM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kunbus.com;
Received: from DB8P193MB0744.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:145::18)
 by DB8P193MB0581.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:153::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Wed, 15 Jul
 2020 14:51:08 +0000
Received: from DB8P193MB0744.EURP193.PROD.OUTLOOK.COM
 ([fe80::21ab:201f:7843:1910]) by DB8P193MB0744.EURP193.PROD.OUTLOOK.COM
 ([fe80::21ab:201f:7843:1910%8]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 14:51:08 +0000
From:   Philipp Rosenberger <p.rosenberger@kunbus.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     Philipp Rosenberger <p.rosenberger@kunbus.com>
Subject: [PATCH] trace: fix commets of include guards
Date:   Wed, 15 Jul 2020 16:50:10 +0200
Message-Id: <20200715145010.15652-1-p.rosenberger@kunbus.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::20) To DB8P193MB0744.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:10:145::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kun-nb-112.kunbus.com (87.130.101.138) by AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 14:51:07 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [87.130.101.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba44dda9-f9c9-4434-d5aa-08d828ce81e5
X-MS-TrafficTypeDiagnostic: DB8P193MB0581:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8P193MB0581EA75E974DC925F7D3AE49F7E0@DB8P193MB0581.EURP193.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijrvSTdmddYLR3hZmrMjr/C0x8t7r+6Z8yxwoc6xT0eHVl/uDLqZCR+liNeimcXFPaxxRu6q1WJr1zDV2MzF/Ie6OXTX5Px4IATWYEwzeI3mobrV6RySntt2+EGgpR+fU4CJTSiRCvVm+pyIt6ipnxWQh1tejM5JrSbG2oDREaHkBxS9NJPoN+4K9UCfXwL2NTZ2Vufc+nt551RRLCSiZ3/9yN9wIO49yRsdDplmCvEtVIbemAIvdqaMtX9N/29G1HIXUpsIY8B3qEoRlvE4HztN8b6VhZXAo6/xZXZAO+hUQGIK+X0XVk6i0FpHSX18AzLW3+QPMRuzd6rd/2sDbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P193MB0744.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(39830400003)(376002)(346002)(83380400001)(52116002)(7696005)(2906002)(66946007)(1076003)(66556008)(66476007)(8936002)(6666004)(36756003)(5660300002)(6486002)(2616005)(4326008)(956004)(86362001)(316002)(508600001)(107886003)(26005)(186003)(16526019)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Mp+mE9Uul1LK9WDCAAeI6A7jKF/+DU+7KQw+Qx2jtxbJFGpi9kez2g3AbVw7x8cAFNgUhPToycf7W43i5m9x2d1MRdF6Hq3SZYUFM8qTIDhPmjvuCzTzmplZIt8qwxbRxdnkGICvz1RbFnlgPK7zFga4VeSAPMYCwCzyW2cgS1tYrzNpMyM2D/1mFngruap+XqBu42eU8kOzNMH2cmY6EjllXJHw4VWQL6YtXPr+97cdRYOVxeJwXwKBzvYFpDheqnbNjp6xTbN5Qe2uYmZ3Zw+Ab+OHUrIzEpdg/wkNe7yRIfSsGcRzzOvQhmyHxA5KNlNWs+yBAPzE6wcM+iVO8IVFSz5i0W6ywOONHeFLRVu76gY2SJ7sRj5CvuGCSai6Hvecg5m7EnPsE+ejoiLuG+iPPcX8b6wWBYHuE+Mi9+b8n5+40hUm8R3gzTXK3xcxvvee6Et0KS293Kw6RmVcn6slyjwWvr37HD8i3geXdKQ=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba44dda9-f9c9-4434-d5aa-08d828ce81e5
X-MS-Exchange-CrossTenant-AuthSource: DB8P193MB0744.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 14:51:08.1737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IH5YIdue1dWNd10fn4aTeYc5RU6SasJnb23/p2fCQsSvczNkirY77Hpd02sbFRgQQu6pPhq/iboEtkQx/Ixav31HleQ0hY01iUNBtHZtWHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0581
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some header files where derived from other headers, but the comments of
the include guards where not changed. This patch fixes those comments
at the end of the header files.

Signed-off-by: Philipp Rosenberger <p.rosenberger@kunbus.com>
---
 include/trace/events/initcall.h   | 2 +-
 include/trace/events/irq_matrix.h | 2 +-
 include/trace/events/page_ref.h   | 2 +-
 include/trace/events/regulator.h  | 2 +-
 include/trace/events/rseq.h       | 2 +-
 include/trace/events/spi.h        | 2 +-
 include/trace/events/sunvnet.h    | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/initcall.h b/include/trace/events/initcall.h
index eb903c3f195f..9d7a00378ba9 100644
--- a/include/trace/events/initcall.h
+++ b/include/trace/events/initcall.h
@@ -68,7 +68,7 @@ TRACE_EVENT(initcall_finish,
 	TP_printk("func=%pS ret=%d", __entry->func, __entry->ret)
 );
 
-#endif /* if !defined(_TRACE_GPIO_H) || defined(TRACE_HEADER_MULTI_READ) */
+#endif /* if !defined(_TRACE_INITCALL_H) || defined(TRACE_HEADER_MULTI_READ) */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/include/trace/events/irq_matrix.h b/include/trace/events/irq_matrix.h
index 267d4cbbf360..6a554bdcd75a 100644
--- a/include/trace/events/irq_matrix.h
+++ b/include/trace/events/irq_matrix.h
@@ -195,7 +195,7 @@ DEFINE_EVENT(irq_matrix_cpu, irq_matrix_free,
 );
 
 
-#endif /*  _TRACE_IRQ_H */
+#endif /* _TRACE_IRQ_MATRIX_H */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index 5d2ea93956ce..e3aa264918da 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -129,7 +129,7 @@ DEFINE_EVENT(page_ref_mod_template, page_ref_unfreeze,
 	TP_ARGS(page, v)
 );
 
-#endif /* _TRACE_PAGE_COUNT_H */
+#endif /* _TRACE_PAGE_REF_H */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/include/trace/events/regulator.h b/include/trace/events/regulator.h
index b70583c32c08..dd1fbf2269a0 100644
--- a/include/trace/events/regulator.h
+++ b/include/trace/events/regulator.h
@@ -136,7 +136,7 @@ DEFINE_EVENT(regulator_value, regulator_set_voltage_complete,
 
 );
 
-#endif /* _TRACE_POWER_H */
+#endif /* _TRACE_REGULATOR_H */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
index a04a64bc1a00..4ebc8f228e7a 100644
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -51,7 +51,7 @@ TRACE_EVENT(rseq_ip_fixup,
 		__entry->post_commit_offset, __entry->abort_ip)
 );
 
-#endif /* _TRACE_SOCK_H */
+#endif /* _TRACE_RSEQ_H */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/include/trace/events/spi.h b/include/trace/events/spi.h
index 277bb9d25779..3e71d24dc5de 100644
--- a/include/trace/events/spi.h
+++ b/include/trace/events/spi.h
@@ -151,7 +151,7 @@ DEFINE_EVENT(spi_transfer, spi_transfer_stop,
 
 );
 
-#endif /* _TRACE_POWER_H */
+#endif /* _TRACE_SPI_H */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/include/trace/events/sunvnet.h b/include/trace/events/sunvnet.h
index 8d444f1bb10d..088481cdd078 100644
--- a/include/trace/events/sunvnet.h
+++ b/include/trace/events/sunvnet.h
@@ -134,7 +134,7 @@ TRACE_EVENT(vnet_skip_tx_trigger,
 	TP_printk("(%x:%x) Skip Tx trigger. Last trigger sent was %d",
 		__entry->lsid, __entry->rsid, __entry->last)
 );
-#endif /* _TRACE_SOCK_H */
+#endif /* _TRACE_SUNVNET_H */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
-- 
2.27.0

