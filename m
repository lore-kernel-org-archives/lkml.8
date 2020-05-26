Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3FDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6B720888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520285;
	bh=BJ0tO64MAidki1KuaMNtI00MVaxBlWf8j4Gm2u/+cZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XiPtFpFGOQF3FcTWbHqab7zZ0uN98JPIfijikV3q8GE7WXD+kb3ron4EtslnU8IUw
	 zdS37xFkZ7VBmHSV7kziJLv5tUdng8MzbH4RyaGK234VG0wK7PGFsCJ6mcDBR+oxoL
	 ujQIauv32BTSSg3jvipcNdUV0vdAcBdCcjTmo5AM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404060AbgEZTLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389286AbgEZTLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:11:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD76E20888;
        Tue, 26 May 2020 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520275;
        bh=BJ0tO64MAidki1KuaMNtI00MVaxBlWf8j4Gm2u/+cZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tDLJrjAGUTFJNdaTSQLPkNq23QtyJ49jNo6v/r0chzTCDTmrZhiCdLl1Mvy5YURFU
         Uof7dMqRF5ChDM0DmeMH7q0NUgY8rJvYW5ulxAmvjjNztFxxZlO+aQcnENkuCJC/0w
         QYFK5f+dUV2a2C4TzrjfpUEjEhfBcC7FcwS8TgoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 016/126] evm: Fix a small race in init_desc()
Date:   Tue, 26 May 2020 20:52:33 +0200
Message-Id: <20200526183938.974820180@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 8433856947217ebb5697a8ff9c4c9cad4639a2cf ]

The IS_ERR_OR_NULL() function has two conditions and if we got really
unlucky we could hit a race where "ptr" started as an error pointer and
then was set to NULL.  Both conditions would be false even though the
pointer at the end was NULL.

This patch fixes the problem by ensuring that "*tfm" can only be NULL
or valid.  I have introduced a "tmp_tfm" variable to make that work.  I
also reversed a condition and pulled the code in one tab.

Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
Fixes: 53de3b080d5e ("evm: Check also if *tfm is an error pointer in init_desc()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/evm/evm_crypto.c | 44 ++++++++++++++---------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 302adeb2d37b..cc826c2767a3 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -75,7 +75,7 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
 {
 	long rc;
 	const char *algo;
-	struct crypto_shash **tfm;
+	struct crypto_shash **tfm, *tmp_tfm;
 	struct shash_desc *desc;
 
 	if (type == EVM_XATTR_HMAC) {
@@ -93,31 +93,31 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
 		algo = hash_algo_name[hash_algo];
 	}
 
-	if (IS_ERR_OR_NULL(*tfm)) {
-		mutex_lock(&mutex);
-		if (*tfm)
-			goto out;
-		*tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
-		if (IS_ERR(*tfm)) {
-			rc = PTR_ERR(*tfm);
-			pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
-			*tfm = NULL;
+	if (*tfm)
+		goto alloc;
+	mutex_lock(&mutex);
+	if (*tfm)
+		goto unlock;
+
+	tmp_tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
+	if (IS_ERR(tmp_tfm)) {
+		pr_err("Can not allocate %s (reason: %ld)\n", algo,
+		       PTR_ERR(tmp_tfm));
+		mutex_unlock(&mutex);
+		return ERR_CAST(tmp_tfm);
+	}
+	if (type == EVM_XATTR_HMAC) {
+		rc = crypto_shash_setkey(tmp_tfm, evmkey, evmkey_len);
+		if (rc) {
+			crypto_free_shash(tmp_tfm);
 			mutex_unlock(&mutex);
 			return ERR_PTR(rc);
 		}
-		if (type == EVM_XATTR_HMAC) {
-			rc = crypto_shash_setkey(*tfm, evmkey, evmkey_len);
-			if (rc) {
-				crypto_free_shash(*tfm);
-				*tfm = NULL;
-				mutex_unlock(&mutex);
-				return ERR_PTR(rc);
-			}
-		}
-out:
-		mutex_unlock(&mutex);
 	}
-
+	*tfm = tmp_tfm;
+unlock:
+	mutex_unlock(&mutex);
+alloc:
 	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
 			GFP_KERNEL);
 	if (!desc)
-- 
2.25.1



