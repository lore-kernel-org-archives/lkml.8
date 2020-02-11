Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B012C352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60262080C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5gXZGhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBKAwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:52:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47016 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgBKAwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:52:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id k29so4546054pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 16:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rX0PBzoSiXMileVxtobQ0Y36WCYvZwaGtCft9G1Vwrs=;
        b=I5gXZGhIMfZbDhsF8nl8dGoCFMj9JkKDACq1y5Q7Zk/PYvXrGPnbQJ32y9WYMU1yY9
         p8RnNvMt4npKsAT6wRHlSt1dZBpnFsy+7EDuyXx6VFv69fEY3FoUBWxCpFq8UTAkAuEm
         uk1FoynnVK9V0fyLaiQzruIQN/b9z1QU+WPNiTbhCREc1dbzekA/mpv39DEkgw3tqXRv
         FO3eSZDh/yBG0/A78FA4xhBJaeqpJIlCYP8MWms5gpvto46GgJihe5/JGKf35cCpToyN
         KLxLpAU1RJ2vEddOd0niS4qWMMf1Y9V/4eQJGHQzls4aetpg5Qatf3VzPa4tTwKCMRM/
         iVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rX0PBzoSiXMileVxtobQ0Y36WCYvZwaGtCft9G1Vwrs=;
        b=H0EyhjWui3iKlVxRrltJuoltV9Po68jVXcbyYdR9tyHyW4zqtTm3JkDiilrVvCCEtj
         JiKpe+d0UxbU1L5NKLBb645MrdqaXQuPpWrS1uqfPCY926RZL5ka9JzNN+ukMhvic71/
         qu8ok7JE8BUmSTIKYQyPIaYAnYv0C0kfCCHpZ8lobh57Vz/2ot8YdSuMDtlaOeLsv3cI
         yEmPxWxV1J4sF7yez7f2PGTMPf48YbyYWwGLbg3CBPmVSW2qppDqpU6h7XEP45FpXvLg
         C6SHJvlx6TkE4G3rm3wyTuOpSAp58gXawvl77NMswfa/Z/KVN9PN7qOy0k+zO5G6pemR
         edzg==
X-Gm-Message-State: APjAAAUXgLeszf50sO2rGiQDGf+vFBipvOoFhZpAutL8KO3J1mITM8Yk
        5IY2ZgkzsNfVDWbpixLHh7xcV9/0mJo=
X-Google-Smtp-Source: APXvYqw8GRFeXo/k+HHUZZ4/EDdvNNPIehWjHGcgeUJJNTuZuFBNV1WNgjtwlbYQl77+7Jhmn3L58A==
X-Received: by 2002:a63:e011:: with SMTP id e17mr4423860pgh.49.1581382337169;
        Mon, 10 Feb 2020 16:52:17 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q21sm1538480pff.105.2020.02.10.16.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 16:52:16 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v3 6/8] remoteproc: Introduce "panic" callback in ops
Date:   Mon, 10 Feb 2020 16:50:57 -0800
Message-Id: <20200211005059.1377279-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200211005059.1377279-1-bjorn.andersson@linaro.org>
References: <20200211005059.1377279-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a "panic" function in the remoteproc ops table, to allow
remoteproc instances to perform operations needed in order to aid in
post mortem system debugging, such as flushing caches etc, when the
kernel panics. The function can return a number of milliseconds needed
by the remote to "settle" and the core will wait the longest returned
duration before returning from the panic handler.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Replace per-rproc notifier callback with one generic
- Move the mdelay() from the individual drivers to the core and sleep the
  longest returned duration. Drivers that doesn't need a delay can return 0.
- Unregister the notifier on exit

 drivers/remoteproc/remoteproc_core.c | 46 ++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  3 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e4f1f3..8b6932027d36 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt)    "%s: " fmt, __func__
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -43,6 +44,7 @@
 
 static DEFINE_MUTEX(rproc_list_mutex);
 static LIST_HEAD(rproc_list);
+static struct notifier_block rproc_panic_nb;
 
 typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
 				 void *, int offset, int avail);
@@ -2216,10 +2218,53 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
 }
 EXPORT_SYMBOL(rproc_report_crash);
 
+static int rproc_panic_handler(struct notifier_block *nb, unsigned long event,
+			       void *ptr)
+{
+	unsigned int longest = 0;
+	struct rproc *rproc;
+	unsigned int d;
+	int locked;
+
+	locked = mutex_trylock(&rproc_list_mutex);
+	if (!locked) {
+		pr_err("Failed to acquire rproc list lock, won't call panic functions\n");
+		return NOTIFY_DONE;
+	}
+
+	list_for_each_entry(rproc, &rproc_list, node) {
+		if (!rproc->ops->panic || rproc->state != RPROC_RUNNING)
+			continue;
+
+		d = rproc->ops->panic(rproc);
+		if (d > longest)
+			longest = d;
+	}
+
+	mutex_unlock(&rproc_list_mutex);
+
+	/* Delay panic for the longest requested duration */
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
@@ -2229,6 +2274,7 @@ static void __exit remoteproc_exit(void)
 {
 	ida_destroy(&rproc_dev_index);
 
+	rproc_exit_panic();
 	rproc_exit_debugfs();
 	rproc_exit_sysfs();
 }
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 16ad66683ad0..14f05f26cbcd 100644
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
 	u32 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
+	unsigned int (*panic)(struct rproc *rproc);
 };
 
 /**
-- 
2.24.0

