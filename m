Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B3FC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6D12063A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="TFX9KOVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgDQNAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:00:40 -0400
Received: from mail-vi1eur05on2125.outbound.protection.outlook.com ([40.107.21.125]:62305
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729904AbgDQNAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:00:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXTQdloxtiNs9clsHKNQO1L9B9OvEoFMfB3CIoGQbJHFWqqB4smCypvqDTE60gsTbTmgPSt7qEJ+eMrIX/g0nwRO9Ldzxd0940mUgHviVvPMC0ryB/v8Nf5TcPE69BOvWTaTp5+aShPMNq9HycLrKWgQ7yoAEEHO6At0gnM9g6BQLpIp78eaux7FdkFJU+G4ycoLb8k6/3Q7lS5E9JR/A/1WKdCuQUGCgSJ8SyUi3qBaGV5UbFDyNeGBpKkWlSY+RqaKdluFw2HOdtx+aGShVMdxKmS0gY2aTk2pcMZxKki5bTjsJXHMib7K0/z1WXcO+tVxs9LvGrzlmMltohXkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uodd5v1I8A14acGmtDZLrsBQ47LpBeYJ1CHymbS5omc=;
 b=D4VZ2H51BKpzL61zX7Y+UBJzI50yxcHOa0Tv01Hu/173jo5teoyfurIF9dFTHbSZ3bBSqooAFnCwNtK3AQtG2zLfGmS2F7xrElZzqAMhVQvRIZL0JfGpTxDhwCp2meZLxWp4Fs86YosT91VthG+OTmUhtxO/ktaiIwWoAqMdbZGXuIihx4aWvcogXex0meWh8Fj5c7C87CunaqFN3nHXHMvWs8daIi0n1Q6/tkc2uiT5ZFD7/nWJS46l5AEZRhZtWnLr0oyE3wNHSA/bqtqGIRnBqmrVujqD4K3rN4PSB49j5O1wcsBTKF0vt4AOXKvKXYvQYtoF98AO+oEXjLM8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uodd5v1I8A14acGmtDZLrsBQ47LpBeYJ1CHymbS5omc=;
 b=TFX9KOVp0H1+7VOGkvc44R/1BJ/9dC2aSsXRuZDH6avDpREe1IM11t8vb2OVxE9zVyYtEcqRBlyG66ZHAZIs5GF8PmbTthWyegLcA3xx9lJhAxE7lpLjYYAyLWk9KfBI6DfzuK0fNVSb6P7E3oMextgs2+KRGqPrr/Gb+TXDi3I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com (2603:10a6:3:4b::11)
 by HE1PR0701MB2409.eurprd07.prod.outlook.com (2603:10a6:3:6e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.24; Fri, 17 Apr
 2020 13:00:34 +0000
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece]) by HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece%10]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 13:00:34 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] blk-wbt: Drop needless newlines from tracepoint format strings
Date:   Fri, 17 Apr 2020 16:00:23 +0300
Message-Id: <20200417130023.104481-2-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200417130023.104481-1-tommi.t.rantala@nokia.com>
References: <20200417130023.104481-1-tommi.t.rantala@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P18901CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::11) To HE1PR0701MB2938.eurprd07.prod.outlook.com
 (2603:10a6:3:4b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.16) by HE1P18901CA0001.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 13:00:33 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [131.228.2.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f53a1f35-a0dc-4c04-cc3f-08d7e2cf50f9
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB240915419D3A34364635E4CEB4D90@HE1PR0701MB2409.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0701MB2938.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(8936002)(2616005)(478600001)(36756003)(8676002)(5660300002)(2906002)(81156014)(103116003)(86362001)(6666004)(52116002)(6916009)(4326008)(956004)(66556008)(6486002)(16526019)(54906003)(6512007)(26005)(1076003)(316002)(6506007)(186003)(66946007)(66476007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ev66iy4pYqHRj1ICEswv0WW+HJCEpd7/hWJTBUOsrFQDf4rwMKfbx2Z4uCUEU9ZGqOFjVKpws7epqS3bMT89roA/ZEcolMzIpMD9/XablFvQ0QYefOnEHvF9N99uKEscs9InZ57EH3c7mLsNcYXfQ6I+E989qzxcpOnAko949jXkl6HGw+quhHFdnKTs141aMt3JgkNjAfhsJFv0MqY7XrsIy7dWRmwZUaYoVrwiBpbiOeHbB+9cbvbT+NIhEOqW1D5XnJqWCQpDCIgLFVBdxC9kE1X9RIlyRMfxICyOI/y592hcy8G/V+qppDbfZxVQRTHyj6fyM4BhcRctDZ3Ljths1cEigfcw248/9psHMTByGIq85jBUyS3UpBxyW7JwxK1fwTkL66B0ixtIJvsiCVFqlajPpKeceZSgr/ZQqVopUCdGnpcLLP3mvx3BY2XH
X-MS-Exchange-AntiSpam-MessageData: sUhJdEyiGF+L2WJYe6PaX4SVHBSfmy4N6ZaUgZLC07eHWbs92RtiBui47IUBCvmAK1PRe0AEl5Vnc0f6YLwjn0KLo8APtJZVH2OEHa+4jS64FFXDOWtM7gdxGlodLQXRi751RVd6B55kvE4nl/mCeA==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53a1f35-a0dc-4c04-cc3f-08d7e2cf50f9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 13:00:34.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsZNkRwm9HFXI+uFHo2h3odbGC5eH17Z9ShwOJtaOeLjqVcY1KIPXZ5jZP9uRcyiLNaESFAIUrk8aja1gdyuhFRKh3eym9+T9ELdgPzVUNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2409
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop needless newlines from tracepoint format strings, they only add
empty lines to perf tracing output.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 include/trace/events/wbt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index 37342a13c9cb..784814160197 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -46,7 +46,7 @@ TRACE_EVENT(wbt_stat,
 	),
 
 	TP_printk("%s: rmean=%llu, rmin=%llu, rmax=%llu, rsamples=%llu, "
-		  "wmean=%llu, wmin=%llu, wmax=%llu, wsamples=%llu\n",
+		  "wmean=%llu, wmin=%llu, wmax=%llu, wsamples=%llu",
 		  __entry->name, __entry->rmean, __entry->rmin, __entry->rmax,
 		  __entry->rnr_samples, __entry->wmean, __entry->wmin,
 		  __entry->wmax, __entry->wnr_samples)
@@ -73,7 +73,7 @@ TRACE_EVENT(wbt_lat,
 		__entry->lat = div_u64(lat, 1000);
 	),
 
-	TP_printk("%s: latency %lluus\n", __entry->name,
+	TP_printk("%s: latency %lluus", __entry->name,
 			(unsigned long long) __entry->lat)
 );
 
@@ -115,7 +115,7 @@ TRACE_EVENT(wbt_step,
 		__entry->max	= max;
 	),
 
-	TP_printk("%s: %s: step=%d, window=%luus, background=%u, normal=%u, max=%u\n",
+	TP_printk("%s: %s: step=%d, window=%luus, background=%u, normal=%u, max=%u",
 		  __entry->name, __entry->msg, __entry->step, __entry->window,
 		  __entry->bg, __entry->normal, __entry->max)
 );
@@ -148,7 +148,7 @@ TRACE_EVENT(wbt_timer,
 		__entry->inflight	= inflight;
 	),
 
-	TP_printk("%s: status=%u, step=%d, inflight=%u\n", __entry->name,
+	TP_printk("%s: status=%u, step=%d, inflight=%u", __entry->name,
 		  __entry->status, __entry->step, __entry->inflight)
 );
 
-- 
2.25.2

