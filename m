Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC245C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8416A2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHkQ9kbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgHZJgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgHZJfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:35:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAAEC061365
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d10so174529wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xmeKWj6ihDtxXg7mmV0g02PkzMbJUwVy4vUADq1jq3Y=;
        b=lHkQ9kbI4YiHrMG+5c1O2DA0EUdgjZyvLmV+8YExFcXi1gdFNdZna7wI1C7eYgwRYz
         9Xk1+KxSEYrXF/zIdSTSg24AIl/kZzSC8uzCISjmVpPb5WPvkYGGet2Msnt5AYRohb/9
         tdTLogHLdCjhAebO1xjCBX6weShNPfIwXefOeUNOsk4XydWW3Dg3BLWF1dKUkFyUxjFH
         89+MNPaKS6ACrOuzatrjQoAYZCgN2RoMGXmYGEZ8aYPqTCfAjVCfkJdUGw7QdeinfKnR
         fQiS/5nY5m8XV04zepMGobk9n7MVwie/ajSLslD2eTM/u2MZs63wJfpm38MbNLDGKajP
         esjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xmeKWj6ihDtxXg7mmV0g02PkzMbJUwVy4vUADq1jq3Y=;
        b=J7mhI5cp2AElN60DnjsGmpUy+/PahQKEV/Pr6+0IptaJEkDituHOW9/wK/5heiBtQe
         4kmyvvaQ0cOBmgslEfFG3C6PiuHzadpArbN+GyibH7991lOvX2EUIgHnUfVmPEDrCVb7
         hANg/FyIsuGHklHrOa4H/AUL+vGCUFeMkiniz9jXpcZ0Tyd9oIzRmUiC17gUylw0wdVS
         sxNZ75tY0hS58BPE+NYVgUk151y8/JeavMk5fHdVJcbwx5HpJz2ON+spOGMp3kS4BFto
         LXFDQJH/I3YE0+CbhmMbZaOozVghT7NyMzIezhzrqUNvWu/2FP1QYlzYXQ7MoG8iR9q+
         G20g==
X-Gm-Message-State: AOAM530sr9Fid/IIczZ/L6rGIFLgVm5dMzEqPSW3t7hd6qbymECadj73
        sK1JrFK6o389zBg0JGCULsiVjA==
X-Google-Smtp-Source: ABdhPJysAlZ5GN6k56EGB8IkpZjoW4o5OuDOadTyLk2UwIoJAbWs4p5DNd4oDWJVopFCUT4nSOwAVg==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr477311wrr.105.1598434480972;
        Wed, 26 Aug 2020 02:34:40 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Subject: [PATCH 29/30] wireless: broadcom: brcm80211: phytbl_lcn: Remove unused array 'dot11lcnphytbl_rx_gain_info_rev1'
Date:   Wed, 26 Aug 2020 10:34:00 +0100
Message-Id: <20200826093401.1458456-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c:1510:33: warning: ‘dot11lcnphytbl_rx_gain_info_rev1’ defined but not used [-Wunused-const-variable=]

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211-dev-list@cypress.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c
index be703be34616a..7526aa441de11 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c
@@ -1507,19 +1507,6 @@ const struct phytbl_info dot11lcnphytbl_rx_gain_info_rev0[] = {
 	,
 };
 
-static const struct phytbl_info dot11lcnphytbl_rx_gain_info_rev1[] = {
-	{&dot11lcn_gain_tbl_rev1,
-	 ARRAY_SIZE(dot11lcn_gain_tbl_rev1), 18,
-	 0, 32}
-	,
-	{&dot11lcn_aux_gain_idx_tbl_rev0,
-	 ARRAY_SIZE(dot11lcn_aux_gain_idx_tbl_rev0), 14, 0, 16}
-	,
-	{&dot11lcn_gain_idx_tbl_rev0,
-	 ARRAY_SIZE(dot11lcn_gain_idx_tbl_rev0), 13, 0, 32}
-	,
-};
-
 const struct phytbl_info dot11lcnphytbl_rx_gain_info_2G_rev2[] = {
 	{&dot11lcn_gain_tbl_2G,
 	 ARRAY_SIZE(dot11lcn_gain_tbl_2G), 18, 0,
-- 
2.25.1

