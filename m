Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E172BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B281321532
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ipgG6TEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgFZKBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:01:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40620 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgFZKBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:01:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200626100110euoutp0253982d622efcffff2579686941b79e9a~cD7x5_t8l2357523575euoutp027
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:01:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200626100110euoutp0253982d622efcffff2579686941b79e9a~cD7x5_t8l2357523575euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593165670;
        bh=3407dn9k5QQedWzfTAmf5rXvTScGYVbjSfdZVMHdevA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipgG6TEgxzP9cYzYOb0Fndx683NMic+WzY/grLfqk/jPI6vOe+z7GbIhKVmvspETy
         Klq/d+ujqIVCWw/jC424z2oaLvrImL9CQZW0fre/CJs+0KZPM7hL16/CMCZfA8CwxI
         krNjesUyHcwoCq8JMxh65RdmmaILqAEIVU62KO4k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200626100109eucas1p212f8a933788e87aeb64f79be106a9eec~cD7xcRLb81867418674eucas1p20;
        Fri, 26 Jun 2020 10:01:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0F.DB.06456.567C5FE5; Fri, 26
        Jun 2020 11:01:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200626100109eucas1p25331652d017cd17d21c0ae60541d1f73~cD7w3_ign0244402444eucas1p2t;
        Fri, 26 Jun 2020 10:01:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200626100109eusmtrp24ba8dd0378ed8a726946b16ba1a4d1d6~cD7w2We7Q1306813068eusmtrp2_;
        Fri, 26 Jun 2020 10:01:09 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-2f-5ef5c7658a64
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 22.86.06017.567C5FE5; Fri, 26
        Jun 2020 11:01:09 +0100 (BST)
