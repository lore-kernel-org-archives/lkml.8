Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60370C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372BA20661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="NKQ8YuiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgBLIkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:40:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33456 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgBLIkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:40:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so1145281wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vlGsrurND/ABJQemtdqIOhR0buTYuD6gWRyYKODN9Xk=;
        b=NKQ8YuiPPz9uuqFcO4gqQlpy0FIsB00vju+5ElEyGiLsREmxv4Jo0jIew6PG4ycqk+
         czj+eYDQUsi/kK6LtoxCJYRrpaNptaf8vhLIUWTh8ctATPy5DayO8eVAz6jqOz4nXPMk
         3psY2+K8n4v3pEpXY66d7wMVgx7TE2Gy9W60ajwfbWTOkuDTzsv+lfP7qNmrCx5SQqvv
         FKET5k/88hDeYjqa+NPiX716k+qae0OUGNZjoxGITKkoEW8rgUzyNOOKaAWonnLNUei3
         00QtZuMW6d60b9nO1J0XsegienKIjeT22Ke4PCaET7ESyrcLW1m/VYLxfZwyPZtr9fZk
         F2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vlGsrurND/ABJQemtdqIOhR0buTYuD6gWRyYKODN9Xk=;
        b=Cs49WcHMs4sODwRMCSWLQ5amTBrBa20V50UBbZfjeKuBc71QgCFlsqRMuXFwpEPt3c
         fLmzjg1u+tNm2fNa7DsgigyvJgEo2J2wEsxYb0N8E3sLAWogqkZ7r6oEsFUFx8FKnQEw
         AF3ZQcK69QP8KckcrWY8wx5WzYUnO+PVzRlK7Ba7TTbXWWXeWVX7Sszxfo4lcFylFZGn
         L1mSxKG/6kGDdkWX1pAKN8qrCc9Weo74awHxKOYPrhd0kq856W1UNlb9dfxhu3yY/Q+p
         ro5pjNaSot5i77MgL1jWxq2hOCqduC9sIT7tLTsME0eBEauGjkAp6UrMtf8ckeF/XmTg
         M2zg==
X-Gm-Message-State: APjAAAWywkzmUIMkK2G8nlMzwZ4mvD85JGRCa+vQ0ey/KnOp6r25v1Bi
        rBKWjJrWXid1r3eOTMESo/B6AEC6jiT2RA==
X-Google-Smtp-Source: APXvYqwd4NGHpkAia9MPc9TqBch3g3lddR5bKtlF0IABbXo2wYaC1n9u3QQSEPORyd4SI6qM5hPp1g==
X-Received: by 2002:a5d:55d2:: with SMTP id i18mr13399003wrw.287.1581496802074;
        Wed, 12 Feb 2020 00:40:02 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id r6sm8849640wrq.92.2020.02.12.00.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:40:01 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] irqchip: xilinx: Fill error code when irq domain registration fails
Date:   Wed, 12 Feb 2020 09:39:56 +0100
Message-Id: <08b652db487686d816d71b3447a3b9f612d0fab4.1581496793.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581496793.git.michal.simek@xilinx.com>
References: <cover.1581496793.git.michal.simek@xilinx.com>
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
2.25.0

