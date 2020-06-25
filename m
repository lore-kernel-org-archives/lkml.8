Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C57C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB882076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCwrZoKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406625AbgFYTRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406557AbgFYTR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:17:27 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E6DC08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a6so7035800wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6KRQ2iJpwYa3qnjlJG4YmheyTfVRexZvMMMSKG/N/5M=;
        b=nCwrZoKDGyU62ArlORuxv6qQBsgl4YVcIUDL6rSD9Y7+e0cL12Hxyq10e0xvkTBGKb
         n6XrBFSKgWUvEx/76sDRUipmJOxN1Si4WqpO95vs96j8UykMdpHbay9F4C7R4brkwQD7
         2dZM09L43FHaxpA7wFsZrQP6QxaPspU2AAXOVG2bYrmKaQanMEz8DNR+cpTRinl5FrfV
         PTx2xeUi3h2Q2e+gNHA2EomT5FJoBvQesO6RIyJn7EZJPerABh02zlc9dae50ChU8jrK
         G5Qbck5qK2xe7uVHXh2KuoTHcnJ6ECDx+PYBhHQawUfhNZVSD8eo2tpKT2F64xbBXwvM
         cZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KRQ2iJpwYa3qnjlJG4YmheyTfVRexZvMMMSKG/N/5M=;
        b=AGLJVucd62FWLWkNHFgWUP9o3eIUFhLL0y4DlYS4c9aT5CRCaClvxcMGk3CK7vphjj
         /MdFk1wsCy+cUVVL3hbt56OFrmhAXO6ZP+ojNP90h5rlZkF364n77GY6U+NZsskHUZDY
         ThuFjobqaF2zjzAyGOLz+FtaaEOlumDjO0EeizaCHTQunSYv9aXCpgXACTVj89nmIyLX
         gE5ibLDx7sbWhmVxyn+wBXOsOyMe+60K6oaABJI4r/NanrL3H3VT1pk2BJThimx4LOEk
         6MywdsACXbO7BW8sbYEpj9XDyUkWATTkva1CiMwFxeBnk9Hx/sJChUQTLL2Ic0vf9vJy
         xKdg==
X-Gm-Message-State: AOAM530EiBGaRx987hkiwS62S133oJhGFIvq3MZlSgEWQH+l2kOL3/Ds
        v1UtrqPqw3BrJ3WA5GAq2z4hww==
X-Google-Smtp-Source: ABdhPJz9/MPIxJh8xZy057BUPDVzPUARP1XEN4i7iiDFKzDhVL1EwMddUZEaB9b7O/scLJTFbxgUGw==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr26668601wrn.143.1593112645638;
        Thu, 25 Jun 2020 12:17:25 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p13sm22693983wrn.0.2020.06.25.12.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:17:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RESEND 10/10] regulator: max14577-regulator: Demote kerneldoc header to standard comment
Date:   Thu, 25 Jun 2020 20:17:08 +0100
Message-Id: <20200625191708.4014533-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625191708.4014533-1-lee.jones@linaro.org>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing about this comment identifies it as a kerneldoc header.
It's missing all of it's function argument descriptions and the
correct function header.

Fixes the following W=1 warning(s):

 drivers/regulator/max14577-regulator.c:166: warning: Function parameter or member 'max14577' not described in 'max14577_get_regma
 drivers/regulator/max14577-regulator.c:166: warning: Function parameter or member 'reg_id' not described in 'max14577_get_regmap'

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/max14577-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index 07a150c9bbf22..e34face736f48 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -155,7 +155,7 @@ static const struct regulator_desc max77836_supported_regulators[] = {
 	[MAX77836_LDO2] = MAX77836_LDO_REG(2),
 };
 
-/**
+/*
  * Registers for regulators of max77836 use different I2C slave addresses so
  * different regmaps must be used for them.
  *
-- 
2.25.1

