Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AC3C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0961A20704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMMrW+4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgDWSvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDWSu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:50:59 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E13BC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:50:59 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id x56so7885186qtc.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=A9o/1fjOsC5s5Fr0nJQ29JU4WvQHR0Kqyz/lYqRJhYg=;
        b=fMMrW+4mVw4osKe6koCLYXeSJJ1aRtIAQ0bX0BMoBxA/aNbIBihmOKQaHbUYi/365m
         zDKWmJ3w4MopN64tJ0OonZ//Ez+vcL92LZv1CP2vG+VnUWv30udBTZgIpRnHn5TKG0NQ
         ZLpBDmCmhreZMWct9RAWjjFMWcE9uI2cxn3XhbmaXqsBRkLYlGXQiZm2fJ+sWCRggYBF
         N6tEIkTc9bA/wqtmjyRBdh9uukDFWrIfvt7d3P1P50YoKdSdSsl5Zt6lohGJyMByjfmz
         VghYO27H6yLA3b3eO0Zpm3xT6vohvHG/1d+ovsTercfaxCzJ8RDpTEG/co0dDM5EFj6L
         /6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=A9o/1fjOsC5s5Fr0nJQ29JU4WvQHR0Kqyz/lYqRJhYg=;
        b=O+4qm0nCgZR8zGTA/nF2q8AjznemPju+624gUrH9zvb83qaXzTQ/QA6s2+UIAxB8Yy
         rh7bVHzScerETYuhq1BDqUDpXtHKkD1i+6sWJSUssOjzhSUz73ElX0g9ebkLaNUC08JM
         ukq4YjaOd+VXxG2qoZe4AnrzhDeCo7DgggfF8BntbgB+glXam1L/xGSIYL3DbC5HzCwS
         px8wcd8+Z83SbhggLNLliUgLKL8uvCI5rpALS4DztyAAUuqCi6sagK/k65wFgaA2mGmX
         HNENwHlIRwPcQDYme3aF75Ob2aR2oezuj+E7/bPTY54jhccfhz+23cLvvBnhN9K9x8Md
         15sA==
X-Gm-Message-State: AGi0PublXW0HS11cFQPG28Pw0fb+bGhDe7kH1gCbkQQNK6eNWJ2Tuu68
        CU4I3B6+vmB5YOGssxpLidvE/pk=
X-Google-Smtp-Source: APiQypL/yjgCBThNNDHGBCWV/dpRBlWm8PBAFNp7jDhn5eTIq1mWctfAl1pf6s0t+DasHruvn0JMJ4M=
X-Received: by 2002:ac8:5653:: with SMTP id 19mr5447074qtt.252.1587667858638;
 Thu, 23 Apr 2020 11:50:58 -0700 (PDT)
Date:   Thu, 23 Apr 2020 14:50:52 -0400
Message-Id: <20200423185052.143975-1-rcy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH] Add rcy@google.com as maintainer for drivers/staging/gasket
From:   Richard Yeh <rcy@google.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Richard C Yeh <rcy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard C Yeh <rcy@google.com>

After consultation with Todd Poynor and Jesse Barnes, I am
adding myself as a maintainer for drivers/staging/gasket

Signed-off-by: Richard C Yeh <rcy@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c1175fc0aadb..3a61de752219 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7036,6 +7036,7 @@ GASKET DRIVER FRAMEWORK
 M:	Rob Springer <rspringer@google.com>
 M:	Todd Poynor <toddpoynor@google.com>
 M:	Ben Chan <benchan@chromium.org>
+M:	Richard Yeh <rcy@google.com>
 S:	Maintained
 F:	drivers/staging/gasket/
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

