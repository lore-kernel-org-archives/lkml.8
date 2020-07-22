Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9383AC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D99E2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GPVhp3NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbgGVWBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgGVWBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:01:24 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D2FC0619E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:01:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d7so1634809plq.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kf4G9OecuatMPdQAajjbtHZg6Z4TN34pDB2QVj3Jfws=;
        b=GPVhp3NGJ19wf1ctURm4g+w3dBSbio1bGMroejrll7ayIS2Q6mitp1XXu92TJA2Jgj
         IN1hNbxl8IeAKe2gdCvYw4pNo6F0E/bMfhMfz7kJzxFdImVkqUM4CCuKZ32g7HBylXO5
         NgOlYSDD0SRuMJy60oyVH0BTPnJ0vphFIOFoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kf4G9OecuatMPdQAajjbtHZg6Z4TN34pDB2QVj3Jfws=;
        b=LWnZCO4wr3s7S9N9LRTiWgDDKi0hPsRiYQ/tGhjuIKYnT07C6z5v5mpR70i4QkI5HT
         5mXZUOiSG16EAgwo+z0ob1uqs8P/AVJA2BV4fV/KPjW0lauKcod0lgWfS4VD/lLCS4im
         s5QpQ1rhC0L7GCEDhP6NmZOwcmfbki+0DZ6osKNVqcZJvs60HCJawdpKUi40LpXYEQCq
         y0lQwwrg22Bs3m/riHm5lRxGRG/c1g8UJLNs/OWnmOFHU+KND/ksNCMfNNq4qgLEV34z
         wux/TVR6UkH/PnZlbV+94iV+Auzb3/DOgT/CR86GCNGDWm8cRiBjjj0npgO/Dd3IRLiC
         9b0w==
X-Gm-Message-State: AOAM533HRNKOSMCasMFvptsZemMMItbvHnGv/UqyUlNm+B+CZ450IPsf
        dCpggiK9Asuto5DItfYYrkoFzQ==
X-Google-Smtp-Source: ABdhPJycqu6mq0CFbV5ri7ojMQiC9BlaOqdNq6tqaC5IOPjIpz1Or40LqD5+CBCdwb8DcHUtsvqq/Q==
X-Received: by 2002:a17:902:bd47:: with SMTP id b7mr1342798plx.144.1595455283992;
        Wed, 22 Jul 2020 15:01:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id g7sm562035pfh.210.2020.07.22.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 15:01:23 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Wolfram Sang <wsa@the-dreams.de>, msavaliy@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom-geni-se: Don't use relaxed writes when writing commands
Date:   Wed, 22 Jul 2020 15:01:20 -0700
Message-Id: <20200722150113.1.Ia50ab5cb8a6d3a73d302e6bdc25542d48ffd27f4@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing the command is the final step in kicking off a transfer.
Let's use writel() to ensure that any other memory accesses are done
before the command kicks off.  It's expected that this is mostly
relevant if we're in DMA mode but since it doesn't appear to regress
performance in a measurable way [1] even in PIO mode and it's easier
to reason about then let's just always use it.

NOTE: this patch came about due to code inspection.  No actual
problems were observed that this patch fixes.

[1] Tested by timing "flashrom -p ec" on a Chromebook which stresses
GENI SPI a lot.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/qcom-geni-se.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index dd464943f717..f50c73be1428 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -262,7 +262,7 @@ static inline void geni_se_setup_m_cmd(struct geni_se *se, u32 cmd, u32 params)
 	u32 m_cmd;
 
 	m_cmd = (cmd << M_OPCODE_SHFT) | (params & M_PARAMS_MSK);
-	writel_relaxed(m_cmd, se->base + SE_GENI_M_CMD0);
+	writel(m_cmd, se->base + SE_GENI_M_CMD0);
 }
 
 /**
@@ -282,7 +282,7 @@ static inline void geni_se_setup_s_cmd(struct geni_se *se, u32 cmd, u32 params)
 	s_cmd &= ~(S_OPCODE_MSK | S_PARAMS_MSK);
 	s_cmd |= (cmd << S_OPCODE_SHFT);
 	s_cmd |= (params & S_PARAMS_MSK);
-	writel_relaxed(s_cmd, se->base + SE_GENI_S_CMD0);
+	writel(s_cmd, se->base + SE_GENI_S_CMD0);
 }
 
 /**
-- 
2.28.0.rc0.142.g3c755180ce-goog

