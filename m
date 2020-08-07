Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5354DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CA4204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596828750;
	bh=sy9S8WJAqXnrm2XSVZnk29zjJqAO4npxEekf6QSblJo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=T3r/IrcCpEXnAA1nTYho3uf90we6elGERgDwbOTtxD63WSZ+lwXHJGJ4cBpQW6QbU
	 g9WjkxYqtA1Q21hmqWMrI0OUs0n++XPWFHVm+3QqJaQNbiZcrk7ImsPLB2KRP5EqC3
	 mHsq5EbAOGYkHytJMW+9VVCld+8S1EB3ExG/5MGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgHGTc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:32:28 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:34030 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:32:27 -0400
Received: by mail-il1-f194.google.com with SMTP id t4so2728446iln.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bt/nVcEmuirPVtvYSsxj3S2SEQncSrQ1r5Gx/y9AdOM=;
        b=USdxikVqXsukqPgBMoghd6Szp18UzME1kfk/5NhrKrrQHmtu1aYp0RnOo3zs2QNABk
         alprHc/QTKS+2dLRAlsrtTzcsFETm4x2nWPin9xN3zZLGEM829AX+WdUtM6vDFBxLbBF
         XzHdWpQUuMlhKUspi5vpPGJuk0lHAvXvMBGkAk0XAsN1Qq04FnDWRm0inMw8hKjHTRa2
         eBabNVHyuzOJYxNlzTFIRqYiT4wMhlmJrz1rmlk35Kc1pAKcVG4Ue5a0eZpgEQy92f7E
         S8wkUH6AJhFY0Y14zaUnRYmuxCYy4MDhFuoKXF6aaEwEFpuiFCzMAY8Rf36d63U/1IMv
         FFiw==
X-Gm-Message-State: AOAM5332tEolHQx1qppCQQoITmIT9l5rXGyyZCVZhbOCsJPN/vv1xyeW
        L1rWS/vLOXQV+Lz6LgDLdJTaXcc=
X-Google-Smtp-Source: ABdhPJwJMQI4IYAymCg9MKgcXByUvR0r8WJebIlBkgrmdn4WhpCmBB/32gCHgDZLX8OfymAsiel0TA==
X-Received: by 2002:a92:c805:: with SMTP id v5mr6360546iln.134.1596828746910;
        Fri, 07 Aug 2020 12:32:26 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id n1sm6807331ilo.68.2020.08.07.12.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 12:32:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] MAINTAINERS: Add missing tools/lib/perf/ path to perf maintainers
Date:   Fri,  7 Aug 2020 13:32:25 -0600
Message-Id: <20200807193225.3904108-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3ce311afb558 ("libperf: Move to tools/lib/perf") moved libperf
out of tools/perf/, but failed to update MAINTAINERS.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 496fd4eafb68..f29ddd97ec20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13410,6 +13410,7 @@ F:	arch/*/kernel/perf_event*.c
 F:	include/linux/perf_event.h
 F:	include/uapi/linux/perf_event.h
 F:	kernel/events/*
+F:	tools/lib/perf/
 F:	tools/perf/
 
 PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
-- 
2.25.1

