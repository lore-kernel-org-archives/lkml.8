Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2151EC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34C22080C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDTLYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:24:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbgDTLYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:24:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E4C0EFA7B7CD3C846ACC;
        Mon, 20 Apr 2020 19:24:17 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 19:24:07 +0800
To:     <gregkh@linuxfoundation.org>, <yeyunfeng@huawei.com>,
        <herbert@gondor.apana.org.au>, <ebiggers@google.com>,
        <alexios.zavras@intel.com>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     <hushiyuan@huawei.com>, <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] crc-t10dif: Replace string names with CRC_T10DIF_STRING
Message-ID: <9ab205ba-1bcb-f01a-a8b4-a7736791fadc@huawei.com>
Date:   Mon, 20 Apr 2020 19:23:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit b76377543b73 ("crc-t10dif: Pick better transform if one becomes
available") add the macro CRC_T10DIF_STRING, so it's better to use
CRC_T10DIF_STRING instead of the "crct10dif" names.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 lib/crc-t10dif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/crc-t10dif.c b/lib/crc-t10dif.c
index 8cc01a603416..87a081f7e662 100644
--- a/lib/crc-t10dif.c
+++ b/lib/crc-t10dif.c
@@ -37,7 +37,7 @@ static int crc_t10dif_rehash(struct notifier_block *self, unsigned long val, voi
 		mutex_unlock(&crc_t10dif_mutex);
 		return 0;
 	}
-	new = crypto_alloc_shash("crct10dif", 0, 0);
+	new = crypto_alloc_shash(CRC_T10DIF_STRING, 0, 0);
 	if (IS_ERR(new)) {
 		mutex_unlock(&crc_t10dif_mutex);
 		return 0;
@@ -87,7 +87,7 @@ __u16 crc_t10dif(const unsigned char *buffer, size_t len)
 static int __init crc_t10dif_mod_init(void)
 {
 	crypto_register_notifier(&crc_t10dif_nb);
-	crct10dif_tfm = crypto_alloc_shash("crct10dif", 0, 0);
+	crct10dif_tfm = crypto_alloc_shash(CRC_T10DIF_STRING, 0, 0);
 	if (IS_ERR(crct10dif_tfm)) {
 		static_key_slow_inc(&crct10dif_fallback);
 		crct10dif_tfm = NULL;
-- 
1.8.3.1

