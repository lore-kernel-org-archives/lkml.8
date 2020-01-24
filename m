Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777C1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447E720718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859124;
	bh=mMVHWPhGVr12UQgiIwOVH1+KWsDTW8eU+eNqwVQThDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dUHrCJQRYRv/p92xB4P+GpPS0hJkAL6cJZBknB0xyPiXCVNCKz+Pw9j2mJjmqVG3r
	 dxVhUNFVAu8bPDYDD7/e24kVUGJ9i4H+xTcm3kuQI15kZ8frlTNYkqVjGFRo4JQcXK
	 eDmB2bHr/TK5ylhuxFwTxYf5/rQDNP3iJRviLSQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgAXJpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:45:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732257AbgAXJpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:45:21 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 787C320718;
        Fri, 24 Jan 2020 09:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859121;
        bh=mMVHWPhGVr12UQgiIwOVH1+KWsDTW8eU+eNqwVQThDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFhZ3+aY83xu/7KcjqX7VVwwfvu0osVgyIvxhExzusTpYmR8j9egkmEp5t+URl4bu
         ZZ4rpbZhe3LlipNgWS0TvkqzZpHpqu30SUG8t98K1ZkJJRIoKK2Yey+6ulyZwE3s9F
         /DpuX6JaIVLew8NoMDGtfTE5PXd26x3YEPUIt4t0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 024/343] pcrypt: use format specifier in kobject_add
Date:   Fri, 24 Jan 2020 10:27:22 +0100
Message-Id: <20200124092922.782535571@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit b1e3874c75ab15288f573b3532e507c37e8e7656 ]

Passing string 'name' as the format specifier is potentially hazardous
because name could (although very unlikely to) have a format specifier
embedded in it causing issues when parsing the non-existent arguments
to these.  Follow best practice by using the "%s" format string for
the string 'name'.

Cleans up clang warning:
crypto/pcrypt.c:397:40: warning: format string is not a string literal
(potentially insecure) [-Wformat-security]

Fixes: a3fb1e330dd2 ("pcrypt: Added sysfs interface to pcrypt")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/pcrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index f8ec3d4ba4a80..a5718c0a3dc4e 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -394,7 +394,7 @@ static int pcrypt_sysfs_add(struct padata_instance *pinst, const char *name)
 	int ret;
 
 	pinst->kobj.kset = pcrypt_kset;
-	ret = kobject_add(&pinst->kobj, NULL, name);
+	ret = kobject_add(&pinst->kobj, NULL, "%s", name);
 	if (!ret)
 		kobject_uevent(&pinst->kobj, KOBJ_ADD);
 
-- 
2.20.1



