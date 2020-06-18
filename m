Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEF2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB382070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="K0ZOAG6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgFRMjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgFRMjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:39:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9392EC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:39:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b4so5261013qkn.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=72mYtR8brLn0NtD1nMNXJ5LkwsKwBqKm9sI8cal1E90=;
        b=K0ZOAG6GPspKsFM7RuoT1Zxla/nSwmJil3wicypom/nE8jjCpK25dmHoz1r1NnXadc
         ww5oAw4uDtuC0r5OyCQKa7v6tue9ZyNUOKyFMkfrCDrEWcgvBPPmvopYsQYDI5AgV8Gv
         AtgDwfC2zGMOR1pOrxPMfHWMFT7z+VjmYyImE54pHzbcrk5YncmWcOFjkVSbGFPeE+wW
         J5QfJWa55NA5KWZb3jklwT0BXjvcVEfIHaG1N2RZgfLA0MGe6Faz6CVqNbqomhSnM10D
         9iYNa53DJtVno8jZynfCQw0FxObMJ0l0mxqquCkzFHCssr3s2M+VbMkq/fVboKjCGbRO
         gHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=72mYtR8brLn0NtD1nMNXJ5LkwsKwBqKm9sI8cal1E90=;
        b=V1GYMYlb74PA2MKPVneluwNi4mp0oHvtfAeV/jpvrC3SG+MB6WsvyMCxUxpfLxcxDn
         lgZj2DWBAk3YjmSh/PghxK0FXZEVVN8t4klM2Xg6gCSIc2q6Aqj90WkyZxBWqhwZ9wgo
         mtCJ4EjsCtnZKaCjPht8x7pvAinZ2oTOcmbzYFWl+tTqQPwfCWeAFAwcqHjW946dVpDB
         R5Szc3OrfJlVFHk574O5OEEyqK7xQl5E3sSEfI/CWiZv/bW6qVvyVo1CrgHiAa+9+0+A
         DhqW2O7lB3m65uktFzmKNwdBKnPX+mDC1mM47juOffKJtoIeXYAiWLoutvwuoqVXwl/P
         wGQg==
X-Gm-Message-State: AOAM5308oeur4sufPQU0sYUenXPyepWevCDKrgdh5fKYa5dMTo/qU51N
        izO6IzbT7iKm9Z4JSg7SkF0Wqw==
X-Google-Smtp-Source: ABdhPJysbQyaTGuA2V7J4PdGuIk1FXVCoiQx2IebAeWXZ00/o4KUBNVIzISUhVKWFuY7ZPiZkyl5pg==
X-Received: by 2002:a05:620a:1310:: with SMTP id o16mr3413267qkj.68.1592483956719;
        Thu, 18 Jun 2020 05:39:16 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id 124sm2870143qkm.115.2020.06.18.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 05:39:16 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] kunit: fix KconfigParseError handling CC_VERSION_TEXT
Date:   Thu, 18 Jun 2020 09:39:12 -0300
Message-Id: <20200618123912.64762-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8b59cd81dc5 ("kbuild: ensure full rebuild when the compiler
is updated") added the environment variable CC_VERSION_TEXT,
parse_from_string() doesn't expect a string in value field and this
causes the failure below:
	
[iha@bbking linux]$ tools/testing/kunit/kunit.py run --timeout=60
[00:20:12] Configuring KUnit Kernel ...
Generating .config ...
Traceback (most recent call last):
  File "tools/testing/kunit/kunit.py", line 347, in <module>
    main(sys.argv[1:])
  File "tools/testing/kunit/kunit.py", line 257, in main
    result = run_tests(linux, request)
  File "tools/testing/kunit/kunit.py", line 134, in run_tests
    config_result = config_tests(linux, config_request)
  File "tools/testing/kunit/kunit.py", line 64, in config_tests
    success = linux.build_reconfig(request.build_dir, request.make_options)
  File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 161, in build_reconfig
    return self.build_config(build_dir, make_options)
  File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 145, in build_config
    return self.validate_config(build_dir)
  File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 124, in validate_config
    validated_kconfig.read_from_file(kconfig_path)
  File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_config.py", line 89, in read_from_file
    self.parse_from_string(f.read())
  File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_config.py", line 85, in parse_from_string
    raise KconfigParseError('Failed to parse: ' + line)
kunit_config.KconfigParseError: Failed to parse: CONFIG_CC_VERSION_TEXT="gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-1)"

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
v2: 
 - maintains CC_VERSION_TEXT in the .config file to ensure full rebuild
   when the compiler is updated.
---
 tools/testing/kunit/kunit_config.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index e75063d603b5..c407c7c6a2b0 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -81,6 +81,12 @@ class Kconfig(object):
 
 			if line[0] == '#':
 				continue
+
+			if 'CONFIG_CC_VERSION_TEXT' in line:
+				name, value = line.split('=')
+				entry = KconfigEntry(name, value)
+				self.add_entry(entry)
+				continue
 			else:
 				raise KconfigParseError('Failed to parse: ' + line)
 

base-commit: 7bf200b3a4ac10b1b0376c70b8c66ed39eae7cdd
-- 
2.26.2

