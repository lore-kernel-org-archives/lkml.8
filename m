Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A442BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828C920672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OP7uzmLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbgF2TiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:38:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47331 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387473AbgF2Thz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:37:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200629112249euoutp02d52adebce8a515b0d9cc2b19c559f012~c-_7TKZNq1987519875euoutp02T
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:22:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200629112249euoutp02d52adebce8a515b0d9cc2b19c559f012~c-_7TKZNq1987519875euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593429769;
        bh=wssmSSMaPF7CImaevv1vsgWSyL4FhXmVP1cwotetOaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OP7uzmLKmDoWUpOXcxFCcZPP+3izi1IaDsNnlTYOpyV7Vt8jcXLvKVUX62U7tZLqr
         8/5ogTTZyMKhLi7IXTupVO/jc5byWpH+m3fwGgX2hPv/JbEJOb5l1Mm4z/erFcTzW4
         JCAiSniFH44G0WCMTGxPs0JzNOaUabR2o9Pyqe5Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200629112248eucas1p1e955f3406a049db1026fd70bf7b7cf37~c-_6su_Ni1033510335eucas1p1l;
        Mon, 29 Jun 2020 11:22:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BC.A7.06456.80FC9FE5; Mon, 29
        Jun 2020 12:22:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200629112248eucas1p187e5dac2f4f6120aacbc86e48ad0fff9~c-_6SUG4N1890518905eucas1p1T;
        Mon, 29 Jun 2020 11:22:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200629112248eusmtrp2595e9175d804508d8e50c56bf97ec1bf~c-_6Rjh9M1939019390eusmtrp2b;
        Mon, 29 Jun 2020 11:22:48 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-c1-5ef9cf08013f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DA.EC.06017.80FC9FE5; Mon, 29
        Jun 2020 12:22:48 +0100 (BST)
Received: from AMDC3748.digital.local (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200629112247eusmtip109ae075f9a8cb05d25252e50db7e5a84~c-_5f8y2e2177921779eusmtip13;
        Mon, 29 Jun 2020 11:22:47 +0000 (GMT)
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
Subject: [PATCH v7 1/4] driver core: add device probe log helper
Date:   Mon, 29 Jun 2020 13:22:39 +0200
Message-Id: <20200629112242.18380-2-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629112242.18380-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUxTQRSGnd4VYsmlIoxIBBqXQIJL0DgGFzA+XN9c3jAgVa9IoAVbCmJi
        MChYakUoEoRKNLIUUBarNIJRsRqqYKGySRUsgj4UFVRAUlSw5aK+fef/zzYnQ2MiC+FPJ8hS
        OblMkiQmPXFjm7MzjO5yxm4sN69Db+o7CeTIfwrQnasNBCp6/4FE88YCDPVOT5DoXHkDifpm
        HBh68bkPR7kFFRQyjPYTqKflGolMRQ8Bqns2RCFT3iFUNlWERTJsT/8rjJ0YyKbYhz9u4Gxz
        6RDF6lQlBGuozSXZ5/ndAvZx2W2KtV80C9i7FZls3r1awLZeKsTZScOqfcJoz+3HuKSENE6+
        YWec54n27jEiReN7SjViw84CrUgNPGjIbIbOd/OYGnjSIqYawOFXL3E+mALw7WCegA8mAWwp
        t7oCaqGkMZqX9QCOthnBv4LWKTXubksyIfD3XRvpZh8mHF62lFLuJIyZxWHfhRzCbSxjImGu
        fghzM86sgYV1BZSbhQyCH79+Ivj9AuGtxtaFHA9mG+yxlgBed1Awr/gkz3tgpUO/mL8Mjpnv
        UTwHwPnm6wKeM6G9+vzCOyGjArCpsRnjjQg42Dnr2pR2bRcCG1o28HIU/NVWgrtlyHjBgS/e
        bhlzodZYjPGyEKpyFq8YDO2WpsWGfrDSOk3yzMKXP3Mp/j4aAKuNOkE+CCz9P+wGALXAj1Mq
        pPGcYpOMS1+vkEgVSln8+qPJUgNwfbKOOfP3+2C6+4gJMDQQLxXGdTpjRYQkTZEhNQFIY2If
        4W5LR6xIeEyScZqTJx+WK5M4hQmspHGxnzD8piNGxMRLUrlEjkvh5H9dAe3hfxZolpeNO+W+
        q+2JGVt7l4RUBhhtQkdAVBXzYNY7y5YeZI7TPFkXGnGwTt/S1w9Cd6jNXQYtWf8iGzsw/Hg8
        NebK/uPOsFhrwa6gLVXt02vPKGt02PADq1ne+y15c/+jDI+s9EeW4DmdQJ1ZM/VjRdNrbXHN
        3sj62rGRMa+Zd752Ma44IdkUiskVkj9CWkN8YAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7oc53/GGTQ18VjcWneO1eLlhMOM
        FhtnrGe1mPrwCZvF/20TmS2ufH3PZtG8eD2bxdXvL5ktTr65ymLROXEJu8Wmx9dYLS7vmsNm
        cWjqXkaLtUfuslsc6ou2mPtlKrODgMflaxeZPd7faGX32PttAYvHzll32T1md8xk9di0qpPN
        48SES0we++euYfe4332cyWPzknqPvi2rGD0O9E5m8fi8SS6AN0rPpii/tCRVISO/uMRWKdrQ
        wkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv49SlV6wFPWIVHY9uMjcwThLqYmTn
        kBAwkdgQ1cXIxSEksJRRYtXu26xdjJxAYXGJ3fPfMkPYwhJ/rnWxQRR9YpToXH4KrIhNQFPi
        7+abbCC2iICxRP/ZWewgRcwCbawSc88/YQdJCAs4ADXcBZvEIqAqMXntRLA4r4CFxNMPr6G2
        yUus3nAArIZTwFLi8oWZjCC2EFDNhaOd7BMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P
        3cQIjKxtx35u2cHY9S74EKMAB6MSD2/CuZ9xQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEot
        yo8vKs1JLT7EaAp01ERmKdHkfGDU55XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0t
        SC2C6WPi4JRqYEzp2lpw5MyN/f8zTk8OlVp4d9rjVWYxlWw/P68UDhbomxn/P3Hxi68G0Qoh
        JqF5ulxpYlWBR69cE2FQllGUPXE/VOzigaVWS89eiHn0syfmFVOke6PD1X+f3t06GGslqKVZ
        p2ZZtKd/mcvZqFshESXa3bpdtxya3XMDLq+K7XnROOG9iYhdoBJLcUaioRZzUXEiAFiu5E7C
        AgAA
X-CMS-MailID: 20200629112248eucas1p187e5dac2f4f6120aacbc86e48ad0fff9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200629112248eucas1p187e5dac2f4f6120aacbc86e48ad0fff9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200629112248eucas1p187e5dac2f4f6120aacbc86e48ad0fff9
References: <20200629112242.18380-1-a.hajda@samsung.com>
        <CGME20200629112248eucas1p187e5dac2f4f6120aacbc86e48ad0fff9@eucas1p1.samsung.com>
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
	return dev_err_probe(dev, err, ...);

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
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

