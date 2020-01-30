Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5576EC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F60C205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410250;
	bh=bGoDS0mBgh3I4daVnCZ7k2qTbcUa8RGgkJZ9QH04wi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cLU2GXc9UPQRsklwZSIl1ebVL2Y8i+f1wHLUTuIwAvryn93d9Aqc2K9KBfy+okKO4
	 GuCzR5z5mWT/+qvWMj6n9DfciLXeUZTaNRWBjWbBsbC4urHzYEZrYHsZyMBz2cKT1H
	 eTFnhnZLNC/UAZC1vM377duGD0nGDN7bKXUoA5ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbgA3SqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:46:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730878AbgA3SqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:46:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FC0820674;
        Thu, 30 Jan 2020 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409968;
        bh=bGoDS0mBgh3I4daVnCZ7k2qTbcUa8RGgkJZ9QH04wi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnolaoxbQTSfpwxtw+DiFBfkXzkj3SNxfW5gpN6UBwn+ItF5ZJl/xxEeLE26qcd7A
         mP26B6z63pEXpAB3ByHgpGmosGbEd8K+ZihSJy81QAPHtDSGdi1Da5ykb9f5Nto48Z
         13jnMEywMROin7QMs66+AG4wvD0l9ZA5tlP/lVfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erhard Furtner <erhard_f@mailbox.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 105/110] crypto: vmx - reject xts inputs that are too short
Date:   Thu, 30 Jan 2020 19:39:21 +0100
Message-Id: <20200130183625.934298628@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Axtens <dja@axtens.net>

commit 1372a51b88fa0d5a8ed2803e4975c98da3f08463 upstream.

When the kernel XTS implementation was extended to deal with ciphertext
stealing in commit 8083b1bf8163 ("crypto: xts - add support for ciphertext
stealing"), a check was added to reject inputs that were too short.

However, in the vmx enablement - commit 239668419349 ("crypto: vmx/xts -
use fallback for ciphertext stealing"), that check wasn't added to the
vmx implementation. This disparity leads to errors like the following:

alg: skcipher: p8_aes_xts encryption unexpectedly succeeded on test vector "random: len=0 klen=64"; expected_error=-22, cfg="random: inplace may_sleep use_finup src_divs=[<flush>66.99%@+10, 33.1%@alignmask+1155]"

Return -EINVAL if asked to operate with a cryptlen smaller than the AES
block size. This brings vmx in line with the generic implementation.

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206049
Fixes: 239668419349 ("crypto: vmx/xts - use fallback for ciphertext stealing")
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[dja: commit message]
Signed-off-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/vmx/aes_xts.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/crypto/vmx/aes_xts.c
+++ b/drivers/crypto/vmx/aes_xts.c
@@ -84,6 +84,9 @@ static int p8_aes_xts_crypt(struct skcip
 	u8 tweak[AES_BLOCK_SIZE];
 	int ret;
 
+	if (req->cryptlen < AES_BLOCK_SIZE)
+		return -EINVAL;
+
 	if (!crypto_simd_usable() || (req->cryptlen % XTS_BLOCK_SIZE) != 0) {
 		struct skcipher_request *subreq = skcipher_request_ctx(req);
 


