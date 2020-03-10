Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53BAC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E1320727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCJKTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:19:35 -0400
Received: from ns.iliad.fr ([212.27.33.1]:60832 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgCJKTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:19:34 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 3851D20020;
        Tue, 10 Mar 2020 11:19:33 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 23F5C1FF7A;
        Tue, 10 Mar 2020 11:19:33 +0100 (CET)
Subject: [PATCH v5 1/2] devres: Provide new helper for devm functions
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <e8221bff-3e2a-7607-c5c8-abcf9cebb1b5@free.fr>
Message-ID: <0b5c5f40-9118-1b87-6cf4-928107ccd20e@free.fr>
Date:   Tue, 10 Mar 2020 11:15:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e8221bff-3e2a-7607-c5c8-abcf9cebb1b5@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Mar 10 11:19:33 2020 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple wrapper for devres_alloc / devres_add.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/devres.c  | 28 ++++++++++++++++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 0bbb328bd17f..b4c18c105f39 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -685,6 +685,34 @@ int devres_release_group(struct device *dev, void *id)
 }
 EXPORT_SYMBOL_GPL(devres_release_group);
 
+/**
+ * devm_add - allocate and register new device resource
+ * @dev: device to add resource to
+ * @func: resource release function
+ * @arg: resource data
+ * @size: resource data size
+ *
+ * Simple wrapper for devres_alloc / devres_add.
+ * Releases the resource if the allocation failed.
+ *
+ * RETURNS:
+ * 0 on success, -ENOMEM otherwise.
+ */
+int devm_add(struct device *dev, dr_release_t func, void *arg, size_t size)
+{
+	void *data = devres_alloc(func, size, GFP_KERNEL);
+
+	if (!data) {
+		func(dev, arg);
+		return -ENOMEM;
+	}
+
+	memcpy(data, arg, size);
+	devres_add(dev, data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_add);
+
 /*
  * Custom devres actions allow inserting a simple function call
  * into the teadown sequence.
diff --git a/include/linux/device.h b/include/linux/device.h
index 0cd7c647c16c..55be3be9b276 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -247,6 +247,9 @@ void __iomem *devm_of_iomap(struct device *dev,
 			    struct device_node *node, int index,
 			    resource_size_t *size);
 
+int devm_add(struct device *dev, dr_release_t func, void *arg, size_t size);
+#define devm_vadd(dev, func, type, args...) \
+	devm_add(dev, func, &(struct type){args}, sizeof(struct type))
 /* allows to add/remove a custom action to devres stack */
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
-- 
2.17.1
