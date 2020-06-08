Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0127C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8F02074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KtRvm0FM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFHV56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgFHV56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:57:58 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81D7C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 14:57:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p21so9323293pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 14:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWZL+kux4yDhzDGbd5a35TWK1xHZ00dTohAmVgLX3eM=;
        b=KtRvm0FMKtiPbVuxwAkIVonwCkmmc+hCJFa+v5OdiA9+Kd85RX7E7Dz4su1hEFMAfC
         N0A+cMW+t6t/S1vbd1lbon+NR+2axYhEMd2KilR+OoBHlQQH6TGZAh4S69qP7stRdrmy
         z+5F/p1OZ19QuZpRriO3Zf8y1YXiv8zZ27CUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWZL+kux4yDhzDGbd5a35TWK1xHZ00dTohAmVgLX3eM=;
        b=B0sGCbiTaOdkgZnNMkblK+44CNeUFLTnQgR2DZOGfbEmS2ykTahcwKbuf+GHkM8pnx
         fY2S49FabviV85WvTBdqkEMQU3gmiMqkqX8veH2RuukcvtDVyDbDpmNZPowsMJXlSXPS
         EOiB6tCTFoihO5HYz8oYNSxJYNBF7DRJW66y/F/2ap+1VLU2QwcF4z/5/WMwuvAQUimP
         Xs/yBpUvTC7piXJpPDLVamZtnvWqtOL5p6S175yFxtnvF+tEDxAm4MofpEFNxmld6ty3
         xqWAUMCD5MQTg2mJIi/gorbD9m2zvh+dc4UWH2KhzlzlgLCrHCH222/VZD7KJMjjuLNP
         6n/w==
X-Gm-Message-State: AOAM531UpcCPKqEqiyQlPLXHXyu+p9Oy4MVX08qHaMlK1KC5LrwcB1SK
        +wWCYu2gs4T1f0HpMLgz8FUrGQ==
X-Google-Smtp-Source: ABdhPJw6qZECPnALxq8UhkvnYK5Ca+cc/l8hvamnwz7rk8VPhvUR8wajVlUTDW7w+FRS6bxZf8gmiQ==
X-Received: by 2002:a62:154f:: with SMTP id 76mr23212427pfv.322.1591653476006;
        Mon, 08 Jun 2020 14:57:56 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:1c5a:73fa:6d5a:5a3c])
        by smtp.gmail.com with ESMTPSA id p190sm8170178pfp.207.2020.06.08.14.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jun 2020 14:57:55 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Markus Elfring <elfring@users.sourceforge.net>,
        Evan Green <evgreen@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: smp2p: Safely acquire spinlock without IRQs
Date:   Mon,  8 Jun 2020 14:57:36 -0700
Message-Id: <20200608145653.1.Ideabf6dcdfc577cf39ce3d95b0e4aa1ac8b38f0c@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp2p_update_bits() should disable interrupts when it acquires its
spinlock. This is important because without the _irqsave, a priority
inversion can occur.

This function is called both with interrupts enabled in
qcom_q6v5_request_stop(), and with interrupts disabled in
ipa_smp2p_panic_notifier(). IRQ handling of spinlocks should be
consistent to avoid the panic notifier deadlocking because it's
sitting on the thread that's already got the lock via _request_stop().

Found via lockdep.

Fixes: 50e99641413e7 ("soc: qcom: smp2p: Qualcomm Shared Memory Point to Point")
Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/soc/qcom/smp2p.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 07183d731d747..a9709aae54abb 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -318,15 +318,16 @@ static int qcom_smp2p_inbound_entry(struct qcom_smp2p *smp2p,
 static int smp2p_update_bits(void *data, u32 mask, u32 value)
 {
 	struct smp2p_entry *entry = data;
+	unsigned long flags;
 	u32 orig;
 	u32 val;
 
-	spin_lock(&entry->lock);
+	spin_lock_irqsave(&entry->lock, flags);
 	val = orig = readl(entry->value);
 	val &= ~mask;
 	val |= value;
 	writel(val, entry->value);
-	spin_unlock(&entry->lock);
+	spin_unlock_irqrestore(&entry->lock, flags);
 
 	if (val != orig)
 		qcom_smp2p_kick(entry->smp2p);
-- 
2.24.1

