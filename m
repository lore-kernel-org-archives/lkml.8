Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EC0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D321D20724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597930931;
	bh=kCmhR+CJ9QTo6q+Nvv/t2fNCrVtHeBPbDvsuZwRkcYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=quEylSj1svFpV3srqUcxDwoR31+KwRUWUaO5WNWkkfMY69Niwl1kIHUesTJus8x/W
	 IOQR0NqI+OzJRYr0TmgxExdfLUgxs+weY5RRmlxuzkzYaTBGcgQRBY+3MeTNZCHeUR
	 IrguimICS/epkMbloPLeMg6RQE9oD+/5IAWUc/1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgHTNmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgHTJ3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:29:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61BEA2075E;
        Thu, 20 Aug 2020 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915783;
        bh=kCmhR+CJ9QTo6q+Nvv/t2fNCrVtHeBPbDvsuZwRkcYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bb+JGaYtiMk9Q3hkHm7BJLMU/7QX1T4P9qIGQD7ySns5Xa7jrwCgIZ/YNBFy3CXJD
         N2oixHyZRYLUTjlFWQorL0SyRJU/Pi0QXMPntXZAycsrqOnkj6QtLiG6NknsBl2Hml
         QYxodHNBWjyGvLNL4vysDh0t4HXNEk9Bwwf+i4+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 133/232] selftests/bpf: test_progs use another shell exit on non-actions
Date:   Thu, 20 Aug 2020 11:19:44 +0200
Message-Id: <20200820091619.262423482@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 3220fb667842a9725cbb71656f406eadb03c094b ]

This is a follow up adjustment to commit 6c92bd5cd465 ("selftests/bpf:
Test_progs indicate to shell on non-actions"), that returns shell exit
indication EXIT_FAILURE (value 1) when user selects a non-existing test.

The problem with using EXIT_FAILURE is that a shell script cannot tell
the difference between a non-existing test and the test failing.

This patch uses value 2 as shell exit indication.
(Aside note unrecognized option parameters use value 64).

Fixes: 6c92bd5cd465 ("selftests/bpf: Test_progs indicate to shell on non-actions")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/159410593992.1093222.90072558386094370.stgit@firesoul
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 6218b2b5a3f62..0849735ebda8a 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -12,6 +12,8 @@
 #include <string.h>
 #include <execinfo.h> /* backtrace */
 
+#define EXIT_NO_TEST		2
+
 /* defined in test_progs.h */
 struct test_env env = {};
 
@@ -707,7 +709,7 @@ int main(int argc, char **argv)
 	close(env.saved_netns_fd);
 
 	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
-		return EXIT_FAILURE;
+		return EXIT_NO_TEST;
 
 	return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
 }
-- 
2.25.1



