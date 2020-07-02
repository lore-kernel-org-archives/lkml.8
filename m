Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD77C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45AA208B8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593703443;
	bh=RzpuYZk2rjqOOWbVaIon9DtDIOb7yEpeKnFn6R9dNAY=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=1jAYA13tZrdDNinqJgnAIC1MgQ6dAUVQHDIWII4qcQ6dbp/GS86WlilWaqYzwNm25
	 M+Eh8uV9uZJtwS1DaklR1kHYPoAGUQcotWozZqF1OgoN2VJAyAt+FyM3kIMWtZYAex
	 K7XPiV5J+e3hMbhfoO5dYfiWBdoByfnpaJH8xZN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgGBPYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgGBPX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:23:58 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693EFC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:23:58 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id e4so15838805oib.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=B4Ar3fpA3HhwCaigMczgSpA2w+YvUJd42HYXvnQydWY=;
        b=ZPv6cx92wk+wl3iQVPR7rcCaSByWPwAMHkBZDRRnVtsZzEOjtZh7EJ9SQDOgW2zvnE
         chfGNQt5cJ+DehMkKw+8jqH19FrshSLmVgDFguKrDQhrfXekgvm3gpeDZAGhv5Z2D2yN
         ti1cqJ8/XrhSH8YbZNaH2jTnvDsoEpJTkdl08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=B4Ar3fpA3HhwCaigMczgSpA2w+YvUJd42HYXvnQydWY=;
        b=VErt6rWT5bJtvIIgKhyI2SdoArCmIUr1fC+XdyeWRmACvzhq18fS+pMj3SZRQ+/75u
         PxzVXc4cib4ddEgHBOrdU5YplJOB6jPlKuSmBwnqB09PRHuWzxff5ae9Ktds03otYDID
         JycryHAm5yU0SGWeg2PVcXkDePV+VhQ1kDl/PGv+QC731gpp1Xg0g/XRiC6kcVVRszkr
         Lpm7gKdyTKZljHUVkDZBRAA7G/eqfLtOgTCNHs0SfThDsZLoeUigf9xBVuV+MRAXb7Ki
         QV/vrBdXCRZTZGtoFoDdiWRfcdzZTd4Y5Iy9IFerXwGjYFfI+HXiL70OYCuvDu63GmZS
         iqJQ==
X-Gm-Message-State: AOAM53143XJXK2tpbYrUKPTapMoMostUwYBN2dhIDi9pk/zS6BdWr8dA
        Ay+E/fpdpNWNyP8ZEct40+FH3w==
X-Google-Smtp-Source: ABdhPJzRLtOaeIiDSxEPiK5IDPEWLft3Ryb8hfoSeSB1WD89Aes2qQa6F5iXonXK0zaQT4eZihuUKw==
X-Received: by 2002:aca:230f:: with SMTP id e15mr23489002oie.164.1593703437711;
        Thu, 02 Jul 2020 08:23:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g8sm2279335otb.39.2020.07.02.08.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 08:23:56 -0700 (PDT)
To:     torvalds@linux-foundation.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, skhan@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kunit fixes update for Linux 5.8-rc4
Message-ID: <39219b27-98db-609c-d77b-3db2eb64345a@linuxfoundation.org>
Date:   Thu, 2 Jul 2020 09:23:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------4311EBEE68346305983AB55B"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4311EBEE68346305983AB55B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kunit fixes update for Linux 5.8-rc4.

This kunit fixes update for Linux 5.8-rc4 consists of fixes to build
and run-times failures. Also includes troubleshooting tips updates
to kunit user documentation.

These tips in the doc patch helped me with my test runs.

diff is included.

thanks,
-- Shuah


----------------------------------------------------------------

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

   Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-fixes-5.8-rc4

for you to fetch changes up to c63d2dd7e134ebddce4745c51f9572b3f0d92b26:

   Documentation: kunit: Add some troubleshooting tips to the FAQ 
