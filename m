Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E38AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74EC820899
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgGCO3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:29:43 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:37581 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgGCO3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:29:42 -0400
Received: from hopp.molgen.mpg.de (hopp.molgen.mpg.de [141.14.25.186])
        by mx.molgen.mpg.de (Postfix) with ESMTP id DD07120643CC0;
        Fri,  3 Jul 2020 16:29:40 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] kernel/params.c: Align last argument with a tab
Date:   Fri,  3 Jul 2020 16:29:37 +0200
Message-Id: <20200703142939.28663-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second and third arguments are aligned with tabs, so do the same for
the fourth.

Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 kernel/params.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 8e56f8b12d8f..111eee82b999 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -233,14 +233,14 @@ char *parse_args(const char *doing,
 	EXPORT_SYMBOL(param_ops_##name)
 
 
-STANDARD_PARAM_DEF(byte,	unsigned char,		"%hhu", kstrtou8);
-STANDARD_PARAM_DEF(short,	short,			"%hi",  kstrtos16);
-STANDARD_PARAM_DEF(ushort,	unsigned short,		"%hu",  kstrtou16);
-STANDARD_PARAM_DEF(int,		int,			"%i",   kstrtoint);
-STANDARD_PARAM_DEF(uint,	unsigned int,		"%u",   kstrtouint);
-STANDARD_PARAM_DEF(long,	long,			"%li",  kstrtol);
-STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",  kstrtoul);
-STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu", kstrtoull);
+STANDARD_PARAM_DEF(byte,	unsigned char,		"%hhu",	kstrtou8);
+STANDARD_PARAM_DEF(short,	short,			"%hi",	kstrtos16);
+STANDARD_PARAM_DEF(ushort,	unsigned short,		"%hu",	kstrtou16);
+STANDARD_PARAM_DEF(int,		int,			"%i",	kstrtoint);
+STANDARD_PARAM_DEF(uint,	unsigned int,		"%u",	kstrtouint);
+STANDARD_PARAM_DEF(long,	long,			"%li",	kstrtol);
+STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",	kstrtoul);
+STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu",	kstrtoull);
 
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
-- 
2.26.2

