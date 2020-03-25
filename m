Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0977C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50F920719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mj6xhK0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCYWIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 18:08:40 -0400
Received: from mail-qv1-f73.google.com ([209.85.219.73]:46834 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgCYWIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 18:08:40 -0400
Received: by mail-qv1-f73.google.com with SMTP id a12so3126374qvq.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 15:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YE4q17ux875MrKIa5CyoLgKk2lWLIsGAH5KW4JkqzM4=;
        b=mj6xhK0pZu5N/qBwPrtIY0Uwy7CeCeFPRJiZxxnTNpnpRcg0T+N/a1vYCHqnEgPnYg
         cNrvFhZnuyU/9Sx7rhZGRl/1abPAnc8q5QtE40GkEMKTShgtpoGME2+ajItnEYSIrSla
         50/BJcVK8HYs/ziMr0iYF18MpWUNIagvlYtL7v7tXZ0TX7dprAIoDFO9mfe3WTr2V82S
         8gpaBDEPr/thGQOCogi+fjzRqXJ4MNK+L6reNgTSyVoeT0heB7hnzd8nAANwv6owshMq
         2Mwec6MSVep93oOIm6+H9yateTvco7IU2u1GVKnxLhlXjOsVhiPVsWKWkmDS7sCWItY2
         BVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YE4q17ux875MrKIa5CyoLgKk2lWLIsGAH5KW4JkqzM4=;
        b=G9iGwebepv1vutawDhCgE2HZd1Y5PnnFTFmVQuHkVf2vrKJpbeaAmydtTScwBKhE/9
         C1KoQ9Z1bKEGIbxj7CBi5hNRqjzMMUguHu2t8YUkwhroUCcEUlwFES7/HO+6OLrUKAKy
         nLOdOOPC/BlZjclLibaahBjSPIg9vbJ3447zH/1aIkWw+x1/pmevtoo0IskYXUXOmn1F
         kLbhlA6lwamLT0l8FUBf7s7zpt6PHfUTAuK0KhD9sRrb8i7HsZq2ZWtTUUpz28cPpTrJ
         /ysXQuYTxeKzVkN0v5MR+KBNB6XzfNOsV1wICspNL+V91ztWBV1eY9VH/OeFdqKLJ2TD
         w31Q==
X-Gm-Message-State: ANhLgQ1VXvgWYi6KAWF8TUE0T2S54kb1pVIaFR9Yofr63HW7h8OJthr3
        d/I0Z+0sR9hC9FGzg8nl5FuT+59EPf8O
X-Google-Smtp-Source: ADFU+vv9FDho7ZSrqbAPlOPWXipRpnXk1qMITMGrRWsPJvLdIAe/afeoUI8xTgXIiclWRXu+hPDt3PbYRTJ2
X-Received: by 2002:a0c:fe87:: with SMTP id d7mr4248419qvs.37.1585174119088;
 Wed, 25 Mar 2020 15:08:39 -0700 (PDT)
Date:   Wed, 25 Mar 2020 15:08:02 -0700
Message-Id: <20200325220802.15039-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] perf/script: allow --symbol to accept hexadecimal addresses
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

This patch extends the perf script --symbols option to filter
on hexadecimal addresses in addition to symbol names. This makes
it easier to handle cases where symbols are aliased.

With this patch, it is possible to mix and match symbols and hexadecimal
addresses using the --symbols option.

$ perf script --symbols=noploop,0x4007a0

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/event.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c5447ff516a2..c978a73fe475 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -599,10 +599,23 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 		al->sym = map__find_symbol(al->map, al->addr);
 	}
 
-	if (symbol_conf.sym_list &&
-		(!al->sym || !strlist__has_entry(symbol_conf.sym_list,
-						al->sym->name))) {
-		al->filtered |= (1 << HIST_FILTER__SYMBOL);
+	if (symbol_conf.sym_list) {
+		int ret = 0;
+		char al_addr_str[32];
+		size_t sz = sizeof(al_addr_str);
+
+		if (al->sym) {
+			ret = strlist__has_entry(symbol_conf.sym_list,
+						al->sym->name);
+		}
+		if (!(ret && al->sym)) {
+			snprintf(al_addr_str, sz, "0x%"PRIx64,
+				al->map->unmap_ip(al->map, al->sym->start));
+			ret = strlist__has_entry(symbol_conf.sym_list,
+						al_addr_str);
+		}
+		if (!ret)
+			al->filtered |= (1 << HIST_FILTER__SYMBOL);
 	}
 
 	return 0;
-- 
2.25.1.696.g5e7596f4ac-goog

