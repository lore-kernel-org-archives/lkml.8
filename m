Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54854C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 06:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304A921973
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 06:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAxw+uKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDSGT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 02:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSGTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 02:19:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91975C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 23:19:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n24so2686251plp.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 23:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Wi+roNxZ30DIhzLUsxQNw2tXyLLMZDC7R3RtjTj2IEM=;
        b=hAxw+uKMPpiPnhrf0eYGc1BIC2UOhuhaSQJZZMu9ucNXQtV6LwTJlWdtjSLTOiut/Y
         sO6cKojvzbLrf2lia8MgA9IXKze+WN6e/SeQC2gSfyj2ZR1JBv/fwMgap70zTWTZBSpy
         9wahWyuYgc1vgCrLRhvCm1Xeg9bgt4/rsVdYtu5ZD2NCIYcJknAmJwc4eUHiSfmJlHzb
         K6kRQRewfTTyZ0ShQqgsc//9B4wKgNHjeVgXJTXXFZAqt7LANvLuQcTVoN7a4WyEmdnb
         5DJHRLZ2jxlcrUWwTJUYzRPYGlcUCa+kRcGAdUjH+iGr1Gjl2DU59pIlW2pSNRnOLYL4
         ozQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wi+roNxZ30DIhzLUsxQNw2tXyLLMZDC7R3RtjTj2IEM=;
        b=YSO59V/zU9E44WfytY7xHaaS7ijUxnmCmsZ+ZLWnTKEqV2o69tzb1HqiSrEU6B16iw
         4Uz8KVfZzRbE7nU5bxNxbXEm0ApTLvobHOSEcwU4fio1DH6aqrNIPm+Mgfq7V3uvtXoB
         v09r+wBwuSx8YhG6rAGZ7CQpTNDuKr97khJRbK/H+8wqI6WBUp8YRt2YqZmlIC56vvff
         Yez8pXCvcDjX50958N935RgLsL6gViw4T14Dg8VtUQych9RfQ1keaMWc+vA9dkSXlUsO
         jC+l0u6yiuGsts7AKVRnDaoPYDEnPwAPl/+I5VfZF4Vhc5npkOWkhUA6hN9FDJ+ydR0o
         KdIA==
X-Gm-Message-State: AGi0Puar96gaft4sctHl16coXOh/CmOX80U9JuuwLECaUcryKWyEmu9m
        wvpgvEdwb0mbDsBNLBBqZWA=
X-Google-Smtp-Source: APiQypLt2XNgw93ALLF2H7ZvapzDFZubdO0emGIArEUZfie8U+RvQQ/1IsbbsZxvAxebfMzT8A++/Q==
X-Received: by 2002:a17:902:b592:: with SMTP id a18mr11481922pls.147.1587277164968;
        Sat, 18 Apr 2020 23:19:24 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([27.59.158.48])
        by smtp.gmail.com with ESMTPSA id r28sm17482772pfg.186.2020.04.18.23.19.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2020 23:19:24 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH 3/7] tools/perf: Remove duplicate headers
Date:   Sun, 19 Apr 2020 11:48:26 +0530
Message-Id: <1587277106-17242-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Code cleanup: Remove duplicate headers which are included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 tools/perf/builtin-report.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 26d8fc2..e197b96 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -47,7 +47,6 @@
 #include "util/time-utils.h"
 #include "util/auxtrace.h"
 #include "util/units.h"
-#include "util/branch.h"
 #include "util/util.h" // perf_tip()
 #include "ui/ui.h"
 #include "ui/progress.h"
-- 
1.8.3.1

