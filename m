Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C250C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46073207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322795;
	bh=kWkYnOgyIZpYVEMaZD7avyMdh028gxcHAOd0VE+Y3yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VzeXdMLHHUZ/C15y27/kFi8Dvq37mHusk0whqJ/qD3n9qZlVI0HGZW9Mwn5H0NLS5
	 lVe8tGvMh6CftR4ZrLHfgNWQFUiGNYW46jvEhChpn+7ZshqpDgqBxgbzPkFu7MyHmm
	 LDsbK5/V+BuoddEl+lZTLYmQMaGsJsPTZCJ56OuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgFPPxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732079AbgFPPxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:53:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51794207C4;
        Tue, 16 Jun 2020 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322788;
        bh=kWkYnOgyIZpYVEMaZD7avyMdh028gxcHAOd0VE+Y3yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJ5w/vxzBe0fj0KWpJ49fT/A1SMe2xxLjyccXurNO/3zHBKwrZny/K6bRaZ7kYZ4F
         eNm9IzcjOAFWB3dhX5uDV5ynM2o9o0VrLojUJ8mgejwQc+x1JyF/7xJll60+PLh2CJ
         YW8i4KdILHviQ1/G6VNOJffY+XUdzDoOm0NKjjm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiumei Mu <xmu@redhat.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.6 097/161] crypto: drbg - fix error return code in drbg_alloc_state()
Date:   Tue, 16 Jun 2020 17:34:47 +0200
Message-Id: <20200616153110.997867394@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
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
 


