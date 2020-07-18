Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5128AC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3772076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="rLzvEfHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGRAtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgGRAtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:49:41 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBE2C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:49:40 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b185so10442582qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ruwweomjqKQrW+HQUE8j6UpZRuOujGYDiY69x9HzLFU=;
        b=rLzvEfHLFKDqsEcpPHR8/Mgq+xC9QkH3UtPOnO1WsRKPXz3jPDQdFI5F5G8wgGjPdV
         Qukl88zZTw3+tG0Bxgbyw7lyhHXHSQz1TRCCYj+BNzpI4QC6C4RZK+oanNvrbx7QeFL3
         YHlLI9LTjbBkRvAJ/kp8oL4YwzixbZPBQosXhSS2eEOiug4z3Uj/lySiHTtv+XyDRJdi
         /8NSI8HFMUs2jIADU7mjTUNmj/L8xeyvp7q3f6HnHEw53ECy9/WBZPQiUDgDal7/6w+a
         RNBCoM6dw0zYR7bjRxGamOQn8BmLKJHvM/vJ/etEUN7ijnKbxa8Qi6EZbLBgP0VXjXPq
         tsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ruwweomjqKQrW+HQUE8j6UpZRuOujGYDiY69x9HzLFU=;
        b=BUdOqL161dGOCMagh8JAupGx0PNtkCDw7UninKuSaEmvOeZV7Tz832afD96xqTjdMx
         rQXTcw7u3/f02Rv4k/L83xCCejeE84xp78KEOPagW2gPZcifAitsMeUFwvFWF72t8gep
         FtsbPDr/C2lZkkMpoXR3BNw8tIgMj0jEjxX3Daf5eaiNZ6cVvVej4aUfeEk8SgsI7qp/
         NgjNMTRt6tFhm0plQfGELzVvZFzlgJxoI6+91a7PnEJkGcLRQhoJNsJSFgXkyuHm7oyk
         CfuETHSqQiB6y55gpAAQa6NozhgSuCJ2tMSaQG2OLRAQil+jbrqbkD8Gqk6fqAfLMmOo
         PzXQ==
X-Gm-Message-State: AOAM532ctbQpuUfRGCy7wOFCSEfaUGQle0HMnBYieezGOr65an9Br4H9
        4inUCws8xiMLA0aDIqCSGtP5kA==
X-Google-Smtp-Source: ABdhPJxaG4OcbM4JnYM0PXLNPgYOqrE86UsL35wzp8l2T+5Wuiq4DaEDu2yvD/YfOBwMdOZTkT50Jw==
X-Received: by 2002:a37:85c7:: with SMTP id h190mr6064083qkd.7.1595033379499;
        Fri, 17 Jul 2020 17:49:39 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id r185sm11903005qkb.39.2020.07.17.17.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 17:49:38 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC v2] kunit: tool: Allows to install and load modules in root filesystem
Date:   Fri, 17 Jul 2020 21:49:34 -0300
Message-Id: <20200718004934.440141-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes possible to install and load KUnit tests
as modules in a root filesystem and boot UML with
this filesystem.

The filesystem was created using debootstrap:
   sudo debootstrap buster .uml_rootfs

And change the owner of the root filesystem files
for your user:
   sudo chown -R $USER:$USER .uml_rootfs

For the kunit-tool to correctly capture the test results,
uml_utilities must be installed on the host to halt uml.

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v2:
    * splitted patch in 3:
        - Allows to install and load modules in root filesystem;
        - Provides an userspace memory context when tests are compiled
          as module;
        - Convert test_user_copy to KUnit test;
    * added documentation;
    * removed the use of global variable;
    * capitalized make_cmd to look like a constant;
    * adjusted unit tests to the new parameter (--uml_rootfs_dir);
