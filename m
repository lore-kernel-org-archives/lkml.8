Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12C1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBCC2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="PYgTN9fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgCEIhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:37:55 -0500
Received: from mail-eopbgr80109.outbound.protection.outlook.com ([40.107.8.109]:50715
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbgCEIhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:37:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GasiJ9dSBzus54hCrrYfDvnVDrArK6vcsEKqRySvGscvcBMfMbDhXw2zICzQmYAc8S+aPuWs5B6yVQL8pPNPygL9r57QADMgFX3b78yWI5cPk/0vrvNdPg+Qd4qD2/YHW89NBI7gPS6O7tMC+VhEckOyt4VbI63VU/XJCpeDtq8xqf+PD8ayAOgSz7bqTuWbKnJHp0GmOtgWU7zsy79hUzgX0yoXMUbwWb83BtTLN8kkPZYQJ2Fgjgcb64CAqhP3IfB69EJhp7Sa83khnk367D9o/SrPx5jXSVtJL95ONnYO99cgCNN52xmgmS/zaoK9gmcTFia6b5DWzPkz29PMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b41EsYfzPGgCuA93xXliMliONNU2Wh9fnCNVaulrt68=;
 b=fUVkpHNP2gpLSvdCVRisY2rjqDkLHlh106n6jddo4oS3XN689hB5aLX8rRtbFP1zZo5P2y/NgC2nPIoHPSZQ4kfSh4qlXwxjJxHFWoUt9p2ef0WwZCQgtJQWV7Axz92SvLbNnpikErw16xrSWmLdCrPqPTexSDhWYZ1e2NqPgmxHi5eIHPV/66RfCOxsV9REZq4tSVASe8E+Ut7cx3KbhvdAvk3RoJdNLr9ZQAA8nF/uIsQl11QYy9RZAD6ss3KUkfOBV794y9tYIjH1n/25z98vpfy9JomYEFlpmqLbMwPg+1dALEepjhi7SfKcH0jqmThbwRUKxHAdZFL7akAlFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b41EsYfzPGgCuA93xXliMliONNU2Wh9fnCNVaulrt68=;
 b=PYgTN9fg7I/7r+jjgFftluFesnmrooD9UZ1CmNPbcKDocyxbfImHEa325pqZZIJ2ENki91OA0V2wG8AkZqM44GKbTTOI0ImUJEf1O0c+u7G3ekhDeD0xSuRNXmNktT1AEgGjgHhWBkT7/sIXBalQmryBv73vJv2MYV24QeQZE/g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (10.167.127.12) by
 HE1PR0702MB3804.eurprd07.prod.outlook.com (52.133.7.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11; Thu, 5 Mar 2020 08:37:45 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::2806:c34c:d469:8e87]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::2806:c34c:d469:8e87%5]) with mapi id 15.20.2793.011; Thu, 5 Mar 2020
 08:37:45 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf bench: Clear struct sigaction before sigaction() syscall
Date:   Thu,  5 Mar 2020 10:37:14 +0200
Message-Id: <20200305083714.9381-4-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305083714.9381-1-tommi.t.rantala@nokia.com>
References: <20200305083714.9381-1-tommi.t.rantala@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0048.eurprd09.prod.outlook.com
 (2603:10a6:7:15::37) To HE1PR0702MB3675.eurprd07.prod.outlook.com
 (2603:10a6:7:85::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.19) by HE1PR0902CA0048.eurprd09.prod.outlook.com (2603:10a6:7:15::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Thu, 5 Mar 2020 08:37:45 +0000
X-Mailer: git-send-email 2.21.1
X-Originating-IP: [131.228.2.19]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e385a699-8c53-4e3c-118d-08d7c0e07a3b
X-MS-TrafficTypeDiagnostic: HE1PR0702MB3804:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0702MB3804B918D024BB1FD28A32ABB4E20@HE1PR0702MB3804.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:39;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(66946007)(66556008)(66476007)(8936002)(110136005)(54906003)(316002)(5660300002)(956004)(86362001)(6506007)(2616005)(52116002)(26005)(103116003)(186003)(4326008)(6666004)(2906002)(16526019)(1076003)(81166006)(81156014)(36756003)(6486002)(7416002)(6512007)(8676002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3804;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVGQ0dFOLeIsDtMzG+jDmb4iX9f1WolnHkuFeT4m2Wf245K86mZD9PRdp8MHWckH8yeR9VaH2YlOKsE7ciGGoYeai+plQP+yZuoItfmgVEGqHON4e+fEt5ia/rpZrIs5ap42xbLLji24qkaMAw2WkcqW3QN5gDzCZmPIlIcmc9qm4TfqVwEj1lGY8MxZRwusFVy3Zg0RNQlH8N+i+/tUQCOFppe2FBqfO+dK16WCcoiR8Zg+7TyCmrUmoDg8a41nb54CcOXHPNKTX7ZQO9AN1Hsacb54tI6rnlz/nibDTf4RJAN4PSqcmpPAk+WfQsH9vac8Ba+je8RO18F3+13iFN8SFqFPTSczklucF4lc2S2KWp50Oz1D3qIWD6o+Ppt7RjCLKrzjnLDbT617G6yXbUbx6yEIdZZaZK4GwWOV6NOXFr2CTxSYtXtNHdMC2Ih2
X-MS-Exchange-AntiSpam-MessageData: tdJ3sJG5ULvx41jdS1CAwlst5lrZsqx2KYls2VLIWrSe9kdZJGLp/uVZRQn6Qc7rU7z3kzP/mcstmhglP70HyWsCKH5K/ZSuzgTukACEtW8/HzNY/wi01wQQCbTAsJB8yLXKtEdJW9Gi4Ro9mnXmwA==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e385a699-8c53-4e3c-118d-08d7c0e07a3b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 08:37:45.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3RYIp+siQa7GYsNRWo0Ei3HqDa8U+BrXpRCpKF0kUDsrdU3khPYi76ohqWh7xn1gka7/zWXpasDvnZpiaBDLVlqK1iDYXtfd1CASbkR1R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3804
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid garbage in sigaction structs used in sigaction() syscalls.
Valgrind is complaining about it.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/perf/bench/epoll-ctl.c           | 1 +
 tools/perf/bench/epoll-wait.c          | 1 +
 tools/perf/bench/futex-hash.c          | 1 +
 tools/perf/bench/futex-lock-pi.c       | 1 +
 tools/perf/bench/futex-requeue.c       | 1 +
 tools/perf/bench/futex-wake-parallel.c | 1 +
 tools/perf/bench/futex-wake.c          | 1 +
 7 files changed, 7 insertions(+)

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index bb617e5688412..63e2520017d81 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -313,6 +313,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 7af694437f4ea..5336e628b404c 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -427,6 +427,7 @@ int bench_epoll_wait(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 8ba0c3330a9a2..c441aa446c7f8 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -137,6 +137,7 @@ int bench_futex_hash(int argc, const char **argv)
 	if (!cpu)
 		goto errmem;
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index d0cae8125423f..27c6e1944cbed 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -161,6 +161,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "calloc");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index a00a6891447ab..7a15c2e610228 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -128,6 +128,7 @@ int bench_futex_requeue(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "cpu_map__new");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index a053cf2b70397..cd2b81a845acb 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -234,6 +234,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 58906e9499bb0..2dfcef3e371e4 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -136,6 +136,7 @@ int bench_futex_wake(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "calloc");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
-- 
2.21.1

