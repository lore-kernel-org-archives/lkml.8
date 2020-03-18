Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF35C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE8F20724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W3UBXYh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCRPaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:30:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52072 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgCRPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:30:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id c187so2607351wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TaCGRE0ddOQFfvjcvGEAh9NQeOSr5Kg0auRkCXlkB9A=;
        b=W3UBXYh31RvR0blEgis0zhsMRI88hYEvr9oLOl8gVTXgiL9H0D3IGOkpXRn2H8Tx0N
         jqcmgyMkm9JIPIG+1Y6Q1Dll64O5ahHBkpmaZFR80mz8zCSOKQDjqFzWIZKgy/Pu5kif
         H4ifB/yWB4RuKk2xbgIh48z/zfOkFi95uAGogll5/j4+boNXtSZsrM3pAa2ggksq/e6W
         yT5pLTWvjOTRpdldS/MT94b6GuvuIc9AIh2746LBZrjjrSRNx2sDWjpNz00di+zxLRIC
         wqvRKklO9Vy+u8Ajti1mPqcLyoDKTaKUx4z8jNvzF1UZspk4GfRQT8OcbYDWPLZhV3bm
         6mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TaCGRE0ddOQFfvjcvGEAh9NQeOSr5Kg0auRkCXlkB9A=;
        b=QDRDOYMbI8OLYoDjyiatWrHyEz485c6TUo6gqMviP0wIza6xi7C4IIbtWaqy736YGP
         mvGCZFsY0OwOM4e4b+vWKPtwcgQ793JVFYdRe9YITzwTkEwAU12dtISwGxGMDX8QjlH5
         AI1FNu8z2uUfXf1l8ze56TcghC0KXQSw7gwTJwz9Sh3SUTKP/u+tYKLHY48RkaYnBNLL
         FFU0f0Fo5vaH8NivPP0rEVc3jIlv9rT3HJeT7Hc2gd4sjxojn33goRTYx75lHOufgem/
         fTrcisFFW2v8Ds1Ih8KD0QPFVBcD4XIyHvfnLQCRz6Ob4sQRqiPJkUkqpZPO70c+o2SJ
         hWsg==
X-Gm-Message-State: ANhLgQ38rq/I7JUhXotITE39RK71cMTk5RPXQBWlBcHmpI+FX5socliM
        6vOi1pGMey3m4KBsxKUkfiKr5g==
X-Google-Smtp-Source: ADFU+vsyKpeQKIsfzZhMgnHUIlxJK9C3vLhsK2vuOOu2pil/AdsY61Szi10LT/GQ7MH+tK+6zDJS1Q==
X-Received: by 2002:a05:600c:350:: with SMTP id u16mr5681702wmd.27.1584545399916;
        Wed, 18 Mar 2020 08:29:59 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l5sm9678228wro.15.2020.03.18.08.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Mar 2020 08:29:59 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] MAINTAINERS: Add linux-acpi list to PNP
Date:   Wed, 18 Mar 2020 15:29:51 +0000
Message-Id: <1584545391-20811-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As asked by the PNP maintainer, linux PNP patch should be CC to
the linux-acpi mailing list.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index be44251d1e04..4979de5c0c61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13452,6 +13452,7 @@ F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
 
 PNP SUPPORT
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
+L:	linux-acpi@vger.kernel.org
 S:	Maintained
 F:	include/linux/pnp.h
 F:	drivers/pnp/
-- 
2.24.1

