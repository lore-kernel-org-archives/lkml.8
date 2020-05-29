Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9E0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F33207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="rM5yGeEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgE2T2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2T2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:28:50 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D2C08C5C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:28:50 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j32so2875647qte.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2yrhlCJB5EdnMFeYW6dCoHgeGO9Wv2PNUyggTiWf66I=;
        b=rM5yGeEPKD1ETwS8p5hRXM1GRXsRU0ckAKC3dyimsrlw1vS2rJwpsAMVoQTgtFp/DV
         FZHDJ4blwRXdYidNVLHlZkwf/JjNlrxftmAzDI4YNv57PCZn16bKvW8Nbet9apvrGJpB
         Dh/cAqXEbs7XMI6pWL93SaGxEWJjols/VZTB7lraAPLuupPcyjB0vvNei3Ax64CJmVDM
         fDdTBepAccSwosJIH6L02feciSsBqqz9GGij+ncBgVWBDiSlua+gQtWczj/baqHgZweG
         vY9vh+CxNJf5TEjZa/UxWbHsZHQAJuqz41u1xCrnAOxcLSk6oJQpkOk8MnbC/Csho+Nl
         jpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2yrhlCJB5EdnMFeYW6dCoHgeGO9Wv2PNUyggTiWf66I=;
        b=G9KolZpzVqt2qNkbgjDyWjV+75lgwbXmzmAr5zpo5x04UgEkUZFYxklCAFAXzeZCXH
         FchnxPn/C7mccOWjpYv6tcuFFO/y1g723aZCFIjYUftcR0kKqHY0ZqO+Zu06Tq6lDT4O
         MUgmte62wkSmatrARaUsmBsREhqMWKiXTvUJzdoHIck3znlKIygSe53Z2QtpRh8VoTkl
         3YYU4hPVZv0Q57je1mpCGEmWEMWqelMG4xYdptcq+y85jvUnaa3xvmm5m5LomxgJtSLS
         wiSBRX7BPPj64f50RHnNUHBSBaM1QeKpeIeoOeZGQg82m8qRWqzkNcCC90MsQjURcndV
         gZ9Q==
X-Gm-Message-State: AOAM532epQze9x4sEc0WIw7IhojNIV9WZtcUjfM6D9skV3A0LpAbwRAK
        JFnIx5CoCKd8J/8LRra4zkrF5Q==
X-Google-Smtp-Source: ABdhPJx5RzeYnSHBhEQtvg6BqNax43i3eDbcLHygMZ5Uh9urOiS7DO2jD4wj/aIF6aluVDFXTouPAw==
X-Received: by 2002:ac8:4556:: with SMTP id z22mr10639657qtn.37.1590780529381;
        Fri, 29 May 2020 12:28:49 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id v126sm7486339qkd.36.2020.05.29.12.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:28:48 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com, skhan@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] kunit: Fix TabError, remove defconfig code and handle when there is no kunitconfig
