Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E84C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363E82077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197048;
	bh=OPa98pr8229ebjPXj4IhS5LOxf8G/Y4/ZXRc9zvSDi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FSIU6XsXDe8vk8964oQbCwZVRf3vSXjpJsMqk4NxZRvQtl3gGiFj4hEU9bLTfFBM7
	 iETnCnWpensLvR2RrlzgxGuW4+QpJxYxefLVMEwmsJMPf+wRUpAYZ59Q1GsAx8bZI1
	 Gr9mVO1lsoWCGafIU5HvGEniO+OwOgAf7NRg9Pgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394583AbgAPRur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:50:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406039AbgAPRph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:45:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 474E924781;
        Thu, 16 Jan 2020 17:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196736;
        bh=OPa98pr8229ebjPXj4IhS5LOxf8G/Y4/ZXRc9zvSDi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LvJ2aYs9sfbWJS1qOY+xN4Aze/acYGFDkaFSbhR7HcuiBi7BSF66joNRVT6ZqUzgx
         McvWN/9i4qVn5QxXWUDoO0g19iFDbRiAc8o0Ym/nDSXKlns3dfHAiiA0qanufjSYGG
         4GIRnru4LE1tiiwsWlf1Fi2NwOUp0Od9d+n19Q0s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 118/174] crypto: caam - free resources in case caam_rng registration failed
Date:   Thu, 16 Jan 2020 12:41:55 -0500
Message-Id: <20200116174251.24326-118-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

[ Upstream commit c59a1d41672a89b5cac49db1a472ff889e35a2d2 ]

Check the return value of the hardware registration for caam_rng and free
resources in case of failure.

Fixes: e24f7c9e87d4 ("crypto: caam - hwrng support")
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/caam/caamrng.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index 9b92af2c7241..a77319bf221d 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -361,7 +361,10 @@ static int __init caam_rng_init(void)
 		goto free_rng_ctx;
 
 	dev_info(dev, "registering rng-caam\n");
-	return hwrng_register(&caam_rng);
+
+	err = hwrng_register(&caam_rng);
+	if (!err)
+		return err;
 
 free_rng_ctx:
 	kfree(rng_ctx);
-- 
2.20.1

