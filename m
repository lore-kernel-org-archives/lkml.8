Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8640C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B6D2088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgGCO3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:29:44 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39343 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbgGCO3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:29:43 -0400
Received: from hopp.molgen.mpg.de (hopp.molgen.mpg.de [141.14.25.186])
        by mx.molgen.mpg.de (Postfix) with ESMTP id ABAB0206442E7;
        Fri,  3 Jul 2020 16:29:41 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 2/3] moduleparams: Add hexint type parameter
Date:   Fri,  3 Jul 2020 16:29:38 +0200
Message-Id: <20200703142939.28663-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703142939.28663-1-pmenzel@molgen.mpg.de>
References: <20200703142939.28663-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For bitmasks printing values in hex is more convenient.

Prefix with `0x` to make it clear, that it’s a hex value, and pad it
out.

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
 include/linux/moduleparam.h |  7 ++++++-
 kernel/params.c             | 17 +++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 3ef917ff0964..cff7261e98bb 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -118,7 +118,7 @@ struct kparam_array
  * you can create your own by defining those variables.
  *
  * Standard types are:
- *	byte, short, ushort, int, uint, long, ulong
+ *	byte, hexint, short, ushort, int, uint, long, ulong
  *	charp: a character pointer
  *	bool: a bool, values 0/1, y/n, Y/N.
  *	invbool: the above, only sense-reversed (N = true).
@@ -448,6 +448,11 @@ extern int param_set_ullong(const char *val, const struct kernel_param *kp);
 extern int param_get_ullong(char *buffer, const struct kernel_param *kp);
 #define param_check_ullong(name, p) __param_check(name, p, unsigned long long)
 
+extern const struct kernel_param_ops param_ops_hexint;
+extern int param_set_hexint(const char *val, const struct kernel_param *kp);
+extern int param_get_hexint(char *buffer, const struct kernel_param *kp);
+#define param_check_hexint(name, p) param_check_uint(name, p)
+
 extern const struct kernel_param_ops param_ops_charp;
 extern int param_set_charp(const char *val, const struct kernel_param *kp);
 extern int param_get_charp(char *buffer, const struct kernel_param *kp);
diff --git a/kernel/params.c b/kernel/params.c
index 111eee82b999..3835fb82c64b 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -233,14 +233,15 @@ char *parse_args(const char *doing,
 	EXPORT_SYMBOL(param_ops_##name)
 
 
-STANDARD_PARAM_DEF(byte,	unsigned char,		"%hhu",	kstrtou8);
-STANDARD_PARAM_DEF(short,	short,			"%hi",	kstrtos16);
-STANDARD_PARAM_DEF(ushort,	unsigned short,		"%hu",	kstrtou16);
-STANDARD_PARAM_DEF(int,		int,			"%i",	kstrtoint);
-STANDARD_PARAM_DEF(uint,	unsigned int,		"%u",	kstrtouint);
-STANDARD_PARAM_DEF(long,	long,			"%li",	kstrtol);
-STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",	kstrtoul);
-STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu",	kstrtoull);
+STANDARD_PARAM_DEF(byte,	unsigned char,		"%hhu",		kstrtou8);
+STANDARD_PARAM_DEF(short,	short,			"%hi",		kstrtos16);
+STANDARD_PARAM_DEF(ushort,	unsigned short,		"%hu",		kstrtou16);
+STANDARD_PARAM_DEF(int,		int,			"%i",		kstrtoint);
+STANDARD_PARAM_DEF(uint,	unsigned int,		"%u",		kstrtouint);
+STANDARD_PARAM_DEF(long,	long,			"%li",		kstrtol);
+STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",		kstrtoul);
+STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu",		kstrtoull);
+STANDARD_PARAM_DEF(hexint,	unsigned int,		"%#08x", 	kstrtouint);
 
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
-- 
2.26.2

