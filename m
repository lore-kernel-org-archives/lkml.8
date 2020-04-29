Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0835EC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C592F206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="laI5WRAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgD2QTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2QTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:19:53 -0400
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7218AC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 09:19:53 -0700 (PDT)
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 3FF022E153D;
        Wed, 29 Apr 2020 19:19:50 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id zscGOiGhAs-JlbidVRg;
        Wed, 29 Apr 2020 19:19:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588177190; bh=yzEK/cS0rekVJ08c6ZLjh9KfT00vs5V4t9OpIY0ciEw=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=laI5WRAMVW1RKFVuTHz0OECfdbJ4v6rQbJ9fzmuwbDjBYcVDWX36lQiSAgHkDELH1
         HGA4pKknYNCUuDIUiMupmUqXDak++FTqdBuXNoJJurma9JAqn2fz1DSrRHMsQnpe4R
         JBeiKr4etmLiNg2MoPNhQDztB7ZJGrfmU657oDoE=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:508::1:9])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id wwtIzrH1vt-JlYafaE0;
        Wed, 29 Apr 2020 19:19:47 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH v2 1/3] perf tool: fix reading new topology attribute
 "core_cpus"
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Wed, 29 Apr 2020 19:19:47 +0300
Message-ID: <158817718710.747528.11009278875028211991.stgit@buzz>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check access("devices/system/cpu/cpu%d/topology/core_cpus", F_OK) fails,
unless current directory is "/sys". Simply try read this file first.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 0ccdb8407a46 ("perf tools: Apply new CPU topology sysfs attributes")
---
 tools/perf/util/smt.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 3b791ef2cd50..8481842e9edb 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -24,13 +24,13 @@ int smt_on(void)
 
 		snprintf(fn, sizeof fn,
 			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
-		if (access(fn, F_OK) == -1) {
+		if (sysfs__read_str(fn, &str, &strlen) < 0) {
 			snprintf(fn, sizeof fn,
 				"devices/system/cpu/cpu%d/topology/thread_siblings",
 				cpu);
+			if (sysfs__read_str(fn, &str, &strlen) < 0)
+				continue;
 		}
-		if (sysfs__read_str(fn, &str, &strlen) < 0)
-			continue;
 		/* Entry is hex, but does not have 0x, so need custom parser */
 		siblings = strtoull(str, NULL, 16);
 		free(str);

