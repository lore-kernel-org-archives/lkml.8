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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34615C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EDC2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy+PtbEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgFRAj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFRAj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:39:29 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8AEC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 17:39:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q2so4009274qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 17:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=2rTi7sVYxh2vc2bTkTkIYUM2u0ppPplMS03UqDSUVng=;
        b=Cy+PtbEF74jCpRkwlJPtIZiv1YjMuA9ctLDf2D6GRsI5hGPGgutVZxTMgGSGsehvvE
         dtqOH28IEtBqoyIb/o0NDDH9loN8e6EfxKuQsbVh1Sv3b0nbVId+McCUno9PDJyb/CJF
         UhwYdSxpYOJwMDkx6jo2IJFfj7te/4lfmPN21+ZGVwNRTn3Du292aD+5rYEBnDfcBtlM
         euIaDf/J2aLKufk5ogY4w8W5a40upGww7+hGazur6S4snuxXHsXh4SrV2i4XnfeTWsI4
         6tD1y1xDCut6nOJLL0rxwIe2MTfEK+5H9yq7R95pgEC4+cjFJ4LOknXc33UfkbzLVr6C
         +DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=2rTi7sVYxh2vc2bTkTkIYUM2u0ppPplMS03UqDSUVng=;
        b=d0D3d85zOyXZiK/6WV9K+ZGrAbNDcxhiYtFqOPel1vmHEdaj8f6NCZowrvmsewORoU
         TXh+KQWSqpL6N3mTYwcsOxbQlu0DngJGsb7bhfmmo/0bU5OoWFgatfcvuEusYfROG3rf
         PuLWg17KmXhqE6FW3ac9kLfDuycXFZWhOQBsx5+JoeBZFhXo3riSJesEPJk8/2HEE4a7
         As/TGO64a1H3+siW6//ma/SwvYpuF/Z5Q8Ixv2RG9PKwbEAA7mK1RECzv9aMjWIyUEqK
         TW1U3r5C4tzvNuOmN43b2qDhMo8ADWVShuonILk7GoS5Uo6ZZtgPS+igPdKQCqIEaqyY
         Iukg==
X-Gm-Message-State: AOAM530OeF5tEm9Hgr1xiBpPd5GJHkNLnMlK4EnaVBBqsiiDtpVpvuDz
        jnVjc7YIev4h/za3VO0VkIs=
X-Google-Smtp-Source: ABdhPJxdV0ykrUh5oqjTY+50oYqRlJtDYcr0Bx93ANiw5+XULviU+C75bakCWcmACjAwiJMzUY/34g==
X-Received: by 2002:a05:620a:23a:: with SMTP id u26mr1311929qkm.443.1592440767971;
        Wed, 17 Jun 2020 17:39:27 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:9c3:b47c:c995:4853])
        by smtp.googlemail.com with ESMTPSA id p13sm1618060qtk.24.2020.06.17.17.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 17:39:27 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] [perf] Fix null pointer deference in nest_epollfd
Date:   Wed, 17 Jun 2020 20:38:49 -0400
Message-Id: <20200618003916.26644-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a NULL check for worker before dereferencing.

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 tools/perf/bench/epoll-wait.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 75dca9773186..42983eb7f82e 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -239,6 +239,9 @@ static void *workerfn(void *arg)
 
 static void nest_epollfd(struct worker *w)
 {
+	if (!w)
+		return;
+
 	unsigned int i;
 	struct epoll_event ev;
 	int efd = multiq ? w->epollfd : epollfd;
-- 
2.17.1

