Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B094C38A2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABC42072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="Qi+OXTWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392182AbgDNXiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731566AbgDNXh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 19:37:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F5CC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 16:37:58 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id f13so11732712qti.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 16:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCwPuKmH/oI9C7WlTBDAO1eLLHGw+bPmXi184TkjafU=;
        b=Qi+OXTWR3M+VOoHxKWPFvZq5KUuIF2h5aY2NneEvBrAsN4w6drKvJqKmM4Qi4V+wNO
         a4foeUbOhBpTfOuHkhg1rhG9eeWx7+OuH0t38UfAWlIg73vLjR1Ae60iX+zIpmdEk1Ds
         AJGjsxtxgOm+GdJKjCTtijUR+extToVz7++Nrsm0u+Y3azL19PJdxB7G+v79d229YLlq
         GHz3HxZkVyfPaoLuyWcF0RYCN7z2OKDzE1DzOVMoDXPz5VloK6+xB+uk3vxoD0PLIRkD
         +v0Lu8W/Dx7bnqA0MgicJCwSgsLyjQhm3wGmm9Jz0Mt2F/Wqsd9BEj8g8vVFM7+46HmE
         SxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCwPuKmH/oI9C7WlTBDAO1eLLHGw+bPmXi184TkjafU=;
        b=TnpqExnnJpyQ9iG8CYca04PzJ7puYqpFAlAgr3dMkN+eoei0YbPXiRu1sAK0t0qj4S
         eTBW693XZhMz21VRJnu+RQxfX5HiXlG/xKRCh9tj0bSUHz0EWvcob+xXzgYzNP9A9qhk
         w8v3oEVrCPmdtENrgySv5r0QAm1zKXzC6NGRNmBR+xgT5HaED8L2t6PCbgPIiaBXMuFM
         csRlhOFoyZpe9/AoTnvc9HOqHt4WJnLQ9xBWfZu+7o0OSfh5kwUSotK7J0J8JT976vaA
         s7afbpZUCpWULy4+gcafupsNW5GLwpPAJtD29r87R2BNW2YIlOTtGgQMJChYgD0aC2vk
         9U2A==
X-Gm-Message-State: AGi0PubytKkGLbHIO9CBkQltWjdbjAEOrQpq+LRz1kgvBAZ5XCAZIWWF
        pt5FTEkRMj3YLDHo2em9K39+2A==
X-Google-Smtp-Source: APiQypLEBpL7JFRTA08Ptl1zvEP1uFukp86z+t4gdFHAskwsDaP5zrTML7sftc0mtMkzp3eCIpX0gQ==
X-Received: by 2002:ac8:45da:: with SMTP id e26mr8533094qto.337.1586907477413;
        Tue, 14 Apr 2020 16:37:57 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id h128sm11333859qkd.17.2020.04.14.16.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 16:37:56 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] kunit: use KUnit defconfig by default
Date:   Tue, 14 Apr 2020 20:37:53 -0300
Message-Id: <20200414233753.94978-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the usability of KUnit, defconfig is used
by default if no kunitconfig is present.

 * https://bugzilla.kernel.org/show_bug.cgi?id=205259

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 tools/testing/kunit/kunit.py | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7dca74774dd2..4b98f6e75e4c 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -23,8 +23,8 @@ import kunit_parser
 KunitResult = namedtuple('KunitResult', ['status','result'])
 
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
-					   'build_dir', 'defconfig',
-					   'alltests', 'make_options'])
+					   'build_dir', 'alltests',
+					   'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -118,10 +118,6 @@ def main(argv, linux=None):
 				'directory.',
 				type=str, default='', metavar='build_dir')
 
-	run_parser.add_argument('--defconfig',
-				help='Uses a default .kunitconfig.',
-				action='store_true')
-
 	run_parser.add_argument('--alltests',
 				help='Run all KUnit tests through allyesconfig',
 				action='store_true')
@@ -143,8 +139,7 @@ def main(argv, linux=None):
 				cli_args.build_dir,
 				kunit_kernel.kunitconfig_path)
 
-		if cli_args.defconfig:
-			create_default_kunitconfig()
+		create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
@@ -153,7 +148,6 @@ def main(argv, linux=None):
 				       cli_args.timeout,
 				       cli_args.jobs,
 				       cli_args.build_dir,
-				       cli_args.defconfig,
 				       cli_args.alltests,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
-- 
2.25.1

