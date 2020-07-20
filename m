Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2E5C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD0A206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261533;
	bh=WWdC/8JRDZCpZNHg7v589mBckIuYNk/cwpy8NeYCGjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Br02DHvwR4gxm28lYeKYxCHc9HJk/Okw7zeR67JRP8YOa5WUm97mj4cUlCHJL9LoG
	 +ycqbL1sHGFb+3Aaw+BgCVkrfJARJroPjPBfz+JsuBwmpdkIVuwprfqhoSpO23VhFt
	 1nJOTg+aAEnHfvz65B437u0+cueoI6LUjats9jN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbgGTQMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387889AbgGTQMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:12:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EBF2064B;
        Mon, 20 Jul 2020 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261519;
        bh=WWdC/8JRDZCpZNHg7v589mBckIuYNk/cwpy8NeYCGjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8o0bm9ZNd27kh6OW8NzVNlBKBAHjjqBLObavN/4DXTTNn+kYtDD/w/LX8In1mkMo
         RlId9siPFlJ61LQnrm3TZOp2qzxiFVzRHQk1l3QUGNO+UMxFhA/aJ4KFI1/0OepR+Q
         +yWAAZBFjASQXKD3fnkcPmk76a+NYqBBD+WhPTXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 114/244] keys: asymmetric: fix error return code in software_key_query()
Date:   Mon, 20 Jul 2020 17:36:25 +0200
Message-Id: <20200720152831.265834535@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 6cbba1f9114a8134cff9138c79add15012fd52b9 ]

Fix to return negative error code -ENOMEM from kmalloc() error handling
case instead of 0, as done elsewhere in this function.

Fixes: f1774cb8956a ("X.509: parse public key parameters from x509 for akcipher")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/asymmetric_keys/public_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index d7f43d4ea925a..e5fae4e838c06 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -119,6 +119,7 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
+	ret = -ENOMEM;
 	key = kmalloc(pkey->keylen + sizeof(u32) * 2 + pkey->paramlen,
 		      GFP_KERNEL);
 	if (!key)
-- 
2.25.1