(2020-06-26 14:29:55 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-5.8-rc4

This kunit fixes update for Linux 5.8-rc4 consists of fixes to build
and run-times failures. Also includes troubleshooting tips updates
to kunit user documentation.

----------------------------------------------------------------
David Gow (2):
       kunit: kunit_tool: Fix invalid result when build fails
       Documentation: kunit: Add some troubleshooting tips to the FAQ

Rikard Falkeborn (1):
       kunit: kunit_config: Fix parsing of CONFIG options with space

Uriel Guajardo (1):
       kunit: show error if kunit results are not present

  Documentation/dev-tools/kunit/faq.rst              |  40 
+++++++++++++++++++++
  tools/testing/kunit/kunit.py                       |   4 ++-
  tools/testing/kunit/kunit_config.py                |   2 +-
  tools/testing/kunit/kunit_parser.py                |   8 ++---
  tools/testing/kunit/kunit_tool_test.py             |  11 ++++++
  .../kunit/test_data/test_insufficient_memory.log   | Bin
  6 files changed, 59 insertions(+), 6 deletions(-)
  create mode 100644 
tools/testing/kunit/test_data/test_insufficient_memory.log
----------------------------------------------------------------


--------------4311EBEE68346305983AB55B
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.8-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.8-rc4.diff"

diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
index ea55b2467653..1628862e7024 100644
--- a/Documentation/dev-tools/kunit/faq.rst
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -61,3 +61,43 @@ test, or an end-to-end test.
   kernel by installing a production configuration of the kernel on production
   hardware with a production userspace and then trying to exercise some behavior
   that depends on interactions between the hardware, the kernel, and userspace.
+
+KUnit isn't working, what should I do?
+======================================
+
+Unfortunately, there are a number of things which can break, but here are some
+things to try.
+
+1. Try running ``./tools/testing/kunit/kunit.py run`` with the ``--raw_output``
+   parameter. This might show details or error messages hidden by the kunit_tool
+   parser.
+2. Instead of running ``kunit.py run``, try running ``kunit.py config``,
+   ``kunit.py build``, and ``kunit.py exec`` independently. This can help track
+   down where an issue is occurring. (If you think the parser is at fault, you
+   can run it manually against stdin or a file with ``kunit.py parse``.)
+3. Running the UML kernel directly can often reveal issues or error messages
+   kunit_tool ignores. This should be as simple as running ``./vmlinux`` after
+   building the UML kernel (e.g., by using ``kunit.py build``). Note that UML
+   has some unusual requirements (such as the host having a tmpfs filesystem
+   mounted), and has had issues in the past when built statically and the host
+   has KASLR enabled. (On older host kernels, you may need to run ``setarch
+   `uname -m` -R ./vmlinux`` to disable KASLR.)
+4. Make sure the kernel .config has ``CONFIG_KUNIT=y`` and at least one test
+   (e.g. ``CONFIG_KUNIT_EXAMPLE_TEST=y``). kunit_tool will keep its .config
+   around, so you can see what config was used after running ``kunit.py run``.
+   It also preserves any config changes you might make, so you can
+   enable/disable things with ``make ARCH=um menuconfig`` or similar, and then
+   re-run kunit_tool.
+5. Try to run ``make ARCH=um defconfig`` before running ``kunit.py run``. This
+   may help clean up any residual config items which could be causing problems.
+6. Finally, try running KUnit outside UML. KUnit and KUnit tests can run be
+   built into any kernel, or can be built as a module and loaded at runtime.
+   Doing so should allow you to determine if UML is causing the issue you're
+   seeing. When tests are built-in, they will execute when the kernel boots, and
+   modules will automatically execute associated tests when loaded. Test results
+   can be collected from ``/sys/kernel/debug/kunit/<test suite>/results``, and
+   can be parsed with ``kunit.py parse``. For more details, see "KUnit on
+   non-UML architectures" in :doc:`usage`.
+
+If none of the above tricks help, you are always welcome to email any issues to
+kunit-dev@googlegroups.com.
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 787b6d4ad716..f9b769f3437d 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -82,7 +82,9 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 					request.make_options)
 	build_end = time.time()
 	if not success:
-		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
+		return KunitResult(KunitStatus.BUILD_FAILURE,
+				   'could not build kernel',
+				   build_end - build_start)
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE,
 				   'could not build kernel',
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index e75063d603b5..02ffc3a3e5dc 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -10,7 +10,7 @@ import collections
 import re
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
-CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+)$'
+CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
 
 KconfigEntryBase = collections.namedtuple('KconfigEntry', ['name', 'value'])
 
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 64aac9dcd431..f13e0c0d6663 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -265,11 +265,9 @@ def bubble_up_suite_errors(test_suite_list: List[TestSuite]) -> TestStatus:
 	return bubble_up_errors(lambda x: x.status, test_suite_list)
 
 def parse_test_result(lines: List[str]) -> TestResult:
-	if not lines:
-		return TestResult(TestStatus.NO_TESTS, [], lines)
 	consume_non_diagnositic(lines)
-	if not parse_tap_header(lines):
-		return None
+	if not lines or not parse_tap_header(lines):
+		return TestResult(TestStatus.NO_TESTS, [], lines)
 	test_suites = []
 	test_suite = parse_test_suite(lines)
 	while test_suite:
@@ -282,6 +280,8 @@ def parse_run_tests(kernel_output) -> TestResult:
 	failed_tests = 0
 	crashed_tests = 0
 	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
+	if test_result.status == TestStatus.NO_TESTS:
+		print_with_timestamp(red('[ERROR] ') + 'no kunit output detected')
 	for test_suite in test_result.suites:
 		if test_suite.status == TestStatus.SUCCESS:
 			print_suite_divider(green('[PASSED] ') + test_suite.name)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 5bb7b118ebd9..f9eeaea94cad 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -170,6 +170,17 @@ class KUnitParserTest(unittest.TestCase):
 			result.status)
 		file.close()
 
+	def test_no_kunit_output(self):
+		crash_log = get_absolute_path(
+			'test_data/test_insufficient_memory.log')
+		file = open(crash_log)
+		print_mock = mock.patch('builtins.print').start()
+		result = kunit_parser.parse_run_tests(
+			kunit_parser.isolate_kunit_output(file.readlines()))
+		print_mock.assert_any_call(StrContains("no kunit output detected"))
+		print_mock.stop()
+		file.close()
+
 	def test_crashed_test(self):
 		crashed_log = get_absolute_path(
 			'test_data/test_is_test_passed-crash.log')
diff --git a/tools/testing/kunit/test_data/test_insufficient_memory.log b/tools/testing/kunit/test_data/test_insufficient_memory.log
new file mode 100644
index 000000000000..e69de29bb2d1

--------------4311EBEE68346305983AB55B--
