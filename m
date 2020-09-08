Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9463EC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451A82137B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593544;
	bh=G/EtVET3CzkVLmZcaD82B3GWVJTDMRAsCsAyA6D3dx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EQKsJZAUB5K0RqyX/1VZbpEPiug9SbMNXpsDKWU6MpJHQ531AhisTJgDuc64O/3DN
	 MiHlSVOAjJ3QSToGsTpe7dD6HZ47w1j1wcVtgsUZ1nmqO+MWSmytL9PB8kY16J1rAR
	 QAIlg+ulQOha6Wtb26ob0v8eJGk5guJSW6OJx/Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbgIHTcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730994AbgIHP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:58:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A981246D1;
        Tue,  8 Sep 2020 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579603;
        bh=G/EtVET3CzkVLmZcaD82B3GWVJTDMRAsCsAyA6D3dx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qu0PlKhaX7xcozy80RGHrH7j+J5D6+qPI4Pk/2wLw1gubqZHMSWtIZZGOJfyg7NbV
         6yzMMM0OoPqRCVptjxVYraR/SFlTjbAUQOspg1NJCAFg44kgSdjNl4+dQcvxn3EmMb
         cEuyj32KFa//ta9DuyqJrClncqI2LwbcN3Z92bSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 107/186] perf bench: The do_run_multi_threaded() function must use IS_ERR(perf_session__new())
Date:   Tue,  8 Sep 2020 17:24:09 +0200
Message-Id: <20200908152246.818387399@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit e4d71f79cf5c10fa8bc6f5d3bebea570c9c438f1 ]

In case of error, the function perf_session__new() returns ERR_PTR() and
never returns NULL. The NULL test in the return value check should be
replaced with IS_ERR()

Committer notes:

This wasn't compiling due to an extraneous '{' not matched by a '}', fix
it.

Fixes: 13edc237200c ("perf bench: Add a multi-threaded synthesize benchmark")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200902140526.26916-1-yuehaibing@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/bench/synthesize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 8d624aea1c5e5..b2924e3181dc3 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -162,8 +162,8 @@ static int do_run_multi_threaded(struct target *target,
 	init_stats(&event_stats);
 	for (i = 0; i < multi_iterations; i++) {
 		session = perf_session__new(NULL, false, NULL);
-		if (!session)
-			return -ENOMEM;
+		if (IS_ERR(session))
+			return PTR_ERR(session);
 
 		atomic_set(&event_count, 0);
 		gettimeofday(&start, NULL);
-- 
2.25.1



