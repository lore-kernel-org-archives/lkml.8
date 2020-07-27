Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE34EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809C52072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgG0Guq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:50:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbgG0Guq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:50:46 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 020D2A30C70C8211127B;
        Mon, 27 Jul 2020 14:50:44 +0800 (CST)
Received: from huawei.com (10.175.104.82) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Jul 2020
 14:50:41 +0800
From:   Huang Guobin <huangguobin4@huawei.com>
To:     <haren@us.ibm.com>, <herbert@gondor.apana.org.au>,
        <ddstreet@ieee.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] lib: Verify array index is correct before using it
Date:   Mon, 27 Jul 2020 02:59:10 -0400
Message-ID: <20200727065910.1628-1-huangguobin4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code reads from the array before verifying that "c" is a valid
index. Move test array offset code before use to fix it.

Fixes: 2da572c959dd ("lib: add software 842 compression/decompression")
Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
---
 lib/842/842_compress.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/842/842_compress.c b/lib/842/842_compress.c
index c02baa4168e1..c37bfe0b9346 100644
--- a/lib/842/842_compress.c
+++ b/lib/842/842_compress.c
@@ -11,6 +11,7 @@
 #define MODULE_NAME "842_compress"
 
 #include <linux/hashtable.h>
+#include <linux/nospec.h>
 
 #include "842.h"
 #include "842_debugfs.h"
@@ -222,12 +223,14 @@ static int add_bits(struct sw842_param *p, u64 d, u8 n)
 static int add_template(struct sw842_param *p, u8 c)
 {
 	int ret, i, b = 0;
-	u8 *t = comp_ops[c];
+	u8 *t = NULL;
 	bool inv = false;
 
 	if (c >= OPS_MAX)
 		return -EINVAL;
+	c = array_index_nospec(c, OPS_MAX);
 
+	t = comp_ops[c];
 	pr_debug("template %x\n", t[4]);
 
 	ret = add_bits(p, t[4], OP_BITS);
@@ -379,12 +382,14 @@ static int add_end_template(struct sw842_param *p)
 
 static bool check_template(struct sw842_param *p, u8 c)
 {
-	u8 *t = comp_ops[c];
+	u8 *t = NULL;
 	int i, match, b = 0;
 
 	if (c >= OPS_MAX)
 		return false;
+	c = array_index_nospec(c, OPS_MAX);
 
+	t = comp_ops[c];
 	for (i = 0; i < 4; i++) {
 		if (t[i] & OP_ACTION_INDEX) {
 			if (t[i] & OP_AMOUNT_2)
-- 
2.17.1

