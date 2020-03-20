Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA05C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9861620753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wxfu5U51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgCTQxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:53:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35595 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgCTQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:53:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id g6so2749889plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtHUB89DolDqM6L2P5lxuDFAtkai+HEJcabiLC8D/6g=;
        b=Wxfu5U51vAodEE7GBQ/C8FI0eLvFUs4E93x7QRv5O2KOU7GMv0XNwkOlKQVcymwoGQ
         fbMFim3bmw78jsQK7aOCyy9JC/p5ZfgnziDNI3ZBBIXcIkoqg2//82Eip+zvvLxjDim7
         dBh/Bhjb8OBxlIDnCG6v5vfocgywqSMtfWpVG5fXgIrSc+LdiFRPzn3ub29kswjxETR+
         7esj/liEzb97VaghBBTu3JBcx008smWMVv3C3C22EbwlJmI16n4zogGSkmiYtaUdm5no
         kBvsqHYakO4l5QaRrOT6jPlHP7ZO08Q9r4hSddy/sTWqnTGAbhaVBFJeUsYACZTAxMuG
         /i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtHUB89DolDqM6L2P5lxuDFAtkai+HEJcabiLC8D/6g=;
        b=tCdMW4bY/t0G6SRUlHW9jmleJ+OJeAMPEJHCaSI2HYBKOtjJ7y/EjRLXSXbUVi0VCf
         WAVDrDM+ZeW1VX8wFf49sbLzaHEiBChVaitbzeB0/gwbjdKqRQZbyJa1znFgHmH1dn9f
         sSacQV86Zr/Sbwo7D426qIKnOmjpZvRu3y/z+grcCyhTg+BosFlfEhy7BMS3tMteX5gZ
         5Yo5ARQ9gRCSoHWO1CVFzLBBryo2k3Gfhnd6NplDQoA3tEDjQ1cMWbSTVgBDtV6w3eoe
         uPM/xcOHzVi1LrhlCtfacEt9/kBsFF7o/RVIstqgXw3svlKmPCx0zjjTWp8ItzN8hEn0
         SNgw==
X-Gm-Message-State: ANhLgQ10uKiXUMfeNs0TgjdZ7DZk/WqWhdmsLM4Q892WMY5hiD1waryf
        I74/pAtZ6mjNUrz0ObXYiAwu3g==
X-Google-Smtp-Source: ADFU+vvQi3trSv3Drb14gpBB8W7jjQOcElpUNhxx3/3LykuggwtTWSqGmQAsZgLVG1N5YFc41NbQ+w==
X-Received: by 2002:a17:90a:8806:: with SMTP id s6mr10666576pjn.141.1584723188224;
        Fri, 20 Mar 2020 09:53:08 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x17sm6064216pfn.16.2020.03.20.09.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:53:07 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     mike.leach@linaro.org, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 03/12] coresight: cti: Add sysfs access to program function registers
Date:   Fri, 20 Mar 2020 10:52:54 -0600
Message-Id: <20200320165303.13681-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320165303.13681-1-mathieu.poirier@linaro.org>
References: <20200320165303.13681-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Adds in sysfs programming support for the CTI function register sets.
Allows direct manipulation of channel / trigger association registers.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |   9 +
 .../hwtracing/coresight/coresight-cti-sysfs.c | 361 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-cti.c   |  19 +
 drivers/hwtracing/coresight/coresight-cti.h   |   8 +
 4 files changed, 397 insertions(+)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 45d3822c8c8c..83e841be1081 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -122,4 +122,13 @@ config CORESIGHT_CTI
 	  halt compared to disabling sources and sinks normally in driver
 	  software.
 
+config CORESIGHT_CTI_INTEGRATION_REGS
+	bool "Access CTI CoreSight Integration Registers"
+	depends on CORESIGHT_CTI
+	help
+	  This option adds support for the CoreSight integration registers on
+	  this device. The integration registers allow the exploration of the
+	  CTI trigger connections between this and other devices.These
+	  registers are not used in normal operation and can leave devices in
+	  an inconsistent state.
 endif
diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index 378b435d9a8f..40d31d73b27c 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -120,6 +120,361 @@ static struct attribute *coresight_cti_mgmt_attrs[] = {
 	NULL,
 };
 
+/* CTI low level programming registers */
+
+/*
+ * Show a simple 32 bit value if enabled and powered.
+ * If inaccessible & pcached_val not NULL then show cached value.
+ */
+static ssize_t cti_reg32_show(struct device *dev, char *buf,
+			      u32 *pcached_val, int reg_offset)
+{
+	u32 val = 0;
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct cti_config *config = &drvdata->config;
+
+	spin_lock(&drvdata->spinlock);
+	if ((reg_offset >= 0) && cti_active(config)) {
+		CS_UNLOCK(drvdata->base);
+		val = readl_relaxed(drvdata->base + reg_offset);
+		if (pcached_val)
+			*pcached_val = val;
+		CS_LOCK(drvdata->base);
+	} else if (pcached_val) {
+		val = *pcached_val;
+	}
+	spin_unlock(&drvdata->spinlock);
+	return sprintf(buf, "%#x\n", val);
+}
+
+/*
+ * Store a simple 32 bit value.
+ * If pcached_val not NULL, then copy to here too,
+ * if reg_offset >= 0 then write through if enabled.
+ */
+static ssize_t cti_reg32_store(struct device *dev, const char *buf,
+			       size_t size, u32 *pcached_val, int reg_offset)
+{
+	unsigned long val;
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct cti_config *config = &drvdata->config;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	/* local store */
+	if (pcached_val)
+		*pcached_val = (u32)val;
+
+	/* write through if offset and enabled */
+	if ((reg_offset >= 0) && cti_active(config))
+		cti_write_single_reg(drvdata, reg_offset, val);
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+
+/* Standard macro for simple rw cti config registers */
+#define cti_config_reg32_rw(name, cfgname, offset)			\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr,		\
+			   char *buf)					\
+{									\
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);	\
+	return cti_reg32_show(dev, buf,					\
+			      &drvdata->config.cfgname, offset);	\
+}									\
+									\
+static ssize_t name##_store(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t size)		\
+{									\
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);	\
+	return cti_reg32_store(dev, buf, size,				\
+			       &drvdata->config.cfgname, offset);	\
+}									\
+static DEVICE_ATTR_RW(name)
+
+static ssize_t inout_sel_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	u32 val;
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	val = (u32)drvdata->config.ctiinout_sel;
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t inout_sel_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	unsigned long val;
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+	if (val > (CTIINOUTEN_MAX - 1))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->config.ctiinout_sel = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(inout_sel);
+
+static ssize_t inen_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	unsigned long val;
+	int index;
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	spin_lock(&drvdata->spinlock);
+	index = drvdata->config.ctiinout_sel;
+	val = drvdata->config.ctiinen[index];
+	spin_unlock(&drvdata->spinlock);
+	return sprintf(buf, "%#lx\n", val);
+}
+
+static ssize_t inen_store(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t size)
+{
+	unsigned long val;
+	int index;
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct cti_config *config = &drvdata->config;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	index = config->ctiinout_sel;
+	config->ctiinen[index] = val;
+
+	/* write through if enabled */
+	if (cti_active(config))
+		cti_write_single_reg(drvdata, CTIINEN(index), val);
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(inen);
+
+static ssize_t outen_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	unsigned long val;
+	int index;
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	spin_lock(&drvdata->spinlock);
+	index = drvdata->config.ctiinout_sel;
+	val = drvdata->config.ctiouten[index];
+	spin_unlock(&drvdata->spinlock);
+	return sprintf(buf, "%#lx\n", val);
+}
+
+static ssize_t outen_store(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t size)
+{
+	unsigned long val;
+	int index;
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct cti_config *config = &drvdata->config;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	index = config->ctiinout_sel;
+	config->ctiouten[index] = val;
+
+	/* write through if enabled */
+	if (cti_active(config))
+		cti_write_single_reg(drvdata, CTIOUTEN(index), val);
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(outen);
+
+static ssize_t intack_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t size)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	cti_write_intack(dev, val);
+	return size;
+}
+static DEVICE_ATTR_WO(intack);
+
+cti_config_reg32_rw(gate, ctigate, CTIGATE);
+cti_config_reg32_rw(asicctl, asicctl, ASICCTL);
+cti_config_reg32_rw(appset, ctiappset, CTIAPPSET);
+
+static ssize_t appclear_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	unsigned long val;
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct cti_config *config = &drvdata->config;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+
+	/* a 1'b1 in appclr clears down the same bit in appset*/
+	config->ctiappset &= ~val;
+
+	/* write through if enabled */
+	if (cti_active(config))
+		cti_write_single_reg(drvdata, CTIAPPCLEAR, val);
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_WO(appclear);
+
+static ssize_t apppulse_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	unsigned long val;
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct cti_config *config = &drvdata->config;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+
+	/* write through if enabled */
+	if (cti_active(config))
+		cti_write_single_reg(drvdata, CTIAPPPULSE, val);
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_WO(apppulse);
+
+coresight_cti_reg(triginstatus, CTITRIGINSTATUS);
+coresight_cti_reg(trigoutstatus, CTITRIGOUTSTATUS);
+coresight_cti_reg(chinstatus, CTICHINSTATUS);
+coresight_cti_reg(choutstatus, CTICHOUTSTATUS);
+
+/*
+ * Define CONFIG_CORESIGHT_CTI_INTEGRATION_REGS to enable the access to the
+ * integration control registers. Normally only used to investigate connection
+ * data.
+ */
+#ifdef CONFIG_CORESIGHT_CTI_INTEGRATION_REGS
+
+/* macro to access RW registers with power check only (no enable check). */
+#define coresight_cti_reg_rw(name, offset)				\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);	\
+	u32 val = 0;							\
+	pm_runtime_get_sync(dev->parent);				\
+	spin_lock(&drvdata->spinlock);					\
+	if (drvdata->config.hw_powered)					\
+		val = readl_relaxed(drvdata->base + offset);		\
+	spin_unlock(&drvdata->spinlock);				\
+	pm_runtime_put_sync(dev->parent);				\
+	return sprintf(buf, "0x%x\n", val);				\
+}									\
+									\
+static ssize_t name##_store(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t size)		\
+{									\
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);	\
+	unsigned long val = 0;						\
+	if (kstrtoul(buf, 0, &val))					\
+		return -EINVAL;						\
+									\
+	pm_runtime_get_sync(dev->parent);				\
+	spin_lock(&drvdata->spinlock);					\
+	if (drvdata->config.hw_powered)					\
+		cti_write_single_reg(drvdata, offset, val);		\
+	spin_unlock(&drvdata->spinlock);				\
+	pm_runtime_put_sync(dev->parent);				\
+	return size;							\
+}									\
+static DEVICE_ATTR_RW(name)
+
+/* macro to access WO registers with power check only (no enable check). */
+#define coresight_cti_reg_wo(name, offset)				\
+static ssize_t name##_store(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t size)		\
+{									\
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);	\
+	unsigned long val = 0;						\
+	if (kstrtoul(buf, 0, &val))					\
+		return -EINVAL;						\
+									\
+	pm_runtime_get_sync(dev->parent);				\
+	spin_lock(&drvdata->spinlock);					\
+	if (drvdata->config.hw_powered)					\
+		cti_write_single_reg(drvdata, offset, val);		\
+	spin_unlock(&drvdata->spinlock);				\
+	pm_runtime_put_sync(dev->parent);				\
+	return size;							\
+}									\
+static DEVICE_ATTR_WO(name)
+
+coresight_cti_reg_rw(itchout, ITCHOUT);
+coresight_cti_reg_rw(ittrigout, ITTRIGOUT);
+coresight_cti_reg_rw(itctrl, CORESIGHT_ITCTRL);
+coresight_cti_reg_wo(itchinack, ITCHINACK);
+coresight_cti_reg_wo(ittriginack, ITTRIGINACK);
+coresight_cti_reg(ittrigin, ITTRIGIN);
+coresight_cti_reg(itchin, ITCHIN);
+coresight_cti_reg(itchoutack, ITCHOUTACK);
+coresight_cti_reg(ittrigoutack, ITTRIGOUTACK);
+
+#endif /* CORESIGHT_CTI_INTEGRATION_REGS */
+
+static struct attribute *coresight_cti_regs_attrs[] = {
+	&dev_attr_inout_sel.attr,
+	&dev_attr_inen.attr,
+	&dev_attr_outen.attr,
+	&dev_attr_gate.attr,
+	&dev_attr_asicctl.attr,
+	&dev_attr_intack.attr,
+	&dev_attr_appset.attr,
+	&dev_attr_appclear.attr,
+	&dev_attr_apppulse.attr,
+	&dev_attr_triginstatus.attr,
+	&dev_attr_trigoutstatus.attr,
+	&dev_attr_chinstatus.attr,
+	&dev_attr_choutstatus.attr,
+#ifdef CONFIG_CORESIGHT_CTI_INTEGRATION_REGS
+	&dev_attr_itctrl.attr,
+	&dev_attr_ittrigin.attr,
+	&dev_attr_itchin.attr,
+	&dev_attr_ittrigout.attr,
+	&dev_attr_itchout.attr,
+	&dev_attr_itchoutack.attr,
+	&dev_attr_ittrigoutack.attr,
+	&dev_attr_ittriginack.attr,
+	&dev_attr_itchinack.attr,
+#endif
+	NULL,
+};
+
+/* sysfs groups */
 static const struct attribute_group coresight_cti_group = {
 	.attrs = coresight_cti_attrs,
 };