---
 Documentation/dev-tools/kunit/start.rst |  15 ++++
 tools/testing/kunit/kunit.py            |  40 +++++++--
 tools/testing/kunit/kunit_kernel.py     | 106 ++++++++++++++++++++----
 tools/testing/kunit/kunit_tool_test.py  |  16 ++--
 4 files changed, 146 insertions(+), 31 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index bb112cf70624..af2b6b9f870f 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -9,6 +9,21 @@ Installing dependencies
 KUnit has the same dependencies as the Linux kernel. As long as you can build
 the kernel, you can run KUnit.
 
+Unless you need to run the tests with a root filesystem, in this case you will
+need to install debootsrap and uml_tools (uml-tools in Debian flavor distro).
+
+To install the root filesystem:
+
+.. code-block:: bash
+
+	sudo debootstrap buster .uml_rootfs
+
+And change the owner of the root filesystem for your user:
+
+.. code-block:: bash
+
+	sudo chown -R $USER:$USER .uml_rootfs
+
 Running tests with the KUnit Wrapper
 ====================================
 Included with KUnit is a simple Python wrapper which runs tests under User Mode
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 2ece17e9eab5..8abe3a61f798 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -23,16 +23,16 @@ import kunit_parser
 KunitResult = namedtuple('KunitResult', ['status','result','elapsed_time'])
 
 KunitConfigRequest = namedtuple('KunitConfigRequest',
-				['build_dir', 'make_options'])
+				['build_dir', 'uml_rootfs_path', 'make_options'])
 KunitBuildRequest = namedtuple('KunitBuildRequest',
-			       ['jobs', 'build_dir', 'alltests',
+			       ['jobs', 'build_dir', 'uml_rootfs_path', 'alltests',
 				'make_options'])
 KunitExecRequest = namedtuple('KunitExecRequest',
-			      ['timeout', 'build_dir', 'alltests'])
+			      ['timeout', 'build_dir', 'uml_rootfs_path', 'alltests'])
 KunitParseRequest = namedtuple('KunitParseRequest',
 			       ['raw_output', 'input_data'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
-					   'build_dir', 'alltests',
+					   'build_dir', 'uml_rootfs_path', 'alltests',
 					   'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
@@ -47,7 +47,6 @@ def create_default_kunitconfig():
 	if not os.path.exists(kunit_kernel.kunitconfig_path):
 		shutil.copyfile('arch/um/configs/kunit_defconfig',
 				kunit_kernel.kunitconfig_path)
-
 def get_kernel_root_path():
 	parts = sys.argv[0] if not __file__ else __file__
 	parts = os.path.realpath(parts).split('tools/testing/kunit')
@@ -61,7 +60,8 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
 
 	config_start = time.time()
 	create_default_kunitconfig()
-	success = linux.build_reconfig(request.build_dir, request.make_options)
+
+	success = linux.build_reconfig(request.build_dir, request.uml_rootfs_path, request.make_options)
 	config_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.CONFIG_FAILURE,
@@ -79,10 +79,9 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 	success = linux.build_um_kernel(request.alltests,
 					request.jobs,
 					request.build_dir,
+					request.uml_rootfs_path,
 					request.make_options)
 	build_end = time.time()
-	if not success:
-		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE,
 				   'could not build kernel',
@@ -97,7 +96,8 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree,
 	test_start = time.time()
 	result = linux.run_kernel(
 		timeout=None if request.alltests else request.timeout,
-		build_dir=request.build_dir)
+		build_dir=request.build_dir,
+		uml_rootfs_path=request.uml_rootfs_path)
 
 	test_end = time.time()
 
@@ -130,12 +130,14 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	run_start = time.time()
 
 	config_request = KunitConfigRequest(request.build_dir,
+					    request.uml_rootfs_path,
 					    request.make_options)
 	config_result = config_tests(linux, config_request)
 	if config_result.status != KunitStatus.SUCCESS:
 		return config_result
 
 	build_request = KunitBuildRequest(request.jobs, request.build_dir,
+					  request.uml_rootfs_path,
 					  request.alltests,
 					  request.make_options)
 	build_result = build_tests(linux, build_request)
@@ -143,6 +145,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 		return build_result
 
 	exec_request = KunitExecRequest(request.timeout, request.build_dir,
+					request.uml_rootfs_path,
 					request.alltests)
 	exec_result = exec_tests(linux, exec_request)
 	if exec_result.status != KunitStatus.SUCCESS:
@@ -168,6 +171,10 @@ def add_common_opts(parser):
 			    help='As in the make command, it specifies the build '
 			    'directory.',
                             type=str, default='.kunit', metavar='build_dir')
