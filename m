Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B4EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB7F20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860217;
	bh=+x4BIgm+Rs6J0btz+KE1I3ThRuf5C+ViDg8xfrtN6jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WwqWwZaxgaRG6NtYjhynGHl/HG/hWr13Q0n+jtuWh2z0jaIS1N8r3lx9+9iAW5uTK
	 ynvi9G4ZRWQcXIg+SPQGhyG4i1LB19n5crPUUGWrTTD9GHs9ojhy4TIwhlb5SY6nOs
	 vDSCVqq9eTfDxACaUb49EFJ9h+i61LsG6UrNfntU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbgAXKDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:03:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388615AbgAXKDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:03:32 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73CCE214DB;
        Fri, 24 Jan 2020 10:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860212;
        bh=+x4BIgm+Rs6J0btz+KE1I3ThRuf5C+ViDg8xfrtN6jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7NiPxmjFfvnczKe/1pWVlX4wNCjgqr93c5QDV3NXm9RLrNVpyVcLCf+ZkC+vyOzJ
         /pEbYZGcfmvutQOfQ1bE1lqoEKhEV1DfQgO+JsxjQs5yXLQUormtLNK46WFn+3tixz
         YraRkswIQW4MceHSR3Z2dxX3XWnqlQM8tFT2naEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Iuliana Prodan <iuliana.prodan@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 268/343] crypto: caam - free resources in case caam_rng registration failed
Date:   Fri, 24 Jan 2020 10:31:26 +0100
Message-Id: <20200124092955.219167873@linuxfoundation.org>
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
index fde07d4ff0190..ff6718a11e9ec 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -353,7 +353,10 @@ static int __init caam_rng_init(void)
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



