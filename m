Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8EAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA3620775
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="Sgn9TuqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgFHUpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgFHUoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:44:15 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B0C08C5C4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 13:44:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v79so18670491qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvr9NfP23GG58EcPnVqv8kY5eMqO/csy7v+VjkFmFa8=;
        b=Sgn9TuqZIjfhLOZy23ytoH3J7BhvoT31XK9/G9VMHs6nkOQ+zTHub7Au0KgS7zmPMZ
         KLMLWIACvee3eD/5yN8gD3jWXkb1wAgfxvqQHKoU2vEBSwQBb2Vo6I3fS8fnze54tqJT
         LnyE61cHBJYjJctCX4HUGo87UUs2OUUn82Tp1p4q6Y/tj+dT/u6CgMP+0bXTn7MMlkBk
         agQwpuIBeEprg7HV3zR7/yUVp1py7fcH3zldZP0zCjThKkf2VM6nbhrK7Qy/J4BSvyJv
         sbqQ55cxprjY9h947Z5WmYn7lI/oQl73rmn9JGEJZAGqSFe1F1RSvVDOmw2hgMoKJqk/
         YwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvr9NfP23GG58EcPnVqv8kY5eMqO/csy7v+VjkFmFa8=;
        b=WvMVQvnISMxaOJXZ9nGYtnHxm2raY4X0u0lfHJVqsEYxyToMUXkoYJh73fO8or5lDA
         icS8IrQXaHt21oLf8FGmi+ow5Glqxa25tA8lul/xGtFOv9tozx59yAS/1J2eKHPzelrR
         +g09NXRcgOzq+TdH4LXnIArWEeHVjfYgIc9CQuos2ZXWlez8vEvHB5ooamnv0tZKid4U
         68z3VTHCCH8Oo3yEdB63UG14XqOENKgJQz6uTJ0/OSignEHDUaxhVp8Jp1iYS5HvbfPR
         pY01G8klFW+1D9k/cmzL5u+hKndAN7nDW12ocTQDrpbuOcg+JH7e8KMpOXdht6bs683g
         XRaA==
X-Gm-Message-State: AOAM532jF/XKt45AAmk8J3TGYRudigW+KH/cOZTTjZgTO+DRWITch2nL
        1wdLIOeSp9Tb1QMEIvaQQzQo32Gy3Nk=
X-Google-Smtp-Source: ABdhPJwRnBMq8uQ6SZnA5t3+W1dY5KfhW+rUvHoY0ZFqRAUpsRl3443LXWlNkfL4jbqrfnKEqxi2qw==
X-Received: by 2002:a37:be43:: with SMTP id o64mr23549112qkf.322.1591649052223;
        Mon, 08 Jun 2020 13:44:12 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y16sm8895565qty.1.2020.06.08.13.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 13:44:11 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     alsa-devel@alsa-project.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] soundwire: qcom: fix abh/ahb typo
Date:   Mon,  8 Jun 2020 16:43:42 -0400
Message-Id: <20200608204347.19685-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200608204347.19685-1-jonathan@marek.ca>
References: <20200608204347.19685-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function name qcom_swrm_abh_reg_read should say ahb, fix that.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/soundwire/qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index a1c2a44a3b4d..f38d1fd3679f 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -114,7 +114,7 @@ struct qcom_swrm_ctrl {
 
 #define to_qcom_sdw(b)	container_of(b, struct qcom_swrm_ctrl, bus)
 
-static int qcom_swrm_abh_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
+static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
 				  u32 *val)
 {
 	struct regmap *wcd_regmap = ctrl->regmap;
@@ -754,7 +754,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (dev->parent->bus == &slimbus_bus) {
-		ctrl->reg_read = qcom_swrm_abh_reg_read;
+		ctrl->reg_read = qcom_swrm_ahb_reg_read;
 		ctrl->reg_write = qcom_swrm_ahb_reg_write;
 		ctrl->regmap = dev_get_regmap(dev->parent, NULL);
 		if (!ctrl->regmap)
-- 
2.26.1

