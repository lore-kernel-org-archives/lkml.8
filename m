Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF5AC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8715A20656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258279;
	bh=ZbFEaN5l+8Ba/vTiEQbdT83zjZPqCfMcehVz7b5ITFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pSKeN8yLmncKun4nj8+klRAz+dyWgbm4mdMScEReyCKVLS71yDSA2Egxb50Zy5ZGd
	 f1dwOs3MMSVoESKFz2xIF5ckpoVCIO+nOm89Z6A72VvqP6gMwmyia4UYxcPcQP9T+5
	 B04hknbRcterKpjQu/OXW3QxPqltGV2a0z/NXBdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbgCCR56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733176AbgCCR5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:57:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE192072D;
        Tue,  3 Mar 2020 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258273;
        bh=ZbFEaN5l+8Ba/vTiEQbdT83zjZPqCfMcehVz7b5ITFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/iONkOYCvMzMwpJ5UIhy+QgoOWvpvyAQqoSlo8qDzTTCLfyAGGeQOud0oQYDXvje
         jSiDw4CS8r6scVYqcmoNCjVkdn65wz72Y17UbTgYh2MQ/tZr7plslrwgKu/Ed8B/VD
         Cl9wsYhqsBYJu0/ziSoWAgZITnqOIg/6626GIQIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.4 139/152] thermal: db8500: Depromote debug print
Date:   Tue,  3 Mar 2020 18:43:57 +0100
Message-Id: <20200303174318.598717376@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

commit c56dcfa3d4d0f49f0c37cd24886aa86db7aa7f30 upstream.

We are not interested in getting this debug print on our
console all the time.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Fixes: 6c375eccded4 ("thermal: db8500: Rewrite to be a pure OF sensor")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191119074650.2664-1-linus.walleij@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/db8500_thermal.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -152,8 +152,8 @@ static irqreturn_t prcmu_high_irq_handle
 		db8500_thermal_update_config(th, idx, THERMAL_TREND_RAISING,
 					     next_low, next_high);
 
-		dev_info(&th->tz->device,
-			 "PRCMU set max %ld, min %ld\n", next_high, next_low);
+		dev_dbg(&th->tz->device,
+			"PRCMU set max %ld, min %ld\n", next_high, next_low);
 	} else if (idx == num_points - 1)
 		/* So we roof out 1 degree over the max point */
 		th->interpolated_temp = db8500_thermal_points[idx] + 1;


