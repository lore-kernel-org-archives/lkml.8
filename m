Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96502C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F4320787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3tIpl7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbgGVSOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVSOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:14:20 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7717EC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:14:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id z17so2352657edr.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RThPcly/jHnmJGOhuBZQDBDLJozqCS4adNNhKvYM4Mg=;
        b=B3tIpl7TcVNNRXBuZlga8XftggXq7bERUxzV260Fo9X43VhGO6VZRdWcUPOlTFHvd7
         kSpw3npLSuA0SyJ6bVVhduLTwnPqeCeeuUTd6D7nSJc1D8dLD6s6oaurlHq9DLPsYxzM
         atOy5pKERBUqD9sKNa2ypB5dD0j1YWxJu/Wr4Nm2MrW+TA7FFfLbPB0Z/R1SjZYn7wC5
         sfskxZ4FDUo/OKrA/xXnxd4nL45smGcElGi8Oz9QF39Hr7zTaygaaVaa1ZM39uGRH+j4
         Pj7mx4q5aXWt08ecF6UURZodhiL46pXRCYbFx+B9p987RWuhrAzj2ZjIeOtsU+GpBx0A
         PZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RThPcly/jHnmJGOhuBZQDBDLJozqCS4adNNhKvYM4Mg=;
        b=AJPQhNIDZqtvK61ZUBGCz4n2daA/nYX8asXrA3XTsBiKAnNOe/EM8ie1dQTBWQd6Xj
         OcuQTMeju8ROkFciensHx325gBqSvZZ0M5RCdw6zMzy1LlPKs+kKZOiR6ehXmu0hDvny
         kWwkBeWEGdrJ//uwntLl+eE7lK1zhRLJEgyT2lB1OgXAbQIrVMnOKZptcNaH938ELIaS
         zDFMUgtdb0RfkgnkzWKTSQEoimgcMpWEeJFSUZH7YyZEvwOtZM5BDEcnTsZo6b239LKs
         y4u/rl1TGQKCkyGPYihiARwRCQVqzfBRzQUzjhnLTvSHZL/DlXd6UCGOnkGNbC3zMXIu
         ZCuw==
X-Gm-Message-State: AOAM530y3dkSn9oBrJhXsBeju9bsdeCS1XLybd73OahbZgJFCmbT3Njb
        rdwPUPlC3agiHSijxnokEQ==
X-Google-Smtp-Source: ABdhPJw92ztJ/Nw8og4fgLjKEfKRszbcX6/RXPzIu2YBLzTwtDy6VFd45FxJ1Z76COkY76NtNEZ5JA==
X-Received: by 2002:a05:6402:1c10:: with SMTP id ck16mr738438edb.72.1595441659181;
        Wed, 22 Jul 2020 11:14:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id x64sm372954edc.95.2020.07.22.11.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:14:18 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner=20?= <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] drm: rockchip: add missing registers for RK3188
Date:   Wed, 22 Jul 2020 20:13:29 +0200
Message-Id: <20200722181332.26995-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722181332.26995-1-knaerzche@gmail.com>
References: <20200722181332.26995-1-knaerzche@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dither_up, dsp_lut_en and data_blank registers to enable their
respective functionality for RK3188's VOP.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

Changes in v2:
- drop the not yet upstreamed dsp_data_swap and rephrase the commit
  message according

 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index b046910129fb..a50877818a86 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -512,6 +512,9 @@ static const struct vop_common rk3188_common = {
 	.dither_down_en = VOP_REG(RK3188_DSP_CTRL0, 0x1, 11),
 	.dither_down_mode = VOP_REG(RK3188_DSP_CTRL0, 0x1, 10),
 	.dsp_blank = VOP_REG(RK3188_DSP_CTRL1, 0x3, 24),
+	.dither_up = VOP_REG(RK3188_DSP_CTRL0, 0x1, 9),
+	.dsp_lut_en = VOP_REG(RK3188_SYS_CTRL, 0x1, 28),
+	.data_blank = VOP_REG(RK3188_DSP_CTRL1, 0x1, 25),
 };
 
 static const struct vop_win_data rk3188_vop_win_data[] = {
-- 
2.17.1

