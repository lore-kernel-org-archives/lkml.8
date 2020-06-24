Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396D9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F24D20707
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XTlmQqsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390690AbgFXLlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:41:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58689 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbgFXLlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:41:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200624114137euoutp02a00fd59e4a85f32b6e347f5f1bb1baf2~beA6yI93c1752317523euoutp02E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:41:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200624114137euoutp02a00fd59e4a85f32b6e347f5f1bb1baf2~beA6yI93c1752317523euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592998897;
        bh=528msPEeeKbk20X6ucIg/zFrY6Boo/jOU+18Jk7kUgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTlmQqsxqgPhToYxHb3ALKE8Fovmdx4CYIJg9ikt1tH7TgyqD/RbqvjBL1/kX2Gx4
         XJD2ZgF6uAA89Um1ocvynSLdzY/kiPyCOFwzV2QuHKaRcBVL052yYbg/O7BlIpbEoR
         jBgV6fqykiyhcQNIs7h65DBdHeJfKh4NIe0FPs/M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200624114137eucas1p1a534acdb8d435a6cf47b1f66a846424f~beA6bu2uB2487924879eucas1p1K;
        Wed, 24 Jun 2020 11:41:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E0.1A.06456.1FB33FE5; Wed, 24
        Jun 2020 12:41:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f~beA6EzgEI2487924879eucas1p1J;
        Wed, 24 Jun 2020 11:41:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200624114136eusmtrp129f7028dd669bad7eb0477985e570453~beA6EEtO-0702007020eusmtrp1O;
        Wed, 24 Jun 2020 11:41:36 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-4d-5ef33bf1c91a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 84.53.06017.0FB33FE5; Wed, 24
        Jun 2020 12:41:36 +0100 (BST)
