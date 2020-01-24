Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72213C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF7820708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864315;
	bh=uzTE8TbwK78FXSf2VUeORIQN1uub9Ihg/cHv5SiDxYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jbkf5UR3qgzCvvVRdcm+GOvKEeP+kxbxb09e9Emj8qy3srbBG9nsg6P9o1017NmUO
	 BZiTEv6Udfzd4d8ncobiRVJx0FyRwOLBA1kyy8fI1An2y+g4gHMl3tQ+7nA/dnwvg7
	 xt/OzjvhSuvT8wn9GzDt/hBfJsbGkSg7TKB/xG2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389927AbgAXLLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:11:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388069AbgAXLLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:11:52 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0824620663;
        Fri, 24 Jan 2020 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864311;
        bh=uzTE8TbwK78FXSf2VUeORIQN1uub9Ihg/cHv5SiDxYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETojN69SvToAK5Df7Cu2iU4IDoJr7PAuJc4hXzF7P2XvIMjZ0qjHZZcwhs8gcC41I
         t7qCPdqPIxnK1Di2mH+HPmRVFJtB52U3Pp6NazrCrpcLVpk0+wI7Z/hmr/hY4Fm/ot
         ABKFZ9Bsm0iAf+8yyOaCh4khK/OVzxDZUaaFJlvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 231/639] clocksource/drivers/exynos_mct: Fix error path in timer resources initialization
Date:   Fri, 24 Jan 2020 10:26:41 +0100
Message-Id: <20200124093115.793232969@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit b9307420196009cdf18bad55e762ac49fb9a80f4 ]

While freeing interrupt handlers in error path, don't assume that all
requested interrupts are per-processor interrupts and properly release
standard interrupts too.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/exynos_mct.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index aaf5bfa9bd9c9..e3ae041ac30e1 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -563,7 +563,19 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 	return 0;
 
 out_irq:
-	free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
+	if (mct_int_type == MCT_INT_PPI) {
+		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
+	} else {
+		for_each_possible_cpu(cpu) {
+			struct mct_clock_event_device *pcpu_mevt =
+				per_cpu_ptr(&percpu_mct_tick, cpu);
+
+			if (pcpu_mevt->evt.irq != -1) {
+				free_irq(pcpu_mevt->evt.irq, pcpu_mevt);
+				pcpu_mevt->evt.irq = -1;
+			}
+		}
+	}
 	return err;
 }
 
-- 
2.20.1



