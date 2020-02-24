Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E4BC38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBC520838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fX6gOAhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBXUAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:00:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52525 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXUAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:00:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so594066wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=be3OLDvZjaaCLb2N4/McyE8bRru+5jOJxsIJGLhs4nw=;
        b=fX6gOAhx8b73cz8EUpQ/jgkt3S93jGE+z4ZdUaRM1tkSf+PCMIHSFQRqqMlIX8+Q3Q
         EqmsMQervzKWbKtUX5QTeN2mb4m85domRTOS5bLh6RUUy4JnpIIhTqK6kIFjPLEg33TU
         5ZxlOZQBiuhay93ikxYCrE0qCV3a5ync5jaXl50a3XYrKhLSv0Wka9zdPsqoWAHZc2/p
         D05DVG3pnBqSoyqhK8890kn6WklayTC2dXiTLZgV93sXqDisXHEzLAfwOJdIktiTy4wE
         32Bth4tsHFlmjrdKa9O1K0mCZL+RDfKKQVv5kpvgbMS/2l1Ccb67IydKXynBWlCKz+fb
         CHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=be3OLDvZjaaCLb2N4/McyE8bRru+5jOJxsIJGLhs4nw=;
        b=ceHorSXg9+W+Hihdv14AdB22z7cwdxKLg0PLdfq4h6g/6K7YBj11nqV4edvlsgNB5b
         jLtgzoe7el9KRo8QJAivMiCSsJ5VoL4qcrDaho5gfamrU4Wvkc+QTPfuud1qkpxn1FCr
         7KZ9rt7uHvmt7WheQh5DpmmRa+MJ7RHMXTKeeFQbTrhY6/YoCCNsBLB9Uca0HRYN7UhA
         zER/eo+c+Cuz0hwj80iz1cHn+cQto7AuH1BjPPRCnfnGm721yY+vapDbBCM6HgXsPE4w
         YXuly8xn/GgGRi4KEeMwqYXDqMwbAF2dkVV0r3Lvsca1hcafEwmg58qR5JCLtT2WsZpW
         f2dg==
X-Gm-Message-State: APjAAAUUM2+y2UyXwUwbkAIHyD7obbxP0mu9C30RBGMRp5E9nbeLhZPg
        rY/PPS9hyl2vY7u4Ep7NqmMXVw==
X-Google-Smtp-Source: APXvYqw1PAyesBCFhW7XC0aap5Vj1zeppo49e9+OwqWKWTOCpiwYLd2srxthSS2BSAzqyR7x5oBRfA==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr624787wmn.47.1582574429658;
        Mon, 24 Feb 2020 12:00:29 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e22sm624250wme.45.2020.02.24.12.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Feb 2020 12:00:29 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] PNP: add missing include/linux/pnp.h in MAINTAINERS
Date:   Mon, 24 Feb 2020 20:00:07 +0000
Message-Id: <1582574407-27214-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/pnp.h should be part of PNP in MAINTAINERS.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b85f22b9b69..5b1574631b21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13404,6 +13404,7 @@ F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
 PNP SUPPORT
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
 S:	Maintained
+F:	include/linux/pnp.h
 F:	drivers/pnp/
 
 POSIX CLOCKS and TIMERS
-- 
2.24.1

