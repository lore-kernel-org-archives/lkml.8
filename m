Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EACC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8492C22CE3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FDcw2hYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHEQaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgHEQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:27:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F99C001FDF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 09:16:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w19so12525564plq.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5CgDyHZh9RmBIguTtW8MfajwzfpPjyTKuSzmrxdMU8=;
        b=FDcw2hYy4Py5Axh/CsQVkdXe+aP99s6M7nxdI7CttWEb6+aTZkAl4+LtEgPhUg/N3D
         q1urrsolKzUY1kbUM7OlOxtKIzD3QbqM1w1J4nVJSksUY/hoXHHDhA6h3OSl3U4tt0zs
         ESZAK/asKRVCuVH2ut3bC7EwESYWpvmMn6+KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5CgDyHZh9RmBIguTtW8MfajwzfpPjyTKuSzmrxdMU8=;
        b=fFOoFKP95oHyQXEjyKUbTIUZqpBA/pDEFn3gHmJYkQ4hCz5Rk8J6QoT2O5E6KEV6ge
         VozqKD7dWH2gql0SoiVKwyxdrdr3pu1m7M/J9h4qoYODTuZTMZRULa8UduuLGd4KaxLt
         tyLeJo4V6WBiYNgWQ9GvHd5xdxjPzeyMnqiMQ3/aMTHRq9XZtMXh15QPF0nkg5Rw6sgv
         g6OGplaio7+JRIViZILkIl5oSnies0PHo05+HDVYpgb8FtyM/hmKj1lG4Nwfr2llndyA
         vWpbAiFvm6lTzNye0PaVFamVMTBH05uOrYs+Up3L9qB4Ev6rxmDoWGWq+Kj4UalaIIXN
         jMwA==
X-Gm-Message-State: AOAM5303DQLlDfXbQ+W/5JZUe9WW50g7gjm5cr8ti6gkouvQm6vaRuMR
        Tr9KHUr6KJOMQN5LCcq8Xfdwag==
X-Google-Smtp-Source: ABdhPJy50K2eKCG+xULNutmAaiRXfFfczTrysNIfy1hK7rGQ8HfVVR9CpYmGt/BqRTxpFl4aLLihxA==
X-Received: by 2002:a17:902:780f:: with SMTP id p15mr3995867pll.56.1596644194594;
        Wed, 05 Aug 2020 09:16:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id f2sm4259734pfb.184.2020.08.05.09.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 09:16:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     swboyd@chromium.org, Alex Elder <elder@linaro.org>,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] soc: qcom: aoss: Don't wait for IRQ if we might be in suspend/resume noirq
Date:   Wed,  5 Aug 2020 09:16:10 -0700
Message-Id: <20200805091141.1.I86b3faaecb0d82997b599b1300f879606c71e116@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running suspend/resume tests on a sc7180-based board with a modem I
found that both system suspend and system resume would hang for 1
second.  These messages indicate where:

  genpd genpd:0:4080000.remoteproc: calling genpd_suspend_noirq+0x0/0x2c @ 18659, parent: none
  genpd genpd:0:4080000.remoteproc: genpd_suspend_noirq+0x0/0x2c returned 0 after 987917 usecs

Adding a printout, I found that we were working with the power domain
where "res->pd.name" was "modem".

I found that we were hanging on the wait_event_interruptible_timeout()
call in qmp_send().  Specifically we'd wait for the whole 1 second
timeout to hit, then we'd notice that our condition was true and would
continue on our merry way.  Sure enough, I could confirm that
wait_event_interruptible_timeout() was returning "1" which indicates
that the condition evaluated to true and we also timed out.

Dumping the stack at the time of the failure made the problem clear.
Specifically the stack looked like:
   qmp_send+0x1cc/0x210
   qmp_pd_power_toggle+0x90/0xb8
   qmp_pd_power_off+0x20/0x2c
   genpd_sync_power_off+0x80/0x12c
   genpd_finish_suspend+0xd8/0x108
   genpd_suspend_noirq+0x20/0x2c
   dpm_run_callback+0xe0/0x1d4
   __device_suspend_noirq+0xfc/0x200
   dpm_suspend_noirq+0x174/0x3bc
   suspend_devices_and_enter+0x198/0x8a0
   pm_suspend+0x550/0x6f4
As you can see we're running from the "noirq" callback.  Looking at
what was supposed to wake us up, it was qmp_intr() (our IRQ handler).
Doh!

I believe that the correct fix here is to assume that our power_off /
power_on functions might be called at "noirq" time and just always
poll if we're called via that path.  Other paths can continue to wait
for the IRQ.

