Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E6AC3404B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB48B2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EuWV2B1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgBRWTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:19:22 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:54634 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRWTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:19:21 -0500
Received: by mail-ua1-f74.google.com with SMTP id y23so4355034uaq.21
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RNrdlMRH8bZOMGcbPYtMG19iVm6s1eWmiGtdcw35HDw=;
        b=EuWV2B1rhJOhQuPyn12KOWAfxA1LcgYVwXwkago/ZhpA2ebUOxjTnaa8wI2s9lejYw
         MMbwihbtFtdIoIVF5AdWNMztFfQwIxOnrTfFkoND9bW12lf58MkKK2mFgrxZdllWNojn
         HCXxZtNx3Fc9x3son29FBWsnCgMDZfxjyQJBepiWACUfUi7I6GunxGgSHuI1Jf5240S1
         UnmpSUUmybTaPzTVvgqX5RkW2qh9mxbbl1iu0FktpIHGwg8TF54dHL70w+D28Rv3ppDb
         pOMojCLf1E6O7q1Bj5rTgQn2vNYffPLfsdlOcmSl+pMxXQ1Zp7BBaOWnkRxNZJcLLxZF
         BwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RNrdlMRH8bZOMGcbPYtMG19iVm6s1eWmiGtdcw35HDw=;
        b=hLQoJyyPGO6I2tFTQYi1Lb3YpuXjnTSTWmlgaP9dlvTyoAjEYZiHIhWEAcLVXdqxnw
         taRiI0Shcm1iI4VI8LsSeZdQlJ1bkA4Pb9mPoZEQy9rARkVbjyu+5sS7Bk9k46bUBezH
         JGVo2BJo12mF9HOOSukGAroR05Lv7G1hGpCYSR2NuiEymcAEc/rR/7IZy8HvUEt9lfmy
         n3zSYzbGZ97TMcOhiodi5lh4XfQo8V7eoGDL0iMNnccx553moIPQp4dV/wFZYxAeZ6Nc
         hbyB+uuAdVLRWnzQZP2IY4suz6kMERqWZKuPNNrb81sTCV9TWPXXwf3mu6uY/VoGRbtf
         P1ZA==
X-Gm-Message-State: APjAAAXpUxD1NlPP1Uz1C/Pfzn3sjvdDUhtj7FHuE/WYgg8PondNGP3t
        1tmLe0UzMt185NMW/pDPj9LIHgUwbdXfDCK/
X-Google-Smtp-Source: APXvYqy+Cwd9EFVOtm74DHBTK9PpxkUS6BhXFgBDHPJokh72vAdqbghHz4tO/zpJprSxvLyo9W/sOuJS8cl9WGp0
X-Received: by 2002:ab0:6258:: with SMTP id p24mr11875147uao.24.1582064360629;
 Tue, 18 Feb 2020 14:19:20 -0800 (PST)
Date:   Tue, 18 Feb 2020 14:19:16 -0800
Message-Id: <20200218221916.239951-1-heidifahim@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] kunit: run kunit_tool from any directory
From:   Heidi Fahim <heidifahim@google.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     frowand.list@gmail.com, Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implemented small fix so that the script changes work directories to the
root of the linux kernel source tree from which kunit.py is run. This
enables the user to run kunit from any working directory. Originally
considered using os.path.join but this is more error prone as we would
have to find all file path usages and modify them accordingly. Using
os.chdir ensures that the entire script is run within /linux.

Signed-off-by: Heidi Fahim <heidifahim@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 3f552e847a14..060d960a7029 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -26,6 +26,8 @@ KunitResult = namedtuple('KunitResult', ['status','result'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
 					'build_dir', 'defconfig', 'json'])
 
+KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
+
 class KunitStatus(Enum):
 	SUCCESS = auto()
 	CONFIG_FAILURE = auto()
@@ -37,6 +39,13 @@ def create_default_kunitconfig():
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
@@ -130,6 +139,9 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if get_kernel_root_path():
+			os.chdir(get_kernel_root_path())
+
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
-- 
2.25.0.265.gbab2e86ba0-goog

