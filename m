Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E321C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3945320718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859852;
	bh=KQwFnlFj/knXAB6kuN3/XLy7vseHLHLagofxE3P5t7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MS+0wp/NA4uiPcKSdn56U5fu+t8qAjDiLRCUI5C0xHzOxY+EBSbgTWLggxdco/4I1
	 AtOOfIQZastFDhfHHVLaOkbY/Ql0mCChuJ2ZZhww6q8oWhJLJNO1UuCilHARZB1y2N
	 lNmtEpp+kCzgtldefgvjtjGdUqHT9oaOjLLrpDL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbgAXJ5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:57:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730740AbgAXJ5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:57:30 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E6EE2075D;
        Fri, 24 Jan 2020 09:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859849;
        bh=KQwFnlFj/knXAB6kuN3/XLy7vseHLHLagofxE3P5t7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qiSO+apqtIF+iQdfjjHO6wM4u3ss3u5ZF2eUjjkFeL10ttwWLe1IRhdW43wq4Sn0n
         C7zrkdN6cXBK5p95mSoAXenDiP6z7AsxJ3JbdZm4bwFQLmTDlXepHQ93NeWstoaTjV
         Egn1J6A1K6zboWczmfzxEb31HjdHI06l5S6/QBPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Masney <masneyb@onstation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 208/343] backlight: lm3630a: Return 0 on success in update_status functions
Date:   Fri, 24 Jan 2020 10:30:26 +0100
Message-Id: <20200124092947.455394663@linuxfoundation.org>
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

From: Brian Masney <masneyb@onstation.org>

[ Upstream commit d3f48ec0954c6aac736ab21c34a35d7554409112 ]

lm3630a_bank_a_update_status() and lm3630a_bank_b_update_status()
both return the brightness value if the brightness was successfully
updated. Writing to these attributes via sysfs would cause a 'Bad
address' error to be returned. These functions should return 0 on
success, so let's change it to correct that error.

Fixes: 28e64a68a2ef ("backlight: lm3630: apply chip revision")
Signed-off-by: Brian Masney <masneyb@onstation.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3630a_bl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 2030a6b77a097..ef2553f452ca9 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -201,7 +201,7 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
 				      LM3630A_LEDA_ENABLE, LM3630A_LEDA_ENABLE);
 	if (ret < 0)
 		goto out_i2c_err;
-	return bl->props.brightness;
+	return 0;
 
 out_i2c_err:
 	dev_err(pchip->dev, "i2c failed to access\n");
@@ -278,7 +278,7 @@ static int lm3630a_bank_b_update_status(struct backlight_device *bl)
 				      LM3630A_LEDB_ENABLE, LM3630A_LEDB_ENABLE);
 	if (ret < 0)
 		goto out_i2c_err;
-	return bl->props.brightness;
+	return 0;
 
 out_i2c_err:
 	dev_err(pchip->dev, "i2c failed to access REG_CTRL\n");
-- 
2.20.1



