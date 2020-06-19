Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9948EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F13021582
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580388;
	bh=lo+IN4r4Bg9TSjj4yw/aqNpns9X/UoYTuCNNSVl6eSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vQ/ldyu4XcB2xYlw6nsX4mCTMVJAGsk/0fMz51nHy0eOTnRbWjUFYAUTgEQpEpfEE
	 3Iac5QmokO8W/Bdh5M9UrjPLy5GZF7ZkGpZJAYPqNgCuX5VkDqEV6AZo/Ox/K5FFag
	 fhDpa2AD6kH68F+otCBiS/hg/UmPHZWHk8NTLuus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404314AbgFSP01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404065AbgFSPYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:24:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AB0F21582;
        Fri, 19 Jun 2020 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580253;
        bh=lo+IN4r4Bg9TSjj4yw/aqNpns9X/UoYTuCNNSVl6eSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=peN2ZInqgAp9zTrRPKpZ9j78YNPYg15LIL2d/09o/TGnqXJ1Udn61JdbbR/OZ2E2x
         t4qDqaZ54mp8wO2jzlOk3BiEz6OB5ogmCixkTNcrSTmC8obfzfveLT8YxEIh/0mfaC
         edAdatRelfm9S4Cy2WR5zVD2JrSV6Y2BdDhOjMW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 149/376] media: sun8i: Fix an error handling path in deinterlace_runtime_resume()
Date:   Fri, 19 Jun 2020 16:31:07 +0200
Message-Id: <20200619141717.381228374@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 62eedb356188376acd0368384a9b294d5180c00b ]

It is spurious to call 'clk_disable_unprepare()' when
'clk_prepare_enable()' has not been called yet.
Re-order the error handling path to avoid it.

Fixes: a4260ea49547 ("media: sun4i: Add H3 deinterlace driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil-cisco@xs4all.nl: err_exlusive_rate -> err_exclusive_rate]
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/sunxi/sun8i-di/sun8i-di.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
index d78f6593ddd1..ba5d07886607 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -941,7 +941,7 @@ static int deinterlace_runtime_resume(struct device *device)
 	if (ret) {
 		dev_err(dev->dev, "Failed to enable bus clock\n");
 
-		goto err_exlusive_rate;
+		goto err_exclusive_rate;
 	}
 
 	ret = clk_prepare_enable(dev->mod_clk);
@@ -969,14 +969,14 @@ static int deinterlace_runtime_resume(struct device *device)
 
 	return 0;
 
-err_exlusive_rate:
-	clk_rate_exclusive_put(dev->mod_clk);
 err_ram_clk:
 	clk_disable_unprepare(dev->ram_clk);
 err_mod_clk:
 	clk_disable_unprepare(dev->mod_clk);
 err_bus_clk:
 	clk_disable_unprepare(dev->bus_clk);
+err_exclusive_rate:
+	clk_rate_exclusive_put(dev->mod_clk);
 
 	return ret;
 }
-- 
2.25.1



