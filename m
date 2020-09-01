Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D8EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C773C206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979388;
	bh=RA20fT0TwJ5xJ395cUD+YGIQN+UL6HpyNW/jNAwOTuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XoNXBP7OdTWMbu2hjPIaWVUpab2jS3nVjarWgMFFPKKIqr0IjxEc/GvuYcq6ahH4l
	 azaM3Q2rAzi258iYymiJ5R1d9isUsZHMSDFjer2ovIYBpbDAcsOhGU5Wjl3CjbCk7F
	 4BDkaYwpr8WM/x5MinOLdlCSacs8RG+XOCcUQwvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgIAPXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729466AbgIAPVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:21:37 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D894021534;
        Tue,  1 Sep 2020 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973697;
        bh=RA20fT0TwJ5xJ395cUD+YGIQN+UL6HpyNW/jNAwOTuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFiPyhp5eF2Lpew8OEi3kjdeIx6Tlvz02/fvRyVmv3ghUNfQ+unHXWOfnyk8wMgx4
         0jVJAn9TJkZnvhmJcGYtkTx5i/Fsro4wkJvZABYLPrnP3Qk7/i8RIcK5ZUzfsjRweA
         sCR1ei48kUbxxe8CvevLypmJbWqlRHFTMe+5p0Oc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 011/125] ASoC: img-parallel-out: Fix a reference count leak
Date:   Tue,  1 Sep 2020 17:09:26 +0200
Message-Id: <20200901150935.141848328@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit 6b9fbb073636906eee9fe4d4c05a4f445b9e2a23 ]

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, causing incorrect ref count if
pm_runtime_put_noidle() is not called in error handling paths.
Thus call pm_runtime_put_noidle() if pm_runtime_get_sync() fails.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Link: https://lore.kernel.org/r/20200614033344.1814-1-wu000273@umn.edu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/img/img-parallel-out.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/img/img-parallel-out.c b/sound/soc/img/img-parallel-out.c
index acc005217be06..f56752662b199 100644
--- a/sound/soc/img/img-parallel-out.c
+++ b/sound/soc/img/img-parallel-out.c
@@ -166,8 +166,10 @@ static int img_prl_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	ret = pm_runtime_get_sync(prl->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(prl->dev);
 		return ret;
+	}
 
 	reg = img_prl_out_readl(prl, IMG_PRL_OUT_CTL);
 	reg = (reg & ~IMG_PRL_OUT_CTL_EDGE_MASK) | control_set;
-- 
2.25.1



