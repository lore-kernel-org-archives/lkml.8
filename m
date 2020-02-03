Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5CEC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2EE2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wasqs3eQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgBCSdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:33:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37977 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbgBCScP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:32:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so8258460pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgteBj9kECksIDTJrgniP2446O1fnhyCOGN0Ivx+enM=;
        b=Wasqs3eQqUzCosW2InB859U3pOvbe38Hb1XgxdLpg6eoIZdzcG1bmQE2AkHc/hD56S
         skYrU9/Iz0iHIwxBM896C1cPiba1pe/l33EBfXbzaovXELHSeSoE0WG1x5UfI+GdVv6r
         qBlhIePFzl/Daj1DGeuKd6ey0dTb9aO3yY33I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgteBj9kECksIDTJrgniP2446O1fnhyCOGN0Ivx+enM=;
        b=InKJpEw2h2Ah6HfJsHA4H1u+2lQHlB3KOnXxS7/djTKvnTnUi58n3srcdsiZ/ByfjA
         IUV9vVHxMQLCoPvG72iJr3u38ceObI0pRJd1FK1ax/qBwehXqKZ62kxAQLyFyPpdVnE9
         hTfbFNyROo8PSSbLxZPiHz+Zo/LdbBZzol3RqLJoM/CSDA0Natp134UC8uIYr10HjfrZ
         NpAAQZXqvYtshyD4eeSImtgrAHPZD6tgJLvNyjap6fDQzaxEuHQitvChOiVhusuGtIJ+
         HdePLsTagF+dGyAPlNnNrJcWPq3CmDAWMpkLfZzdUVQqZ0I3InE9KPMEfRj3T1OHe3tc
         QZ4g==
X-Gm-Message-State: APjAAAVqSVT4DA03fjnIAs9UaxGj4nfASFBnejh3N8LPOxmJfuAroAFo
        jVBbscMMIfnTFJg5mRH2gvrgow==
X-Google-Smtp-Source: APXvYqzvauFbriTETiUnafbrlgvwI/wPoIrVw6ombXysZj6zY/10IZRZSdiVV5V0bmXbBDeIPjRjjw==
X-Received: by 2002:a63:511:: with SMTP id 17mr4524461pgf.221.1580754734404;
        Mon, 03 Feb 2020 10:32:14 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f9sm21009137pfd.141.2020.02.03.10.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:32:13 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, jeffrey.l.hugo@gmail.com,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        devicetree@vger.kernel.org, mka@chromium.org,
        kalyan_t@codeaurora.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, hoegsberg@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/15] clk: qcom: rcg2: Don't crash if our parent can't be found; return an error
Date:   Mon,  3 Feb 2020 10:31:34 -0800
Message-Id: <20200203103049.v4.1.I7487325fe8e701a68a07d3be8a6a4b571eca9cfa@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200203183149.73842-1-dianders@chromium.org>
References: <20200203183149.73842-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I got my clock parenting slightly wrong I ended up with a crash
that looked like this:

  Unable to handle kernel NULL pointer dereference at virtual
  address 0000000000000000
  ...
  pc : clk_hw_get_rate+0x14/0x44
  ...
  Call trace:
   clk_hw_get_rate+0x14/0x44
   _freq_tbl_determine_rate+0x94/0xfc
   clk_rcg2_determine_rate+0x2c/0x38
   clk_core_determine_round_nolock+0x4c/0x88
   clk_core_round_rate_nolock+0x6c/0xa8
   clk_core_round_rate_nolock+0x9c/0xa8
   clk_core_set_rate_nolock+0x70/0x180
   clk_set_rate+0x3c/0x6c
   of_clk_set_defaults+0x254/0x360
   platform_drv_probe+0x28/0xb0
   really_probe+0x120/0x2dc
   driver_probe_device+0x64/0xfc
   device_driver_attach+0x4c/0x6c
   __driver_attach+0xac/0xc0
   bus_for_each_dev+0x84/0xcc
   driver_attach+0x2c/0x38
   bus_add_driver+0xfc/0x1d0
   driver_register+0x64/0xf8
   __platform_driver_register+0x4c/0x58
   msm_drm_register+0x5c/0x60
   ...

It turned out that clk_hw_get_parent_by_index() was returning NULL and
we weren't checking.  Let's check it so that we don't crash.

Fixes: ac269395cdd8 ("clk: qcom: Convert to clk_hw based provider APIs")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
I haven't gone back and tried to reproduce this same crash on older
kernels, but I'll put the blame on commit ac269395cdd8 ("clk: qcom:
Convert to clk_hw based provider APIs").  Before that if we got a NULL
parent back it was fine and dandy since a NULL "struct clk" is valid
to use but a NULL "struct clk_hw" is not.

Changes in v4: None
Changes in v3:
- Add Matthias tag.

Changes in v2:
- Patch ("clk: qcom: rcg2: Don't crash...") new for v2.

 drivers/clk/qcom/clk-rcg2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index da045b200def..9098001ac805 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -218,6 +218,9 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 
 	clk_flags = clk_hw_get_flags(hw);
 	p = clk_hw_get_parent_by_index(hw, index);
+	if (!p)
+		return -EINVAL;
+
 	if (clk_flags & CLK_SET_RATE_PARENT) {
 		rate = f->freq;
 		if (f->pre_div) {
-- 
2.25.0.341.g760bfbb309-goog

