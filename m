Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E779C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279A32087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="VuLYv490"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgDQNYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:24:04 -0400
Received: from mail-eopbgr60111.outbound.protection.outlook.com ([40.107.6.111]:30528
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730635AbgDQNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:24:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX2nbpecoBd3GEH5roiySwoD4eMOKhVsjopu7e9DreBxB3iivJtIH83HnnJStqyguNcVmigOGnlq02ZCFxazmD8a3H3j9L/tYNUZ+BGtc5xmhrHkChNNwi5I8nY1S2SjnUg7TCni5UiLYFuYBb9PJUmeGe18Wn+MDtviY4gsvkNLGZk3YSqs4XXZCJSomuCdu6561p/i3zTtzN5mYIU9xxihRfIeuhgsdNKGuGM1rbbxoRUi6zraoRTYyNvvc6d3heB9HP+CttbJbTCSrnNx2DYg7vHDNW1pol6+EmRgd8ns9sqMyPi6djyKehFbL6eSDMgsmDKgTFg6VSvsEnRVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTfESe02uereOyVGg/rEh9j2VRTC4bqPFWJUgpfFrV0=;
 b=LXo28VH0RrJgnFQsZVu6s8VKNMEOhENhuDWBFKXgFwTrp2/JBqFU9vMdBWsaLWEd5SZ9tI+v2uSoCcvOHOEAynPmwzFUp7AHIpkcROEORyRvXvtWzsBVSG6Ov5KFza0yGSJx1upsYHrgH/gRslcOYxWTFWS742DfAgHYWoJ9pdrL7ZT1ADHwNjwmol7Fl6JpQqc90PWd0mVPAHr2icCrvo9xeJ1M9tTq8iF0qJCm+rArd+55IaT5i1cakaLROq894Widv24zew8NSUKYo7oFrr+AJ8oA0JVcMB0SukTPPAGjMf4A/V1iwh9n1nrHc5ilOd2NyOJ4HuP3gkmfVUkWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTfESe02uereOyVGg/rEh9j2VRTC4bqPFWJUgpfFrV0=;
 b=VuLYv490PWBCzDi6pMej7pv+2rnwhr7Siujv+MxaXEGIlHL3gOsH3Q+YQypqCU1EXdtRw6MnOfQ0rLwyZ6IfNjZOmzKQgQA9fMGkl1NMmk57dsL3kfai/RKPqTsAhin7w7drRM1fcyaAs7bs0ap+1DudVExquK2HVHp5KSYlFvU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com (2603:10a6:3:4b::11)
 by HE1PR0701MB2763.eurprd07.prod.outlook.com (2603:10a6:3:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.18; Fri, 17 Apr
 2020 13:23:58 +0000
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece]) by HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece%10]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 13:23:58 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] perf bench: Fix div-by-zero if runtime is zero
Date:   Fri, 17 Apr 2020 16:23:29 +0300
Message-Id: <20200417132330.119407-4-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
References: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR1001CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::18) To HE1PR0701MB2938.eurprd07.prod.outlook.com
 (2603:10a6:3:4b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.16) by HE1PR1001CA0008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend Transport; Fri, 17 Apr 2020 13:23:57 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [131.228.2.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f542107-2d22-4c09-f78b-08d7e2d295b8
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB276338D3841D0273BBE3FF07B4D90@HE1PR0701MB2763.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:69;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0701MB2938.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(36756003)(6666004)(6506007)(66946007)(66556008)(1076003)(8936002)(316002)(186003)(66476007)(16526019)(478600001)(7416002)(26005)(110136005)(86362001)(54906003)(5660300002)(2616005)(956004)(103116003)(4326008)(8676002)(81156014)(2906002)(6512007)(6486002)(52116002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4SyUkrWF6shkKZbsIvUyrAGNCc1uZFiEaHgET4f4JAlfuFL/hC7gb4vBRzkwA3FWsj7G6ZSsEReTmWw2pQ1ZfZHJ5czKap8tSyCjTJZ2UhsxvoijzMllr/eTSM0Z9HPe/z2IQE5HEOfUatlOVz6I97ujakaZjsEqWCIXRWUs1p/zglflWzvYg0sb7rSv/Dh2D74SFjMLr8lpCimZAcRKYTMAafHqgILwaIGTeQYUJjiI9oHdyBHSEjh00pzd740ZfoHL9l7d8tpOJ15VRitHtPkqUqnTCa6weVVyFUXL5om7yUet5pyTd8AzLxdgm6mgoKX5JMon8aVqXmJeMCfoinlGp2FYSL3Z7pwtUJVeiEXiBHz7/R4NDiFiZN2L2yKBSIzxBGuiosHBzJ8VG4+jXbsc0TwFQoU70v4+WZfQudjTXE1GdF51bjll6pYa7Ll
X-MS-Exchange-AntiSpam-MessageData: 0QLDNA45lIhyvZEol8efYAeDwwpJD52d0UeN6cA8ep/6Y5Hal6pKXgutE6CUWMpjxT9GI98bqaaNbSCrhxQpepM3yQ2yiSXU3ZszcS+SyqWFb4Nu/RY1FDs+fmDdYNJ7UjFRJ8ajCeQFGqGYbmlfsQ==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f542107-2d22-4c09-f78b-08d7e2d295b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 13:23:58.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2HRa9z4ZaHVQs1xAJaOyP9PhP1F/H6Yy0BMaDNW8gDNnD2+HOMupX985FHeyU1f9yXuWECH4Y7Tcg9o3Q3Wrv2g+S5qjBkdBfIqrSfTCDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2763
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix div-by-zero if runtime is zero:

  $ perf bench futex hash --runtime=0
  # Running 'futex/hash' benchmark:
  Run summary [PID 12090]: 4 threads, each operating on 1024 [private] futexes for 0 secs.
  Floating point exception (core dumped)

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/perf/bench/epoll-wait.c    | 3 ++-
 tools/perf/bench/futex-hash.c    | 3 ++-
 tools/perf/bench/futex-lock-pi.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index f938c585d512..cf797362675b 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -519,7 +519,8 @@ int bench_epoll_wait(int argc, const char **argv)
 		qsort(worker, nthreads, sizeof(struct worker), cmpworker);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
+		unsigned long t = bench__runtime.tv_sec > 0 ?
+			worker[i].ops / bench__runtime.tv_sec : 0;
 
 		update_stats(&throughput_stats, t);
 
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 65eebe06c04d..915bf3da7ce2 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -205,7 +205,8 @@ int bench_futex_hash(int argc, const char **argv)
 	pthread_mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
+		unsigned long t = bench__runtime.tv_sec > 0 ?
+			worker[i].ops / bench__runtime.tv_sec : 0;
 		update_stats(&throughput_stats, t);
 		if (!silent) {
 			if (nfutexes == 1)
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 89fd8f325f38..bb25d8beb3b8 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -211,7 +211,8 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	pthread_mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
+		unsigned long t = bench__runtime.tv_sec > 0 ?
+			worker[i].ops / bench__runtime.tv_sec : 0;
 
 		update_stats(&throughput_stats, t);
 		if (!silent)
-- 
2.25.2

