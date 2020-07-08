Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 21:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9454A206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 21:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlfj14tJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgGHVhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGHVhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 17:37:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83578C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 14:37:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 132so313104ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PXdA0rNG8aGRV2ZzjVBiGuKlp3LZqY6KQhSWMv0h4t4=;
        b=jlfj14tJJso5xJQh2ZFFUs+makolFUrtgyAdJTx9tMshD9dQ4nIfqgVBWvXrCFtUjW
         tPjDOLfUBINVIxsCnn8HVfGIfL8tNijy3YNFr/s/B5grX6afT81g0nBf1biHctoipWCg
         Mnk6HeZMMiUtYz0ZWIJZxSyOxK78K5wCTlYcvd7ItygslKBi9ig+BZvRjgJk2AUCDzVf
         lVzsc9WErPnKTAEPfoVRpGsbI+2B/psJffTfyQAl9Z9Q8+H1qIi84CcGyndNSp+/7ICp
         JfxQ4iZExzvGzvmwyHTcbqYqRU+UwwyM/6Uf+EKK/gZKa6VJb1hYZJW7mwXePCx9V6Im
         KQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PXdA0rNG8aGRV2ZzjVBiGuKlp3LZqY6KQhSWMv0h4t4=;
        b=XUNnkcyLCQlMZKEGTV1kABWitVgfdnPWQgAWqp5jtdzbR47Xz6zZCbt5Bqi9dgjFyA
         ecTlZwtMjACoduLEeuvjjJyZGZL9wBerW/tddcN3h2F7qUOIjg69rr0Du/7za3I4fNDa
         thHB0iv/9h/V21YUpxESvVmAtFHs9LWs+0KOQZpF6V8QDSgya50GuQDGZVkqJgOpBi85
         4BiRY0P8gVKexITmXEBqYj/ps5lwoFdZEaA2xhO8KmcYZVl59hIbybX1P7y2lz1X1fal
         sHra8VvRekoVV0wqUPAo1oxaxS8fYRvDmUJxTY/KAr5JoMz9/ddYsCLBJmfPkv1EyFAn
         jl5w==
X-Gm-Message-State: AOAM533Ze1pM47nbYV+kOySsrruiaT0FnLykBdJAtBl+Zj5KDbs6S+df
        6W0u5S4UL5J3REVNJKxE0+fJU9eWUF8=
X-Google-Smtp-Source: ABdhPJzIAK/YhDl8oNzm9DEGNOQQXAqOey/d2Kazv/0TNh0ZqLlJor388FJ1PxZwqByTgY20/BZETshRzyE=
X-Received: by 2002:a25:ad03:: with SMTP id y3mr13948847ybi.411.1594244250479;
 Wed, 08 Jul 2020 14:37:30 -0700 (PDT)
Date:   Wed,  8 Jul 2020 14:35:43 -0700
Message-Id: <20200708213543.1365306-1-chenwi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH] kunit: capture stderr on all make subprocess calls
From:   Will Chen <chenwi@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     Will Chen <chenwi@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct stderr to subprocess.STDOUT so error messages get included in the
subprocess.CalledProcessError exceptions output field. This results in
more meaningful error messages for the user.

This is already being done in the make_allyesconfig method. Do the same
for make_mrproper, make_olddefconfig, and make methods.

With this, failures on unclean trees [1] will give users an error
message that includes:
"The source tree is not clean, please run 'make ARCH=um mrproper'"

[1] https://bugzilla.kernel.org/show_bug.cgi?id=205219

Signed-off-by: Will Chen <chenwi@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 63dbda2d029f..e20e2056cb38 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -34,7 +34,7 @@ class LinuxSourceTreeOperations(object):
 
 	def make_mrproper(self):
 		try:
-			subprocess.check_output(['make', 'mrproper'])
+			subprocess.check_output(['make', 'mrproper'], stderr=subprocess.STDOUT)
 		except OSError as e:
 			raise ConfigError('Could not call make command: ' + e)
 		except subprocess.CalledProcessError as e:
@@ -47,7 +47,7 @@ class LinuxSourceTreeOperations(object):
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command, stderr=subprocess.PIPE)
+			subprocess.check_output(command, stderr=subprocess.STDOUT)
 		except OSError as e:
 			raise ConfigError('Could not call make command: ' + e)
 		except subprocess.CalledProcessError as e:
@@ -77,7 +77,7 @@ class LinuxSourceTreeOperations(object):
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command)
+			subprocess.check_output(command, stderr=subprocess.STDOUT)
 		except OSError as e:
 			raise BuildError('Could not call execute make: ' + e)
 		except subprocess.CalledProcessError as e:
-- 
2.27.0.383.g050319c2ae-goog

