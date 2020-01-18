Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7730FC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4565F246A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579367989;
	bh=ddQnRDrCZoiijxmUQgQS5LGJ3SUdaS32zPV3m++qtXY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=U5RtNJ1gFBqfnH7Pp/NboA5Z18mgrvYJ+MGgq0WqCGupSdN8fuo/FLh1xSAly8ce3
	 oQyZOZuxql7deGFqcku4JD/qTbYVzavGwTnkRgiuxIekAw9f/L2UjfE8IjU3FMuB+7
	 Kfrplyil6M98IV7uqCycEIDZybQIX3SUMZRXQ6io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgARRTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:19:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56190 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgARRTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:19:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so10372661wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 09:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EInU/dPYRvAZRwXJwqErJZ8yw9wZRuIpHUzkalVTyT4=;
        b=dNtdcZ1/xaM13ffIwADWHZR3khEWHDFXBVJiytn/IPYPN3NYvSiH3QQpgjAgoToIUK
         WngiagXpsTSX9pgwWCq4Lohl0nBNbLIAV6Jb8j+B+uGDcZ9CBCfWuSZ/2HZVG6CKg7ei
         KhZhooYUxtRyOYDrjECjZW1RXRc/uZzCPGv14EYAbyNVWzYvT0VgPxT8DFZZgC9YMa4y
         dZWApEJ3UiONhm69UnI1tzBB0JqHzgpKLjXYRT2PIpahx+oMu0Gj8CjTaCFfBb2P6f3G
         zMwWYFEY5MycNr6+SRyTdpYtcL0+XKA4UQwutlWmRV6q6XtvLCnt/FkJ8SWmp/97a52L
         NCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=EInU/dPYRvAZRwXJwqErJZ8yw9wZRuIpHUzkalVTyT4=;
        b=qvWhET+bbeafr3oEdpVQD5Qcb1C4uBvrF2LvLEXE+SdJLpc4T+Xh2KhcwdbmQqGFnK
         iExjdxTxxM+KYxgmmbxU+QwlCg0FgyTOpqHazXqLVnDEECMfVz+O+/CbPYdPWIJK31Nb
         sgSkRKmzNLYHWOeMWdJDy99svkWLAiL28OVfxlZqRGtS5jKeEDwc3knIP0CpiioNc4dV
         LG5vaFGVUV+xRzJ1omT1aW/F/2gRQtiAYXAFCu9lfa2CjlS/9zVfhmug3vN7YCswGITJ
         N768Dbr6koro9iy5a6Fk+goFFf3+3w0iJhy5wZEfm1gp0mgzYP9Fbxa79VHsWp3+HCZO
         p0kQ==
X-Gm-Message-State: APjAAAWrXjEMfH2qKV1ZWfMg9787CD6V0zP23ZYbfiL9SyKB06qkJaPl
        dDoAPaK/KUJ+RwdjeEZcf2+DYooU
X-Google-Smtp-Source: APXvYqywHbYqTw/ircYwVV87z40gJQb85fKlnRIXbYl0K9nvnF2A6NJLzZw6Ed2y2JZWfMaFzCUFhw==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr10711405wmo.147.1579367986172;
        Sat, 18 Jan 2020 09:19:46 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c15sm38837116wrt.1.2020.01.18.09.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 09:19:45 -0800 (PST)
Date:   Sat, 18 Jan 2020 18:19:43 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] IRQ fix
Message-ID: <20200118171943.GA82768@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

   # HEAD: 1fd224e35c1493e9f5d4d932c175616cccce8df9 irqchip/ingenic: Get rid of the legacy IRQ domain

Fix a recent regression in the Ingenic SoCs irqchip driver that floods 
the syslog.

 Thanks,

	Ingo

------------------>
Paul Cercueil (1):
      irqchip/ingenic: Get rid of the legacy IRQ domain


 drivers/irqchip/irq-ingenic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 01d18b39069e..c5589ee0dfb3 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 
 #include <asm/io.h>
-#include <asm/mach-jz4740/irq.h>
 
 struct ingenic_intc_data {
 	void __iomem *base;
@@ -50,7 +49,7 @@ static irqreturn_t intc_cascade(int irq, void *data)
 		while (pending) {
 			int bit = __fls(pending);
 
-			irq = irq_find_mapping(domain, bit + (i * 32));
+			irq = irq_linear_revmap(domain, bit + (i * 32));
 			generic_handle_irq(irq);
 			pending &= ~BIT(bit);
 		}
@@ -97,8 +96,7 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		goto out_unmap_irq;
 	}
 
-	domain = irq_domain_add_legacy(node, num_chips * 32,
-				       JZ4740_IRQ_BASE, 0,
+	domain = irq_domain_add_linear(node, num_chips * 32,
 				       &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		err = -ENOMEM;
