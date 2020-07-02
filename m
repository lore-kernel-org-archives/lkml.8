Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA494C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF7920772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgGBOBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:01:14 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42883 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbgGBOBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:01:13 -0400
Received: from hopp.molgen.mpg.de (hopp.molgen.mpg.de [141.14.25.186])
        by mx.molgen.mpg.de (Postfix) with ESMTP id A3423206442DE;
        Thu,  2 Jul 2020 16:01:11 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] moduleparams: Add hex type parameter
Date:   Thu,  2 Jul 2020 16:01:01 +0200
Message-Id: <20200702140102.26129-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For bitmasks printing values in hex is more convenient.

Prefix with 0x (#) to make it clear, that it’s a hex value.

Using the helper for `amdgpu.ppfeaturemask`, it will look like below.

Before:

    $ more /sys/module/amdgpu/parameters/ppfeaturemask
    4294950911

After:

    $ more /sys/module/amdgpu/parameters/ppfeaturemask
    0xffffbfff

Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 include/linux/moduleparam.h | 7 ++++++-
 kernel/params.c             | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 3ef917ff0964..408978fcfe27 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -118,7 +118,7 @@ struct kparam_array
  * you can create your own by defining those variables.
  *
  * Standard types are:
- *	byte, short, ushort, int, uint, long, ulong
+ *	byte, hex, short, ushort, int, uint, long, ulong
  *	charp: a character pointer
  *	bool: a bool, values 0/1, y/n, Y/N.
  *	invbool: the above, only sense-reversed (N = true).
@@ -448,6 +448,11 @@ extern int param_set_ullong(const char *val, const struct kernel_param *kp);
 extern int param_get_ullong(char *buffer, const struct kernel_param *kp);
 #define param_check_ullong(name, p) __param_check(name, p, unsigned long long)
 
+extern const struct kernel_param_ops param_ops_hex;
+extern int param_set_hex(const char *val, const struct kernel_param *kp);
+extern int param_get_hex(char *buffer, const struct kernel_param *kp);
+#define param_check_hex(name, p) param_check_uint(name, p)
+
 extern const struct kernel_param_ops param_ops_charp;
 extern int param_set_charp(const char *val, const struct kernel_param *kp);
 extern int param_get_charp(char *buffer, const struct kernel_param *kp);
diff --git a/kernel/params.c b/kernel/params.c
index 8e56f8b12d8f..ceca8394dac5 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -241,6 +241,7 @@ STANDARD_PARAM_DEF(uint,	unsigned int,		"%u",   kstrtouint);
 STANDARD_PARAM_DEF(long,	long,			"%li",  kstrtol);
 STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",  kstrtoul);
 STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu", kstrtoull);
+STANDARD_PARAM_DEF(hex,		unsigned int,		"%#x",  kstrtouint);
 
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
-- 
2.26.2

