Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88560C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5642A20848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="lCcHcjXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgH1QOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:14:45 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:64593 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgH1QOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:14:39 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BdPn83mQHz12;
        Fri, 28 Aug 2020 18:14:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1598631277; bh=+l268Yhr5BVTwrZad9fGXbzA6y84l/JaX3Bbx5fuoU0=;
        h=Date:From:Subject:To:Cc:From;
        b=lCcHcjXUrDKVwyEzpEx0oMa7LhBVIZrLYtEOdUl9bmsEvDU2Fs8GMUGKxMvsFhLVd
         QjumDy4Sx1sL4nF851kPFfDvC9URyXMGGwxeaepV/3H1lmhJzdhxO8pXb1WO7JXlNQ
         zJE01U9A+vCVbNp8z2I/swgXor5sPBuXTX1yRe8mouR6t0SVpmQTCfXatv7gr41vf3
         8dTdCUEF99OVH9ZVJI3grwViI10I2V20qrPifBeoNSEUIwkfsmkiD/RgPf9BRblI+z
         0Em15qWd1P/Zd6+6+fe3yEAfjpQgRtmRDr9k52czQEcvQXFbAFZSqXGff8EGe2t008
         dTdk2hfHxtdmg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Fri, 28 Aug 2020 18:14:35 +0200
Message-Id: <ea3f973e4708919573026fdce52c264db147626d.1598630856.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] driver code: print symbolic error code
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() prepends the message with an error code. Let's make it
more readable by translating the code to a more recognisable symbol.

Fixes: a787e5400a1c ("driver core: add device probe log helper")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index ac1046a382bc..1a4706310b28 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4237,10 +4237,10 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 	vaf.va = &args;
 
 	if (err != -EPROBE_DEFER) {
-		dev_err(dev, "error %d: %pV", err, &vaf);
+		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
 	} else {
 		device_set_deferred_probe_reason(dev, &vaf);
-		dev_dbg(dev, "error %d: %pV", err, &vaf);
+		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
 	}
 
 	va_end(args);
-- 
2.20.1

