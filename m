Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1442C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCE7206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467325;
	bh=pmR/0QLMadPzlQumAh7CF7ZTtI1d/law5OkmNEhUj1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tWm8N/mvddw+yBD15OmKERadmTg+t76QXN++jUg34MBmE7UT7FDF/RX96pLJtGQFA
	 ELpjUD4biSk+YMtYKd553NhjfcDKPifEQDO2Jr/5hAN6ZxjOvJn8aXyMYynsU3/39A
	 Rf9d4FVe4p3VYWM9RgP3vYJWOfluEvyZx1u4zhgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404316AbgF2Vsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgF2Sfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD98324760;
        Mon, 29 Jun 2020 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444078;
        bh=pmR/0QLMadPzlQumAh7CF7ZTtI1d/law5OkmNEhUj1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmi7aj/ky2EnLGqK6j/L3tWMe6Pkm1dsMnLIYHETohyEu3t5U8anqVKS00lrC2xKp
         G/7mC7JfpgN6rTvYH+ivp64p8ZUgrE3ikXEx8mFpdehAwsP0s5/KhBd6G6WbWS5UoE
         ja9Yc+uJuLWZFxW6k8jidk2j4X7Ow1FT6MC1S6BQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 187/265] hwrng: ks-sa - Fix runtime PM imbalance on error
Date:   Mon, 29 Jun 2020 11:17:00 -0400
Message-Id: <20200629151818.2493727-188-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 95459261c99f1621d90bc628c2a48e60b7cf9a88 ]

pm_runtime_get_sync() increments the runtime PM usage counter even
the call returns an error code. Thus a pairing decrement is needed
on the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/ks-sa-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/ks-sa-rng.c b/drivers/char/hw_random/ks-sa-rng.c
index e2330e757f1ff..001617033d6a2 100644
--- a/drivers/char/hw_random/ks-sa-rng.c
+++ b/drivers/char/hw_random/ks-sa-rng.c
@@ -244,6 +244,7 @@ static int ks_sa_rng_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable SA power-domain\n");
+		pm_runtime_put_noidle(dev);
 		pm_runtime_disable(dev);
 		return ret;
 	}
-- 
2.25.1

