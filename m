Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CDAC47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BCA521835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1b9Qc4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgEAUzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgEAUzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:55:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE33C061A0C;
        Fri,  1 May 2020 13:55:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so1082038wma.4;
        Fri, 01 May 2020 13:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LsgLAvGjFq7jRPIazMnBnD+SBBsUAuHEkZQoHgwkKaM=;
        b=j1b9Qc4UvahEcukTib502Bag9ZDRY3tJB02fr4hPyi8Smf/af7G/n2/jGN3X7IM6/w
         lbXvxHeZDp2WBsIZNeXnAvRgays9eVxBkF8QeohjF+JL394DwI5Vhri4Tyd+ZkH247Bt
         nmZx9aO8+YHQRM9ZIq/u8XOYD8B9HE/whN1U4IsyEY4DNNkYK4eCmsCAc9geqHmDPhW1
         q8NYbS34w4JISYAHh/d1CdXDxoYuSaMq1/WBdNmdazEsi5EwZ3v8GBg90U2FQsedAMiM
         vW6g09XsqNXp1rk7yQWFT9A1ypHTpzuL8uxpnFFgfssh37W7eqKI2miRhgEedhW2BgHC
         B2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LsgLAvGjFq7jRPIazMnBnD+SBBsUAuHEkZQoHgwkKaM=;
        b=Cy9sThBcVxrpR5nsGnE8qATRaf4ksIrBkP83r74Cwa1UB1Ej9KBHoUkVnuZdyxOABw
         CmLXG0bHY85FUfyVTc8TVd7Qa/FUSljrJo6UXbiYwBZsTqzuqZWb/v9bVxR4rAQerSdG
         PIS9pIsVFZhuvCCuPnSrvldojWxvDcZbEu7P+PFgwyoFiEv3kf8gWhdfMhnIvCu1LMCH
         Zg6smmOKWwmVIH4z7NQJ7D3F47RFi4rvCV3Wi5jLhUEWoAuwWzG5SEV6ccNID12yoUqf
         WGAMsJmkcVojg7Mn9edotvhFmJA2fu/bYYkBmV9xZsO6pX+iS6sxePl/qRqb0FHC+2GH
         L7/Q==
X-Gm-Message-State: AGi0Pub7yrQH2AEx282JOd0pXz3U/1yWKBXVrSRaXAI/6yIm3l9z8789
        YqtIuNAxhpJNlBzGcgM88bDGPg2ByA1leg==
X-Google-Smtp-Source: APiQypInuUJyC9ppT/hrUmfKzxNYICGRnmVnxMq1QYzVXIttt4Ms+mYwEf4TYIN0NLJAwOCfuK8v6w==
X-Received: by 2002:a1c:43c6:: with SMTP id q189mr1206554wma.115.1588366553479;
        Fri, 01 May 2020 13:55:53 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id d13sm996223wmb.39.2020.05.01.13.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:55:53 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: socinfo: add msm8936/39 and apq8036/39 soc ids
Date:   Fri,  1 May 2020 22:55:46 +0200
Message-Id: <20200501205546.151575-1-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Knecht <vincent.knecht@mailoo.org>

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 drivers/soc/qcom/socinfo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index ebb49aee179bb..14831ed392e28 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -188,6 +188,10 @@ static const struct soc_id soc_id[] = {
 	{ 216, "MSM8674PRO" },
 	{ 217, "MSM8974-AA" },
 	{ 218, "MSM8974-AB" },
+	{ 233, "MSM8936" },
+	{ 239, "MSM8939" },
+	{ 240, "APQ8036" },
+	{ 241, "APQ8039" },
 	{ 246, "MSM8996" },
 	{ 247, "APQ8016" },
 	{ 248, "MSM8216" },
-- 
2.26.1

