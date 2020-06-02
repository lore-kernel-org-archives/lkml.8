Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD25C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45409206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5yZkA2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgFBFZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFBFZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:25:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5739C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 22:25:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b5so1677087pfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 22:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pmTQ2J+ewmzAEXPhfQy/+hCxdmaweoAFACeDccmRGl0=;
        b=h5yZkA2l+Mg+kNUOWElvwFJjm2e1UB14Z+QBIySxys0830XZ9MF/dClCMu0l+DtKGE
         o9SyVR1BIDZ3dTL5vmbUYfxj5uQDWDVnQkYbK3iVMAeELega+0qsbn2jRbtwi7O+/WVX
         BSeQ5q/IdE+Epsq46jRoijqjDQ4CM0PTYlNMvNfB62aHj+0NTnLn4zQ7KK2DkAgUXeTd
         GDhhQQEK3NpJp5a2mmHIYUmj+UQN7VgW+hpPJViUZJoPX3HTgTeSSz5YCXSAdly87wOB
         iFISROlBAuTNkdchyO4pMVuAJdtWnq0kIUOHdMMad4/APHraiQ0dY9xK/7xJbS4e03CO
         ZPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pmTQ2J+ewmzAEXPhfQy/+hCxdmaweoAFACeDccmRGl0=;
        b=pR9HV3dN3VXZHjg8+HJ4LG5yxqJmeR0I3lRF0f66Sp/h5Q4mFKgNYH9sZL6Pi3TohA
         VA28NCAz9pPyx0q3Ka3SEtD5cFMgqDJCSwQQDYMbJvR+8xCNnsrBaBZHdkGTVs+pXkD0
         7WgivPHH7EQFenJZwVlzOGN7L/UxLZMF0YKBuO9EGZw3FXvZk9qcx/TeZdbHVt2G8xdi
         3TypGq7EPc7ItcwcxIKH6BCN6hhu3aTaRkfYq7vFMCnGj04AsZh2UqqoYI7bgjrxA1RP
         5xUQkRRpbXP8eQT6NK54qVn6ZJBmW1tT67KzbSMXM4fb9jC8aWlBOJB+zBcfkt+0VWX5
         NqFQ==
X-Gm-Message-State: AOAM532aVpcLwItKU3b5OU/EHduiCi7pt6KogXtLK/+7MXguq8Enkzx3
        rXknQOc3i9IcqHcEJ6K7h3Zd7zYCo0I=
X-Google-Smtp-Source: ABdhPJym62I5PYrbey5hKJ41iA2hotYaRo67Whb7YuRi7XclxNuXaWayAK5GxIE0maNqAf41WqvcwA==
X-Received: by 2002:a65:6795:: with SMTP id e21mr22870328pgr.282.1591075538931;
        Mon, 01 Jun 2020 22:25:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id f7sm1031988pjp.24.2020.06.01.22.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 22:25:38 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rakesh Pillai <pillair@qti.qualcomm.com>,
        Govind Singh <govinds@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org
Subject: [PATCH] wireless: ath10k: Return early in ath10k_qmi_event_server_exit() to avoid hard crash on reboot
Date:   Tue,  2 Jun 2020 05:25:33 +0000
Message-Id: <20200602052533.15048-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since 5.7-rc1, if we call
ath10k_qmi_remove_msa_permission(), the db845c hard crashes on
reboot, resulting in the device getting stuck in the usb crash
debug mode and not coming back up wihthout a hard power off.

This hack avoids the issue by returning early in
ath10k_qmi_event_server_exit().

A better solution is very much desired!

Feedback and suggestions welcome!

Cc: Rakesh Pillai <pillair@qti.qualcomm.com>
Cc: Govind Singh <govinds@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: ath10k@lists.infradead.org
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/net/wireless/ath/ath10k/qmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 85dce43c5439..ab38562ce1cb 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -854,6 +854,11 @@ static void ath10k_qmi_event_server_exit(struct ath10k_qmi *qmi)
 	struct ath10k *ar = qmi->ar;
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 
+	/*
+	 * HACK: Calling ath10k_qmi_remove_msa_permission causes
+	 * hardware to hard crash on reboot
+	 */
+	return;
 	ath10k_qmi_remove_msa_permission(qmi);
 	ath10k_core_free_board_files(ar);
 	if (!test_bit(ATH10K_SNOC_FLAG_UNREGISTERING, &ar_snoc->flags))
-- 
2.17.1

