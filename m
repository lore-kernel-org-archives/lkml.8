Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77205C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAD52465D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271593;
	bh=fKgzkNovUzgTf8pbQsgdrFyVGaFJHfBMFNKzV/qWmos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e9KzexJeHDT5KknEHapu9F2KsNMBXY2JkQSW+ZiCBpcS6XMd4XnPyMYvDqAouY2K2
	 gzKZAtdHrFThnW7b1Jl9MnNQ/WQYU+g1QJcQFhYL9QFh4BrD+rHU4iGKa3Fa8FxaJl
	 g1pmFrKsV28RSsmQsGFszMuQyEm4p1ikg+IpSbt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgBUHxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:53:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730014AbgBUHxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:53:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B94D24656;
        Fri, 21 Feb 2020 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271587;
        bh=fKgzkNovUzgTf8pbQsgdrFyVGaFJHfBMFNKzV/qWmos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13sxEQOeoQ4GpYdur1HmnzhmQcHKWCeC4Omld5UHEIQH9lr5cIhLIrExA61yacqbM
         hgorPA4KukISXeYUD/96Aixvr68fXVUCbXvlS3FeBuCQ+43djI1rWH+C5F+tqMeEeR
         N+Reh9+lfFC4++VDE8vq8gke9dCV5iO46oNmlbJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 222/399] selftests: Uninitialized variable in test_cgcore_proc_migration()
Date:   Fri, 21 Feb 2020 08:39:07 +0100
Message-Id: <20200221072424.558967249@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 192c197cbca599321de95a4cf15c2fa0681140d3 ]

The "c_threads" variable is used in the error handling code before it
has been initialized

Fixes: 11318989c381 ("selftests: cgroup: Add task migration tests")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/cgroup/test_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index c5ca669feb2bd..e19ce940cd6a2 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -369,7 +369,7 @@ static void *dummy_thread_fn(void *arg)
 static int test_cgcore_proc_migration(const char *root)
 {
 	int ret = KSFT_FAIL;
-	int t, c_threads, n_threads = 13;
+	int t, c_threads = 0, n_threads = 13;
 	char *src = NULL, *dst = NULL;
 	pthread_t threads[n_threads];
 
-- 
2.20.1



