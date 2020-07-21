Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B49C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5254D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3XTIZfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgGUOoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgGUOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:44:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBAAC061794;
        Tue, 21 Jul 2020 07:44:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so21450540wrs.11;
        Tue, 21 Jul 2020 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ZPgUCgCyCJ533zU9xgomZJ4ZfzK2nMz+2ShrXAvUbU=;
        b=p3XTIZfWJt7p1TwrtemIEqVnzN7N7bVOKtEgQPxc1uZUlzPq66EZC2BHNy8iKdYIX5
         50bW3qkA+DZR9HVBi63e7aHgl+LCPRrD3PRvlBrEDcDCrdQ2lYxmi2zQzh0K2jku6V0g
         /ihH3fteVL0ygeF9ycxUzplx86sg48D/voh0lNMxPnRY/4VfMLSYVV+JBMSQ8lHYf7uk
         4wXQCLE0Uw0tcZEtyX6PYj3pozeh2F8ZfWXWd7kaBaJwaqL996QiryIK18wDhyuoFvHE
         NnGTZWEdaxyRSTQQHKq3ZQiA8ZTujJrunY6nK+GkJc2nN7laMJvTlnpvhl+Fp6fxXIwW
         0kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ZPgUCgCyCJ533zU9xgomZJ4ZfzK2nMz+2ShrXAvUbU=;
        b=b3YBahOrAqc0GUchA4UNlY6oPXEtfi+itVuoC/ITISdTJ5Wyeka0ra7uyFeu7HBZmu
         me6SC7P12uJUWcoIk7SD/xcPQCwTzcS4FHbHxwUcU3ZDOBAP+GrWr7z7cnABD8H+81rZ
         g1PaNKEC2fW6JhUqQXKLDWJ5qGTqM8g+/uG/HCa8PfAIEJCBxY9MB5YcGwyWcdFD1H1a
         zWv5kxGu8QERYBQjcYLCYVBtr9X8B3kURQpCgp8IYL7hZAwvPj22tMu+ABOI2ZNhHb9X
         ET3SGxEwNleTzufbRE/KIVMi9lv4JPbS4mU1EOZIbtGh3UjBAvcY8CPb0ik1MVUyKak4
         3bxw==
X-Gm-Message-State: AOAM530d2BPkD3SgzTl5J6iLqXkucgoKsTwoms3SYhJGLCboa43Itq5h
        j5eylzTLRS7uWLnXW6yHgRtGtQon
X-Google-Smtp-Source: ABdhPJylMLSaczatjJBkMfzLMs3J8WiXu4RiECOgAlF4ZBv3ZtBQs+pSV6zf0tF43q+YwpTCHvP0qA==
X-Received: by 2002:adf:bc4b:: with SMTP id a11mr6240398wrh.381.1595342642251;
        Tue, 21 Jul 2020 07:44:02 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y6sm38043116wrr.74.2020.07.21.07.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:44:01 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Danesh Petigara <danesh.petigara@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v2 6/7] usb: bdc: Halt controller on suspend
Date:   Tue, 21 Jul 2020 10:43:25 -0400
Message-Id: <20200721144326.7976-7-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721144326.7976-1-alcooperx@gmail.com>
References: <20200721144326.7976-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danesh Petigara <danesh.petigara@broadcom.com>

GISB bus error kernel panics have been observed during S2 transition
tests on the 7271t platform. The errors are a result of the BDC
interrupt handler trying to access BDC register space after the
system's suspend callbacks have completed.

Adding a suspend hook to the BDC driver that halts the controller before
S2 entry thus preventing unwanted access to the BDC register space during
this transition.

Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 2c2f7aef7ba7..c1650247ea39 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -607,9 +607,14 @@ static int bdc_remove(struct platform_device *pdev)
 static int bdc_suspend(struct device *dev)
 {
 	struct bdc *bdc = dev_get_drvdata(dev);
+	int ret;
 
-	clk_disable_unprepare(bdc->clk);
-	return 0;
+	/* Halt the controller */
+	ret = bdc_stop(bdc);
+	if (!ret)
+		clk_disable_unprepare(bdc->clk);
+
+	return ret;
 }
 
 static int bdc_resume(struct device *dev)
-- 
2.17.1

