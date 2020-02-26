Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133B0C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEEC20732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582677214;
	bh=uRtrbTwRkJy9ud2b0H4iJ5yrVx3QvOZ7Q1qIdwuoUDU=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=A9Bkp9cJ6fzIG8hWG461zsrdZ4YwRsAENfvaWbiuVlO7W39m42R9teCpG6EGTaRbM
	 9k9lEJ+QfYfsCVonjo5Y+j1rfG3ORAFe1uMkjePTZN8eicdt482i+hT4h9lDCjeseS
	 9qGA7SIaw0ywvDmOIn6l8fdxZ9rw3zDKK9kILFLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgBZAdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:33:33 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:42563 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbgBZAdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 19:33:33 -0500
Received: by mail-il1-f170.google.com with SMTP id x2so825692ila.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 16:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=cF+cf0TvkH5gluf6NeH9N2EMiwXac4QQvmLsm1w4peg=;
        b=LzQ3sDXI5B9SS8btnv7UsZwmgPQT1E2mlEvqy1i+cvj41J+Ovgq6F1UVuAEgImU+Gr
         4lHglaykDuUOxBe9ORomJhj71jtlpwtHfZ0Cnl+nwD6zDhc6H3NFuy1K4I7anPv5G/sG
         gQSFoj9KapxLN7rA0UJodWSB3amwaA+Afd8RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=cF+cf0TvkH5gluf6NeH9N2EMiwXac4QQvmLsm1w4peg=;
        b=JuyK9wmdNisq31NXXrNgOYz+AgIfTuDutTiC6HAxO5PWnmXr/0MKNMb4B4Q7aMBaVH
         d+LVqK8bvu9wEC1+iWa1bor2g0prSyhNBkztLNGOpIuK9ZM5TqrR167t8rzCHRt7w04X
         fjAfysZPBVb4WLzX/Ws3HpaMlrt2/NubI/FKkLOC8AqaKWnAmfD6lsYNvMkLneXe3t6Y
         o5VuP1Dfe+NVjgJ0YdeALblzOyhsAstCZm1o6Ip5sKuEwRb83vdn9a2U616opheiqeNG
         J/oR04NEWEhIdB+wO+70Kfhmo3YUO10RUvirsr/hsNFsjFpy3dRUKQEIRQRmP+oagD0W
         MZUg==
X-Gm-Message-State: APjAAAUhMBbJgg9YRxHouCJIiJvFGaQsH8+oPMA+rYL7cVU0IbnWIy0X
        uRuZ8QtG35UuXbrkQ1OX1g3byGdZClA=
X-Google-Smtp-Source: APXvYqyAvDBmc4k6IovdR72VFQDAWbh7Erl6Plnv0T9BmtvK9APLkVvmjUyCnZA9zQ94gKHtPU+UWg==
X-Received: by 2002:a92:8458:: with SMTP id l85mr1425672ild.296.1582677212122;
        Tue, 25 Feb 2020 16:33:32 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o76sm140657ili.8.2020.02.25.16.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 16:33:31 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest kunit update for Linux 5.6-rc4
Message-ID: <728b8941-6687-d3b3-2156-1d74ee4dc3db@linuxfoundation.org>
Date:   Tue, 25 Feb 2020 17:33:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------EAD8E6D2B4D83A7CBD97E73B"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EAD8E6D2B4D83A7CBD97E73B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest kunit update for Linux 5.6-rc4.

This Kselftest kunit update consists of fixes to documentation and
run-time tool from Brendan Higgins and Heidi Fahim.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-5.6-rc4

for you to fetch changes up to be886ba90cce2fb2f5a4dbcda8f3be3fd1b2f484:

   kunit: run kunit_tool from any directory (2020-02-19 15:58:07 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-5.6-rc4

This Kselftest kunit update consists of fixes to documentation and
run-time tool from Brendan Higgins and Heidi Fahim.

----------------------------------------------------------------
Brendan Higgins (1):
       Documentation: kunit: fixed sphinx error in code block

Heidi Fahim (2):
       kunit: test: Improve error messages for kunit_tool when 
kunitconfig is invalid
       kunit: run kunit_tool from any directory

  Documentation/dev-tools/kunit/usage.rst |  1 +
  tools/testing/kunit/kunit.py            | 12 ++++++++++++
  tools/testing/kunit/kunit_kernel.py     | 28 ++++++++++++++++------------
  3 files changed, 29 insertions(+), 12 deletions(-)

----------------------------------------------------------------

--------------EAD8E6D2B4D83A7CBD97E73B
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.6-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.6-rc4.diff"

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 7cd56a1993b1..607758a66a99 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -551,6 +551,7 @@ options to your ``.config``:
 Once the kernel is built and installed, a simple
 
 .. code-block:: bash
+
 	modprobe example-test
 
 ...will run the tests.
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e59eb9e7f923..180ad1e1b04f 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -24,6 +24,8 @@ KunitResult = namedtuple('KunitResult', ['status','result'])
 
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir', 'defconfig'])
 
+KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
+
 class KunitStatus(Enum):
 	SUCCESS = auto()
 	CONFIG_FAILURE = auto()
@@ -35,6 +37,13 @@ def create_default_kunitconfig():
 		shutil.copyfile('arch/um/configs/kunit_defconfig',
 				kunit_kernel.kunitconfig_path)
 
+def get_kernel_root_path():
+	parts = sys.argv[0] if not __file__ else __file__
+	parts = os.path.realpath(parts).split('tools/testing/kunit')
+	if len(parts) != 2:
+		sys.exit(1)
+	return parts[0]
+
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
 	config_start = time.time()
@@ -114,6 +123,9 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if get_kernel_root_path():
+			os.chdir(get_kernel_root_path())
+
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index cc5d844ecca1..d99ae75ef72f 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -93,6 +93,20 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
+	def validate_config(self, build_dir):
+		kconfig_path = get_kconfig_path(build_dir)
+		validated_kconfig = kunit_config.Kconfig()
+		validated_kconfig.read_from_file(kconfig_path)
+		if not self._kconfig.is_subset_of(validated_kconfig):
+			invalid = self._kconfig.entries() - validated_kconfig.entries()
+			message = 'Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, ' \
+					  'but not in .config: %s' % (
+					', '.join([str(e) for e in invalid])
+			)
+			logging.error(message)
+			return False
+		return True
+
 	def build_config(self, build_dir):
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
@@ -103,12 +117,7 @@ class LinuxSourceTree(object):
 		except ConfigError as e:
 			logging.error(e)
 			return False
-		validated_kconfig = kunit_config.Kconfig()
-		validated_kconfig.read_from_file(kconfig_path)
-		if not self._kconfig.is_subset_of(validated_kconfig):
-			logging.error('Provided Kconfig is not contained in validated .config!')
-			return False
-		return True
+		return self.validate_config(build_dir)
 
 	def build_reconfig(self, build_dir):
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
@@ -133,12 +142,7 @@ class LinuxSourceTree(object):
 		except (ConfigError, BuildError) as e:
 			logging.error(e)
 			return False
-		used_kconfig = kunit_config.Kconfig()
-		used_kconfig.read_from_file(get_kconfig_path(build_dir))
-		if not self._kconfig.is_subset_of(used_kconfig):
-			logging.error('Provided Kconfig is not contained in final config!')
-			return False
-		return True
+		return self.validate_config(build_dir)
 
 	def run_kernel(self, args=[], timeout=None, build_dir=''):
 		args.extend(['mem=256M'])

--------------EAD8E6D2B4D83A7CBD97E73B--
