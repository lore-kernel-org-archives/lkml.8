Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4618C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C367A217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgBMDpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:45:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729470AbgBMDpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:45:51 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5FE231F777D9C80FF576;
        Thu, 13 Feb 2020 11:45:49 +0800 (CST)
Received: from huawei.com (10.175.101.78) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 11:45:41 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <agk@redhat.com>, <snitzer@redhat.com>, <yangyingliang@huawei.com>
Subject: [PATCH] dm crypt: use crypt_integrity_aead() helper
Date:   Thu, 13 Feb 2020 12:11:26 +0800
Message-ID: <1581567086-17807-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.78]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace test_bit(CRYPT_MODE_INTEGRITY_AEAD, XXX) with
crypt_integrity_aead().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/md/dm-crypt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index c6a5298..3df90da 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -230,6 +230,8 @@ struct crypt_config {
 static struct scatterlist *crypt_get_sg_data(struct crypt_config *cc,
 					     struct scatterlist *sg);
 
+static bool crypt_integrity_aead(struct crypt_config *cc);
+
 /*
  * Use this to access cipher attributes that are independent of the key.
  */
@@ -346,7 +348,7 @@ static int crypt_iv_benbi_ctr(struct crypt_config *cc, struct dm_target *ti,
 	unsigned bs;
 	int log;
 
-	if (test_bit(CRYPT_MODE_INTEGRITY_AEAD, &cc->cipher_flags))
+	if (crypt_integrity_aead(cc))
 		bs = crypto_aead_blocksize(any_tfm_aead(cc));
 	else
 		bs = crypto_skcipher_blocksize(any_tfm(cc));
@@ -712,7 +714,7 @@ static int crypt_iv_random_gen(struct crypt_config *cc, u8 *iv,
 static int crypt_iv_eboiv_ctr(struct crypt_config *cc, struct dm_target *ti,
 			    const char *opts)
 {
-	if (test_bit(CRYPT_MODE_INTEGRITY_AEAD, &cc->cipher_flags)) {
+	if (crypt_integrity_aead(cc)) {
 		ti->error = "AEAD transforms not supported for EBOIV";
 		return -EINVAL;
 	}
-- 
1.8.3

