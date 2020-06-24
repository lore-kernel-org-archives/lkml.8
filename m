Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B25EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDE52100A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/oz4MDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbgFXBfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbgFXBfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:35:34 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07504C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:35:33 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dm12so339432qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=TqReVHnhod4CGtUTTe7lNXyrQSlqJcDme46q9bN7OuI=;
        b=d/oz4MDQJGr5mV4CIQqGnXLaXd79fCAfN+CrAt3YjNYFXWnK1lPtNAlqGzC+T+WYqw
         TXe2Ccq6IlgN0g7IpMVH2H1ewkzPKdwJC+GUShrl+t4PsZTAmL+zYAb213Kilihp97fv
         RBEM5pZeyrjUyg0XpRAPLDI8g7wRMyr4GQGNsqq36S9kvzuZ3/A07/mJXD9rHWmahc9R
         rk1F4xazJf5+t/+JWj/emeu23tgXCBDUUDY87uuo2ert2gjlV7wn18YckP2WqNbAcJOH
         5pGmF3WR6PmZQDBsAOJS4rmai41CkqS7PaQfE+eqwEa37Lh5XJ/D6G4UcAtEPsGMeifW
         4OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=TqReVHnhod4CGtUTTe7lNXyrQSlqJcDme46q9bN7OuI=;
        b=j5hp/tw9ty3nBTSqNAnUhBRo4J20c3sSnGYN75qJNaI1E0gt/pn67sA64F2/ZyNLFO
         xErCPKx7A6/vk2Ox6qEKnWi0AhxYsAMtWhzpz8ghJWO63h5nsoFKtE1RUUDHbUtT3+U3
         fmRsmPsT9Po0DT/FvlzgIxXQE7Zln5EtP1xFlumtDDI7GQJshEvl+8r9eZUO28ONXo8q
         JC39rB9jX4klAurgQY7It+u8EyDhWJUmtPuPUk6RFryAezW55F9WFKcsjgSSXhzc5ZOR
         vttxy9Nk9sVCMgYfhbmu8lHi898scK0o1vF/MjJ1+C2G4hLj+ttm0UKDVcqKW8BCpZm2
         /vEw==
X-Gm-Message-State: AOAM530FLxPO3NICJ6Nke+gIPAtmqfJQXu6fMSKTugJddL7ChaiPCVxF
        z82jIpXIhhMHJaQq72n4oJk=
X-Google-Smtp-Source: ABdhPJxINudWbymKcfDEGryCkOw0uXhO4SHM27YrGgngnUSKDoFYZXBd9yhBbqxfTMm6FWWpJTDocQ==
X-Received: by 2002:a0c:a993:: with SMTP id a19mr4030626qvb.34.1592962532275;
        Tue, 23 Jun 2020 18:35:32 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:596e:7d49:a74:946e])
        by smtp.googlemail.com with ESMTPSA id h4sm2102136qtd.43.2020.06.23.18.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:35:31 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] [perf] lsdir_bid_tail_filter: fix index check
Date:   Tue, 23 Jun 2020 21:35:22 -0400
Message-Id: <20200624013524.10836-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check bounds before accessing d->d_name[].

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 tools/perf/util/build-id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index c076fc7fe025..8c35cbe93f10 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -431,7 +431,7 @@ static bool lsdir_bid_tail_filter(const char *name __maybe_unused,
 				  struct dirent *d)
 {
 	int i = 0;
-	while (isxdigit(d->d_name[i]) && i < SBUILD_ID_SIZE - 3)
+	while (i < SBUILD_ID_SIZE - 3 && isxdigit(d->d_name[i]))
 		i++;
 	return (i == SBUILD_ID_SIZE - 3) && (d->d_name[i] == '\0');
 }
-- 
2.17.1

