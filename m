Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D7BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84FC20897
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsGlLlWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFRAat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFRAat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:30:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E62DC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 17:30:49 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c12so3095149qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 17:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=akP5TkvP5YIRbXmgcjZryXwqTlfdBNOtLQhNnMzmBg8=;
        b=fsGlLlWzYEWqgg5lC7qq3g3HVKzQyMMUjnuhIMp8KzYT0eltdurHq8Z0Q/PAMHug9B
         R5Ft+yQbK5elRA5weU43vQMisjAf7hahd8ymokdWebcw1Kf5/eqr/mE+d5+R9glzRTQ+
         F7kpOiubXtU48uqUGJZA8KtfpKkHox/qg3GslDiNnnpgE6TpTE2wDMmptz3N1DVPyQjf
         5APlGU/MQFfDVFWRpyCMP4KPlVw41jbUAbUTxkVHqJ36HOsjQJSRG+QkkokvcVnHfC8C
         Lj4Hjel5k6XRhb0VajDY23R1ARn4oBrWM7O4ScameFFXO/G6Qda1RbFXy0QJb6vu8O5b
         RS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=akP5TkvP5YIRbXmgcjZryXwqTlfdBNOtLQhNnMzmBg8=;
        b=FhPrrO9o+pldeVVc9UJAtvtQLT2jvemV642HFhU+LnYhAkee4rvJnidqqdWuHsdsNJ
         Dr11vtao01mIVg5Mej9KYjnDwm1WR938SkGtQrXZIbqFFVmQvpk/Zk9lJSPQJz3GwZjt
         Majt8nZP77NJrnvpneCABr3dP4UFx/HAff5sHj708jVR2gzYV0zgYDsngY0tGVR4tC/Q
         6WzoFJ5+9H1raMleNERfBDynMtIo9rmyB/4psonZySRozqLg3Bn2cCWIgVQyWm8hXifk
         VnU2Bbw7WkvaDxayjDCLHiUZA13nduYKLFuzTVvmbzMe7HrsPh5rEwtllvQIQkd54hq1
         QXFw==
X-Gm-Message-State: AOAM532DNZajrpsmOSlysRe0MSJTlaV2Va8JBTynZayC6VgjlmYEYncs
        c3Ko+1cwcx85AQDWTyEu1Mo=
X-Google-Smtp-Source: ABdhPJxrf8U7AvDY7BA+EpaFqARDd7AaisPCxAptSyMJMmAL6mD5D4Dg2YYeayEg+wsRHO9Rnc4J5A==
X-Received: by 2002:ac8:3f77:: with SMTP id w52mr1834059qtk.161.1592440248360;
        Wed, 17 Jun 2020 17:30:48 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:9c3:b47c:c995:4853])
        by smtp.googlemail.com with ESMTPSA id k81sm1450121qke.11.2020.06.17.17.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 17:30:47 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] [perf] sort : Fix null pointer dereference in _hist_entry__sym_snprintf
Date:   Wed, 17 Jun 2020 20:30:18 -0400
Message-Id: <20200618003040.26360-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer ms can be NULL. Add null check before
dereferencing it to avoid segmentation fault.

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 tools/perf/util/sort.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index d42339df20f8..25c7c96893f6 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -294,6 +294,9 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 				     u64 ip, char level, char *bf, size_t size,
 				     unsigned int width)
 {
+	if (!ms) 
+		return 0;
+
 	struct symbol *sym = ms->sym;
 	struct map *map = ms->map;
 	size_t ret = 0;
-- 
2.17.1

