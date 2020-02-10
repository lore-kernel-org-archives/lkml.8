Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56317C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C47120714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340718;
	bh=7Yb61XXglUE8vFoOFTeRXvxRnUMTpt+E2LKizfxYCPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IkEHA9XjQjawgluHIJgI0K6nSUTGzWHQO3QYtw2stQyhktRkyUJF+Gj+qds/b9q48
	 R2Cq582DAHwMwmP3aJyI44Oxe+U/9wqsZ8UqB8DnUa5GXkL664qdpo1cXhTeU5mmN/
	 JxS7xJdTbtSfNp/m+ndWSN8qHEfNhGziOrna9GWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgBJNSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728930AbgBJMhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:52 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 831D920842;
        Mon, 10 Feb 2020 12:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338270;
        bh=7Yb61XXglUE8vFoOFTeRXvxRnUMTpt+E2LKizfxYCPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYYDv8uRwIJKxx/BFaRUv5mLQmELglyfdTTAHSbl4GjHYy2iaQiJ3HySwNOJXa+cu
         /Jo0YRuFLA+lqVadY5Z15i1lZRJhnQCcmmSqvRewfPdkYnPXKZwFJex+tUmv7loCg4
         5oUpqjUyPfc294mLZMbCXoajNOEEWFhYYVo/4EGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH 5.4 152/309] selftests/bpf: Skip perf hw events test if the setup disabled it
Date:   Mon, 10 Feb 2020 04:31:48 -0800
Message-Id: <20200210122420.867341734@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

commit f1c3656c6d9c147d07d16614455aceb34932bdeb upstream.

The same with commit 4e59afbbed96 ("selftests/bpf: skip nmi test when perf
hw events are disabled"), it would make more sense to skip the
test_stacktrace_build_id_nmi test if the setup (e.g. virtual machines) has
disabled hardware perf events.

Fixes: 13790d1cc72c ("bpf: add selftest for stackmap with build_id in NMI context")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20200117100656.10359-1-liuhangbin@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
@@ -49,8 +49,12 @@ retry:
 	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
 			 0 /* cpu 0 */, -1 /* group id */,
 			 0 /* flags */);
-	if (CHECK(pmu_fd < 0, "perf_event_open",
-		  "err %d errno %d. Does the test host support PERF_COUNT_HW_CPU_CYCLES?\n",
+	if (pmu_fd < 0 && errno == ENOENT) {
+		printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
+		test__skip();
+		goto cleanup;
+	}
+	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n",
 		  pmu_fd, errno))
 		goto close_prog;
 


