Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A18C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFD7215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BdwMJy5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCJPoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:44:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36654 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgCJPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:44:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so5585209plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2p+EcI7L/A1DVC/29xLNkKoAlt6wKb9qgS0/TTntts=;
        b=BdwMJy5ModIWnTns/Hmo1norAhn7toeZcwzhh1mWGCyafM1GB1p/TSRDLh5lDA5AC4
         N9RZvDG2r3PGnocKoaWGq5iva3cEoYDsb4ZkhbFBLQ7r0p4A2ua/jWhd9T4jLVvsExqB
         3ByWj2yt7V0RzcxEp/312/y+DaucUA2vIzpWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2p+EcI7L/A1DVC/29xLNkKoAlt6wKb9qgS0/TTntts=;
        b=GR6uU74Hi6C61MhP7BjkZ/e45nq/UyN7CNlSJf1rufHbyi+lmJXuzP4HBjs8ZMp4Ui
         bsdjn8fAtbMsJmzjEANhb/XvgdjZcpmKmmcCFX35GD6d1M2matAfYbXFmjcrXu1AErJw
         md8PfGIguYcWlDAjaBxvGjxreSb2fniZ7X535II7K+oMS1FzmZWM3/Bvy4ycy/SeP2Hw
         KQj8gWT4Hnrbsi90+/Mpky1id3K1Q08/HiPnPh9VlFQb7U1zaZhBoStMG/jkC3W28Zyy
         9xGTePoBzpoVN/NfUGZvrRIjQdgrR+lRGDeqoa8kjBY37CHbuieNHRCt5A44Cl7ITkxi
         wdww==
X-Gm-Message-State: ANhLgQ05xF7NV6XNpEGeKoKZ2uEa+kjisARh1eFGogUMkCgCHIiEctgT
        Utudk/JMzhJydVuZHckVCpUqOA==
X-Google-Smtp-Source: ADFU+vspG8Hr+OXyqIuMQSfkHHhLCVU2hiot8wjx0g6f9q8vljrpx0xyBhDfkfu5EpF55umf6MGrTQ==
X-Received: by 2002:a17:90b:4903:: with SMTP id kr3mr2329828pjb.3.1583855041356;
        Tue, 10 Mar 2020 08:44:01 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m12sm2731090pjk.20.2020.03.10.08.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:44:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v2 1/3] i2c: qcom-geni: Let firmware specify irq trigger flags
Date:   Tue, 10 Mar 2020 08:43:56 -0700
Message-Id: <20200310154358.39367-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200310154358.39367-1-swboyd@chromium.org>
References: <20200310154358.39367-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to force IRQF_TRIGGER_HIGH here as the DT or ACPI tables
should take care of this for us. Just use 0 instead so that we use the
flags from the firmware. Also, remove specify dev_name() for the irq
name so that we can get better information in /proc/interrupts about
which device is generating interrupts.

Cc: Alok Chauhan <alokc@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 17abf60c94ae..4efca130035a 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -549,8 +549,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	init_completion(&gi2c->done);
 	spin_lock_init(&gi2c->lock);
 	platform_set_drvdata(pdev, gi2c);
-	ret = devm_request_irq(&pdev->dev, gi2c->irq, geni_i2c_irq,
-			       IRQF_TRIGGER_HIGH, "i2c_geni", gi2c);
+	ret = devm_request_irq(&pdev->dev, gi2c->irq, geni_i2c_irq, 0,
+			       dev_name(&pdev->dev), gi2c);
 	if (ret) {
 		dev_err(&pdev->dev, "Request_irq failed:%d: err:%d\n",
 			gi2c->irq, ret);
-- 
Sent by a computer, using git, on the internet