+	parser.add_argument('--uml_rootfs_dir',
+			    help='To load modules, a root filesystem is '
+			    'required to install and load these modules.',
+                            type=str, default=None, metavar='uml_rootfs_dir')
 	parser.add_argument('--make_options',
 			    help='X=Y make option, can be repeated.',
 			    action='append')
@@ -196,6 +203,7 @@ def add_parse_opts(parser):
 
 
 def main(argv, linux=None):
+	uml_rootfs_path = None
 	parser = argparse.ArgumentParser(
 			description='Helps writing and running KUnit tests.')
 	subparser = parser.add_subparsers(dest='subcommand')
@@ -235,6 +243,16 @@ def main(argv, linux=None):
 
 	cli_args = parser.parse_args(argv)
 
+	if cli_args.uml_rootfs_dir \
+			and os.path.exists(cli_args.uml_rootfs_dir) \
+			and os.path.abspath(cli_args.uml_rootfs_dir) != \
+				os.path.abspath(os.getcwd()) \
+			and os.path.abspath(cli_args.uml_rootfs_dir) != '/':
+		uml_rootfs_path = os.path.abspath(cli_args.uml_rootfs_dir)
+	elif cli_args.uml_rootfs_dir != None:
+		print("Invalid uml_rootfs_dir: {}".format(cli_args.uml_rootfs_dir))
+		sys.exit(1)
+
 	if cli_args.subcommand == 'run':
 		if not os.path.exists(cli_args.build_dir):
 			os.mkdir(cli_args.build_dir)
@@ -246,6 +264,7 @@ def main(argv, linux=None):
 				       cli_args.timeout,
 				       cli_args.jobs,
 				       cli_args.build_dir,
+				       uml_rootfs_path,
 				       cli_args.alltests,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
