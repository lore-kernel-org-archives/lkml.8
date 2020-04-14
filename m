Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF4EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05882054F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="d/XycrnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441005AbgDNXKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731377AbgDNXJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 19:09:57 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EC1C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 16:09:55 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l60so3380511qtd.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 16:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8GmpDGYHNWO1HVRGOCC1HUE41KMOfYWwP4MYA86x9Hs=;
        b=d/XycrnOIE9zVNs85mQ8kiqfaX2FAKRGtTainrFJ0IzS2KMbTBKck6+HKcl12KMfi/
         mLyCl0M1OBOJwXwZ3mkeZWf734twgkheW3CbMFKK9vgo54UnwfYGSfuqlmm2nneOODqY
         lFI2ztDOic5VkmRttn366D+g3jqOHNKyx6SEMuHpgfwN4dMbeYlKBWMp7+Sx0VtOHgkw
         QAB6RJyglN5wdqlfuhGUcdCQiEH3Z01NDBhyXZH9qCDuhlHStFTK31cHPnoZ3HSzOw1n
         zELCk4JBQJoOxdIR6Znl2rOgnjsEmPOnLC0nGGBLDO2jdXjzhoB0uXDpMRgRXyQfNDmR
         X8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8GmpDGYHNWO1HVRGOCC1HUE41KMOfYWwP4MYA86x9Hs=;
        b=kg7RH0ghHiv3Hzz7glkSlEK4rlNx7Nypou/52egDdqVwP0L+c01hAEfsxqrCtFc/Yt
         XK1o/Ym3LL/yql9byzLv0DKjff8wVMFBgbbkBM0D4qbLfgp5soT+aGjZL/8OEAgitBk/
         kSOdD6/G2FrDou7LtiyiZVI60F64YwcQ83OenOG5VuxZDGsn3dhrw8sOHxnJGfcn0zef
         itMm4VCDOjSRBLJoQiOzMcAbNnPet7bgwK470/kpjOFXI0f+d3/rG7UvAxCMYMFAi7f4
         eKvR8xgiYpTzN322kuCcbPhCbMXE9l25F2fWDQtC0sZIY9ngYDEM6F+I3ZnzlEhzJQhl
         r9kA==
X-Gm-Message-State: AGi0Pua5WQzjkRxXDypIhFcfBWAPIF2Kq1xBUZMAuSPFVUxIOTZ2yePN
        KHRtP4o035M2aRVY+imdr1qvlQ==
X-Google-Smtp-Source: APiQypIq7HA/Rl7AQcDjE3FdKvf8IBKg1xI6rru45NLF9fLflB46Gk0TTOpZ6L0hLOq23HmizGMYBQ==
X-Received: by 2002:ac8:16e4:: with SMTP id y33mr19301422qtk.4.1586905795146;
        Tue, 14 Apr 2020 16:09:55 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id f1sm11455084qkl.72.2020.04.14.16.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 16:09:54 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RESEND] kunit: use --build_dir=.kunit as default
Date:   Tue, 14 Apr 2020 20:09:50 -0300
Message-Id: <20200414230950.83665-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make KUnit easier to use, and to avoid overwriting object and
.config files, the default KUnit build directory is set to .kunit

 * Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205221

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 tools/testing/kunit/kunit.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7dca74774dd2..5da190c79481 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -116,7 +116,7 @@ def main(argv, linux=None):
 	run_parser.add_argument('--build_dir',
 				help='As in the make command, it specifies the build '
 				'directory.',
-				type=str, default='', metavar='build_dir')
+				type=str, default='.kunit', metavar='build_dir')
 
 	run_parser.add_argument('--defconfig',
 				help='Uses a default .kunitconfig.',
@@ -136,12 +136,11 @@ def main(argv, linux=None):
 		if get_kernel_root_path():
 			os.chdir(get_kernel_root_path())
 
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
-			kunit_kernel.kunitconfig_path = os.path.join(
-				cli_args.build_dir,
-				kunit_kernel.kunitconfig_path)
+		if not os.path.exists(cli_args.build_dir):
+			os.mkdir(cli_args.build_dir)
+		kunit_kernel.kunitconfig_path = os.path.join(
+			cli_args.build_dir,
+			kunit_kernel.kunitconfig_path)
 
 		if cli_args.defconfig:
 			create_default_kunitconfig()
-- 
2.25.1

