Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C28DC433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 639AF20829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UqckbfU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgG1JUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgG1JUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:20:00 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6E2C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:19:59 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id v15so6075731lfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4zsWyblv4WYqOLRqFANl/g337TI8guVn11cXGgyt8Y0=;
        b=UqckbfU0UoUqAEx3PUc0VVyr7US4m3M4LDoKEHI42J+xeM4TM4pTOwXt8KPCpiGRe8
         eP6trKsNWEcrx3Kc8ZpHtDWYIy8eBNJhtmrOlEx+YsOi85o4NHE/WjxNvrNaVKBcvxuM
         R1E7Rxd2QmEP+mDEyrVwDwow8yQTMkS/54MGBaLAri006UgG2ISyTAzXBEd7zxHVCcmA
         EP7WL4h1pLr5786+Vt93AzyHtAGl422GpdMu5ZjRxI2Qe2eRwwS8SV9TNNBcpkvoH8Sv
         KXr1qHGKmIozzcYJbbXfgd0RHpvysV1Vo7Iwc+6F/ay3A3/bU5ageHf0Qsdzr5mSaVmK
         gEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4zsWyblv4WYqOLRqFANl/g337TI8guVn11cXGgyt8Y0=;
        b=JgJJ74E0w3BLcoc7N4WsxxU8odZfKDhm/+lwc2APSo3ys+26xAPHWiyj/yfR0qRnk5
         xR73+jCMtLXvbkxN5h/xsbmdSiRlHsRzM8oIFweyHSgWIW/VsrbUu18ioUSqtHpL74hf
         T6ltFuywXzjw8olRWDht+1OumiM2uqY9Av9vSrUzTAcRmN383DDz+pgb+lQUs8PNJ/zB
         Wj6M7/UrVcTnaBWPTuGaZ9Pqb1qxsvmHX5JQeGZy7JO0M5aoYozKbthXfok1OjUmOIYV
         i6W78w+YEcm4Z8IgmpX10tMB4v/845xxK+9OPbdUTFpgb39gMEnoFDHXlo9XE80F/x3K
         IAIQ==
X-Gm-Message-State: AOAM531SJ4uaDzVtuPlyJ4z0d7ao0huO4bfkC2jbYtKTN7OiVjdYROf+
        v0AhZPZ9LbHQnQVQAc2/LagtcA==
X-Google-Smtp-Source: ABdhPJxRJWE+gM9SiYoY7IFMYw8V87jNUKTEVCIhStBNKuL376Wh3ooXVpFqkBhf2mcG3Y2uIQ9+IA==
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr13963168lfc.100.1595927998173;
        Tue, 28 Jul 2020 02:19:58 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id q22sm3643270lfc.33.2020.07.28.02.19.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2020 02:19:57 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, david@lechnology.com,
        wmills@ti.com, praneeth@ti.com
Subject: [PATCH v4 4/5] irqchip/irq-pruss-intc: Implement irq_{get,set}_irqchip_state ops
Date:   Tue, 28 Jul 2020 11:18:37 +0200
Message-Id: <1595927918-19845-5-git-send-email-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595927918-19845-1-git-send-email-grzegorz.jaszczyk@linaro.org>
References: <1595927918-19845-1-git-send-email-grzegorz.jaszczyk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

This implements the irq_get_irqchip_state and irq_set_irqchip_state
callbacks for the TI PRUSS INTC driver. The set callback can be used
by drivers to "kick" a PRU by injecting a PRU system event.

Example:
     irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, true);

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Reviewed-by: Lee Jones <lee.jones@linaro.org>
---
v3->v4:
- Update commit message
v2->v3:
- Get rid of unnecessary pruss_intc_check_write() and use
  pruss_intc_write_reg directly.
v1->v2:
- https://patchwork.kernel.org/patch/11069769/
---
 drivers/irqchip/irq-pruss-intc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index cf9a59b..c13ba14 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -7,6 +7,7 @@
  *	Suman Anna <s-anna@ti.com>
  */
 
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
@@ -316,6 +317,43 @@ static void pruss_intc_irq_relres(struct irq_data *data)
 	module_put(THIS_MODULE);
 }
 
+static int pruss_intc_irq_get_irqchip_state(struct irq_data *data,
+					    enum irqchip_irq_state which,
+					    bool *state)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+	u32 reg, mask, srsr;
+
+	if (which != IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	reg = PRU_INTC_SRSR(data->hwirq / 32);
+	mask = BIT(data->hwirq % 32);
+
+	srsr = pruss_intc_read_reg(intc, reg);
+
+	*state = !!(srsr & mask);
+
+	return 0;
+}
+
+static int pruss_intc_irq_set_irqchip_state(struct irq_data *data,
+					    enum irqchip_irq_state which,
+					    bool state)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+
+	if (which != IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	if (state)
+		pruss_intc_write_reg(intc, PRU_INTC_SISR, data->hwirq);
+	else
+		pruss_intc_write_reg(intc, PRU_INTC_SICR, data->hwirq);
+
+	return 0;
+}
+
 static struct irq_chip pruss_irqchip = {
 	.name = "pruss-intc",
 	.irq_ack = pruss_intc_irq_ack,
@@ -323,6 +361,8 @@ static struct irq_chip pruss_irqchip = {
 	.irq_unmask = pruss_intc_irq_unmask,
 	.irq_request_resources = pruss_intc_irq_reqres,
 	.irq_release_resources = pruss_intc_irq_relres,
+	.irq_get_irqchip_state = pruss_intc_irq_get_irqchip_state,
+	.irq_set_irqchip_state = pruss_intc_irq_set_irqchip_state,
 };
 
 static int pruss_intc_validate_mapping(struct pruss_intc *intc, int event,
-- 
2.7.4