Fixes: 2209481409b7 ("soc: qcom: Add AOSS QMP driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This problem was observed on the Chrome OS 5.4 tree which has some
extra patches in it compared to mainline.  The top of the current
Qualcomm tree didn't have the delay, but that's probably because
everything isn't fully enabled there yet.  I at least confirmed that
this patch doesn't actually _break_ anything on mainline, though.

 drivers/soc/qcom/qcom_aoss.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index ed2c687c16b3..818cdf74a267 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -6,6 +6,7 @@
 #include <linux/clk-provider.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -215,6 +216,8 @@ static bool qmp_message_empty(struct qmp *qmp)
  * @qmp: qmp context
  * @data: message to be sent
  * @len: length of the message
+ * @noirq: If true we might have been called from the "noirq" suspend/resume
+ *         callbacks, so fall back to polling mode for waiting for completion.
  *
  * Transmit @data to AOSS and wait for the AOSS to acknowledge the message.
  * @len must be a multiple of 4 and not longer than the mailbox size. Access is
@@ -222,11 +225,12 @@ static bool qmp_message_empty(struct qmp *qmp)
  *
  * Return: 0 on success, negative errno on failure
  */
-static int qmp_send(struct qmp *qmp, const void *data, size_t len)
+static int qmp_send(struct qmp *qmp, const void *data, size_t len, bool noirq)
 {
 	long time_left;
 	size_t tlen;
 	int ret;
+	bool is_empty;
 
 	if (WARN_ON(len + sizeof(u32) > qmp->size))
 		return -EINVAL;
@@ -245,8 +249,16 @@ static int qmp_send(struct qmp *qmp, const void *data, size_t len)
 	tlen = readl(qmp->msgram + qmp->offset);
 	qmp_kick(qmp);
 
-	time_left = wait_event_interruptible_timeout(qmp->event,
-						     qmp_message_empty(qmp), HZ);
+	/*
+	 * We may be called from a suspend/resume "noirq" context.  In such
+	 * a case we have no choice but to poll.
+	 */
+	if (noirq)
+		time_left = readx_poll_timeout_atomic(qmp_message_empty, qmp,
+						      is_empty, is_empty, 1U, 1000000U);
+	else
+		time_left = wait_event_interruptible_timeout(qmp->event,
+							     qmp_message_empty(qmp), HZ);
 	if (!time_left) {
 		dev_err(qmp->dev, "ucore did not ack channel\n");
 		ret = -ETIMEDOUT;
@@ -267,7 +279,7 @@ static int qmp_qdss_clk_prepare(struct clk_hw *hw)
 	static const char buf[QMP_MSG_LEN] = "{class: clock, res: qdss, val: 1}";
 	struct qmp *qmp = container_of(hw, struct qmp, qdss_clk);
 
-	return qmp_send(qmp, buf, sizeof(buf));
+	return qmp_send(qmp, buf, sizeof(buf), false);
 }
 
 static void qmp_qdss_clk_unprepare(struct clk_hw *hw)
@@ -275,7 +287,7 @@ static void qmp_qdss_clk_unprepare(struct clk_hw *hw)
 	static const char buf[QMP_MSG_LEN] = "{class: clock, res: qdss, val: 0}";
 	struct qmp *qmp = container_of(hw, struct qmp, qdss_clk);
 
-	qmp_send(qmp, buf, sizeof(buf));
+	qmp_send(qmp, buf, sizeof(buf), false);
 }
 
 static const struct clk_ops qmp_qdss_clk_ops = {
@@ -321,7 +333,7 @@ static int qmp_pd_power_toggle(struct qmp_pd *res, bool enable)
 	snprintf(buf, sizeof(buf),
 		 "{class: image, res: load_state, name: %s, val: %s}",
 		 res->pd.name, enable ? "on" : "off");
-	return qmp_send(res->qmp, buf, sizeof(buf));
+	return qmp_send(res->qmp, buf, sizeof(buf), true);
 }
 
 static int qmp_pd_power_on(struct generic_pm_domain *domain)
@@ -438,7 +450,7 @@ static int qmp_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 			qmp_cdev->name,
 			cdev_state ? "on" : "off");
 
-	ret = qmp_send(qmp_cdev->qmp, buf, sizeof(buf));
+	ret = qmp_send(qmp_cdev->qmp, buf, sizeof(buf), false);
 
 	if (!ret)
 		qmp_cdev->state = cdev_state;
-- 
2.28.0.163.g6104cc2f0b6-goog

