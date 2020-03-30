Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1244BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8B2206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1cFkXMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgC3U1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:27:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38366 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgC3U1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:27:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id x7so9216226pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5kwrCgZfkDCR5kojZgtUr75C5RmgBcKGuDCcFWeq9ps=;
        b=y1cFkXMZFV9ho+nVsFjYO29N0pTcxmjmPUUqukKfRxUi/J0XQctotRFc1U7AQA2/yR
         HBrf7EQl11HCCdXZHhPdsmLywrPkSHJeEZ2s4e88nJPhMv1k0brSEf1EfT98PVM8601n
         R6AfAy3XI3NsRin+/KsBqrTAHPf7bmRjiJT3EXtcdnJaWHdTTgaHdszUc9FRNAR/33R/
         T/gtLlotKPspu5/tJKXz9aRQ3iuKTW7H7hWTg4y66YRaVVTzlydeyW6oskphnpZPYhBt
         7RFag9tDIAE6hIeh5eVVFJRZovqjOmQJmg8LKtotMoLdAfQk4QGIZ9gHqy0bNwxnXdT3
         GF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5kwrCgZfkDCR5kojZgtUr75C5RmgBcKGuDCcFWeq9ps=;
        b=dc6L2K1NWgitdPE5N6zkU6290D4IL9XDFozgnpx0WUwcNGD5CCVjHUPXUacyAp2bdL
         B9iDV2djqfhOd4GVL7wu3wXogKevQAyESj3ETwTBHOD1iQL4P+jBNnkBzw+YNMzcm0u2
         edjp7r5c8/ReKDkMoX3ta34IUY5YqorpcNIiKlF+GIK3+6TijqMzYG/FoWyZHx0UqctY
         JZt6p+SpklYDMQWp5GvP9xzmpUNIcbnxA7Tx1RPXMcK+7+TWoABrPxT9xZ4dt2pJ/CoV
         89Efk/rEwXHgcMg48S2wMEhRFh8w97NktoDqHjx8zRhbR79bqdr89jPOs8FuymUMzyTZ
         la/w==
X-Gm-Message-State: ANhLgQ3d6erwgHocMglYbk2Ed9W+DXHKWcjDApqIgSC0OV2TgWi5klEV
        yx7wcGQWofXhWM4wRrkyMybEvVD7wq0=
X-Google-Smtp-Source: ADFU+vsrs02AnlgYDEXJGGhQIIEcONZIZpe5Yv9E5HIIBsANslv46K41gLCQJYv1pi9dy5y8wl/jZw==
X-Received: by 2002:a63:a069:: with SMTP id u41mr14237169pgn.3.1585600040315;
        Mon, 30 Mar 2020 13:27:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y22sm10853628pfr.68.2020.03.30.13.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 13:27:19 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] driver core: Use dev_warn() instead of dev_WARN() for deferred_probe_timeout warnings
Date:   Mon, 30 Mar 2020 20:27:15 +0000
Message-Id: <20200330202715.86609-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c8c43cee29f6 ("driver core: Fix
driver_deferred_probe_check_state() logic") and following
changes the logic was changes slightly so that if there is no
driver to match whats found in the dtb, we wait 30 seconds
for modules to be loaded by userland, and then timeout, where
as previously we'd print "ignoring dependency for device,
assuming no driver" and immediately return -ENODEV after
initcall_done.

However, in the timeout case (which previously existed but was
practicaly un-used without a boot argument), the timeout message
uses dev_WARN(). This means folks are now seeing a big backtrace
in their boot logs if there a entry in their dts that doesn't
have a driver.

To fix this, lets use dev_warn(), instead of dev_WARN() to match
the previous error path.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Basil Eljuse <Basil.Eljuse@arm.com>
Cc: Ferry Toth <fntoth@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Anders Roxell <anders.roxell@linaro.org>
Fixes: c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state() logic")
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 06ec0e851fa1..ca1652221c1a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -267,7 +267,7 @@ int driver_deferred_probe_check_state(struct device *dev)
 	}
 
 	if (!driver_deferred_probe_timeout) {
-		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
+		dev_warn(dev, "deferred probe timeout, ignoring dependency");
 		return -ETIMEDOUT;
 	}
 
-- 
2.17.1

