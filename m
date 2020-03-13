Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB05C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135732071C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce46Gaog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCMSzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:55:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41961 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMSzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:55:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id m25so13124241edq.8;
        Fri, 13 Mar 2020 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2WuB5xXMxFx8qoep56fRjLFlqqVLZxwUqYQw+OOizLU=;
        b=ce46Gaog+VC1RTePandT+0mydyECZ68AyAEipXfSJ+flhB83WpX1JM4fvvJPdSkobf
         rrFbfzCYSeP7PR6Z71nP/PqPL3J4d4yOug6SGogzhzuH1uqOIejw/GfdYaOwANPWoM9n
         2A2k5tj5BMVr9oVME2CkR+IE7GxdzrCg3pA1qXVPm9qxllP20gh51Zx7+pjsCP5gxe8N
         dFQmckYtfuikA+6RKRf/GrmiX9Io+uFTht9iieTybmJ1tjvVHfS/DyA9qCH2+guOwo7G
         +WGvBimSemWRtqCsy8xnBtpSH/rFZcChbVNWt/XBOlsfGO6qrhIbiR1Y4NU3UEh55Zw9
         Gyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2WuB5xXMxFx8qoep56fRjLFlqqVLZxwUqYQw+OOizLU=;
        b=pAm9EIZ8tBU+GR54uMbDU2t2wAgfYIk63U0lTqLRKTnaGxyJehG8JmaupYNlpJhXDq
         kNiKpD4jKZO1HJrbHywUI2/Cg1+6rsdC1EL0MFKo1qqCaLxjgT1hFkd2UxSuFGrJxVYn
         qbKg8YB3TN/a//eQ06Hp1LkqYVEfpUZ5OazhnifOOMcrrbPwa1GR2ebdLp4vJa+6+GEZ
         UAHlpaDGzVSEtaK2WBi/zzi2FWFZVoWxUveLACMtsQ9m1nKegxNiU7ayk2uejgu1IJuq
         WBF5Cj2cXBKlQygsfcYGf29FOKhhJKDjcQbL2IN6pNvyfnksNZiFHKdhrtNuUxV4nd/A
         LNyg==
X-Gm-Message-State: ANhLgQ3vv/3XVNE0sguxHjGN/8rttGl5b76VSM9pZdIskzcU2s9pFvkB
        xfnd9ka1NAG5NeCv2Grz4/s=
X-Google-Smtp-Source: ADFU+vuK7AU23b5J/6IMctVT/DI9hy1uvQ83h7z91tD7k0pf9nDNbJufUjhUG77sz7Dww8KUVWb6Uw==
X-Received: by 2002:a50:eb05:: with SMTP id y5mr14849321edp.358.1584125699097;
        Fri, 13 Mar 2020 11:54:59 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host61-50-dynamic.50-79-r.retail.telecomitalia.it. [79.50.50.61])
        by smtp.googlemail.com with ESMTPSA id p7sm468763ejr.62.2020.03.13.11.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 11:54:58 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     agross@kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipq806x: gcc: Added the enable regs and mask for PRNG
Date:   Fri, 13 Mar 2020 19:54:06 +0100
Message-Id: <20200313185406.10029-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel got hanged while reading from /dev/hwrng at the
time of PRNG clock enable

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index b0eee0903807..a8456e09c44d 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -1224,6 +1224,8 @@ static struct clk_rcg prng_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.clkr = {
+		.enable_reg = 0x2e80,
+		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "prng_src",
 			.parent_names = gcc_pxo_pll8,
-- 
2.25.0

