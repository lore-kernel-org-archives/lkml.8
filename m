Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AAAC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8032E2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202581;
	bh=z7UtFpjytQG8OQ4ULKWVO8VA52K/0wUewiNVs40n9VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bI6RBxVUK981phMRWRlYanBk4ATyZbtfibAC6+oE7JJnGBSrVQE+aSOIXsAJOWBvj
	 gCw3zeiwiJWbo1kPdJwIeSmDIJkthKF9Y3Ge5JFAJBWI0E/s68zKIxPY1H7BSkjTjx
	 69Yrj1z8r5DSHvxCgGedxzRNdtxEEXf20Twht+74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgAPQxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:53:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbgAPQxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:53:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E9E205F4;
        Thu, 16 Jan 2020 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193591;
        bh=z7UtFpjytQG8OQ4ULKWVO8VA52K/0wUewiNVs40n9VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJ9oDdJkDvbAsROK7Llo4chxJhLZ1iDOMa9c6S5Oz3xiW+kMQqWZmQYHdl29FzCNl
         XaUOOEpSOLYgs0M3Bbhk6wR+Pgl9pCH3oTn0dLEVxQBdkhF4YMc24s1wC+LPVcamJN
         zquePOvPVcpl1P67DaEmYF4ebYP0ZPbKX8n6rYsc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 131/205] s390/pkey: fix memory leak within _copy_apqns_from_user()
Date:   Thu, 16 Jan 2020 11:41:46 -0500
Message-Id: <20200116164300.6705-131-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[ Upstream commit f9cac4fd8878929c6ebff0bd272317905d77c38a ]

Fixes: f2bbc96e7cfad ("s390/pkey: add CCA AES cipher key support")
Reported-by: Markus Elfring <Markus.Elfring@web.de>
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/pkey_api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 9de3d46b3253..e17fac20127e 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -740,8 +740,10 @@ static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqns)
 		kapqns = kmalloc(nbytes, GFP_KERNEL);
 		if (!kapqns)
 			return ERR_PTR(-ENOMEM);
-		if (copy_from_user(kapqns, uapqns, nbytes))
+		if (copy_from_user(kapqns, uapqns, nbytes)) {
+			kfree(kapqns);
 			return ERR_PTR(-EFAULT);
+		}
 	}
 
 	return kapqns;
-- 
2.20.1

