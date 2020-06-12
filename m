Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D212EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A635420792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="S9sT7t5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgFLL2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 07:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgFLL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 07:28:03 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD5AC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 04:28:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q19so9730693eja.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 04:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=x+EzCa13oBkDmmedkJhpOdOSq/9OAyMQhRjI6L6Gk/o=;
        b=S9sT7t5ZIpfYCDAbMcB8jwtLa9MGKk4nqPnImEddN0kepR2Z2qESMoSN67etrUmroP
         5QE5GwFi7YDu7pm2Eqp1OZ7LmU+DXSlFqm3Js6tHBg6u2TDbxzqtQu940+Cgd+XtqYhl
         //2bmHmnG6qgnSQSqHZ/epqvSiZ1jb8gbfaJX0fko6dCVNmJs4BFRpdReRJ9d76Ui4vY
         qgwSALEkjxQjQiiTAhpqu1t/sst2pzjGpuSjiz+7iL5YL6q9Yf4rqQBCxWyw1U2TplfR
         ou4iHSigiIisVr6BInNL7yCRKp2Uz+nkp1juM7ujUqL0KImK8i0aA00J+oiEpe6FJLet
         V0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=x+EzCa13oBkDmmedkJhpOdOSq/9OAyMQhRjI6L6Gk/o=;
        b=Aif5CId7taTYmhdUMN8gaF37fe45ATDV6IIQZe7+mm8TRTrwjws9Y0DOiIVcbOabTU
         yOWPg5cgkyvsw4S24Ph0aGgzQC5DrUOrOyZh0VdFFnUkUHUFZFokYNBt+4xyA4+dmPhQ
         GhWdQVzBbpKTfWbqqLNrmYVENoSKpxNH8RzNXyRPfhOiZFBAlbMXSJsz/bKzzDhc2Gpa
         OavwRFhFTXX0m6jElEx/uJ6PsDlSOTdKPv57fbmFDFHlZPgsLwu1BHx5nPKgn7lciLVp
         C0mRhIJ0uuBBx0MF5sTEd9ABRNIXlSzt2RZrAezICnGgrgURrrPnamDeXw5aHMz5wPUA
         mgdw==
X-Gm-Message-State: AOAM530Wzrx6fhxVTu5RM0YVlXT7jcJzgY9n98QTqX7IkHlW2kcAt5NZ
        MVWwNMbwfzTXHSjxCOSpul3AKg==
X-Google-Smtp-Source: ABdhPJz41qD396e8oQ3tm1hW5XAIn/LJUid1p+0iAEYyEf4Y0r8td0r8b0A9+lQuL6oaAsmx37Tuzg==
X-Received: by 2002:a17:906:3548:: with SMTP id s8mr12279231eja.202.1591961281224;
        Fri, 12 Jun 2020 04:28:01 -0700 (PDT)
Received: from x1 (i59F66838.versanet.de. [89.246.104.56])
        by smtp.gmail.com with ESMTPSA id y62sm2957534edy.61.2020.06.12.04.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 04:28:00 -0700 (PDT)
Date:   Fri, 12 Jun 2020 13:27:58 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH] pinctrl: single: fix function name in documentation
Message-ID: <20200612112758.GA3407886@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct the function name in the documentation for
"pcs_parse_one_pinctrl_entry()".

"smux_parse_one_pinctrl_entry()" appears to be an artifact from the
development of a prior patch series ("simple pinmux driver") which
transformed into pinctrl-single.

Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 drivers/pinctrl/pinctrl-single.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index a9d511982780..02f677eb1d53 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -958,7 +958,7 @@ static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
 }
 
 /**
- * smux_parse_one_pinctrl_entry() - parses a device tree mux entry
+ * pcs_parse_one_pinctrl_entry() - parses a device tree mux entry
  * @pctldev: pin controller device
  * @pcs: pinctrl driver instance
  * @np: device node of the mux entry
-- 
2.25.1

