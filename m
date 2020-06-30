Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32271C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115FB20780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cSM7Pwgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgF3BLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 21:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgF3BLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 21:11:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CA8C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 18:11:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z7so20892836ybz.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 18:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3+Iq/MXOcbSUp/+nHtUzggFuUsgKGhG/vV+48k4w4OQ=;
        b=cSM7Pwgj28gdY5CA12KGe4fYcjvJzOjCGrwQ0AmXermj1tHfdZrsjUZJBsBx2GrEPY
         BA1q0mlnRFN2+jx1RR2i6CitfER/2t0HDTe1Ea6GnnnNQB5IPSRhOHNXqbwbNUPbT37f
         DzH8QBrP2sy/jsH6Tq37FKzFLDwvC2ffYWXdjs9u5G58B68x0mZp4+sRmtufEXeKXBvy
         E1cgWh7vGWO+Xo5ZffR5iH1Tnc5JVBb50PIy8cwDQ8SQP+y6sIPGW8hb40ECLqLLaRvZ
         5kqhGq8GSvG2uX3JOUsUesKCvX7hxtmpipPnOsbmzuHn50ZPZkki9Y7lI+siCFRkCevp
         Cbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3+Iq/MXOcbSUp/+nHtUzggFuUsgKGhG/vV+48k4w4OQ=;
        b=omvV9EkjibacTw1UY44qkWY/V0FhcuDG8h9FG30p3ZhNhseE0xuHWRllqXyd5SQBuS
         gsa7ZK0pcMaFbOvBS0sLC1s511ctEYFmdnZgHiLUQ7/wwqPWGvs1xNBcEDBhppEJj7Em
         u+t7b1n+Soea24sQiLTRARbieDX1E0Z5D6lxAxgPeUxmJQd9fJF3knZ/CAWxU5+gMd5H
         N5giJQhhPag9i2nqirq8X/xtyMSg1uhelG1w/JDFgnYhpl/5c3Llq8eQbSLgxpB4CilM
         Jd0oyGrkYkRxSBY8eT+FjCv+VjEB2RwBpJDUxlughjVgWMMIhTwNU0Khh8kQXzS/g32g
         Do5w==
X-Gm-Message-State: AOAM5310zc1csRD2Ao5h80s9oa4HTKZX3r/K27NXsOHq9NT4WpATpB/9
        RYZNj8q74h2J/jTRcGypC7CkXQ1g/VIj
X-Google-Smtp-Source: ABdhPJwHlV12J3jmhSgfapnwmVJEvCJRHQHW7Wzl8yg/D9C9h0zd6idlrSpzbckw9anZCATywg6aWVmQswSM
X-Received: by 2002:a25:b21e:: with SMTP id i30mr29661766ybj.35.1593479462230;
 Mon, 29 Jun 2020 18:11:02 -0700 (PDT)
Date:   Tue, 30 Jun 2020 11:10:51 +1000
Message-Id: <20200630111047.1.I05d781ac794389337a4adc2f6402f673117e2937@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] regulator: mt6397: Implement of_map_mode regulator_desc function
From:   Anand K Mistry <amistry@google.com>
To:     linux-mediatek@lists.infradead.org
Cc:     broonie@kernel.org, drinkcat@chromium.org,
        hsin-hsiung.wang@mediatek.com, Anand K Mistry <amistry@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without a of_map_mode implementation, the regulator-allowed-modes
devicetree field is skipped, and attempting to change the regulator mode
results in an error:
[    1.439165] vpca15: mode operation not allowed

Signed-off-by: Anand K Mistry <amistry@google.com>

---

 drivers/regulator/mt6397-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index 269c2a6028e8..5c60b52addf1 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -55,6 +55,7 @@ struct mt6397_regulator_info {
 		.vsel_mask = vosel_mask,				\
 		.enable_reg = enreg,					\
 		.enable_mask = BIT(0),					\
+		.of_map_mode = mt6397_map_mode,				\
 	},								\
 	.qi = BIT(13),							\
 	.vselon_reg = voselon,						\
@@ -146,6 +147,12 @@ static const unsigned int ldo_volt_table7[] = {
 	1300000, 1500000, 1800000, 2000000, 2500000, 2800000, 3000000, 3300000,
 };
 
+static unsigned int mt6397_map_mode(unsigned int mode)
+{
+	return mode == MT6397_BUCK_MODE_AUTO ?
+		REGULATOR_MODE_NORMAL : REGULATOR_MODE_FAST;
+}
+
 static int mt6397_regulator_set_mode(struct regulator_dev *rdev,
 				     unsigned int mode)
 {
-- 
2.27.0.212.ge8ba1cc988-goog

