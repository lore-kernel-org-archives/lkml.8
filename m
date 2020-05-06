Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260BCC4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED26520CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778572;
	bh=XBTKbMNdQt+QeTWlJ3bmshCmhiKjZaPEYSsbOHhQlnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xY4LbuC3Dq+G8Gqo8z20MxGXXzIjKF4CikF2ZNhYZZl6UvzBpeT0fPe8lDk5av8cc
	 v5xx0Ct/xlm0BbAGNtHtBMw+i5uHfPAkar2bczbcVcxqpDEuAlQH1EqIg8pr1tFNOD
	 xRjmoPf+jyfsDYxcg15kIBK2rhdnsa7Zh8UhZbUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgEFPWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgEFPWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:22:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0851E215A4;
        Wed,  6 May 2020 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778567;
        bh=XBTKbMNdQt+QeTWlJ3bmshCmhiKjZaPEYSsbOHhQlnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVr6jdqAmmdT3IZ74k4i6nVbHTwpFt1IZxPggRaTo4665HnR4g1QvoGRlSZJ4Anbs
         +BEdrKV9hz2otV98tTieFgRVUHnPpSvcBc+V/PNBTiJHDNbVcupMVZc9zJ/fo0xq0n
         ths9OGEu59dR7ImHEk0eT/nBQxfIsShDPe8/8cDA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/91] perf cgroup: Avoid needless closing of unopened fd
Date:   Wed,  6 May 2020 12:21:04 -0300
Message-Id: <20200506152234.21977-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

Do not bother with close() if fd is not valid, just to silence valgrind:

    $ valgrind ./perf script
    ==59169== Memcheck, a memory error detector
    ==59169== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
    ==59169== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
    ==59169== Command: ./perf script
    ==59169==
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200417132330.119407-1-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index b73fb7823048..050dea9f1e88 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -107,7 +107,8 @@ static int add_cgroup(struct evlist *evlist, const char *str)
 
 static void cgroup__delete(struct cgroup *cgroup)
 {
-	close(cgroup->fd);
+	if (cgroup->fd >= 0)
+		close(cgroup->fd);
 	zfree(&cgroup->name);
 	free(cgroup);
 }
-- 
2.21.1

