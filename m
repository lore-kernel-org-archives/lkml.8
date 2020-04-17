Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDB6C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47912087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="NhQVOzTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgDQNYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:24:02 -0400
Received: from mail-eopbgr60111.outbound.protection.outlook.com ([40.107.6.111]:30528
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730118AbgDQNYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:24:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI2f6puBUC7EUpTQN743nlir7F/a2A+EO6VI47j/vUrCDRyjBrqRurUktMWS6y8hf8sPlwzJKcxAgwk0mxHkbjcUIBs8kxyQkERB1EFSgzlXlBa/a6fcua8rulgdrGsO2OYIHhKV6r7sKdXaas+wOPH1E8OI8UEbkwFrWd6LGTI8w/wXxMfYvGiIOzV0FMo8v/uTmAv29C88sPxna0ClM/H7aAilw95vAUsIJghxIXSFsHyV7B5PMzFIMDyPRdofq9RdFfAyaIUZUNBDL9EAOnoVeVfQm1e1afcxJG9LaXp1brOwZMWWKex5dRN+yPoaNOTXRFLn4cqfPSV7ycCjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt/B7C9gFzgPZug3bPoVpkpzYxsbZKTig2cR+ubnY6s=;
 b=LmV4Qgc8ObMfHDTOy9k5HtR9df4QFHWmsFMEk1QL3CSYqvKUCEhpui6U+sDsbpSp5GH+5xlQ65cB5Yagk9xSzDi+RzltN+bnVrH4VV9FEtT9JHlGMS+Gm6WYsoQuiZmXFFmAX6792KQpsKFeU3DBr2XUH5u6zKaO4gNiFPHihpg1SyiqzH8gZzwWX5mh6M5tSgrsJyDHqOJe/aFFF7xwTlqbiSCAC6Y1F99e76BOmH8CoMW5po8AC7Fy1uwTGdS4PophxIyqNV+hKofDI1VqHhEUwlNKXB20shx/DvZm3brMWo9wNtKFdvsEDp2aP6EMJerE0vPscojApka52RNFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt/B7C9gFzgPZug3bPoVpkpzYxsbZKTig2cR+ubnY6s=;
 b=NhQVOzTR5DxjPqiW/l5J9z54nkAwRGolDHPO5Yaz8lafHy17Jameghwlsznz1oolMDtOWoxJ2XWeGma1I/N5dvUIjXEZwVjJcSTsZYFeM5KeoNv1Lt5clSKi4X/oinoaHvCwNcCQT/fA82ykVzdQLf6UZvyb2UAMJqmIPLn0Rg0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com (2603:10a6:3:4b::11)
 by HE1PR0701MB2763.eurprd07.prod.outlook.com (2603:10a6:3:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.18; Fri, 17 Apr
 2020 13:23:56 +0000
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece]) by HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece%10]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 13:23:56 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] perf tools: Fix segfaults due to missing zstd decompressor initialization
Date:   Fri, 17 Apr 2020 16:23:28 +0300
Message-Id: <20200417132330.119407-3-tommi.t.rantala@nokia.com>
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
Received: from trfedora.emea.nsn-net.net (131.228.2.16) by HE1PR1001CA0008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend Transport; Fri, 17 Apr 2020 13:23:56 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [131.228.2.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da740067-5f05-4d81-ccb6-08d7e2d294c2
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB276305EA887EDE8EAF6C459CB4D90@HE1PR0701MB2763.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0701MB2938.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(36756003)(6666004)(6506007)(66946007)(66556008)(1076003)(8936002)(316002)(186003)(66476007)(16526019)(478600001)(7416002)(26005)(110136005)(86362001)(54906003)(5660300002)(2616005)(956004)(103116003)(4326008)(8676002)(81156014)(2906002)(6512007)(6486002)(52116002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: widXVr4SHgIX+agqsBNQYgoV5Ukslv09JNkOOEX/tYuqqNy8Q25tmVqPWsMlPcxkbbrKoC4NoJVLUSLISx87eldY5/tb2gqMTd9RDTYG57fMAwlhiECM8RFJXcYy4ALoVMU7I7aYT9xJUTUjNJ3/K4zdkd7rs+jffy07XzJQF8jVo2FeQa0EM2Tigx4ehqvSCwrGcbSUeOZAa/P5mTbeWJCRZzwxlYJIK4pDv6skDexmwuR4XA0qoOXdoW6iSLkK1PNydf1OO9nCtLOgWyi9PUvGzs7X8+D3UkDuTyq77uoGVv2gly9ZRVebb3QJATO3BtUljK5wQzqkH5209WMccVotqBPfs3vNxa6AIOAZ3vNfqpuLLvGhtJa/eDlHEOSEscRgH/pGPnCR0RJ9HfgIYVZ+VOuXk+5+NmRFFXZw1lymrD2/l2apnQFN+Yxs4NNC
X-MS-Exchange-AntiSpam-MessageData: rf8aytXYhnEYL1tvF3RhSKr8ZwOrHGkBhv6t642maa2yO1cPqA3vbPGDwws+A8PyZaG5rH9j72A0jJocauEqANN2ObAOJI7ihFb3pUUrKwMSL911hg7wQaEetAqULaCuFvCHDy/57JaMtujcz0J8qw==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da740067-5f05-4d81-ccb6-08d7e2d294c2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 13:23:56.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnsanAw+YRO452BnzvuNyN4z1TIHji8yPoCUEAEB6pECpAAuXq+G+n4GZqx8LncR/oGTSncd4N8vTqvsaOvJsn946X73VSHMIDsI7i+hESU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2763
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialization of zstd decompressor state is done for "perf report" and
"perf inject", but missing for other tools, causing segfaults e.g. with
"perf script" and "perf annotate" when zstd compressed data is used:

  # ./perf record -z -a -- sleep 1
  # gdb -q --args ./perf script
  (gdb) run
  Program received signal SIGSEGV, Segmentation fault.
  0x00007ffff771d4cb in ZSTD_decompressStream () from /lib64/libzstd.so.1
  (gdb) bt
  #0  0x00007ffff771d4cb in ZSTD_decompressStream () from /lib64/libzstd.so.1
  #1  0x00000000005c92a8 in zstd_decompress_stream (data=0xc3f8e0, src=0x7ffff6dd3038, src_size=255, dst=0x7ffff61ec028, dst_size=528384) at util/zstd.c:100
  #2  0x00000000005262ba in perf_session__process_compressed_event (session=0xc38cc0, event=0x7ffff6dd3030, file_offset=11948080) at util/session.c:73
  #3  0x000000000052a596 in perf_session__process_user_event (session=0xc38cc0, event=0x7ffff6dd3030, file_offset=11948080) at util/session.c:1581
  #4  0x000000000052ab4b in perf_session__process_event (session=0xc38cc0, event=0x7ffff6dd3030, file_offset=11948080) at util/session.c:1713
  #5  0x000000000052bed6 in process_simple (session=0xc38cc0, event=0x7ffff6dd3030, file_offset=11948080) at util/session.c:2209
  #6  0x000000000052bcfe in reader__process_events (rd=0x7fffffffb400, session=0xc38cc0, prog=0x7fffffffb420) at util/session.c:2175
  #7  0x000000000052bfc2 in __perf_session__process_events (session=0xc38cc0) at util/session.c:2232
  #8  0x000000000052c0f3 in perf_session__process_events (session=0xc38cc0) at util/session.c:2265
  #9  0x0000000000447266 in __cmd_script (script=0x7fffffffb5c0) at builtin-script.c:2608
  #10 0x000000000044ba79 in cmd_script (argc=0, argv=0x7fffffffd330) at builtin-script.c:3988
  #11 0x00000000004bf2b8 in run_builtin (p=0xa398f8 <commands+408>, argc=1, argv=0x7fffffffd330) at perf.c:312
  #12 0x00000000004bf525 in handle_internal_command (argc=1, argv=0x7fffffffd330) at perf.c:364
  #13 0x00000000004bf66c in run_argv (argcp=0x7fffffffd18c, argv=0x7fffffffd180) at perf.c:408
  #14 0x00000000004bfa38 in main (argc=1, argv=0x7fffffffd330) at perf.c:538

Split zstd_init() into zstd_decomp_init() and zstd_comp_init(), so that
we can do lazy initialization for the decompressor, and handle it all in
perf_session to make it easily available to all the tools.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/perf/builtin-inject.c |  3 ---
 tools/perf/builtin-record.c |  2 +-
 tools/perf/builtin-report.c |  3 ---
 tools/perf/util/compress.h  | 10 ++++++++--
 tools/perf/util/session.c   |  3 +++
 tools/perf/util/zstd.c      | 14 +++++++++++++-
 6 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 1ffb8393357a..8cc9dff9e66b 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -803,9 +803,6 @@ int cmd_inject(int argc, const char **argv)
 	if (IS_ERR(inject.session))
 		return PTR_ERR(inject.session);
 
-	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
-		pr_warning("Decompression initialization failed.\n");
-
 	if (inject.build_ids) {
 		/*
 		 * to make sure the mmap records are ordered correctly
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8ed00de1ca29..fa9c59fc4fe0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1461,7 +1461,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	fd = perf_data__fd(data);
 	rec->session = session;
 
-	if (zstd_init(&session->zstd_data, rec->opts.comp_level) < 0) {
+	if (zstd_comp_init(&session->zstd_data, rec->opts.comp_level) < 0) {
 		pr_err("Compression initialization failed.\n");
 		return -1;
 	}
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index e06e14980264..b85fcdebdb5a 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1355,9 +1355,6 @@ int cmd_report(int argc, const char **argv)
 	if (ret)
 		return ret;
 
-	if (zstd_init(&(session->zstd_data), 0) < 0)
-		pr_warning("Decompression initialization failed. Reported data may be incomplete.\n");
-
 	if (report.queue_size) {
 		ordered_events__set_alloc_size(&session->ordered_events,
 					       report.queue_size);
diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index 0cd3369af2a4..aff9ce60dfb8 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -26,7 +26,8 @@ struct zstd_data {
 
 #ifdef HAVE_ZSTD_SUPPORT
 
-int zstd_init(struct zstd_data *data, int level);
+int zstd_comp_init(struct zstd_data *data, int level);
+int zstd_decomp_init(struct zstd_data *data);
 int zstd_fini(struct zstd_data *data);
 
 size_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
@@ -37,7 +38,12 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
 			      void *dst, size_t dst_size);
 #else /* !HAVE_ZSTD_SUPPORT */
 
-static inline int zstd_init(struct zstd_data *data __maybe_unused, int level __maybe_unused)
+static inline int zstd_comp_init(struct zstd_data *data __maybe_unused, int level __maybe_unused)
+{
+	return 0;
+}
+
+static inline int zstd_decomp_init(struct zstd_data *data __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 64e8b794b0bc..2bba731e7cbf 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -45,6 +45,9 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
 	struct decomp *decomp, *decomp_last = session->decomp_last;
 
+	if (zstd_decomp_init(&session->zstd_data) < 0)
+		return -1;
+
 	if (decomp_last) {
 		decomp_last_rem = decomp_last->size - decomp_last->head;
 		decomp_len += decomp_last_rem;
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index d2202392ffdb..d789665e8c0c 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -5,10 +5,13 @@
 #include "util/compress.h"
 #include "util/debug.h"
 
-int zstd_init(struct zstd_data *data, int level)
+int zstd_decomp_init(struct zstd_data *data)
 {
 	size_t ret;
 
+	if (data->dstream)
+		return 0;
+
 	data->dstream = ZSTD_createDStream();
 	if (data->dstream == NULL) {
 		pr_err("Couldn't create decompression stream.\n");
@@ -18,9 +21,18 @@ int zstd_init(struct zstd_data *data, int level)
 	ret = ZSTD_initDStream(data->dstream);
 	if (ZSTD_isError(ret)) {
 		pr_err("Failed to initialize decompression stream: %s\n", ZSTD_getErrorName(ret));
+		ZSTD_freeDStream(data->dstream);
+		data->dstream = NULL;
 		return -1;
 	}
 
+	return 0;
+}
+
+int zstd_comp_init(struct zstd_data *data, int level)
+{
+	size_t ret;
+
 	if (!level)
 		return 0;
 
-- 
2.25.2

