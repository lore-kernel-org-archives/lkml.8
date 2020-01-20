Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29BBC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DFB207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgATIzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:55:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60857 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:55:43 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1itSqH-0002Vt-QB; Mon, 20 Jan 2020 09:55:29 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1itSqF-0006s2-1P; Mon, 20 Jan 2020 09:55:27 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] driver core: convert probe error messages to use %de
Date:   Mon, 20 Jan 2020 09:55:08 +0100
Message-Id: <20200120085508.25522-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
References: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this change

	rtc-s35390a: probe of 3-0030 failed with error -EIO

is emitted instead of

	rtc-s35390a: probe of 3-0030 failed with error -5

. The former is more descriptive and so gives a better hint what is
actually broken. The actual value of the error code isn't of any
importance, so there is no relevant information lost.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/base/dd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d811e60610d3..e4e308ac187b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -620,13 +620,13 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		break;
 	case -ENODEV:
 	case -ENXIO:
-		pr_debug("%s: probe of %s rejects match %d\n",
+		pr_debug("%s: probe of %s rejects match %de\n",
 			 drv->name, dev_name(dev), ret);
 		break;
 	default:
 		/* driver matched but the probe failed */
 		printk(KERN_WARNING
-		       "%s: probe of %s failed with error %d\n",
+		       "%s: probe of %s failed with error %de\n",
 		       drv->name, dev_name(dev), ret);
 	}
 	/*
@@ -652,7 +652,7 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
 	ret = really_probe(dev, drv);
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
-	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
+	printk(KERN_DEBUG "probe of %s returned %de after %lld usecs\n",
 	       dev_name(dev), ret, (s64) ktime_to_us(delta));
 	return ret;
 }
@@ -813,7 +813,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 		dev_dbg(dev, "Device match requests probe deferral\n");
 		driver_deferred_probe_add(dev);
 	} else if (ret < 0) {
-		dev_dbg(dev, "Bus failed to match device: %d", ret);
+		dev_dbg(dev, "Bus failed to match device: %de", ret);
 		return ret;
 	} /* ret > 0 means positive match */
 
@@ -1046,7 +1046,7 @@ static int __driver_attach(struct device *dev, void *data)
 		dev_dbg(dev, "Device match requests probe deferral\n");
 		driver_deferred_probe_add(dev);
 	} else if (ret < 0) {
-		dev_dbg(dev, "Bus failed to match device: %d", ret);
+		dev_dbg(dev, "Bus failed to match device: %de", ret);
 		return ret;
 	} /* ret > 0 means positive match */
 
-- 
2.24.0

