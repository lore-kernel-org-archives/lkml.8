Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DDAC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A302072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlLq4n/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgCWTFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:05:07 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55180 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbgCWTFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:05:07 -0400
Received: by mail-pf1-f201.google.com with SMTP id t19so11954937pfq.21
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=62ODFo7fgtXrZQirhZFriVDxWJbpN32F85/2VefFryo=;
        b=rlLq4n/miZ/WNYaR8D0o1QhJuCKChqbKhtqfObtqtHzh3ZK09KPXexT576LOjSw3qH
         MrHnfw7INxbbdsjnuJy+239bqBeW/7MV9P98a8o70j95TzgbbxBYPny55hqrBM5l/Yo8
         wSeImOAGWwY6yzb5U5KFsBEbf+zmK7NrrnUROgF4wS5a4pa5LbSPUU/iwXNYUBeWz16T
         LwfqL3FR2iQTKHan5y65vPha46ce5jMsQ8qam1pNx3zq+CyaOFjiPKY5aqibqdv+Lceg
         kk/fUCQZjTJW8+MEGeocQphtfjQ/+5O1TwgcAwkbi7UzM3VcpJF/AM97lQXYXAYa+6Cg
         9fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=62ODFo7fgtXrZQirhZFriVDxWJbpN32F85/2VefFryo=;
        b=YXrNwj6+6QIVMPY+Ac6kyZhQeKGXECyMeQ75F/5c6Nv/qvnaMSIV6UcuIDL26FUTz2
         CO7HaFEbDvETxrgD9TzGfhU17jeI+BBSvktX7Mbe+Kf83s9tBokg7ejFefREYouV3+T9
         GH9rh7DXeuDlmpBdyFh9N30YW+W3Zdneae/F++qSn21uq26ziPYzi7F0tJkJzQaRyQZB
         p1eqILWY7I3bhylL6Jejq6w4E1vXYZniCZM+1mjZVUDFWRd2zGOibx+mH1+mfVrznPzm
         n6hwTFZTi/rxIeT+tMnKcYiRSnKZjgoStHntut5rDURLfFosnVb99s+wWupM4R/OD608
         bAdg==
X-Gm-Message-State: ANhLgQ0J3NxwODP3QjPdRQPy7JdmzrgG7yvI/LwYvdeur99amt/AcNjM
        +6MASUrjnz15l9xIw/jRGCDbQS3qSo3hpOOcyMiEdg==
X-Google-Smtp-Source: ADFU+vu60MjNR8qzisTn2g+enOhutcBQfdSiszlSCdNZiG9hSVpVqoH9ZuWAdaiqf7WCYmN1QexHDoTKiL0zlXbSGQCUgg==
X-Received: by 2002:a17:90b:14cb:: with SMTP id jz11mr910275pjb.142.1584990305331;
 Mon, 23 Mar 2020 12:05:05 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:04:59 -0700
Message-Id: <20200323190459.64737-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH rebase v2] kunit: add --make_options
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, gthelen@google.com, natechancellor@gmail.com
Cc:     linux-kselftest@vger.kernel.org, davidgow@google.com,
        kunit-dev@googlegroups.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Thelen <gthelen@google.com>

The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
optional --make_options flag to kunit.py allowing for the operator to
specify extra build options.

This allows use of the clang compiler for kunit:
  tools/testing/kunit/kunit.py run --defconfig \
    --make_options CC=clang --make_options HOSTCC=clang

Signed-off-by: Greg Thelen <gthelen@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: David Gow <davidgow@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py        | 14 ++++++++++----
 tools/testing/kunit/kunit_kernel.py | 24 ++++++++++++++----------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 650bb4cfc544..7dca74774dd2 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -24,7 +24,7 @@ KunitResult = namedtuple('KunitResult', ['status','result'])
 
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
 					   'build_dir', 'defconfig',
-					   'alltests'])
+					   'alltests', 'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -49,7 +49,7 @@ def get_kernel_root_path():
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
 	config_start = time.time()
-	success = linux.build_reconfig(request.build_dir)
+	success = linux.build_reconfig(request.build_dir, request.make_options)
 	config_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.CONFIG_FAILURE, 'could not configure kernel')
@@ -59,7 +59,8 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	build_start = time.time()
 	success = linux.build_um_kernel(request.alltests,
 					request.jobs,
-					request.build_dir)
+					request.build_dir,
+					request.make_options)
 	build_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
@@ -125,6 +126,10 @@ def main(argv, linux=None):
 				help='Run all KUnit tests through allyesconfig',
 				action='store_true')
 
+	run_parser.add_argument('--make_options',
+				help='X=Y make option, can be repeated.',
+				action='append')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
@@ -149,7 +154,8 @@ def main(argv, linux=None):
 				       cli_args.jobs,
 				       cli_args.build_dir,
 				       cli_args.defconfig,
-				       cli_args.alltests)
+				       cli_args.alltests,
+				       cli_args.make_options)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 415d8f3c4fe4..63dbda2d029f 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -40,8 +40,10 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output)
 
-	def make_olddefconfig(self, build_dir):
+	def make_olddefconfig(self, build_dir, make_options):
 		command = ['make', 'ARCH=um', 'olddefconfig']
+		if make_options:
+			command.extend(make_options)
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
@@ -68,8 +70,10 @@ class LinuxSourceTreeOperations(object):
 		kunit_parser.print_with_timestamp(
 			'Starting Kernel with all configs takes a few minutes...')
 
-	def make(self, jobs, build_dir):
+	def make(self, jobs, build_dir, make_options):
 		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
+		if make_options:
+			command.extend(make_options)
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
@@ -128,19 +132,19 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def build_config(self, build_dir):
+	def build_config(self, build_dir, make_options):
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
 		self._kconfig.write_to_file(kconfig_path)
 		try:
-			self._ops.make_olddefconfig(build_dir)
+			self._ops.make_olddefconfig(build_dir, make_options)
 		except ConfigError as e:
 			logging.error(e)
 			return False
 		return self.validate_config(build_dir)
 
-	def build_reconfig(self, build_dir):
+	def build_reconfig(self, build_dir, make_options):
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if os.path.exists(kconfig_path):
@@ -149,19 +153,19 @@ class LinuxSourceTree(object):
 			if not self._kconfig.is_subset_of(existing_kconfig):
 				print('Regenerating .config ...')
 				os.remove(kconfig_path)
-				return self.build_config(build_dir)
+				return self.build_config(build_dir, make_options)
 			else:
 				return True
 		else:
 			print('Generating .config ...')
-			return self.build_config(build_dir)
+			return self.build_config(build_dir, make_options)
 
-	def build_um_kernel(self, alltests, jobs, build_dir):
+	def build_um_kernel(self, alltests, jobs, build_dir, make_options):
 		if alltests:
 			self._ops.make_allyesconfig()
 		try:
-			self._ops.make_olddefconfig(build_dir)
-			self._ops.make(jobs, build_dir)
+			self._ops.make_olddefconfig(build_dir, make_options)
+			self._ops.make(jobs, build_dir, make_options)
 		except (ConfigError, BuildError) as e:
 			logging.error(e)
 			return False

base-commit: f90ead0534f28c96dd8149ca13408d167bed9209
-- 
2.25.1.696.g5e7596f4ac-goog

