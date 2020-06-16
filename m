Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2582C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F9B208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323659;
	bh=kWkYnOgyIZpYVEMaZD7avyMdh028gxcHAOd0VE+Y3yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x6iIxW1jxq7tew2pMO208e4b9SwTC1QTkk5oZd57ZgjgS6X5VCP1ovVc72AfIcHOM
	 Mt5bxC9/o4QKcpVx5X0XMTXp9s7PsCLVbxwZpmJJv8QQP8aBUWemIbeNKi6c8TaFR5
	 6H75Mfw9ej7D8hE0bTC2sunZVKqrRymDa7GbexMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgFPPrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731887AbgFPPqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:46:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59FCA21475;
        Tue, 16 Jun 2020 15:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322414;
        bh=kWkYnOgyIZpYVEMaZD7avyMdh028gxcHAOd0VE+Y3yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPawAMVgEpELnbQG78cNcwWancwPmk0hQdbcAh+BFN8v9w36u7Te6HyQEBp9CSnMb
         UBh2Jh7KhgVDb4wwhl1mtwr+L++azzz9AfObqWtlfButu0Ffpps+EWwdNe4Mej2Io5
         p14oNJFLxrUjqeoEZiLMfvnHsQEUB9YjpwFbP6y4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiumei Mu <xmu@redhat.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.7 092/163] crypto: drbg - fix error return code in drbg_alloc_state()
Date:   Tue, 16 Jun 2020 17:34:26 +0200
Message-Id: <20200616153111.242763285@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit e0664ebcea6ac5e16da703409fb4bd61f8cd37d9 upstream.

Fix to return negative error code -ENOMEM from the kzalloc error handling
case instead of 0, as done elsewhere in this function.

Reported-by: Xiumei Mu <xmu@redhat.com>
Fixes: db07cd26ac6a ("crypto: drbg - add FIPS 140-2 CTRNG for noise source")
Cc: <stable@vger.kernel.org>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/drbg.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1294,8 +1294,10 @@ static inline int drbg_alloc_state(struc
 	if (IS_ENABLED(CONFIG_CRYPTO_FIPS)) {
 		drbg->prev = kzalloc(drbg_sec_strength(drbg->core->flags),
 				     GFP_KERNEL);
-		if (!drbg->prev)
+		if (!drbg->prev) {
+			ret = -ENOMEM;
 			goto fini;
+		}
 		drbg->fips_primed = false;
 	}
 


