Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC0AC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80448206E2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZAp5Fm6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCGAAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:00:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37840 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCGAAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:00:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so1874690pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 16:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mRf7ifgX7zbaVmn4NjSkySRjH8oQPa4m1mLq8CgIprc=;
        b=ZAp5Fm6dpDpVjUdraWnOpQsptURIcZwYpytZSVu+fMPEKSrjimoeHYaUHkH7jZTVKR
         vffXeuouP4jlQWxxYQRpZFjkQJfl3sPXKW4s52ci0BKa1Y+1JS19nEat043+XbAiUMer
         Hl6H8k0VMX3V1CJmew66wRlji6TFJlOML9TT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mRf7ifgX7zbaVmn4NjSkySRjH8oQPa4m1mLq8CgIprc=;
        b=m94/HiJ2wfLWZPeDpr21DXNrGbj8eP+ZjO3QXqrSnQfnCkrCxcv2KikWfjwX1jzFhW
         ukU6KJc0jwBteKq04PdbUOL30iNHxsJm005iGWvWJRAOjuMtsf7hO0ZlXJPQwDwj7sin
         u9iH+SFroVmSAQtq4lvRR2TNXp1igiSe+6gUxN8rz1hZNtC5onS3CW+OQFE79WIwYSLx
         HwqA/rJHIh2aL48jFLT7IIXOSk+KYrpn+mDLUbMssfUYeXYw7sFxhfFWKsgMm5kv4DrF
         gtPhtR1hWdPI2SzkY8UCmjKFT2z3sN5Rpsuazmg/yylwEmPUgm9apPhy080vP5VsyfAu
         9U5A==
X-Gm-Message-State: ANhLgQ2Gw9sVAgEHlmJBjy3k4z0lOZgQrF6/IFJ4qxP7sAtrDIACGE3Z
        Ou9eeiVFLivm8gTZtunJzoq3nzsTpYk=
X-Google-Smtp-Source: ADFU+vtkomkxgMKcVnN3kivqhu2On7dz8E96mTuuCr4xI+v38xMJHA54SjCqeH6gBm3Te2cwQnq+Yg==
X-Received: by 2002:a63:f757:: with SMTP id f23mr5568459pgk.223.1583539230403;
        Fri, 06 Mar 2020 16:00:30 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 9sm32302246pge.65.2020.03.06.16.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 16:00:29 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 8/9] drivers: qcom: rpmh-rsc: spin_lock_irqsave() for tcs_invalidate()
Date:   Fri,  6 Mar 2020 15:59:50 -0800
Message-Id: <20200306155707.RFT.8.I07c1f70e0e8f2dc0004bd38970b4e258acdc773e@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200306235951.214678-1-dianders@chromium.org>
References: <20200306235951.214678-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auditing tcs_invalidate() made me worried.  Specifically I saw that it
used spin_lock(), not spin_lock_irqsave().  That always worries me.

As I understand it, using spin_lock() is only valid in these
situations:

a) You know you are running in the interrupt handler (and all other
   users of the lock use the "irqsave" variant).
b) You know that nobody using the lock is ever running in the
   interrupt handler.
c) You know that someone else has always disabled interrupts before
   your code runs and thus the "irqsave" variant is pointless.

From auditing the driver we look OK.  ...except that there is one
further corner case.  If sometimes your code is called with IRQs
disabled and sometimes it's not you will get in trouble if someone
ever boots your board with "nosmp" (AKA in uniprocessor mode).  In
such a case if someone else has the lock (without disabling
interrupts) and they get swapped out then your code (with interrupts
disabled) might loop forever waiting for the spinlock.

It's just safer to use the irqsave version, so let's do that.  In
future patches I believe tcs_invalidate() will always be called with
interrupts off anyway.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/soc/qcom/rpmh-rsc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 693873fce895..0297da5ceeaa 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -210,9 +210,10 @@ static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
 static int tcs_invalidate(struct rsc_drv *drv, int type)
 {
 	int m;
+	unsigned long flags;
 	struct tcs_group *tcs = &drv->tcs[type];
 
-	spin_lock(&tcs->lock);
+	spin_lock_irqsave(&tcs->lock, flags);
 	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
 		spin_unlock(&tcs->lock);
 		return 0;
@@ -227,7 +228,7 @@ static int tcs_invalidate(struct rsc_drv *drv, int type)
 		write_tcs_reg_sync(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0);
 	}
 	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
-	spin_unlock(&tcs->lock);
+	spin_unlock_irqrestore(&tcs->lock, flags);
 
 	return 0;
 }
-- 
2.25.1.481.gfbce0eb801-goog

