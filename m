Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DA5C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C3820828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="G/sk+6Tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBXMF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:05:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40482 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgBXMFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:05:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so10069069wru.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 04:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T9r6peNg0GxGj8w89WCtwmOuzXrMVBPuq1CL8I6A2Ko=;
        b=G/sk+6TupatTQhbUWm14NNhPLJMvPbcsOYmuLGICcspebLWuUa5zHSfDJb98+0j/Xj
         GjnDlJTFVWHE5lpGZTxwj1LTYflqZmNjZa/2abHUuprbkvR3Kf/YuC3TT6KMMrvqVe3v
         eonMeLn6m1j0bdcuKUZw2zrSP7hKGzmKiW4fpEzC71bhou/GooLON6y3GP4pZFXpjcwT
         h7FpDkbgNa2IyszxqLiUOXv4ZowjhZ4Kwtx4eFhbuFbteilC1c5dAa62jhJQrm27B/6N
         qvmLFUkaWkuCJ56CGOLj2EqUeZZwsYhoDFVn38u258xpT72SgLU5MEnDIYf9Ht4Gk3LF
         yhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=T9r6peNg0GxGj8w89WCtwmOuzXrMVBPuq1CL8I6A2Ko=;
        b=bC3E+O5nyQluSiI3YM9QLd3Zfi2OKf+Qp6N6tRrTberqESsNJgVvqkySVyOKQsv7vR
         U7HD/3Reoc+gGf+bt4V3sujChJznLEAsPTSdAl12fPu+ZwzTx9P7ycEyK4YstBYxU9SV
         cFIFFcOHN+Kz0LupDvNCZU6/LkwRo8Q3eVxu087ZSwplKmi+1Us7qTnFmGvHsxGyepnV
         KWZv9/YYyQlcAQhBArTsRToIawznZyX60GXuT07i8hPFj3IyVuKunLvuUSUZo2GAG9el
         Oxb2CphnwpnSAm8UnVUqoVYv7ARZChEoHisQHfHfmLqj0IYAKoziGm5zIMqYTJUejNd/
         9goQ==
X-Gm-Message-State: APjAAAUFAsetPuaMVkiRJcYPiZJETB0llLfMCYsmvU6O6tVHJYhHmkcE
        aQe85QcoEFyd8kdVv+KO9OFratE/U5sq6Q==
X-Google-Smtp-Source: APXvYqyoGJfFaOtQ+ttvleKU+L6BzGECPvMdJcQz2foegA1t4YK39tfOEWb8fgTDcza1P3CZ1d05Fw==
X-Received: by 2002:adf:e542:: with SMTP id z2mr942344wrm.150.1582545921835;
        Mon, 24 Feb 2020 04:05:21 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x11sm17525429wmg.46.2020.02.24.04.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 04:05:21 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, maz@kernel.org
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] irqchip: xilinx: Fill error code when irq domain registration fails
Date:   Mon, 24 Feb 2020 13:05:13 +0100
Message-Id: <968acd4ba3a053554b17da93aaa1cead3c00c5f3.1582545908.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1582545908.git.michal.simek@xilinx.com>
References: <cover.1582545908.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no ret filled in case of irq_domain_add_linear() failure.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

Changes in v2: None

 drivers/irqchip/irq-xilinx-intc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 51f461d2934f..cf1bb470d7b5 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -230,6 +230,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 						  &xintc_irq_domain_ops, irqc);
 	if (!irqc->root_domain) {
 		pr_err("irq-xilinx: Unable to create IRQ domain\n");
+		ret = -EINVAL;
 		goto error;
 	}
 
-- 
2.25.1

