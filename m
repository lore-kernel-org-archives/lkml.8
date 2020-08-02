Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59455C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CC772076B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgHBLPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 07:15:44 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:38704 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728192AbgHBLPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 07:15:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U4T30CY_1596366926;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U4T30CY_1596366926)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Aug 2020 19:15:26 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     freude@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ifranzki@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianjia.zhang@alibaba.com
Subject: [PATCH] s390/pkey: Remove redundant variable initialization
Date:   Sun,  2 Aug 2020 19:15:26 +0800
Message-Id: <20200802111526.4883-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the first place, the initialization value of `rc` is wrong.
It is unnecessary to initialize `rc` variables, so remove their
initialization operation.

Fixes: f2bbc96e7cfad ("s390/pkey: add CCA AES cipher key support")
Cc: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/s390/crypto/pkey_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 74e63ec49068..58140506a8e7 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -818,7 +818,7 @@ static int pkey_keyblob2pkey2(const struct pkey_apqn *apqns, size_t nr_apqns,
 static int pkey_apqns4key(const u8 *key, size_t keylen, u32 flags,
 			  struct pkey_apqn *apqns, size_t *nr_apqns)
 {
-	int rc = EINVAL;
+	int rc;
 	u32 _nr_apqns, *_apqns = NULL;
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
 
@@ -886,7 +886,7 @@ static int pkey_apqns4keytype(enum pkey_key_type ktype,
 			      u8 cur_mkvp[32], u8 alt_mkvp[32], u32 flags,
 			      struct pkey_apqn *apqns, size_t *nr_apqns)
 {
-	int rc = -EINVAL;
+	int rc;
 	u32 _nr_apqns, *_apqns = NULL;
 
 	if (ktype == PKEY_TYPE_CCA_DATA || ktype == PKEY_TYPE_CCA_CIPHER) {
-- 
2.26.2