Received: from AMDC3748.digital.local (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200624114136eusmtip219790ef495719a8f910be072e9f0316f~beA5amx7E2617226172eusmtip2l;
        Wed, 24 Jun 2020 11:41:36 +0000 (GMT)
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
Subject: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept integer
 and pointer types
Date:   Wed, 24 Jun 2020 13:41:25 +0200
Message-Id: <20200624114127.3016-4-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624114127.3016-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUhUURjlzls1J55jNjeLpLF+JJiJhpfUqJR4BIr/iqTRqXku5NY8l8pA
        wSX3XJDSMsRywcyZxgWNTJ1MrXHMJUMtmaQgLMNqHLdSc3wj/Tv3O+d85/BxaUxiIJzoqNgE
        ThWriJaRtnhb38pbt18+JvnRyQUGTTUNEWi26CVAT++qCVQ284VEG23FGHpnnidR+kM1icaX
        ZjH0em4cRznFjyik/fyeQGPP7pNIV9YJ0JPeaQrpCkNQ5UIZdpJhx96PYOz8RCbFdi5W4WxH
        xTTF3ssuJ1htQw7JDhSNitiuykaKNeb1i9jmR6lsYUsDYLsLSnHWpN0fLL5g66vkoqOSOJX7
        iTDbyHp9Gojvcbr2c+ArlQb0jrnAhoaMF6wvGcRygS0tYeoBfDM6DoTHAoD51d+tjAnAasN3
        attiWmmxquoA7C2YJC3ElqVXLbVgkjkM15qF+S7GE942VFAWA8as4nD8VhaRC2jagQmFy1mu
        Fg3OHIKapp6tADHjDfuMVaQQ5gwfa7oxC7ZhECzJGNkKhswsBfsa80SCKABWmJcJATvAb/0t
        1qb7oL40HxdwKjTWZ2CCORvAVk0HJhA+8OPQKmkphG22Vj9zt0DInIIdPWcFuBNO/LC3iLFN
        WNJ2BxPGYpidJRF2HIBGQ6t1nxTWDJut7Vn46kuZSDhVHoALiytEEXCu+J9VBUADkHKJfEwE
        x3vEcslHeEUMnxgbceRyXIwWbH4y/Xr/73ZgHr2kAwwNZHZizadfcgmhSOKvx+gApDHZLvFp
        g14uESsV129wqrhQVWI0x+vAXhqXScWe1bMXJUyEIoG7wnHxnGqbFdE2Tmmg0T8qMrixtdTv
        Rbp8N+/SHXh5ubZn2Bie079j0NxcZ4rTzzw4E7yOdQat1f7Rpjg2KP2rb/rl9R4L9Tk/GoCf
        Ox92wCsDLlUGPXc5WB5y5m+GXciHqeCr7Xsy7wWlyG2iEwLLjwe6hSuTy6U7a4pAfLZzYof3
        huYn6ds1F5rWYi/D+UiFhyum4hX/ABHMHEBgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xe7ofrD/HGay8bG5xa905VouXEw4z
        WmycsZ7VYurDJ2wW/7dNZLa48vU9m0Xz4vVsFle/v2S2OPnmKotF58Ql7BabHl9jtbi8aw6b
        xaGpexkt1h65y25xqC/aYu6XqcwOAh6Xr11k9nh/o5XdY++3BSweO2fdZfeY3TGT1WPTqk42
        jxMTLjF57J+7ht3jfvdxJo/NS+o9+rasYvQ40DuZxePzJrkA3ig9m6L80pJUhYz84hJbpWhD
        CyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jBWnGxgLDkpVfDjxnL2B8bRoFyMn
        h4SAicTnn1sYuxi5OIQEljJKHPn6hA0iIS6xe/5bZghbWOLPtS42iKJPjBK/NkAk2AQ0Jf5u
        vgnWICJgLNF/dhY7SBGzQBurxNzzT9hBEsICsRKXW84zgtgsAqoSG9YdBIvzCphLHLu/AGqb
        vMTqDQfAhnIKWEhMarkIVi8EVHPo+mLWCYx8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+du
        YgRG17ZjP7fsYOx6F3yIUYCDUYmHd8ODj3FCrIllxZW5hxglOJiVRHidzp6OE+JNSaysSi3K
        jy8qzUktPsRoCnTURGYp0eR8YOTnlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1I
        LYLpY+LglGpgzHyWe33Sr6odrDr9/Lpa3bwmxtEJK04yNRb1xlw+cCctITmh7U6Hr8thySjd
        TaKNN8xnyP1zZO9JeNhfd9P80M42s31Lrj4r+q0d+iLy8SWRC4ky8n45veH5NzznVn+8zvh5
        inUcc8fd3P/Cf52ktxx1XVTmbbpNsfb293V8bX8Dl1b5LvFXYinOSDTUYi4qTgQAUptpfMQC
        AAA=
X-CMS-MailID: 20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f
References: <20200624114127.3016-1-a.hajda@samsung.com>
        <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many resource acquisition functions return error value encapsulated in
pointer instead of integer value. To simplify coding we can use macro
which will accept both types of error.
With this patch user can use:
	probe_err(dev, ptr, ...)
instead of:
	probe_err(dev, PTR_ERR(ptr), ...)
Without loosing old functionality:
	probe_err(dev, err, ...)

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/base/core.c    | 25 ++-----------------------
 include/linux/device.h | 25 ++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2a96954d5460..df283c62d9c0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3953,28 +3953,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
 
 #endif
 
-/**
- * probe_err - probe error check and log helper
- * @dev: the pointer to the struct device
- * @err: error value to test
- * @fmt: printf-style format string
- * @...: arguments as specified in the format string
- *
- * This helper implements common pattern present in probe functions for error
- * checking: print message if the error is not -EPROBE_DEFER and propagate it.
- * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
- * later by reading devices_deferred debugfs attribute.
- * It replaces code sequence:
- * 	if (err != -EPROBE_DEFER)
- * 		dev_err(dev, ...);
- * 	return err;
- * with
- * 	return probe_err(dev, err, ...);
- *
- * Returns @err.
- *
- */
-int probe_err(const struct device *dev, int err, const char *fmt, ...)
+int __probe_err(const struct device *dev, int err, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -3992,7 +3971,7 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(probe_err);
+EXPORT_SYMBOL_GPL(__probe_err);
 
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
diff --git a/include/linux/device.h b/include/linux/device.h
index 40a90d9bf799..22d3c3d4f461 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -965,7 +965,30 @@ void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
 
 extern __printf(3, 4)
-int probe_err(const struct device *dev, int err, const char *fmt, ...);
+int __probe_err(const struct device *dev, int err, const char *fmt, ...);
+
+/**
+ * probe_err - probe error check and log helper
+ * @dev: the pointer to the struct device
+ * @err: error value to test, can be integer or pointer type
+ * @fmt: printf-style format string
+ * @...: arguments as specified in the format string
+ *
+ * This helper implements common pattern present in probe functions for error
+ * checking: print message if the error is not -EPROBE_DEFER and propagate it.
+ * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
+ * later by reading devices_deferred debugfs attribute.
+ * It replaces code sequence:
+ * 	if (err != -EPROBE_DEFER)
+ * 		dev_err(dev, ...);
+ * 	return err;
+ * with
+ * 	return probe_err(dev, err, ...);
+ *
+ * Returns @err.
+ *
+ */
+#define probe_err(dev, err, args...) __probe_err(dev, (long)(err), args)
 
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
-- 
2.17.1