@@ -260,6 +279,7 @@ def main(argv, linux=None):
 			linux = kunit_kernel.LinuxSourceTree()
 
 		request = KunitConfigRequest(cli_args.build_dir,
+					     uml_rootfs_path,
 					     cli_args.make_options)
 		result = config_tests(linux, request)
 		kunit_parser.print_with_timestamp((
@@ -277,6 +297,7 @@ def main(argv, linux=None):
 
 		request = KunitBuildRequest(cli_args.jobs,
 					    cli_args.build_dir,
+					    uml_rootfs_path,
 					    cli_args.alltests,
 					    cli_args.make_options)
 		result = build_tests(linux, request)
@@ -295,6 +316,7 @@ def main(argv, linux=None):
 
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
+						uml_rootfs_path,
 						cli_args.alltests)
 		exec_result = exec_tests(linux, exec_request)
 		parse_request = KunitParseRequest(cli_args.raw_output,
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 63dbda2d029f..aeffd024816c 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -11,6 +11,7 @@ import logging
 import subprocess
 import os
 import signal
+import time
 
 from contextlib import ExitStack
 
@@ -19,8 +20,58 @@ import kunit_parser
 
 KCONFIG_PATH = '.config'
 kunitconfig_path = '.kunitconfig'
+X86_64_DEFCONFIG_PATH = 'arch/um/configs/x86_64_defconfig'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 
+MAKE_CMD = {
+	'make': {
+		'command': ['make', 'ARCH=um'],
+		'msg_error': 'Could not call execute make: ',
+	},
+	'make_modules': {
+		'command': ['make', 'modules', 'ARCH=um'],
+		'msg_error': 'Could not call execute make modules: ',
+	},
+	'make_modules_install': {
+		'command': ['make', 'modules_install', 'ARCH=um'],
+		'msg_error': 'Could not call execute make modules_install: ',
+	}
+}
+
+def halt_uml():
+	try:
+		subprocess.call(['uml_mconsole', 'kunitid', 'halt'])
+	except OSError as e:
+		raise ConfigError('Could not call uml_mconsole ' + e)
+	except subprocess.CalledProcessError as e:
+			raise ConfigError(e.output)
+
+def enable_uml_modules_on_boot(output_command, uml_rootfs_path):
+	uml_modules_path = None
+	found_kernel_version = False
+	modules = []
+	for i in output_command.decode('utf-8').split():
+		if found_kernel_version:
+			kernel_version = i
+			uml_modules_path = os.path.join(uml_rootfs_path,
+			      'lib/modules/', kernel_version, 'kernel/lib/')
+			break
+		if 'DEPMOD' in i:
+			found_kernel_version = True
+
+	try:
+		if os.path.exists(uml_modules_path):
+			modules = subprocess.check_output(['ls',
+					    uml_modules_path]).decode('utf-8').split()
+	except OSError as e:
+		raise ConfigError('Could not list directory ' + e)
+	except subprocess.CalledProcessError as e:
+			raise ConfigError(e.output)
+
+	with open(os.path.join(uml_rootfs_path, 'etc/modules'), 'w') as f:
+		for i in modules:
+			f.write(i.replace('.ko', ''))
+
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
 
@@ -70,20 +121,28 @@ class LinuxSourceTreeOperations(object):
 		kunit_parser.print_with_timestamp(
 			'Starting Kernel with all configs takes a few minutes...')
 
-	def make(self, jobs, build_dir, make_options):
-		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
+	def make(self, cmd, jobs, build_dir, uml_rootfs_path, make_options):
+		command = MAKE_CMD[cmd]['command'] + ['--jobs=' + str(jobs)]
+
 		if make_options:
 			command.extend(make_options)
 		if build_dir:
 			command += ['O=' + build_dir]
+
+		if cmd == 'make_modules_install':
+			command += ['INSTALL_MOD_PATH=' + uml_rootfs_path]
+
 		try:
-			subprocess.check_output(command)
+			output = subprocess.check_output(command)
+			if cmd == 'make_modules_install':
+				 enable_uml_modules_on_boot(output,
+							    uml_rootfs_path)
 		except OSError as e:
-			raise BuildError('Could not call execute make: ' + e)
+			raise BuildError(MAKE_CMD[cmd]['msg_error'] + e)
 		except subprocess.CalledProcessError as e:
 			raise BuildError(e.output)
 
-	def linux_bin(self, params, timeout, build_dir, outfile):
+	def linux_bin(self, params, timeout, build_dir, uml_rootfs_path, outfile):
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = './linux'
 		if build_dir:
@@ -92,7 +151,11 @@ class LinuxSourceTreeOperations(object):
 			process = subprocess.Popen([linux_bin] + params,
 						   stdout=output,
 						   stderr=subprocess.STDOUT)
-			process.wait(timeout)
+			if uml_rootfs_path:
+				time.sleep(timeout)
+				halt_uml()
+			else:
+				process.wait(timeout)
 
 
 def get_kconfig_path(build_dir):
@@ -132,11 +195,16 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def build_config(self, build_dir, make_options):
+	def build_config(self, build_dir, uml_rootfs_path, make_options):
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
 		self._kconfig.write_to_file(kconfig_path)
+
+		if uml_rootfs_path:
+			with open(kconfig_path, 'a') as fw:
+				with open(X86_64_DEFCONFIG_PATH, 'r') as fr:
+					fw.write(fr.read())
 		try:
 			self._ops.make_olddefconfig(build_dir, make_options)
 		except ConfigError as e:
@@ -144,7 +212,7 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def build_reconfig(self, build_dir, make_options):
+	def build_reconfig(self, build_dir, uml_rootfs_path, make_options):
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if os.path.exists(kconfig_path):
@@ -153,28 +221,38 @@ class LinuxSourceTree(object):
 			if not self._kconfig.is_subset_of(existing_kconfig):
 				print('Regenerating .config ...')
 				os.remove(kconfig_path)
-				return self.build_config(build_dir, make_options)
+				return self.build_config(build_dir, uml_rootfs_path,
+							 make_options)
 			else:
 				return True
 		else:
 			print('Generating .config ...')
-			return self.build_config(build_dir, make_options)
+			return self.build_config(build_dir, uml_rootfs_path, make_options)
 
-	def build_um_kernel(self, alltests, jobs, build_dir, make_options):
+	def build_um_kernel(self, alltests, jobs, build_dir,
+			    uml_rootfs_path, make_options):
 		if alltests:
 			self._ops.make_allyesconfig()
 		try:
 			self._ops.make_olddefconfig(build_dir, make_options)
-			self._ops.make(jobs, build_dir, make_options)
+			self._ops.make('make', jobs, build_dir, uml_rootfs_path, make_options)
+			if uml_rootfs_path:
+				self._ops.make('make_modules', jobs, build_dir,
+						uml_rootfs_path, make_options)
+				self._ops.make('make_modules_install', jobs,
+						build_dir, uml_rootfs_path, make_options)
 		except (ConfigError, BuildError) as e:
 			logging.error(e)
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args=[], build_dir='', timeout=None):
+	def run_kernel(self, args=[], build_dir='', uml_rootfs_path=None, timeout=None):
 		args.extend(['mem=1G'])
+		if uml_rootfs_path:
+			args.extend(['root=/dev/root', 'rootfstype=hostfs',
+				     'rootflags=' + uml_rootfs_path, 'umid=kunitid'])
 		outfile = 'test.log'
-		self._ops.linux_bin(args, timeout, build_dir, outfile)
+		self._ops.linux_bin(args, timeout, build_dir, uml_rootfs_path, outfile)
 		subprocess.call(['stty', 'sane'])
 		with open(outfile, 'r') as file:
 			for line in file:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index ebedfc57a39b..2359c77c8efb 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -247,14 +247,14 @@ class KUnitMainTest(unittest.TestCase):
 	def test_build_passes_args_pass(self):
 		kunit.main(['build'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 0
-		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '.kunit', None)
+		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '.kunit', None, None)
 		assert self.linux_source_mock.run_kernel.call_count == 0
 
 	def test_exec_passes_args_pass(self):
 		kunit.main(['exec'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 0
 		assert self.linux_source_mock.run_kernel.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', uml_rootfs_path=None, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_pass(self):
@@ -262,7 +262,7 @@ class KUnitMainTest(unittest.TestCase):
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', timeout=300)
+			build_dir='.kunit', uml_rootfs_path=None, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_exec_passes_args_fail(self):
@@ -302,7 +302,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_exec_timeout(self):
 		timeout = 3453
 		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', uml_rootfs_path=None, timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_timeout(self):
@@ -310,7 +310,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', timeout=timeout)
+			build_dir='.kunit', uml_rootfs_path=None, timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_builddir(self):
@@ -318,7 +318,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--build_dir=.kunit'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir=build_dir, timeout=300)
+			build_dir=build_dir, uml_rootfs_path=None, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_config_builddir(self):
@@ -329,12 +329,12 @@ class KUnitMainTest(unittest.TestCase):
 	def test_build_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
-		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, build_dir, None)
+		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, build_dir, None, None)
 
 	def test_exec_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['exec', '--build_dir', build_dir], self.linux_source_mock)
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, uml_rootfs_path=None, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 if __name__ == '__main__':

base-commit: 725aca9585956676687c4cb803e88f770b0df2b2
prerequisite-patch-id: 5e5f9a8a05c5680fda1b04c9ab1b95ce91dc88b2
prerequisite-patch-id: 4d997940f4a9f303424af9bac412de1af861f9d9
prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0
-- 
2.26.2

