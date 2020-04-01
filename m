Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA3AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 01:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0279F20CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 01:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="j237GYzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbgDABgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:36:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34219 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbgDABgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 21:36:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id 10so20371995qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 18:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbgGcVF0EJCkLy2QmL9Rcj9NjTuET0dt713t3OmqqbY=;
        b=j237GYzKoXjs1kMFmRh42jSasBRN0D7GB+dLS33p3s+FcbM6DlqulG5sneDSwJ761j
         V6fW4MvqxnPCFHSrD0hFA405b6NxssHove7YA0wgQVqlPCwdX7fcyo/Esvn9jcAQryok
         Ywu2ZvldoS3Jc4Xlo9EoDX8zrF6E8uN5RWChZ8yjeyc5XmhAUpdJa8Suzjgw4gJr7G3F
         C9dpxGJrABuWQN+S9kP+tbtrUKowkIcxuUEVcV2X97JC1WuNB2HGfF6HDMhctd2BpAue
         hx1+nimq1fJ441QW8i9Bwj3byVdnEu/nyypKLLeJoeaibIsK9o3zZM4GFXNfVgtOfZ1z
         eioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbgGcVF0EJCkLy2QmL9Rcj9NjTuET0dt713t3OmqqbY=;
        b=LmANPG1nl28yGffYukvxThLrqzuHeF1R8CqWOY5Fhogp4vsfWFuKlUoH2cVjgkziin
         7xYTxtVWr4nmjL4+8pJJB+YhxyJbuDGnOU/uLJgPyW5zUOYzttA/IsX9lnMtqTbznlS9
         Tec40iREONz8gJZPCovz+/3vQfgXZNgjk93lx9WTx18CLsCdBPtPVsHkSTWi66nol7vN
         xc76EiV1AP1z8/wcZtY835WopLpkh4Y0KdqbCSU4UObRKXJGwupafxhVRAgx0sVcDP49
         8BVRYfzxry8he6SmlG2apgX8HbY15Bet379SErVU2DHm0UxMRu8Ozn3wdjgqfX/VViTt
         yeBw==
X-Gm-Message-State: ANhLgQ2jw8KNjE+pz7Ffhn1Z8F1WZ+8Tlur6erRdQNNueNdiNqwgXe5P
        w4MzJzYGcWyZ9ak/S6ooy+mFgQ==
X-Google-Smtp-Source: ADFU+vuCtJl0alErKaDbHnravdHUnZEMxreqX2xAcP5PQ+W9SAURzTl80251dKNQNke6ULhDfGC3JQ==
X-Received: by 2002:ac8:1608:: with SMTP id p8mr8109582qtj.123.1585705003728;
        Tue, 31 Mar 2020 18:36:43 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id w28sm513147qtc.27.2020.03.31.18.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 18:36:43 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] kunit: Fix kunit.py run --build_dir='<foo>' fails on "unclean" trees
Date:   Tue, 31 Mar 2020 22:36:39 -0300
Message-Id: <20200401013639.16388-1-vitor@massaru.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219

For some reason, the environment variable ARCH is used instead of ARCH
passed as an argument, this patch uses a copy of the env, but using
ARCH=um and CROSS_COMPILER='' to avoid this problem.

This patch doesn't change the user's environment variables, avoiding
side effects.

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
v2:
 - Use the correct next branch
---
 tools/testing/kunit/kunit_kernel.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index cc5d844ecca1..5c30751387c7 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -15,6 +15,7 @@ import kunit_config
 
 KCONFIG_PATH = '.config'
 kunitconfig_path = '.kunitconfig'
+env = dict(os.environ.copy(), ARCH='um', CROSS_COMPILE='')
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -36,22 +37,22 @@ class LinuxSourceTreeOperations(object):
 			raise ConfigError(e.output)
 
 	def make_olddefconfig(self, build_dir):
-		command = ['make', 'ARCH=um', 'olddefconfig']
+		command = ['make', 'olddefconfig']
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command)
+			subprocess.check_output(command, env=env)
 		except OSError as e:
 			raise ConfigError('Could not call make command: ' + e)
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output)
 
 	def make(self, jobs, build_dir):
-		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
+		command = ['make', '--jobs=' + str(jobs)]
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command)
+			subprocess.check_output(command, env=env)
 		except OSError as e:
 			raise BuildError('Could not call execute make: ' + e)
 		except subprocess.CalledProcessError as e:
@@ -66,7 +67,8 @@ class LinuxSourceTreeOperations(object):
 			[linux_bin] + params,
 			stdin=subprocess.PIPE,
 			stdout=subprocess.PIPE,
-			stderr=subprocess.PIPE)
+			stderr=subprocess.PIPE,
+			env=env)
 		process.wait(timeout=timeout)
 		return process
 
-- 
2.21.1

