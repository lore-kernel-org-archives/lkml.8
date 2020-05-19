Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E799C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20182207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWSz0BBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgESSVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgESSVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:21:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC402C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:21:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ci21so47293pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b52A7vD+RR088Jsg7MbGhWVJbszSlF+rCVUgMjj+kMs=;
        b=vWSz0BBOdzlZR3rjV4RVeNr/tSysik77xL++h89DZQuWbl/uK/LiTCvupqnojGgoWG
         523FmT5ugUWk8LxKFBale9tvHpL4kaz1mVkqFZR+szr6J0G7mrp5sIdFJryzMEzR/N7U
         ZOmTlh89BqpPuJ9CqdMtJvPp/E3ba5BcZrFJNUfR6/jE3j1bXQzaJ+I8YLU0WVBT8OZA
         Yl1wNF1GShuriWr4x4bc8AL54sAVUvnJ2QCiWwpXgPi/25+uJMYYnnXkJR+wtBbC9ISE
         Oqak0vA7BCVLpaoczJyD9bLmYI4bdtlPP8BBNuhIdOrSs2MTROi0pj9p+63HBpNLOTOo
         74aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b52A7vD+RR088Jsg7MbGhWVJbszSlF+rCVUgMjj+kMs=;
        b=VwmLxkCa95sUUCc+GoK4pz4Sf/X6yDvTsnraKNp6j+KIp64IRfbZFbnebuFeWD0xGI
         1NcUcS/SztaOWlivB2fKHzaipbeiPzT2fcH7eIsW+Oiw24DDASnzPZmTPulatvblc5Hj
         bjgDFq5G7TdVghd/RIo+kBW5yEoMWdyQk3/9MBF3+hwSYNQnuP3B0Meh5k/WZYCxpvHj
         RHw9T4B5qmHRzT0+a5YjkIy1htOUx36jjN9HvK+fvlK9URfQaKqf3NGxS+1T0+65wVNX
         2dhvZnULAkiUpQuVUrAO4qwiWYDAybldiVi/kRIvSJ6OjRw3coNdinuej+hkH7KRfDEI
         mSHQ==
X-Gm-Message-State: AOAM531NRpcsWtt+ps6yna9LQ+Fhy/cLeVI5SamEVivZpsSOzuR4RJb5
        q41h+eTuLmJkg483dH1Pl8s=
X-Google-Smtp-Source: ABdhPJws2U/VxXLXMna/NvEGpbIbjledu6ue4XKhF7XHouk2PIjlxarxjV0y9Pn0hcVd8HOR0tuCPw==
X-Received: by 2002:a17:902:a584:: with SMTP id az4mr707797plb.201.1589912501372;
        Tue, 19 May 2020 11:21:41 -0700 (PDT)
Received: from localhost.localdomain ([223.235.145.232])
        by smtp.gmail.com with ESMTPSA id p2sm148399pgh.25.2020.05.19.11.21.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 11:21:40 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, sboyd@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v2 03/10] clk: actions: Add MMC clock-register reset bits
Date:   Tue, 19 May 2020 23:49:21 +0530
Message-Id: <1589912368-480-4-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
References: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds reset bits needed for MMC clock registers present
on Actions S700 SoC.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes from v1:
        * No change.
Changes from RFC:
        * No change.
---
 drivers/clk/actions/owl-s700.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
index a2f34d13fb54..cd60eca7727d 100644
--- a/drivers/clk/actions/owl-s700.c
+++ b/drivers/clk/actions/owl-s700.c
@@ -577,6 +577,9 @@ static const struct owl_reset_map s700_resets[] = {
 	[RESET_DSI]	= { CMU_DEVRST0, BIT(2) },
 	[RESET_CSI]	= { CMU_DEVRST0, BIT(13) },
 	[RESET_SI]	= { CMU_DEVRST0, BIT(14) },
+	[RESET_SD0]     = { CMU_DEVRST0, BIT(22) },
+	[RESET_SD1]     = { CMU_DEVRST0, BIT(23) },
+	[RESET_SD2]     = { CMU_DEVRST0, BIT(24) },
 	[RESET_I2C0]	= { CMU_DEVRST1, BIT(0) },
 	[RESET_I2C1]	= { CMU_DEVRST1, BIT(1) },
 	[RESET_I2C2]	= { CMU_DEVRST1, BIT(2) },
-- 
2.7.4

