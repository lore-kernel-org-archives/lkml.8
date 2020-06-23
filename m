Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D4AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 04:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5DC20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 04:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Fh7zkWQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbgFWEI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 00:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732198AbgFWEIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 00:08:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8744C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 21:08:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jz3so920675pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 21:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4FW+m4OKf2kSNXiUaghZT1zAXKX8nqzoE0clDN0F5Qw=;
        b=Fh7zkWQNym4oqDH66prnjrc36hHWRRxrH1DhPVinGsnUuV3wkuvFUQtzAy3GQfdr9H
         1DN66h5Ioc+/ubli9zxZr0Lw18N4LsbYwHAOeSxIVZNe2NoricB9btPSMUnUTi7sIoJo
         KTaEugIKs/QVNDb7vkjNDxsBHHeN3AoDPMh7sKQwDrBvwYG6MjkMv1GmiSaEB5CRZXMw
         kl/xrdJKiaaG1MeueI/fic6ef073H+2fYLWzHoPnv+6czq+FzCSri8sHFkDyrnTXl2sk
         r5TJCTsRU1Pw8NGXjGOrtI4IEyOR74D0vw6S0gzTBGPV7G+Zvjp56rUX8M9fhtsYG+2X
         HdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4FW+m4OKf2kSNXiUaghZT1zAXKX8nqzoE0clDN0F5Qw=;
        b=eMoznXrKr10kNoR91S9zZWW3EW1Yne4ny1UXK9GBbYDwzIUIXzwYKl8VpeRbntPwsL
         7B7g6m5JgGZjlM9FwkUZCNdGl/etWa2/rYg4TMqaE5SZWKPlaM2atbMPiD1dDs3D0ZDc
         ecChI2TleCkWkWSint8HQd93nwasQ+oB1ZyR8X0TyaJBH6ZGUdtKprUySmtpW7rP6E+x
         ieAG/YSfxXrnHkq1eA9B5irvbL+t+qHCU9O7YlXIO6M4q4CrmR7IMPtlglyFyICac95X
         EsLPhE9q261Ldd+/uasOJ8WO9HTxU4yAzQjYlQxu2oWafVdeKl5VIi3W6mC6Y4bbI9q0
         HlFg==
X-Gm-Message-State: AOAM530jvPeqZ9MiH//3u4MaUFGlgLXsWiavE6iWXpr34LESfXlsH67S
        ghKRv3elZPNzS9zrjmrmS1Y2KA==
X-Google-Smtp-Source: ABdhPJwGu8FV0PNFXuyfR/GeKUM5EgUJAZmPSV35uIXBFybIjRXhQpMKbAC6JrjTz5ZMw5v/8mHbGg==
X-Received: by 2002:a17:90a:55c7:: with SMTP id o7mr19715373pjm.205.1592885333119;
        Mon, 22 Jun 2020 21:08:53 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id y4sm12554827pgr.76.2020.06.22.21.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 21:08:52 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, anup.patel@wdc.com, atish.patra@wdc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, maz@kernel.org, jason@lakedaemon.net,
        tglx@linutronix.de
Subject: [PATCH] irqchip/riscv-plic: Fix typo in irq-riscv-intc.c
Date:   Tue, 23 Jun 2020 12:08:45 +0800
Message-Id: <20200623040845.42423-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in irq-riscv-intc.c

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 drivers/irqchip/irq-riscv-intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index a6f97fa6ff69..8017f6d32d52 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -99,7 +99,7 @@ static int __init riscv_intc_init(struct device_node *node,
 
 	hartid = riscv_of_parent_hartid(node);
 	if (hartid < 0) {
-		pr_warn("unable to fine hart id for %pOF\n", node);
+		pr_warn("unable to find hart id for %pOF\n", node);
 		return 0;
 	}
 
-- 
2.27.0

