Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1075FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE63B2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="ecGB8EiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgEZSfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgEZSfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:35:13 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED72C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:35:13 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c185so7569995qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tOHefzf5rrf6G5EWDMOouxVnKSU7Wd/O1AnRn9bMs1U=;
        b=ecGB8EiRX+iwxbGas+Dcx/BedPX+XhFTrkIpEUtRlmlYtDVzT38LGjlDQ+q0FGUsVq
         vMlno1I/lZLGX10FakV/Gie2hEbDpAk9KwWjUPG2tp9zqkjs2XGBadd0xZTH7ZtTiz+g
         f6OYTzZ35mk2dWOeVG/8r0pwIUn4JixaihXgg9Di9Be2BWUjgpaQIFKGBsZ1+uowDH83
         +6aFYeXMhY5gvukVB1flp+GlXlpw6t6WZWGk6fX5tZgluAbwhKJtaZb3j7YIj2IIOl/x
         lt2akuZxcJ21/6+Vaj0s9YkLkKgZwjy6mUVeAzk8jXI3/Pnhw2EsE+qzD2CdI2zQUUjR
         ahJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tOHefzf5rrf6G5EWDMOouxVnKSU7Wd/O1AnRn9bMs1U=;
        b=mfOVlrbp4KGTRvw9otcfr7Aqw9z6h21580xsD9T5TMrck457a3Pd3XQescLeDFQZv3
         dRZ4ks6ijIGIFMQDaKM6ggJXilaKbpbL/QfJSRmOF0NaPGftFyNEwKzFar2g+ENzLCO0
         a3CRa5a/ajIUVcx8k07dJvw/mfN+ZLnAspwEKOil2sNi5/yeCxxrJEFQ5Tg2Ob3iiaJl
         UkgcM2ElAzD4C8H2+78JHM8p+izx+8UKU/US6Dk82u2rPmQw2NvRKlDB8VdiRhpQA85C
         l1VBiYWMsrfrMUIM7OMNF53+lmFX3hHtvsCNJAPggT+f2A7vKTxbB7q7xWn3dznzoU2N
         sAkA==
X-Gm-Message-State: AOAM532ac9JkyVAkl45meQupUia7xMPEeK+BQx+puJvOJxOMKEsBCQkd
        z5HcMaKyf3Z45JKllrOJdF9lvQ==
X-Google-Smtp-Source: ABdhPJxCRmUucVbdyfLei9YA5WE+HsPraMh/wlOImgdfrkErvWAIFR3hdUWwt5WWeBJVD5+n89/mHw==
X-Received: by 2002:a05:620a:22f5:: with SMTP id p21mr129040qki.241.1590518112425;
        Tue, 26 May 2020 11:35:12 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id o2sm396942qtj.70.2020.05.26.11.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:35:11 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com, skhan@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [fixup] kunit: use KUnit defconfig by default
Date:   Tue, 26 May 2020 15:35:06 -0300
Message-Id: <20200526183506.47104-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the usability of KUnit, defconfig is used
by default if no kunitconfig is present.

 * https://bugzilla.kernel.org/show_bug.cgi?id=205259

Fixed up minor merge conflicts - Shuah Khan <skhan@linuxfoundation.org>

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Version after kunit merge branch:
 * removes code related defconfig;
 * handles when there is no .kunitconfig. 
---
 tools/testing/kunit/kunit.py | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index b3490271a103..787b6d4ad716 100755
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
@@ -32,8 +32,8 @@ KunitExecRequest = namedtuple('KunitExecRequest',
 KunitParseRequest = namedtuple('KunitParseRequest',
 			       ['raw_output', 'input_data'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
-					   'build_dir', 'defconfig',
-					   'alltests', 'make_options'])
+					   'build_dir', 'alltests',
+					   'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -60,8 +60,7 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_parser.print_with_timestamp('Configuring KUnit Kernel ...')
 
 	config_start = time.time()
-	if request.defconfig:
-		create_default_kunitconfig()
+	create_default_kunitconfig()
 	success = linux.build_reconfig(request.build_dir, request.make_options)
 	config_end = time.time()
 	if not success:
@@ -131,7 +130,6 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	run_start = time.time()
 
 	config_request = KunitConfigRequest(request.build_dir,
-					    request.defconfig,
 					    request.make_options)
 	config_result = config_tests(linux, config_request)
 	if config_result.status != KunitStatus.SUCCESS:
@@ -177,11 +175,6 @@ def add_common_opts(parser):
 			    help='Run all KUnit tests through allyesconfig',
 			    action='store_true')
 
-def add_config_opts(parser):
-	parser.add_argument('--defconfig',
-			    help='Uses a default .kunitconfig.',
-			    action='store_true')
-
 def add_build_opts(parser):
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
@@ -210,7 +203,6 @@ def main(argv, linux=None):
 	# The 'run' command will config, build, exec, and parse in one go.
 	run_parser = subparser.add_parser('run', help='Runs KUnit tests.')
 	add_common_opts(run_parser)
-	add_config_opts(run_parser)
 	add_build_opts(run_parser)
 	add_exec_opts(run_parser)
 	add_parse_opts(run_parser)
@@ -219,7 +211,6 @@ def main(argv, linux=None):
 						help='Ensures that .config contains all of '
 						'the options in .kunitconfig')
 	add_common_opts(config_parser)
-	add_config_opts(config_parser)
 
 	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests')
 	add_common_opts(build_parser)
@@ -251,6 +242,9 @@ def main(argv, linux=None):
 			cli_args.build_dir,
 			kunit_kernel.kunitconfig_path)
 
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
+
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
@@ -258,7 +252,6 @@ def main(argv, linux=None):
 				       cli_args.timeout,
 				       cli_args.jobs,
 				       cli_args.build_dir,
-				       cli_args.defconfig,
 				       cli_args.alltests,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
@@ -272,11 +265,13 @@ def main(argv, linux=None):
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
@@ -292,6 +287,9 @@ def main(argv, linux=None):
 				cli_args.build_dir,
 				kunit_kernel.kunitconfig_path)
 
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
+
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
@@ -313,6 +311,9 @@ def main(argv, linux=None):
 				cli_args.build_dir,
 				kunit_kernel.kunitconfig_path)
 
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
+
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
-- 
2.26.2