Date:   Fri, 29 May 2020 16:28:45 -0300
Message-Id: <20200529192845.60468-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The identation before this code (`if not os.path.exists(cli_args.build_dir):``)
was with spaces instead of tabs after fixed up merge conflits,
this commit revert spaces to tabs:

[iha@bbking linux]$ tools/testing/kunit/kunit.py run
  File "tools/testing/kunit/kunit.py", line 247
    if not linux:
                ^
TabError: inconsistent use of tabs and spaces in indentation

Remove defconfig related code to fix these two errors,
the commit 9bdf64b35 was created before 45ba7a893ad,
and the commit 9bdf64b35 removes defconfig related code:

[iha@bbking linux]$ tools/testing/kunit/kunit.py run
Traceback (most recent call last):
  File "tools/testing/kunit/kunit.py", line 338, in <module>
    main(sys.argv[1:])
  File "tools/testing/kunit/kunit.py", line 215, in main
    add_config_opts(config_parser)

[iha@bbking linux]$ tools/testing/kunit/kunit.py run
Traceback (most recent call last):
  File "tools/testing/kunit/kunit.py", line 337, in <module>
    main(sys.argv[1:])
  File "tools/testing/kunit/kunit.py", line 255, in main
    result = run_tests(linux, request)
  File "tools/testing/kunit/kunit.py", line 133, in run_tests
    request.defconfig,
AttributeError: 'KunitRequest' object has no attribute 'defconfig'

Handles when there is no .kunitconfig, the error occurs because
commit 9bdf64b35 was created before 45ba7a893ad.

[iha@bbking linux]$ tools/testing/kunit/kunit.py run
Traceback (most recent call last):
  File "tools/testing/kunit/kunit.py", line 335, in <module>
    main(sys.argv[1:])
  File "tools/testing/kunit/kunit.py", line 246, in main
    linux = kunit_kernel.LinuxSourceTree()
  File "/home/iha/sdb/opensource/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 109, in __init__
    self._kconfig.read_from_file(kunitconfig_path)
  File "/home/iha/sdb/opensource/lkmp/linux/tools/testing/kunit/kunit_config.py", line 88, in read_from_file
    with open(path, 'r') as f:
FileNotFoundError: [Errno 2] No such file or directory: '.kunit/.kunitconfig'

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
Fix the fixup on this commits: 9bdf64b, ddbd60c.

Some errors occurs because these commits were created before
this commit 45ba7a8, as explained in the commit message.
---
 tools/testing/kunit/kunit.py | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index ec73b07d1265..787b6d4ad716 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -23,7 +23,7 @@ import kunit_parser
 KunitResult = namedtuple('KunitResult', ['status','result','elapsed_time'])
 
 KunitConfigRequest = namedtuple('KunitConfigRequest',
-				['build_dir', 'defconfig', 'make_options'])
+				['build_dir', 'make_options'])
 KunitBuildRequest = namedtuple('KunitBuildRequest',
 			       ['jobs', 'build_dir', 'alltests',
 				'make_options'])
@@ -130,7 +130,6 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	run_start = time.time()
 
 	config_request = KunitConfigRequest(request.build_dir,
-					    request.defconfig,
 					    request.make_options)
 	config_result = config_tests(linux, config_request)
 	if config_result.status != KunitStatus.SUCCESS:
@@ -212,7 +211,6 @@ def main(argv, linux=None):
 						help='Ensures that .config contains all of '
 						'the options in .kunitconfig')
 	add_common_opts(config_parser)
-	add_config_opts(config_parser)
 
 	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests')
 	add_common_opts(build_parser)
@@ -238,11 +236,14 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
-                if not os.path.exists(cli_args.build_dir):
-                    os.mkdir(cli_args.build_dir)
-                kunit_kernel.kunitconfig_path = os.path.join(
-                        cli_args.build_dir,
-                        kunit_kernel.kunitconfig_path)
+		if not os.path.exists(cli_args.build_dir):
+			os.mkdir(cli_args.build_dir)
+		kunit_kernel.kunitconfig_path = os.path.join(
+			cli_args.build_dir,
+			kunit_kernel.kunitconfig_path)
+
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
@@ -264,11 +265,13 @@ def main(argv, linux=None):
 				cli_args.build_dir,
 				kunit_kernel.kunitconfig_path)
 
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
+
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
 		request = KunitConfigRequest(cli_args.build_dir,
-					     cli_args.defconfig,
 					     cli_args.make_options)
 		result = config_tests(linux, request)
 		kunit_parser.print_with_timestamp((
@@ -284,6 +287,9 @@ def main(argv, linux=None):
 				cli_args.build_dir,
 				kunit_kernel.kunitconfig_path)
 
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
+
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
@@ -305,6 +311,9 @@ def main(argv, linux=None):
 				cli_args.build_dir,
 				kunit_kernel.kunitconfig_path)
 
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
+
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
-- 
2.26.2

