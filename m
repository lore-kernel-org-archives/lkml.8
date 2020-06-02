Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D04C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA782074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgFBLZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:25:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:1988 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgFBLZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:25:40 -0400
IronPort-SDR: YVTOJA1kWfkHBOY197OibLbIEBrEpGS/0xCl+pS3E8ZbWIjbraMIjmJBjT3MAOKXXH1VnjpuQ/
 7t8GcEXqwtag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 04:25:39 -0700
IronPort-SDR: Vt5hFo/noc/5O4LBKKynkXP+DEjGzBPWT8SpbjdRMYjojELhXvxAb6S3KA+hom3JsE8PT+cBjo
 Bpf1o1ru87XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,464,1583222400"; 
   d="scan'208";a="286622080"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2020 04:25:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix kernel maps for kcore and eBPF
Date:   Tue,  2 Jun 2020 14:25:05 +0300
Message-Id: <20200602112505.1406-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust pgoff also when moving a map's start address.

Example with v5.4.34 based kernel:

  Before:

    $ sudo tools/perf/perf record -a --kcore -e intel_pt//k sleep 1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 1.958 MB perf.data ]
    $ sudo tools/perf/perf script --itrace=e >/dev/null
    Warning:
    961 instruction trace errors

  After:

    $ sudo tools/perf/perf script --itrace=e >/dev/null
    $

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: fb5a88d4131a ("perf tools: Preserve eBPF maps when loading kcore")
Cc: stable@vger.kernel.org
---
 tools/perf/util/symbol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 57cbe7a29868..5ddf84dcbae7 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1224,6 +1224,7 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 
 				m->end = old_map->start;
 				list_add_tail(&m->node, &merged);
+				new_map->pgoff += old_map->end - new_map->start;
 				new_map->start = old_map->end;
 			}
 		} else {
@@ -1244,6 +1245,7 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 				 *      |new......| ->         |new...|
 				 * |old....|        -> |old....|
 				 */
+				new_map->pgoff += old_map->end - new_map->start;
 				new_map->start = old_map->end;
 			}
 		}
-- 
2.17.1

