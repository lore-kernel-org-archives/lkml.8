Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF17C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C4D20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="qaE9ka01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgC3XDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:03:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39564 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3XDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:03:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id b62so21115620qkf.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kfP3d4P8jwaZXBD9eOyojCY2clb925eYfLTaD8OeKhA=;
        b=qaE9ka01+XIZt+e6Bvi86miiEoTYjIAZNc6SBrJHsRF8RCkg86ZaVTJROEIRnMjbX+
         epd/phtbktcNMRoCxb7vZX6Uhk31J7yqFb6MwNNJRzsjAuhxOSqF6Fj3w73J+otw36rm
         OhfKblcf3wgx2qK3ZGstg761wknK0bbodDx8aXiYsF8Y7xVUDYoNGoLpSASWg2c3X9mj
         KX42UsxIDrw+v1w7GyYu7f2qjDQzhIvNPOGxC8wcDG8kDGo68q8ffi9Hox+EvyO+YLjG
         T5SYPpcbPf9Vtdh9g+Jm56bfxJbkws3MmYsj5E4XViubrU10Xh4eHltlNPRyRB+/Virv
         C4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kfP3d4P8jwaZXBD9eOyojCY2clb925eYfLTaD8OeKhA=;
        b=aQhEaR9H44CuMtavfPaTAMFIMffYP8aFLVvv/nyc5R1LLMXxk6GSd0MNZBdseXmmTA
         lbPCho7ZQhmzcfI/e5u+JzuZLe4lSPa5ht6MyHSWrsOy3baUdtvEkGxPTXpAj/WlwZIv
         af+J1lAHuVssUvva5IXKeDB5EPKL/Ajxg+Ss3cpOMlokwZh6OqbQL/2sBanC2xUoQlPh
         mkEgQ6cHlHJl9MNNJSiOIAgETpNp/OW/MiPGXlkwFYmSwIpVKEhRcadgkJDGInEUXzwE
         GNJBwzYxpioKejU0ezvwAReSVeRRdRV7olOZsyoKJy/CmqDPxpJ/ibZfqo9C7Ab+lSiG
         +Pew==
X-Gm-Message-State: ANhLgQ2fhGGbOkcBw25Ng7V110HtepewUytefgJXG1lgxFJD+Z2PuRzC
        54isAV/WgWGD4j7JTTsaq8XdBg==
X-Google-Smtp-Source: ADFU+vuRo0Z9og1N04QkJ35KoQ07MEFGwx1jCIe2vGcNdl80NJ4ucpQC+2OppHx5h2cN8yRDQj+PoA==
X-Received: by 2002:a05:620a:539:: with SMTP id h25mr2309572qkh.395.1585609380619;
        Mon, 30 Mar 2020 16:03:00 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id i20sm931146qkl.135.2020.03.30.16.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:03:00 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] kunit: Fix kunit.py run --build_dir='<foo>' fails on "unclean" trees
Date:   Mon, 30 Mar 2020 20:02:56 -0300
Message-Id: <20200330230256.28323-1-vitor@massaru.org>
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
 tools/testing/kunit/kunit_kernel.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index d99ae75ef72f..0cb1f81ac8f2 100644
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

