Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE20C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0496120663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xws2Re/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCXF3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:29:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37024 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCXF3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 01:29:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id h72so6516932pfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 22:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iOae39ZLxu99CuZ+vnrVCDxAqMUSZVQXhKOAdACPP94=;
        b=Xws2Re/9sTHSdvoLV1C/OerGG2vrUwlHjn8SkyO979v8vRK17RnFwVd3H0acHLdvvg
         ZlupQaefxjOxmlP6rH7S9z+erIBgb5jDsaiC4qPL4xgg5/ukdWnLlklzlsap8kqfZHE4
         Y8po/0ZCrNbzx01lbbpLT58UlLKiR8ru+Yj6BTL8p785C0X/WDf3O2qjYzxDw0CzX7ch
         YJy5tbj5pI48qsGcNyz8pI8JbBK5ZZhX1v6PUwRubyVrKwZDnwXm4HliHhut+xtEJHFO
         XSaeXnVeU0U1s8EB7CUwrGeEFvV4MklAh6mouf1ZBIRhTcKdRvAnLvI2IxGlryOwr1je
         nWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOae39ZLxu99CuZ+vnrVCDxAqMUSZVQXhKOAdACPP94=;
        b=dslH+dVEJT/G4+jRKRSqRQXdomLoGyCq3wVP7Fg7d/4pKo8iyOs0lgsGbpQxoaK/Dg
         7QKXmZjGWucgdqC2ODKkECP6cVexocFnn/wSE0IEZOUptg7WJW+ambB+ihd77S8XFJWy
         XBYLuB3JOriR7qDOL02A9zp8f3tv3erHVUMu+acxmq21r4FCdX1Su2GFnl9ujVfLIATH
         kYGZsiILty3FuTgEtyr+XsWRWTYTn5ZeFhIzGoTuub07qXdQqQjxyhA2grm/xNJCUoq4
         6E5WLPynQoXdawHW/BNYalYcb9Z5FH6XOBhsDf30vcOhWgWic1Rrmu2EgVtrefs0tuJr
         Vlpw==
X-Gm-Message-State: ANhLgQ26zZoileXPXmDvx50InRb6KDIchaadtX5rihjbXVvuF/yUC32w
        57FIIMCYYy18xQu1WwhpB1jPog==
X-Google-Smtp-Source: ADFU+vsfiadgTn+esHQ2mswkV7PB2b9HK3iPvH/04B892CZM07osWa4KTdOAk/ZNirsq9SaTD4Tadg==
X-Received: by 2002:aa7:9f42:: with SMTP id h2mr13546696pfr.22.1585027751538;
        Mon, 23 Mar 2020 22:29:11 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j14sm2795413pgk.74.2020.03.23.22.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 22:29:10 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v5 2/4] remoteproc: Introduce "panic" callback in ops
Date:   Mon, 23 Mar 2020 22:29:02 -0700
Message-Id: <20200324052904.738594-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200324052904.738594-1-bjorn.andersson@linaro.org>
References: <20200324052904.738594-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce generic support for handling kernel panics in remoteproc
drivers, in order to allow operations needed for aiding in post mortem
system debugging, such as flushing caches etc.

The function can return a number of milliseconds needed by the remote to
"settle" and the core will wait the longest returned duration before
returning from the panic handler.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Reworded comment about delay
- Picked up Mathieu's r-b

 drivers/remoteproc/remoteproc_core.c | 43 ++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  3 ++
 2 files changed, 46 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 7ee976ee2044..e12a54e67588 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt)    "%s: " fmt, __func__
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -45,6 +46,7 @@
 
 static DEFINE_MUTEX(rproc_list_mutex);
 static LIST_HEAD(rproc_list);
+static struct notifier_block rproc_panic_nb;
 
 typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
 				 void *, int offset, int avail);
@@ -2236,10 +2238,50 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
 }
 EXPORT_SYMBOL(rproc_report_crash);
 
+static int rproc_panic_handler(struct notifier_block *nb, unsigned long event,
+			       void *ptr)
+{
+	unsigned int longest = 0;
+	struct rproc *rproc;
+	unsigned int d;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(rproc, &rproc_list, node) {
+		if (!rproc->ops->panic || rproc->state != RPROC_RUNNING)
+			continue;
+
+		d = rproc->ops->panic(rproc);
+		longest = max(longest, d);
+	}
+	rcu_read_unlock();
+
+	/*
+	 * Delay for the longest requested duration before returning. This can
+	 * be used by the remoteproc drivers to give the remote processor time
+	 * to perform any requested operations (such as flush caches), when
+	 * it's not possible to signal the Linux side due to the panic.
+	 */
+	mdelay(longest);
+
+	return NOTIFY_DONE;
+}
+
+static void __init rproc_init_panic(void)
+{
+	rproc_panic_nb.notifier_call = rproc_panic_handler;
+	atomic_notifier_chain_register(&panic_notifier_list, &rproc_panic_nb);
+}
+
+static void __exit rproc_exit_panic(void)
+{
+	atomic_notifier_chain_unregister(&panic_notifier_list, &rproc_panic_nb);
+}
+
 static int __init remoteproc_init(void)
 {
 	rproc_init_sysfs();
 	rproc_init_debugfs();
+	rproc_init_panic();
 
 	return 0;
 }
@@ -2249,6 +2291,7 @@ static void __exit remoteproc_exit(void)
 {
 	ida_destroy(&rproc_dev_index);
 
+	rproc_exit_panic();
 	rproc_exit_debugfs();
 	rproc_exit_sysfs();
 }
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index ed127b2d35ca..9c07d7958c53 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -369,6 +369,8 @@ enum rsc_handling_status {
  *			expects to find it
  * @sanity_check:	sanity check the fw image
  * @get_boot_addr:	get boot address to entry point specified in firmware
+ * @panic:	optional callback to react to system panic, core will delay
+ *		panic at least the returned number of milliseconds
  */
 struct rproc_ops {
 	int (*start)(struct rproc *rproc);
@@ -383,6 +385,7 @@ struct rproc_ops {
 	int (*load)(struct rproc *rproc, const struct firmware *fw);
 	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
 	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
+	unsigned long (*panic)(struct rproc *rproc);
 };
 
 /**
-- 
2.24.0

