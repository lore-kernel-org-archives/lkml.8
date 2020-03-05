Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33102C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0032D2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="p0UN+6pL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgCEIhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:37:51 -0500
Received: from mail-eopbgr80109.outbound.protection.outlook.com ([40.107.8.109]:50715
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbgCEIht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:37:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeaX8N5La8pUjsyOjAsNeuO8bZdwEWKfvpLuNn3d4FEk3sv5HMIrGLLkPDRgxotp1RtbJmB/xTm/FBNT+VM8xATf5vxFGVHhrePbratYgpohTrxMlAUjYsAiof0+LN56Dhbawy271HjWaHND3gKEKjrpb6wFPkGQFEIYtI4Gi85hi92mvLp6FO0yUVJMmfC10cwwIyQcBMToR/g++m2ZkXChzMmhcMkiXm6fKCPkLXyjGBgrzKa6JkXDA3R91Su7ocTnTV4hdHblJ5G5bYVkNoIWpUW+ohDzduSaeV1qjdGjtqBYWuZlZifCZ24nlY2g36RpjUhJAty5FmMr3EfI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2IFlgNrHScozW71XWIlD9D6hZmfxSV/Fl0+1anKf1c=;
 b=kXmYrcVcd6L9VBny/trdnopRf8Pak6eC0zyGGvhJWwt7kwjw7UK3HUHwvq8JyjC3xvfYTGL/cWcpppS0YcaUGXQz1o0nf7YBs0wmjesNtq3ruWOFOu5KQr1g6p/eJGBhtd8iAT7/HSJwA9ou8XojHO71Rix5/GhQNgcyE96MHNpFdt2i+XspunjnCBgqeL3+4EDxN48Zd2qxhZnbNiUhvIhIpNY9p6TjK8fWe7wVkYxGBPLTp3IFnc+ER2zofLIOOy/QCTRuqs8I20YDVE1tiGsf5W8ih12It7UEGXBQRsoqw5CPrFL2olPu5dNQ93BQxMY/pyMTkqJDUXz1elOP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2IFlgNrHScozW71XWIlD9D6hZmfxSV/Fl0+1anKf1c=;
 b=p0UN+6pLNmoHJg6AHk1a+PF26Wa7Apus8HeJrUWqiNcYtpEqDjUGZJkOSX0OBSv/2x2L0WoGnnn7SR8+ECC3f3N/taTFMlJv74Vphutzw2P0shWqo1v8kTnEWBtl5c7ujxg2v/s1h2PvtR7zHTrpG5Vy0EGs0m0z0Yh1q9zSiYI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (10.167.127.12) by
 HE1PR0702MB3804.eurprd07.prod.outlook.com (52.133.7.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11; Thu, 5 Mar 2020 08:37:42 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::2806:c34c:d469:8e87]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::2806:c34c:d469:8e87%5]) with mapi id 15.20.2793.011; Thu, 5 Mar 2020
 08:37:42 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf bench futex-wake: Restore thread count default to online CPU count
