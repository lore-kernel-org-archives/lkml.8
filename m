Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71851C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549B124962
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgEIIwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:52:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56036 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727886AbgEIIwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:52:34 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2720840CDD1CBC2CEBAA;
        Sat,  9 May 2020 16:52:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 16:52:21 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <heiko.carstens@de.ibm.com>, <gor@linux.ibm.com>,
        <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.or>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH -next 1/3] s390/crypto: use scnprintf() instead of snprintf()
Date:   Sat, 9 May 2020 16:56:06 +0800
Message-ID: <20200509085608.41061-2-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509085608.41061-1-chenzhou10@huawei.com>
References: <20200509085608.41061-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snprintf() returns the number of bytes that would be written,
which may be greater than the the actual length to be written.

show() methods should return the number of bytes printed into the
buffer. This is the return value of scnprintf().

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/s390/crypto/prng.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
index d977643fa627..e1ae23911ccd 100644
--- a/arch/s390/crypto/prng.c
+++ b/arch/s390/crypto/prng.c
@@ -693,7 +693,7 @@ static ssize_t prng_chunksize_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", prng_chunk_size);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", prng_chunk_size);
 }
 static DEVICE_ATTR(chunksize, 0444, prng_chunksize_show, NULL);
 
@@ -712,7 +712,7 @@ static ssize_t prng_counter_show(struct device *dev,
 		counter = prng_data->prngws.byte_counter;
 	mutex_unlock(&prng_data->mutex);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", counter);
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", counter);
 }
 static DEVICE_ATTR(byte_counter, 0444, prng_counter_show, NULL);
 
@@ -721,7 +721,7 @@ static ssize_t prng_errorflag_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", prng_errorflag);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", prng_errorflag);
 }
 static DEVICE_ATTR(errorflag, 0444, prng_errorflag_show, NULL);
 
@@ -731,9 +731,9 @@ static ssize_t prng_mode_show(struct device *dev,
 			      char *buf)
 {
 	if (prng_mode == PRNG_MODE_TDES)
-		return snprintf(buf, PAGE_SIZE, "TDES\n");
+		return scnprintf(buf, PAGE_SIZE, "TDES\n");
 	else
-		return snprintf(buf, PAGE_SIZE, "SHA512\n");
+		return scnprintf(buf, PAGE_SIZE, "SHA512\n");
 }
 static DEVICE_ATTR(mode, 0444, prng_mode_show, NULL);
 
@@ -756,7 +756,7 @@ static ssize_t prng_reseed_limit_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", prng_reseed_limit);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", prng_reseed_limit);
 }
 static ssize_t prng_reseed_limit_store(struct device *dev,
 				       struct device_attribute *attr,
@@ -787,7 +787,7 @@ static ssize_t prng_strength_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "256\n");
+	return scnprintf(buf, PAGE_SIZE, "256\n");
 }
 static DEVICE_ATTR(strength, 0444, prng_strength_show, NULL);
 
-- 
2.20.1

