Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30576C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12F7246B4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196878;
	bh=i3bhFYQ73fcMOFo5nCQYc4SnP63kA5+9c/wcneZEyYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xdIQ6Ky7jtzjffKrkPROBK8NvALtbFjMq6zuvem//zxlH1F4sHCr82Dmscp9xewpG
	 CM8xrHW+UytLF6qynflqpHLQF+XZrW2ka4AP3JVBdItO7TwQUGlTm4QEGVUz/39a07
	 3YET4OX9dl3C89HbNKaezxfwdW8+AAemMZR1wGnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394290AbgAPRr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:47:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406779AbgAPRqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:46:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB82B246EA;
        Thu, 16 Jan 2020 17:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196804;
        bh=i3bhFYQ73fcMOFo5nCQYc4SnP63kA5+9c/wcneZEyYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oS3dHF+CLAQ11rzhl8gVpYW951l2zLB+xtNzGa08ZuWlmP4NfdB6HNrtN5BhAlRKi
         d2nIElPStTG3YfqM9ILLx6X0nhXxMiVYLbGB4yU0uj3dR5vHH1FytnK9bFZ5/pOaRe
         mSiBrtfHpNQKzwxjZ7YNz/X9xuHXYIlWiKdLlq0A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 163/174] regulator: ab8500: Remove SYSCLKREQ from enum ab8505_regulator_id
Date:   Thu, 16 Jan 2020 12:42:40 -0500
Message-Id: <20200116174251.24326-163-sashal@kernel.org>
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

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 458ea3ad033fc86e291712ce50cbe60c3428cf30 ]

Those regulators are not actually supported by the AB8500 regulator
driver. There is no ab8500_regulator_info for them and no entry in
ab8505_regulator_match.

As such, they cannot be registered successfully, and looking them
up in ab8505_regulator_match causes an out-of-bounds array read.

Fixes: 547f384f33db ("regulator: ab8500: add support for ab8505")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191106173125.14496-2-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/regulator/ab8500.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
index d8ecefaf63ca..6b8ec40af2c4 100644
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -44,8 +44,6 @@ enum ab8505_regulator_id {
 	AB8505_LDO_ANAMIC2,
 	AB8505_LDO_AUX8,
 	AB8505_LDO_ANA,
-	AB8505_SYSCLKREQ_2,
-	AB8505_SYSCLKREQ_4,
 	AB8505_NUM_REGULATORS,
 };
 
-- 
2.20.1

