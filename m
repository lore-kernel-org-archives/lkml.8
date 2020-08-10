Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26720C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A62206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Jbo0hkAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHJLXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:23:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57698 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHJLVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:21:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597058507; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=AxvoBcWG8EXvjruIo9s4TgmENSIrz3k6NXBlzZX8t80=; b=Jbo0hkAS126aPMcdvnqhuOGjs6ckP0um9lmOFSnai/lvoXe2siHQDlVryo4qLjrsqnHpdK+d
 2LZeT1YYkPxPNQR0zOOEJb95WFsz6nuLSVGegkeoTDp/ut3F8U74/3Wbg3cGlI14hQNGwXC6
 M5/nybf/d+3/V6GNRI6Yb9GEoIE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f312dc3d96d28d61e00cb64 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 Aug 2020 11:21:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2524C433CA; Mon, 10 Aug 2020 11:21:39 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B33EC433C6;
        Mon, 10 Aug 2020 11:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B33EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     bjorn.andersson@linaro.org, maz@kernel.org,
        linus.walleij@linaro.org, swboyd@chromium.org,
        evgreen@chromium.org, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v4 4/7] genirq: introduce irq_suspend_parent() and irq_resume_parent()
Date:   Mon, 10 Aug 2020 16:50:57 +0530
Message-Id: <1597058460-16211-5-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597058460-16211-1-git-send-email-mkshah@codeaurora.org>
References: <1597058460-16211-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

This goes with the new irq_suspend_one() and irq_resume_one()
callbacks and allow us to easily pass things up to our parent.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 include/linux/irq.h |  2 ++
 kernel/irq/chip.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 8d37b32..4188f50 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -679,6 +679,8 @@ extern int irq_chip_set_affinity_parent(struct irq_data *data,
 					const struct cpumask *dest,
 					bool force);
 extern int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on);
+extern void irq_chip_suspend_one_parent(struct irq_data *data);
+extern void irq_chip_resume_one_parent(struct irq_data *data);
 extern int irq_chip_set_vcpu_affinity_parent(struct irq_data *data,
 					     void *vcpu_info);
 extern int irq_chip_set_type_parent(struct irq_data *data, unsigned int type);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index caf80c1..5039311 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1519,6 +1519,34 @@ int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
 EXPORT_SYMBOL_GPL(irq_chip_set_wake_parent);
 
 /**
+ * irq_chip_suspend_one_parent - Call irq_suspend_one() on our parent.
+ * @data:	Pointer to interrupt specific data
+ *
+ * Conditional, as the underlying parent chip might not implement it.
+ */
+void irq_chip_suspend_one_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	if (data->chip->irq_suspend_one)
+		data->chip->irq_suspend_one(data);
+}
+EXPORT_SYMBOL_GPL(irq_chip_suspend_one_parent);
+
+/**
+ * irq_chip_resume_one_parent - Call irq_resume_one() on our parent.
+ * @data:	Pointer to interrupt specific data
+ *
+ * Conditional, as the underlying parent chip might not implement it.
+ */
+void irq_chip_resume_one_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	if (data->chip->irq_resume_one)
+		data->chip->irq_resume_one(data);
+}
+EXPORT_SYMBOL_GPL(irq_chip_resume_one_parent);
+
+/**
  * irq_chip_request_resources_parent - Request resources on the parent interrupt
  * @data:	Pointer to interrupt specific data
  */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