Date:   Thu,  5 Mar 2020 10:37:13 +0200
Message-Id: <20200305083714.9381-3-tommi.t.rantala@nokia.com>
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
Received: from trfedora.emea.nsn-net.net (131.228.2.19) by HE1PR0902CA0048.eurprd09.prod.outlook.com (2603:10a6:7:15::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Thu, 5 Mar 2020 08:37:41 +0000
X-Mailer: git-send-email 2.21.1
X-Originating-IP: [131.228.2.19]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2be8944a-bba3-4bf3-51f0-08d7c0e07825
X-MS-TrafficTypeDiagnostic: HE1PR0702MB3804:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0702MB3804B05AA03204703DF9FC21B4E20@HE1PR0702MB3804.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(66946007)(66556008)(66476007)(8936002)(110136005)(54906003)(316002)(5660300002)(956004)(86362001)(6506007)(2616005)(52116002)(26005)(103116003)(186003)(4326008)(6666004)(2906002)(16526019)(1076003)(81166006)(81156014)(36756003)(6486002)(7416002)(6512007)(8676002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3804;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQJQo3vaLnt0YAoGEK8z70iXaQ/E0MfkfiX7tw+rZq+mg0QzYQKb9vFIlXZrrWDLy6Sn1DTCcD9KGPIq/uROU1b9FKr769qySw1o/fu7S9YMBV+bppExDzX0XmnL4DvuFfy4VEVcit0R/jieAhAqCDAPrMIDyolU52MUPHwRu7hYUZz+ZrTJ0sTJEIz0uOhooyYLrH9yw2CA3N3nrOyS7VPfYC1DEY5SNEJGLWE8o4LPgr8FYYH+o3RAAREllLHnH1AeU45XgoL2FHUa5PZhBBiKaNbytRi8Tx5Uz5VG3d4nrUUKadtTlA+S5euBvP5OLMtHCfeT5MS+vz3uj/Y6SApp/0Wgg+cmAJY0yDMWS8/26QT6IEyOyDsXMn4D0/yxbWIhfFty8iTcR0/O2WFZFTN9M/FYqeDuSx2bKBIddt6/yhk9udX2YP59NndJC4Ll
X-MS-Exchange-AntiSpam-MessageData: Tt21MHFa3X4rOEeG3J8B87BH5c2buf32BTyXMe3clegleuHAs7ne3HHanlG8Mtbsmd4CmCsHzSgKLpiuwc8SBjATnRhz6qz44jVLBJ01iROBpGPwJm1C//Dh6YL53iQ84s+1qkYel+Qm7CEsIIAUhQ==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be8944a-bba3-4bf3-51f0-08d7c0e07825
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 08:37:41.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0feD/zIio0ERmh1PspUKh203A3IfiYbCpYfMTtXX6l+Wl3dHpQwrQVNaGQUMVzuhw9dR22pG7JOscfGks9AO5mPej951BZfuUXi7YwV4VrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3804
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3b2323c2c1c4 ("perf bench futex: Use cpumaps") the default
number of threads the benchmark uses got changed from number of online
CPUs to zero:

  $ perf bench futex wake
  # Running 'futex/wake' benchmark:
  Run summary [PID 15930]: blocking on 0 threads (at [private] futex 0x558b8ee4bfac), waking up 1 at a time.
  [Run 1]: Wokeup 0 of 0 threads in 0.0000 ms
  [...]
  [Run 10]: Wokeup 0 of 0 threads in 0.0000 ms
  Wokeup 0 of 0 threads in 0.0004 ms (+-40.82%)

Restore the old behavior by grabbing the number of online CPUs via
cpu->nr:

  $ perf bench futex wake
  # Running 'futex/wake' benchmark:
  Run summary [PID 18356]: blocking on 8 threads (at [private] futex 0xb3e62c), waking up 1 at a time.
  [Run 1]: Wokeup 8 of 8 threads in 0.0260 ms
  [...]
  [Run 10]: Wokeup 8 of 8 threads in 0.0270 ms
  Wokeup 8 of 8 threads in 0.0419 ms (+-24.35%)

Fixes: 3b2323c2c1c4 ("perf bench futex: Use cpumaps")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/perf/bench/futex-wake.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index df810096abfef..58906e9499bb0 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -43,7 +43,7 @@ static bool done = false, silent = false, fshared = false;
 static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
 static struct stats waketime_stats, wakeup_stats;
-static unsigned int ncpus, threads_starting, nthreads = 0;
+static unsigned int threads_starting, nthreads = 0;
 static int futex_flag = 0;
 
 static const struct option options[] = {
@@ -141,7 +141,7 @@ int bench_futex_wake(int argc, const char **argv)
 	sigaction(SIGINT, &act, NULL);
 
 	if (!nthreads)
-		nthreads = ncpus;
+		nthreads = cpu->nr;
 
 	worker = calloc(nthreads, sizeof(*worker));
 	if (!worker)
-- 
2.21.1

