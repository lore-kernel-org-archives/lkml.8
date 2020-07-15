Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C76C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBDE220658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ve1r7nGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbgGOMgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgGOMf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:35:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96025C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 05:35:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so2502316wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nLZftJ21jew9/kEGtv8CWXpR9DUFRsrGq7tmpIdUY4=;
        b=Ve1r7nGPBBEiMYQVujZ7qg7mSbRSHFW4Ztrfzm2LPTx16M+82GP/RHVovoCQv0ol28
         BFXXss9yjRYgkeNGUVe/USz+SAWMau2sdERTYjWb8ZjqLNY7GLhJp4TgFb8AljxCFrwi
         +P+m7mIDiJTpM0DaZ1yAx3H2cz3JpqN/NAxlZdETzweBJvzoaEvHnGhui7I0DkdZFMVk
         N88t0wop/ylDjgIoo4aWmk3rxUUM2bi5XGLyKEyCD6hZSSWa++1nQF+Noh6StvJwu36w
         WF6S7t8/lwJDeta1SsDLw2U71Ss0FlTVUGsZyReFZsHS9LnYfPmkiPQBZ/0T7yBX1M++
         qKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nLZftJ21jew9/kEGtv8CWXpR9DUFRsrGq7tmpIdUY4=;
        b=Zd2hdEf7B4bOVAKd/xlENPfuvhhjVfr0p9nseodqA0mQxOzVT3eTQ0cLswigrAS+RV
         3GRk11cd9ptui5bxmvWdLv7GxEDfXYCl5pUnrOIZyITPomHSvUbQCANMMYi13oNDkipL
         CeW9xXmuC2YnoaHZVjRZcedlYgX6dwhtIHX5eDdEo6dvimLSptV+CInP3DUvcQ+y5yKo
         sD6SpkEyTKkmst0uxmVtYmfyhvwUnJwBTdC+trrvrvpqsV72NkhHhhTJYgxssxCTfTGL
         io3rnpR92E8MXSw4T8v793GBe3V3VkPE2Ps+G/gyVE7jqESEZj+OCHMd9T4vL/AidecG
         Ixsg==
X-Gm-Message-State: AOAM531dadn19YkGc1NCyfeljioTpGCe98R+ZSW8Pj4pyNw3g1BzmIeF
        lt8xJj6kLX1CC5HPRBJrUuZb9g==
X-Google-Smtp-Source: ABdhPJyIP3kH3V8I1GPMPgN/hVOqqIuII4i5MJ7c685HCY4SeeX7azeY70/maT4T0v/n6YAAHo90+w==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr11024189wrr.364.1594816555336;
        Wed, 15 Jul 2020 05:35:55 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h14sm3298985wrt.36.2020.07.15.05.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 05:35:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] remoteproc: qcom_sysmon: Solve function header bitrot issues
Date:   Wed, 15 Jul 2020 13:35:51 +0100
Message-Id: <20200715123551.4011154-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715123551.4011154-1-lee.jones@linaro.org>
References: <20200715123551.4011154-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks as though 'name' has now been moved into 'struct sysmod_event'
which is passed in instead.  However, the parameter descriptions were
not updated at the same time.  Let's do that now.

Fixes the following W=1 kernel build warning(s):

 drivers/remoteproc/qcom_sysmon.c:78: warning: Function parameter or member 'event' not described in 'sysmon_send_event'
 drivers/remoteproc/qcom_sysmon.c:78: warning: Excess function parameter 'name' description in 'sysmon_send_event'
 drivers/remoteproc/qcom_sysmon.c:350: warning: Function parameter or member 'event' not described in 'ssctl_send_event'
 drivers/remoteproc/qcom_sysmon.c:350: warning: Excess function parameter 'name' description in 'ssctl_send_event'

Cc: Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/remoteproc/qcom_sysmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index 8d8996d714f07..9eb2f6bccea63 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -71,7 +71,7 @@ static LIST_HEAD(sysmon_list);
 /**
  * sysmon_send_event() - send notification of other remote's SSR event
  * @sysmon:	sysmon context
- * @name:	other remote's name
+ * @event:	sysmon event context
  */
 static void sysmon_send_event(struct qcom_sysmon *sysmon,
 			      const struct sysmon_event *event)
@@ -343,7 +343,7 @@ static void ssctl_request_shutdown(struct qcom_sysmon *sysmon)
 /**
  * ssctl_send_event() - send notification of other remote's SSR event
  * @sysmon:	sysmon context
- * @name:	other remote's name
+ * @event:	sysmon event context
  */
 static void ssctl_send_event(struct qcom_sysmon *sysmon,
 			     const struct sysmon_event *event)
-- 
2.25.1

