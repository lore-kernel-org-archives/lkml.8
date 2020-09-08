Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE37C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8492087C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599581818;
	bh=xxLuFjleyA9bTUO5ou9b/Lv3eXv+7nkOwhXd1J6behg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V7QfT7mGpnLCU9Yd9p26JsIBxM0YZhX9lvjBG1yk8FpA5PLy9R6zUEGPqXYw960V0
	 l+9rsRotwaXS9ll4E0laP/drvcA7QASYUHf2//lwBpuYYLXQcx7lBgpixrFLv3gcrd
	 bJmrejJIG83r8f0JlKD9T0H5VV/PTK0/xK8M8CJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbgIHQQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731245AbgIHQGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:06:06 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17ADA23D9A;
        Tue,  8 Sep 2020 15:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579990;
        bh=xxLuFjleyA9bTUO5ou9b/Lv3eXv+7nkOwhXd1J6behg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOPuip9kp0RFEddZguOBK/G/t+fzSmj3nI91vxEejejJvC9ay/fNk6KljfFl7ZAF9
         tFoogeQySB6ow1er+xWKLMTfoGbMVXxtcBkFmX9xWf2v/jAcc/hbffJrhKberQa2sZ
         s0ggEGsmzWuRDV7J6MknXU8Ip17Z9gzkoLrCyMPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 116/129] dm crypt: Initialize crypto wait structures
Date:   Tue,  8 Sep 2020 17:25:57 +0200
Message-Id: <20200908152235.654342705@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 7785a9e4c228db6d01086a52d5685cd7336a08b7 upstream.

Use the DECLARE_CRYPTO_WAIT() macro to properly initialize the crypto
wait structures declared on stack before their use with
crypto_wait_req().

Fixes: 39d13a1ac41d ("dm crypt: reuse eboiv skcipher for IV generation")
Fixes: bbb1658461ac ("dm crypt: Implement Elephant diffuser for Bitlocker compatibility")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-crypt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -720,7 +720,7 @@ static int crypt_iv_eboiv_gen(struct cry
 	u8 buf[MAX_CIPHER_BLOCKSIZE] __aligned(__alignof__(__le64));
 	struct skcipher_request *req;
 	struct scatterlist src, dst;
-	struct crypto_wait wait;
+	DECLARE_CRYPTO_WAIT(wait);
 	int err;
 
 	req = skcipher_request_alloc(any_tfm(cc), GFP_NOIO);


