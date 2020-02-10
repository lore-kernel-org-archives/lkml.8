Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4F7C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD1B20661
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338641;
	bh=EtqAip2wnqvoXOp3+xaMnhpjYdXXYLsB5O4YTrNPBjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oLnQ6BU2Jhwx1uYTFJX/gg1i7NeQuHECg+12guEy+fF+HR7OjOdrw+UQqG4hrqAXB
	 wC8VMLPkcgkFNnmeK1iIUfhnAoP68mZV6sxLGgl9Ik7UcIBUzLNbE5NmMXbR9jnXJH
	 kjeWfusImFwsjvrkvN58uNa/fdz6yjwuhUWc7xF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgBJMn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:43:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgBJMkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:18 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C7520661;
        Mon, 10 Feb 2020 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338417;
        bh=EtqAip2wnqvoXOp3+xaMnhpjYdXXYLsB5O4YTrNPBjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTTokeqB0vIu/BU2w55ZnrN7GSlsF7Gu/etS4zcOBLnmuyhdkAYTk9tHAfXaWuZRq
         dXtAZ7dqwWql21AKoYO5SXcwep0Dk0GH9M8C54Kt/L9/cHFN6zGbxBhDmsgZqwlpBx
         VqwefaYO6AyOXlTWOloj/Wa6pl6QhViu7c+Gyg1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.5 116/367] crypto: ccree - fix AEAD decrypt auth fail
Date:   Mon, 10 Feb 2020 04:30:29 -0800
Message-Id: <20200210122435.326007380@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit 2a6bc713f1cef32e39e3c4e6f2e1a9849da6379c upstream.

On AEAD decryption authentication failure we are suppose to
zero out the output plaintext buffer. However, we've missed
skipping the optional associated data that may prefix the
ciphertext. This commit fixes this issue.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Fixes: e88b27c8eaa8 ("crypto: ccree - use std api sg_zero_buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_aead.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/ccree/cc_aead.c
+++ b/drivers/crypto/ccree/cc_aead.c
@@ -237,7 +237,7 @@ static void cc_aead_complete(struct devi
 			 * revealed the decrypted message --> zero its memory.
 			 */
 			sg_zero_buffer(areq->dst, sg_nents(areq->dst),
-				       areq->cryptlen, 0);
+				       areq->cryptlen, areq->assoclen);
 			err = -EBADMSG;
 		}
 	/*ENCRYPT*/


