Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE2EC35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC22A2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVm9Np1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgBXAxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:53:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47072 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXAxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:53:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so4438122pfp.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 16:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2q5Bw/ucFD2V9qs/uw34gKjr/pW9DYBRDHjUIIhZanY=;
        b=rVm9Np1krx2aUiWRCVerDDLdlglGF8VBgSA+sOMRPKP0zn5mqd3muGphw/CLmOl9Y9
         BNfuU4RCYOYHJ7uEKE5jnBfIeSRDhbxXRMy6DENcO+OZDIhV4oYsnRACJQ3ZgicT0PRS
         XX8fj0pc8PuXBTkDlC2vKlYIU3lijkk/J/IHg9s9pzLLSfLNdpLogs7HXQlBcrTQor2L
         nGAvKKid7s7Lzrq8d9LzmdRM6ncv7pGFCku1fx6MqTlJU2p7SPYLchNzn3lClC/pHPbS
         7DptlvQk3CflGO9ZnJAjaJLVeNLIiseGtBwG79Te9rsmr9wuWyq8CkJXEhpkAkBRMRCu
         JFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2q5Bw/ucFD2V9qs/uw34gKjr/pW9DYBRDHjUIIhZanY=;
        b=LEcccjnFCMvcq05v8kFeg6imh39Ie9TqI8zel6zPTQmU7iml6f1sbQmAmHyjlAg0yK
         VHMOFZU711TlFH+8lIM8Ion6l62VUk/U/ajZlpkDt4PUWb5+4XioKpczEIY1yvplxz8R
         //j+WCb80GJJRQUkp2chQC9er1m3VolacHDt5kHv42sS+00Lv3fRvT5xVjgHUFX33Szy
         y5t2xFDxQGhjNGen5ptTjYrpDN3eqNx3HS/3CmT/iDfCuk14HJw0jBvaUmRhXi/nQ1F/
         nY30JroPEpQPoXxYu5PLn4wULKLHWUTZL46p4R8oBoN1tmx+1pXQayKhPKkak7NcPD3m
         RlAA==
X-Gm-Message-State: APjAAAWh6PiE7whoaSoAWyyt+xRFkoXlK+uHJimfTp2fETRYAad6zbIu
        UVHdogxuwZOBJo0UW+eORHmeORr+iPM=
X-Google-Smtp-Source: APXvYqx3REoOag4hF2lygYk774q9v7u5t/gutm7pjdf30B9bZpMXzelKQFN7Ez9CVAS4BUaAFj75BA==
X-Received: by 2002:a63:257:: with SMTP id 84mr2436499pgc.304.1582505593682;
        Sun, 23 Feb 2020 16:53:13 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id m128sm10385977pfm.183.2020.02.23.16.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 16:53:13 -0800 (PST)
Date:   Mon, 24 Feb 2020 06:23:11 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 17/18] irqchip: Replace setup_irq() by request_irq()
Message-ID: <8369f9ec8a878a9ad930914acdb4a03e3c8fc3da.1582471508.git.afzal.mohd.ma@gmail.com>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). The early boot setup_irq()
invocations happen either via 'init_IRQ()' or 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---

v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 drivers/irqchip/irq-i8259.c   |  9 +++------
 drivers/irqchip/irq-ingenic.c | 11 +++++------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index d000870d9b6b..23664fa9900a 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -271,11 +271,6 @@ static void init_8259A(int auto_eoi)
 /*
  * IRQ2 is cascade interrupt to second interrupt controller
  */
-static struct irqaction irq2 = {
-	.handler = no_action,
-	.name = "cascade",
-	.flags = IRQF_NO_THREAD,
-};
 
 static struct resource pic1_io_resource = {
 	.name = "pic1",
@@ -323,7 +318,9 @@ struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
 	if (!domain)
 		panic("Failed to add i8259 IRQ domain");
 
-	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
+	if (request_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, no_action,
+			IRQF_NO_THREAD, "cascade", NULL))
+		pr_err("%s: request_irq() failed\n", "cascade");
 	register_syscore_ops(&i8259_syscore_ops);
 	return domain;
 }
diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index c5589ee0dfb3..482b35b273d9 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -58,11 +58,6 @@ static irqreturn_t intc_cascade(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction intc_cascade_action = {
-	.handler = intc_cascade,
-	.name = "SoC intc cascade interrupt",
-};
-
 static int __init ingenic_intc_of_init(struct device_node *node,
 				       unsigned num_chips)
 {
@@ -130,7 +125,11 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		irq_reg_writel(gc, IRQ_MSK(32), JZ_REG_INTC_SET_MASK);
 	}
 
-	setup_irq(parent_irq, &intc_cascade_action);
+	if (request_irq(parent_irq, intc_cascade, 0,
+			"SoC intc cascade interrupt", NULL)) {
+		pr_err("%s: request_irq() failed\n",
+		       "SoC intc cascade interrupt");
+	}
 	return 0;
 
 out_domain_remove:
-- 
2.25.1

