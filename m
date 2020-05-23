Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62286C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 03:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C99204EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 03:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jicZvPr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbgEWDu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 23:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387540AbgEWDu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 23:50:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3179C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 20:50:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e11so5132042pfn.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 20:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPafhH9pnJaTqstx2UvGSdDHFfhLmyPCCnvVrZ2DidM=;
        b=jicZvPr0SoeIUl4JxC5OBdgpKchxt9qYT873yS6tIpQ6a96t9AcmsRXb7WokzdGKGr
         sRmBdQzO7cwnkzWIv0228SkHyNoJQx7vjS59hTpYUieeXdqUn2UKvDJTOGNGM9pYU4eh
         kvDDtmxRZ7g3ovM6se1HlB76g/f9HMod9N3kjdlSE6QVldS8RmtG8sRM1NFx8xO9l5YA
         dx6aUHyjKPrS7iebbf0E4a0k+65rmHf6jK4Zj7SI23LR7Fc3ir8+5XW1nKbyg3B/Hwpi
         uXdXzwsnQzEQyMOHOebYkQnvzBj750en6d2wZpBR1G1aup2DjB8YL6GAPepAsBK6lktZ
         68dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPafhH9pnJaTqstx2UvGSdDHFfhLmyPCCnvVrZ2DidM=;
        b=iwU3x6pNdsMCHeDEBWKj0H8tREwUBjLchlgRZbfeojR0ib8HQIkFX/iRiBqogdl3Kg
         dv2VFDPHviwwFE/bX0qqX83Ibwkf4yUYTy8BEMpZ7MI8832lsRsTp/UFatgeMeRnZc4N
         XkRVtn1JfrZr7z2kMGi3wTwgNK9pLwHdQJxTHXkGo5zchG+tOF/vhcmOmkA+WiAe9wl1
         fM/dbVog0WWABjdgEEpNXjGaBW7SVxapAVNFKkvQUss9l2KSXniXQm9QSMEzWCtVNd+l
         Pz9Gz1xVcxcKvXbOPddlnmVLfU1Z6+fFcZHwAxCDwQcIeVOk7kdYpA5p7pX/x+4eJ6v4
         zf1Q==
X-Gm-Message-State: AOAM532qwXKDsnBYnVHH4Sq20MXCuTKvNqsYuV83IVkBa+d4zYMfLXwA
        LKYv6F7NBTwxc9KF3JnU/BQ=
X-Google-Smtp-Source: ABdhPJxTWDo7li/tipVSzpOG0m+rTPXb+P1lgnDWZ9lsZOiiVm34jsZ56FQfYk6HasZllfTQdLSd7Q==
X-Received: by 2002:a63:5a07:: with SMTP id o7mr16785320pgb.450.1590205857912;
        Fri, 22 May 2020 20:50:57 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id e1sm7805171pjv.54.2020.05.22.20.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 20:50:57 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] phy: intel: Eliminate unnecessary assignment in intel_cbphy_set_mode
Date:   Fri, 22 May 2020 20:50:43 -0700
Message-Id: <20200523035043.3305846-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/phy/intel/phy-intel-combo.c:202:34: warning: implicit conversion
from enumeration type 'enum intel_phy_mode' to different enumeration
type 'enum intel_combo_mode' [-Wenum-conversion]
        enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
                              ~~~~~~~   ^~~~~~~~~~~~~
1 warning generated.

The correct enum to use would be PCIE0_PCIE1_MODE. However, eliminating
this assignment is a little better because the switch statement always
assigns a new value to cb_mode, which also takes care of the warning.

Fixes: ac0a95a3ea78 ("phy: intel: Add driver support for ComboPhy")
Link: https://github.com/ClangBuiltLinux/linux/issues/1034
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/phy/intel/phy-intel-combo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
index c2a35be4cdfb..4bc1276ecf23 100644
--- a/drivers/phy/intel/phy-intel-combo.c
+++ b/drivers/phy/intel/phy-intel-combo.c
@@ -199,9 +199,9 @@ static int intel_cbphy_pcie_dis_pad_refclk(struct intel_cbphy_iphy *iphy)
 
 static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
 {
-	enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
 	enum aggregated_mode aggr = cbphy->aggr_mode;
 	struct device *dev = cbphy->dev;
+	enum intel_combo_mode cb_mode;
 	enum intel_phy_mode mode;
 	int ret;
 

base-commit: c11d28ab4a691736e30b49813fb801847bd44e83
-- 
2.27.0.rc0

