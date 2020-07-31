Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B044C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A4021744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kc0NekPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbgGaQtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733290AbgGaQtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:49:15 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A23BC0611E0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:49:13 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p16so15080452ile.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AU7itzG3fOE6KUAsG0umiG6Zq2Rv0f3naycGhvQ89PE=;
        b=kc0NekPMGwS8K5ELb4t/cdoHr1nkTenMQzPABWn1cr20jAKOBFHBDXblbGi6/jlMab
         VvSoBIhoIeTnIDM9vklyuvivHkIuYLqbId7OIn6jCXkdD4u5xyhzFQH0rZGF1GAkGGFH
         PBQrxlHmjdyXVhHklFI9m+Ls05bQCyarvnS7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AU7itzG3fOE6KUAsG0umiG6Zq2Rv0f3naycGhvQ89PE=;
        b=Aj2354avyX576yw3v8SrZN6FnxeHsSzWdA3Cg3xpi45SFrhUocGBVb0N6BO6EP7LpG
         AbZGvODU+rR0kNgUA2FkkJQDhWTSzx0z8xUtr5205U1UXkaIMLbMsQtbLFxkb2SJ0iGN
         A1UZtqo/eymEvkURotzdxK0FFeOjK2skBRwoHtcljq7A0omjG9eSeti3YznZVZo0xb/p
         QwGitx179qLv+uFgwpYgJwzEc9f6COPY/bUG7D11BbXcmCkWRUFA4J+1x1Q5lNPC5avY
         BS02vjZ77/tiJ2Z3QUZr55faAnWIPMksRNg6+G+F3bh0c8ySZkoBeVN57Bj5fS6GJxi1
         pB5w==
X-Gm-Message-State: AOAM533KYe2DNwd/8HvY0FzSiOcTszMpV4bbFuuAJUSr4Rrx/IyE+Q70
        1mIMxiTs+Rc8fDnF996BVaMSlUSHHIz9vw==
X-Google-Smtp-Source: ABdhPJxy4WksgY5qoSLQIw0LnwfLVyLP2ng0Hl+eFA1fDlDDKYKjg4LCq/zbc/IBIuRgoUPxRHLFUQ==
X-Received: by 2002:a92:4a09:: with SMTP id m9mr4783559ilf.79.1596214152801;
        Fri, 31 Jul 2020 09:49:12 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:49:12 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 15/15] iio: sx9310: Use irq trigger flags from firmware
Date:   Fri, 31 Jul 2020 10:48:52 -0600
Message-Id: <20200731104555.v3.15.I4c344a6793007001bbb3c1c08e96d3acf893b36b@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

We shouldn't need to set default irq trigger flags here as the firmware
should have properly indicated the trigger type, i.e. level low, in the
DT or ACPI tables.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Daniel Campello <campello@chromium.org>
---

Changes in v3:
 - Added irq trigger flags commit to the series.

Changes in v2: None

 drivers/iio/proximity/sx9310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index a20cd6a4dad729..c41fa7f6558e3f 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -951,7 +951,7 @@ static int sx9310_probe(struct i2c_client *client)
 		ret = devm_request_threaded_irq(dev, client->irq,
 						sx9310_irq_handler,
 						sx9310_irq_thread_handler,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						IRQF_ONESHOT,
 						"sx9310_event", indio_dev);
 		if (ret)
 			return ret;
-- 
2.28.0.163.g6104cc2f0b6-goog

