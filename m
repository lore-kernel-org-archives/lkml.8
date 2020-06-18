Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EA8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13EF921D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442505;
	bh=dUtyJ0sPCHDAMrCFVYZk9Na/o7Im+6kdHi4WP4M/VJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yX9hs6ksdv6yn1V158Q9hB7/KbCuBODcGmu6xB91s5jsL8tIVn1qJAyJ9A+p7JXw3
	 5hOxW2S4oPSFZSy+FaKoVsMm6zm9H98RGsYH0rotyOz+1dIeQ8unLkBu8ZlzxEEoto
	 ATIbbXQh4jmP+xsqiTkWSuA6L9AhCWu1DqEH9Un4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgFRBIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgFRBIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:08:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3133B2193E;
        Thu, 18 Jun 2020 01:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442499;
        bh=dUtyJ0sPCHDAMrCFVYZk9Na/o7Im+6kdHi4WP4M/VJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5kHqYEx7ALMHmA1Q7w/SxOqgKu6OCo9zhGe5XRfSANQs3hpxKlnPpwclu62XYHb7
         r8/EMgRUFE9MU2bAJUpDpyBPxj8G8WjkGkgZNcKJx6FHxxfNU6UCjVgNqh+hidnbnM
         OTwMCTjDNkDb3Bfssj7sI5aV9AcDw+xNDkI2K65s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Elder <elder@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 010/388] remoteproc: Fix IDR initialisation in rproc_alloc()
Date:   Wed, 17 Jun 2020 21:01:47 -0400
Message-Id: <20200618010805.600873-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Elder <elder@linaro.org>

[ Upstream commit 6442df49400b466431979e7634849a464a5f1861 ]

If ida_simple_get() returns an error when called in rproc_alloc(),
put_device() is called to clean things up.  By this time the rproc
device type has been assigned, with rproc_type_release() as the
release function.

The first thing rproc_type_release() does is call:
    idr_destroy(&rproc->notifyids);

But at the time the ida_simple_get() call is made, the notifyids
field in the remoteproc structure has not been initialized.

I'm not actually sure this case causes an observable problem, but
it's incorrect.  Fix this by initializing the notifyids field before
calling ida_simple_get() in rproc_alloc().

Fixes: b5ab5e24e960 ("remoteproc: maintain a generic child device for each rproc")
Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suman Anna <s-anna@ti.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20200415204858.2448-2-mathieu.poirier@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/remoteproc_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index be15aace9b3c..8f79cfd2e467 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2053,6 +2053,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	rproc->dev.type = &rproc_type;
 	rproc->dev.class = &rproc_class;
 	rproc->dev.driver_data = rproc;
+	idr_init(&rproc->notifyids);
 
 	/* Assign a unique device index and name */
 	rproc->index = ida_simple_get(&rproc_dev_index, 0, 0, GFP_KERNEL);
@@ -2078,8 +2079,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 
 	mutex_init(&rproc->lock);
 
-	idr_init(&rproc->notifyids);
-
 	INIT_LIST_HEAD(&rproc->carveouts);
 	INIT_LIST_HEAD(&rproc->mappings);
 	INIT_LIST_HEAD(&rproc->traces);
-- 
2.25.1

