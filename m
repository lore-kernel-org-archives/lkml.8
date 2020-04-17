Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56A0C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F33220724
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="r8xFc5ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbgDQNX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:23:57 -0400
Received: from mail-eopbgr80130.outbound.protection.outlook.com ([40.107.8.130]:59503
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730118AbgDQNXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:23:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WodCHyMvbd5pcoDX/JIUvfyH+9mbUsGAxAik88ey4DR9Aeu7WY8y2lm6lCGDQyY+/glpTpHyW8TQJPeW2EoHmhkmvQYTCCxBvXHtexZQ3qhhTGif8QbiHyWqut+o48fdeXDUHu6qISR/c2PKxNi/VobZofy6TwghPz/q3hIS8fLLmh9K77JUnQyKWzOVodsx09Kfyh0RPW4PZPkT8nIBlIUZLL4W/iT6PmO7YHwgQP+3594UXt9kKgWCRUnGy5Xh4xbb3y5IoDjjZEsUpO4YNcwB/UypM8Guo9lUu7fMTZb9zGARXuYd73vJZY8MiiBj5n2wFxDbOyigV5WBxb8HlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5vgD/4cVbp1AEMekxW/73BD7nPpLxuAjtGtT1vO5bg=;
 b=jxYbU27N8IGWybUenreaL8Bs86KqkliTmkjHLkITX8OthkggzHCb8YZua8siKKxFDssuYbVZNASDohfMgrighULfCxEpljbSEG2BXuLBkkG8mU+j/Q19pVIpX8Dw1faKv1q3YZn6Q+qJ3FOtfR6CwnlCjgWRZl2JUwT78/b0/uGus7dZUomsMTNfJ09FTigJeR2OaiLqUrTRC7QYGAV2pGlqZPxl6uH+ZQp8wfA4E2J8JOYjXRYfC/F297bXx2D62TYZK67waUDwktv2n/aje4ddESeuve/Lm1eKQ8+8mJfxruTiRHkQRtVB8ibxD9uUUeaWSsVDz3Kwokw/F1GLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5vgD/4cVbp1AEMekxW/73BD7nPpLxuAjtGtT1vO5bg=;
 b=r8xFc5ZZrfYR13sZUdqnnDyUUwkRIlkuPf/FhdaFeTyIJTSZUmyI6xHnoRqS77buj/6UNl339MkT2EQKvS8e0bqE0KIQKNZ96hMp18Tz9z2bdPBd8TOEuiplIeYRQySvVms0b0ydE0e5JIkGGPhASpHlyWwxLDiZuz96mfnWUW0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com (2603:10a6:3:4b::11)
 by HE1PR0701MB2763.eurprd07.prod.outlook.com (2603:10a6:3:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.18; Fri, 17 Apr
 2020 13:23:52 +0000
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece]) by HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece%10]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 13:23:52 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] perf tools: Move zstd_fini() to session deletion
Date:   Fri, 17 Apr 2020 16:23:27 +0300
Message-Id: <20200417132330.119407-2-tommi.t.rantala@nokia.com>
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
Received: from trfedora.emea.nsn-net.net (131.228.2.16) by HE1PR1001CA0008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend Transport; Fri, 17 Apr 2020 13:23:51 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [131.228.2.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 657b977b-f976-4afb-a4d3-08d7e2d29222
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2763326E3FAEA2BC3A25162EB4D90@HE1PR0701MB2763.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0701MB2938.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(36756003)(6666004)(6506007)(66946007)(66556008)(1076003)(8936002)(316002)(186003)(66476007)(16526019)(478600001)(7416002)(26005)(110136005)(86362001)(54906003)(5660300002)(2616005)(956004)(103116003)(4326008)(8676002)(81156014)(2906002)(6512007)(6486002)(52116002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVV7oQkMcfZdx6KqCjxlwSOAcVKPS+aCvGH988/0cI6qLD4lb3zBlvz/WKDU0ghGcuhAPaJ73KNY/798hrwHUdtU5iX0X61IPSlpCAaTl56ruHGCCegqcYMLqtkHENvsbE32pi+XCvV7BtRuW/ygbeqeJxfYiyD1sp+udAl5SbznaSwLhFCdI2Sn9cOMQq0soIS4DfD0HGFpfHeiz0XxcPMSUtC8ImAPiszvWZ4H/TTchg/MGCtXUS0SEB0iUDPMmDtOPMxjtBj1ER0XnOe1PtddYDF6JJPyPp3mNxiizEAoSuJhGXzkbuYTqF6uu8Do0DsgNENZpTxyaF3Limxj3eIZsieLtgH/Tqejj22zkP8bXFqCYqzyx/KidEsQEAu74VgQ1j3EFdJS2xBeydtHKKj19tdcyVigjIhv6qcYMDxtYTNxVDta5UPZZjixTb08
X-MS-Exchange-AntiSpam-MessageData: ZfkQKvrJlHv2bLPpbS2Mb9ViTDcNWfK21GjniS5GeW0QXD/FPG6ueVKkoMkBCdLCtC/oBOIq4k+Gqz8rR0R7BYTYIH4zsLQCLRoH6zYpo5LWVGQ9PBv4mAkfdamcC4qZg5oUofV4gyKnBNSRf1k0Jw==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657b977b-f976-4afb-a4d3-08d7e2d29222
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 13:23:52.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0U+rSkLXLprfe8upVA5VtdHJ34JPJtGddZXFSqI4+hjMgdwBKUgJ/IVJU6/Q7Y3bhrIUz92Pe0wihv8RvyjKVknR+AuS7oFJ7s8Qqjis7m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2763
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move zstd_fini() call to perf_session__delete(), so that we always
cleanup the zstd state when deleting the session.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/perf/builtin-inject.c | 1 -
 tools/perf/builtin-record.c | 1 -
 tools/perf/builtin-report.c | 1 -
 tools/perf/util/session.c   | 1 +
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 7e124a7b8bfd..1ffb8393357a 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -836,7 +836,6 @@ int cmd_inject(int argc, const char **argv)
 	ret = __cmd_inject(&inject);
 
 out_delete:
-	zstd_fini(&(inject.session->zstd_data));
 	perf_session__delete(inject.session);
 	return ret;
 }
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1ab349abe904..8ed00de1ca29 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1827,7 +1827,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 out_delete_session:
-	zstd_fini(&session->zstd_data);
 	perf_session__delete(session);
 
 	if (!opts->no_bpf_event)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 26d8fc27e427..e06e14980264 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1579,7 +1579,6 @@ int cmd_report(int argc, const char **argv)
 		report.block_reports = NULL;
 	}
 
-	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
 	return ret;
 }
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0b0bfe5bef17..64e8b794b0bc 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -302,6 +302,7 @@ void perf_session__delete(struct perf_session *session)
 	machines__exit(&session->machines);
 	if (session->data)
 		perf_data__close(session->data);
+	zstd_fini(&session->zstd_data);
 	free(session);
 }
 
-- 
2.25.2

