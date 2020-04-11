Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF51C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FF4206E9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586647197;
	bh=UB/WITbOLLqRVaT2oRzPuCdxNSA2y2uAPXWX9G1M8XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E3+AZCALbP5ZuFlfawSjLjuTRzywMmdomqdragL/zOVihf8txcTvErc9ZkEjXEk+A
	 vBq2ZJ+MQqzt1eGfo8GpcVEAfjFEavY61o858XiHXpr7y0+P/FdBZLlSA/6/8xKpae
	 a+12v7/qAuUN2f+1H2w/aJyNfvZH3FtIV2EXY774=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgDKXTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgDKXNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:13:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD29215A4;
        Sat, 11 Apr 2020 23:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646830;
        bh=UB/WITbOLLqRVaT2oRzPuCdxNSA2y2uAPXWX9G1M8XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUP2Bs2lz5xI4iVlUGa7jy2ey3CX4LAAurqtHDoo2ItPJr6KhgTUdqiIzwcLBkHf3
         kxhvfaK/bQKks8UvMCI5x3o3udDw3FpNPsb+UhPa8+70NRc/yKh1Ua25d0v3vJw46n
         /Wn3i/IJCWvPanpjGm30zF8OT48+XV1SqXzDIEB0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 20/37] crypto: tcrypt - fix printed skcipher [a]sync mode
Date:   Sat, 11 Apr 2020 19:13:09 -0400
Message-Id: <20200411231327.26550-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231327.26550-1-sashal@kernel.org>
References: <20200411231327.26550-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geantă <horia.geanta@nxp.com>

[ Upstream commit 8e3b7fd7ea554ccb1bdc596bfbcdaf56f7ab017c ]

When running tcrypt skcipher speed tests, logs contain things like:
testing speed of async ecb(des3_ede) (ecb(des3_ede-generic)) encryption
or:
testing speed of async ecb(aes) (ecb(aes-ce)) encryption

The algorithm implementations are sync, not async.
Fix this inaccuracy.

Fixes: 7166e589da5b6 ("crypto: tcrypt - Use skcipher")
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/tcrypt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index f7affe7cf0b47..9d9a9f5f2b9be 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -883,8 +883,8 @@ static void test_skcipher_speed(const char *algo, int enc, unsigned int secs,
 		return;
 	}
 
-	pr_info("\ntesting speed of async %s (%s) %s\n", algo,
-			get_driver_name(crypto_skcipher, tfm), e);
+	pr_info("\ntesting speed of %s %s (%s) %s\n", async ? "async" : "sync",
+		algo, get_driver_name(crypto_skcipher, tfm), e);
 
 	req = skcipher_request_alloc(tfm, GFP_KERNEL);
 	if (!req) {
-- 
2.20.1

