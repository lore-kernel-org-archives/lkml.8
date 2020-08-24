Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB5EC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF53207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258188;
	bh=CiB2JlYzRRv4NoLy9qj+dbZcYvJL+2KWQ7TFKK68R+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNCvkw6J+7lrsz8j8rcMC02dDQ/f078OPjGGrlS7AxddEbMi7By7h7+6eUi5rPkgB
	 kz17shJ1w6pVNJS1rZkmNccvZsNgxm8HwA20edaTqa70jb/StIwNoszWG+mSidHj8s
	 pyRGlZBJxcKqZZ6JBW7wfGV7h38RF4uQlvmqmdQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgHXIg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgHXIgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:36:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34F89204FD;
        Mon, 24 Aug 2020 08:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258168;
        bh=CiB2JlYzRRv4NoLy9qj+dbZcYvJL+2KWQ7TFKK68R+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLXnjPZYlvDSqKrptPma0uA+3n7k7TVdtNw8uRZy4dWe0oOHckS7zG+xtPfR+6HAy
         MIbpIQpfoBhgwBvLKBrhtLjj7EXu+7xNuymiol4XnAM8gJ5trlKnc2R6xiTgIGMfkd
         r35Gil7M3PyWKxrtRVCh/n5/Qjm52NgCwvyqCsJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 100/148] ASoC: msm8916-wcd-analog: fix register Interrupt offset
Date:   Mon, 24 Aug 2020 10:29:58 +0200
Message-Id: <20200824082418.829268163@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit ff69c97ef84c9f7795adb49e9f07c9adcdd0c288 ]

For some reason interrupt set and clear register offsets are
not set correctly.
This patch corrects them!

Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20200811103452.20448-1-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 85bc7ae4d2671..26cf372ccda6f 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -19,8 +19,8 @@
 
 #define CDC_D_REVISION1			(0xf000)
 #define CDC_D_PERPH_SUBTYPE		(0xf005)
-#define CDC_D_INT_EN_SET		(0x015)
-#define CDC_D_INT_EN_CLR		(0x016)
+#define CDC_D_INT_EN_SET		(0xf015)
+#define CDC_D_INT_EN_CLR		(0xf016)
 #define MBHC_SWITCH_INT			BIT(7)
 #define MBHC_MIC_ELECTRICAL_INS_REM_DET	BIT(6)
 #define MBHC_BUTTON_PRESS_DET		BIT(5)
-- 
2.25.1