Received: from AMDC3748.digital.local (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200626100108eusmtip17696631433fc09b000d8dedeaaeada88~cD7wImxm_2131121311eusmtip1_;
        Fri, 26 Jun 2020 10:01:08 +0000 (GMT)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
Subject: [PATCH v6 1/4] driver core: add device probe log helper
Date:   Fri, 26 Jun 2020 12:01:00 +0200
Message-Id: <20200626100103.18879-2-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626100103.18879-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0iTURjHOXsvezUXb1PxYJI5EFTIC0qcqMRC4v0SXaAkRWvmy6ycyl7n
        7YujctnyWonlhTTNxJWXpdbstpY4wzZMnahoJhliJIZulYKa2zvr2+85z/N//v9zOBQmNhO+
        1KX0LFaRLk2TkO54T/+qZR9rsieFr46Fo8k2C4EWyt8D1HmvnUCVs3Mk2uypwNCofYlE1xrb
        SWT9vYChDz+sOLpZ0SREuq9jBBrprSWRsfI1QE/7poXIWJqA6myVWAzNjIx9wpil8UIh8/pX
        Pc7oq6eFTE3RfYLRtd4kmYHyYQHztu6JkJm5ZRIwz5oKmNKuVsAYSu7gzIpuz0lRvPuhFDbt
        UjarCIu+4J5qL5wkMke9cxstSSrwZZcGuFGQjoJzmnlSA9wpMd0C4LJhHfCFDcCnOi3BFysA
        Ng5p8G3J82a1a+oxgGpjC/FPYtioxxxTJB0M159NkA72oiNhmbla6BjC6DUcWm+oCUfDk46B
        i59rBQ7G6UD4cmDJKRDRCK62vyJ5O3+o7TA4l7rRB2DVZInTDdKLQlhXPOzKFAvXzZ0Yz57w
        u6lLyLMf3NQ/EPBcAGdarmO8uAjA7g69S3AQTlnWttyorXjBsL03zIGQPgJtZTIed8LxReeD
        YVt4u6cK449FsEgt5ncEwBlzt2ufD3w0ZHelZ+CktsR5WzFdDGDDG1E58K/+b1UPQCvwYZWc
        XMZyEelsTignlXPKdFnoxQy5Dmx9ssEN0/ILYB9ONgKaAhIPkaHCliQmpNlcntwIIIVJvERH
        zYNJYlGKNC+fVWScVyjTWM4IdlO4xEcU+XAhUUzLpFnsFZbNZBXbXQHl5qsCp+0BKbs0OzLm
        lSFxvct+HXvXLzTMkl0dqlT1t3fm5GNTqQOnVLagnyvN3II+5XhkVnlfQpy3RXm4LflPtOJM
        TafnSIQsd2Z0f0JOgEpRZK1ODIy6rFWXxTf1L37cczd/7Zz2hCy2YHVN3tUnmC2cCBu1WyOD
        zqYteZisV+X6KAnOpUojQjAFJ/0Lq2KVvGADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7qpx7/GGRxay2Nxa905VouXEw4z
        WmycsZ7VYurDJ2wW/7dNZLa48vU9m0Xz4vVsFle/v2S2OPnmKotF58Ql7BabHl9jtbi8aw6b
        xaGpexkt1h65y25xqC/aYu6XqcwOAh6Xr11k9nh/o5XdY++3BSweO2fdZfeY3TGT1WPTqk42
        jxMTLjF57J+7ht3jfvdxJo/NS+o9+rasYvQ40DuZxePzJrkA3ig9m6L80pJUhYz84hJbpWhD
        CyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jK+tt1gLrohWLD4X18D4QLCLkZND
        QsBEYvuyNsYuRi4OIYGljBIde/exQyTEJXbPf8sMYQtL/LnWxQZR9IlRYuXMzywgCTYBTYm/
        m2+ygdgiAsYS/WdnsYMUMQu0sUrMPf8EbJKwgIPE23tzmEBsFgFVid0n3oM18ApYSPxcv4cN
        YoO8xOoNB8C2cQpYSky/1cvaxcgBtM1ConNJ5ARGvgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1
        kvNzNzECI2vbsZ9bdjB2vQs+xCjAwajEw3tg4pc4IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRW
        VqUW5ccXleakFh9iNAW6aSKzlGhyPjDq80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRm
        p6YWpBbB9DFxcEo1MObaTxD9IbqzIa1f8LXOg6rJR8P1+bqSvmYyenRtbir7+d9w+b1vv23f
        M4ZNa1miK71PNd5t66NeKWEPhpKjM128EmXmHTh5+FvsjP/avolmmfvT9t9apHbjVZixkunG
        2KU/vi/2SYg+urI1ivPHG5eOjFjO1q7Zbjfnno7cFqF+b1PDa6niOCWW4oxEQy3mouJEAJrA
        gH3CAgAA
X-CMS-MailID: 20200626100109eucas1p25331652d017cd17d21c0ae60541d1f73
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200626100109eucas1p25331652d017cd17d21c0ae60541d1f73
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200626100109eucas1p25331652d017cd17d21c0ae60541d1f73
References: <20200626100103.18879-1-a.hajda@samsung.com>
        <CGME20200626100109eucas1p25331652d017cd17d21c0ae60541d1f73@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe every time driver gets resource it should usually check for
error printk some message if it is not -EPROBE_DEFER and return the error.
This pattern is simple but requires adding few lines after any resource
acquisition code, as a result it is often omitted or implemented only
partially.
dev_err_probe helps to replace such code sequences with simple call,
so code:
	if (err != -EPROBE_DEFER)
		dev_err(dev, ...);
	return err;
becomes:
	return probe_err(dev, err, ...);

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/base/core.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67d39a90b45c..3a827c82933f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3953,6 +3953,48 @@ define_dev_printk_level(_dev_info, KERN_INFO);
 
 #endif
 
+/**
+ * dev_err_probe - probe error check and log helper
+ * @dev: the pointer to the struct device
+ * @err: error value to test
+ * @fmt: printf-style format string
+ * @...: arguments as specified in the format string
+ *
+ * This helper implements common pattern present in probe functions for error
+ * checking: print debug or error message depending if the error value is
+ * -EPROBE_DEFER and propagate error upwards.
+ * It replaces code sequence:
+ * 	if (err != -EPROBE_DEFER)
+ * 		dev_err(dev, ...);
+ * 	else
+ * 		dev_dbg(dev, ...);
+ * 	return err;
+ * with
+ * 	return dev_err_probe(dev, err, ...);
+ *
+ * Returns @err.
+ *
+ */
+int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	if (err != -EPROBE_DEFER)
+		dev_err(dev, "error %d: %pV", err, &vaf);
+	else
+		dev_dbg(dev, "error %d: %pV", err, &vaf);
+
+	va_end(args);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(dev_err_probe);
+
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
 	return fwnode && !IS_ERR(fwnode->secondary);
diff --git a/include/linux/device.h b/include/linux/device.h
index 15460a5ac024..6b2272ae9af8 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -964,6 +964,9 @@ void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
 
+extern __printf(3, 4)
+int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
-- 
2.17.1