@@ -129,8 +484,14 @@ static const struct attribute_group coresight_cti_mgmt_group = {
 	.name = "mgmt",
 };
 
+static const struct attribute_group coresight_cti_regs_group = {
+	.attrs = coresight_cti_regs_attrs,
+	.name = "regs",
+};
+
 const struct attribute_group *coresight_cti_groups[] = {
 	&coresight_cti_group,
 	&coresight_cti_mgmt_group,
+	&coresight_cti_regs_group,
 	NULL,
 };
diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index c71b72d12534..e0748cc92384 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -149,6 +149,25 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
 	return 0;
 }
 
+void cti_write_single_reg(struct cti_drvdata *drvdata, int offset, u32 value)
+{
+	CS_UNLOCK(drvdata->base);
+	writel_relaxed(value, drvdata->base + offset);
+	CS_LOCK(drvdata->base);
+}
+
+void cti_write_intack(struct device *dev, u32 ackval)
+{
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct cti_config *config = &drvdata->config;
+
+	spin_lock(&drvdata->spinlock);
+	/* write if enabled */
+	if (cti_active(config))
+		cti_write_single_reg(drvdata, CTIINTACK, ackval);
+	spin_unlock(&drvdata->spinlock);
+}
+
 /*
  * Look at the HW DEVID register for some of the HW settings.
  * DEVID[15:8] - max number of in / out triggers.
diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
index d0ac90f49544..35eb77b276c4 100644
--- a/drivers/hwtracing/coresight/coresight-cti.h
+++ b/drivers/hwtracing/coresight/coresight-cti.h
@@ -180,7 +180,15 @@ struct cti_trig_con *cti_allocate_trig_con(struct device *dev, int in_sigs,
 					   int out_sigs);
 int cti_enable(struct coresight_device *csdev);
 int cti_disable(struct coresight_device *csdev);
+void cti_write_intack(struct device *dev, u32 ackval);
+void cti_write_single_reg(struct cti_drvdata *drvdata, int offset, u32 value);
 struct coresight_platform_data *
 coresight_cti_get_platform_data(struct device *dev);
 
+/* cti powered and enabled */
+static inline bool cti_active(struct cti_config *cfg)
+{
+	return cfg->hw_powered && cfg->hw_enabled;
+}
+
 #endif  /* _CORESIGHT_CORESIGHT_CTI_H */
-- 
2.20.1

