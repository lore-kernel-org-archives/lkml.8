Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F34C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8020D2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tv+lROKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgEOUHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726223AbgEOUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:07:43 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CCDC05BD0A
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:07:42 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id z9so1713064qvi.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VnxRWHDXHhnTZy+gwKWC5VS3DYI6cRqhNhPWiq4rZmg=;
        b=Tv+lROKByW/LBPC0MoPALLkGwSNyeqW0JW97X019XsYzrTpHJ1jejK1GDUnGz2qpW4
         Eklk4GhajSlShVGuB/rxGAQ4l5ohbG31MBGzav8b2hgh9lnHhDt+Btva8nEY3epA2JhO
         AGFPo36fVH0LmUwzlsJ1UbuQsS0bEtoKt9GaFjhInArgcGibLC/oa5IFYTmO9G65GLUi
         ul9WcXUzWkcFjX/fTDC96YmaQ8P56slnE8SA0Mxkdbx8WXHPpS6G303UxjkRd1mrlocl
         aefrDa2CmQ0BDhjSGMakOygFLbkDm3nutDEuA0Ihvg2QMA6EIAevt8ETDiQXibZk9s7T
         0BVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VnxRWHDXHhnTZy+gwKWC5VS3DYI6cRqhNhPWiq4rZmg=;
        b=SAnuKAN87czRNqPb7DvEBtQacLBG0cmR/Exs1wtTliZFs2fCZ3jyp7xzqog0xjoREg
         tpmbDswTSAGZQ+lKntHFL2bBpwQ9IZrv9b1axN3QUI9B8IOZIzP94UYpKlLiT4/XVhSU
         9LsIKoGq2gco6hQgaxuRJNZpOFxkXL1FbIMMtHXpYCWCXjEaoEbKqeImzL/oZqr8KWMh
         S5PL4ygXJNDkcdpn1NSHteAHgILR6F6BdCiTyftyu78VRWbRADzHLqOAMe1ugxQJ19y8
         2m3DwIzdJNJL4GUqCo5ICt8iYfI4f/iYHLR+y85PDMC2pkDQ2/FIUBm5MSHaeVPvztuh
         gnUg==
X-Gm-Message-State: AOAM530LJlRpym6Gh6jRx8IsMLtiT1xO7c8M8vm2TdV3+GTtkIY7r/LN
        uB5AjiWIi13+NtloVtda+PPwiw==
X-Google-Smtp-Source: ABdhPJzDnLFI//uXsW8EBqoqzHLUpXo1v2yfY/OVy6VaSEXRw3Oh6dIVhIfzxprXD6TWafpO8bjl4g==
X-Received: by 2002:a0c:f485:: with SMTP id i5mr5365095qvm.144.1589573261453;
        Fri, 15 May 2020 13:07:41 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id 132sm2328246qkj.117.2020.05.15.13.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:07:41 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: ipa: don't use noirq suspend/resume callbacks
Date:   Fri, 15 May 2020 15:07:30 -0500
Message-Id: <20200515200731.2931-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515200731.2931-1-elder@linaro.org>
References: <20200515200731.2931-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the suspend and resume callbacks rather than suspend_noirq and
resume_noirq.  With IPA v4.2, we use the CHANNEL_STOP command to
implement a suspend, and without interrupts enabled, that command
won't complete.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index e0b1fe3c34f9..76d5108b8403 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -933,8 +933,8 @@ static int ipa_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops ipa_pm_ops = {
-	.suspend_noirq	= ipa_suspend,
-	.resume_noirq	= ipa_resume,
+	.suspend	= ipa_suspend,
+	.resume		= ipa_resume,
 };
 
 static struct platform_driver ipa_driver = {
-- 
2.20.1

