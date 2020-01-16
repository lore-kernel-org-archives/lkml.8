Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747CFC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF6F208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579192995;
	bh=Zzz6m6m3/AUqY4n8sfeAOpYqz2PzTvmTHYFzD/sVSTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=byHv2b96V/rOA2f+nmdxUFTyNfMSAq352Hbr8CCUQGlTH0YSBHNKBwGAK7gj+ZgiS
	 bgzyz/OCJg0GBqfNSw6VyaGkEggtqKNQepYuw0A51uteEj7Ofd4nP30GUiFfql0mRl
	 y/zblqOGnTpNzqBPGaekaeR3lVgJzv61KOiVIoJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAPQnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgAPQnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:43:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42AB207FF;
        Thu, 16 Jan 2020 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579192993;
        bh=Zzz6m6m3/AUqY4n8sfeAOpYqz2PzTvmTHYFzD/sVSTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sJjGqVqFbr6vsH1C/nok30VPfZCFhV1FSmh3CQhMAPU0kH0cP9iyADRgpm5bmdNtU
         gkg40EIYMO1U6RWWkr6I9zyqAftjp9wHexw/wL+LvmnTriHpdipKmbQQ0MGKJ4PrD+
         Fe6UBbvJCkIQUzJxufrFakid544NCXO5EmKuZlmQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steven Price <steven.price@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 002/205] drm/panfrost: Add missing check for pfdev->regulator
Date:   Thu, 16 Jan 2020 11:39:37 -0500
Message-Id: <20200116164300.6705-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Price <steven.price@arm.com>

[ Upstream commit 52282163dfa651849e905886845bcf6850dd83c2 ]

When modifying panfrost_devfreq_target() to support a device without a
regulator defined I missed the check on the error path. Let's add it.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: e21dd290881b ("drm/panfrost: Enable devfreq to work without regulator")
Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190822093218.26014-1-steven.price@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 12ff77dacc95..c1eb8cfe6aeb 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -53,8 +53,10 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 	if (err) {
 		dev_err(dev, "Cannot set frequency %lu (%d)\n", target_rate,
 			err);
-		regulator_set_voltage(pfdev->regulator, pfdev->devfreq.cur_volt,
-				      pfdev->devfreq.cur_volt);
+		if (pfdev->regulator)
+			regulator_set_voltage(pfdev->regulator,
+					      pfdev->devfreq.cur_volt,
+					      pfdev->devfreq.cur_volt);
 		return err;
 	}
 
-- 
2.20.1

