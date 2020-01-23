Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8171DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5339424673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqJjWbud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgAWLT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:19:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34611 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgAWLT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:19:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so1406491pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=82scBKRueLOczEUnCgg4pJWq6Va+L/4UJRbtpRC9qQE=;
        b=eqJjWbud8dKdn5D9SgbGh+3pdo31T7t8bpEY96WOoVx7ndPlMxdChiivMaP+ONmU1v
         P1HXlZVp254ANRCTIC3rMWw+n5+ADe3dW5j4KcuSZt5+3sWTli/F5HIqajelYq77qEjc
         DB9OY/JCq8jPELWqw6CJDbmv/Z8/DOmru0zOvptNWSAywQ4cEiBexjXwH8IITWiqGoZl
         lXrCehaWToId9gzgmiigcVNXxGq+8UQ5V1fQCVM/zHPDbPzHr44TH5gABdH0nLGWO5Ya
         9HKCHUPWsJFPihPYkb+BY+c+4a7OzJE5k5Fs5RAo9ER6RmzJ6GfxoblR+CMErO+cEEs0
         O0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=82scBKRueLOczEUnCgg4pJWq6Va+L/4UJRbtpRC9qQE=;
        b=VzID7kdCH6ZyNjxoziLHNEZUJ9EWcO9L4ogH/lPsqqTLLg5yhgwdzl2oW/bRE1thk/
         L982ndTZ9xCbZ0zNVQWDHNw9pfkRoCxegkfPy6OZPA1eBTFK//sU362utIjELB3u5ufw
         sQ/dkw3GoY0YcwRx+khpzoN+nqEgEQwc001j10acbtGkVXYMdM0T2XFZXps1BQltQuu6
         QNFI0x0TxPBTV/CyA2B+OZNzfsx4RjlR/kmACNNJIzup518bze0FwSRKF10axojaRPiK
         eMFP/VEk9p2iCFgdppgt9ihqizMHiRN8QSZr3Wpu2Kmu19cPnJkDkeScBPznbTlLET9A
         b3Ag==
X-Gm-Message-State: APjAAAWEjXj9lNdeJx6+TTtDp8DvLZDWJyj95r2S2Lh+soRNdOJlwb+b
        oppXurLrtD3/ku+c54/gjhqu
X-Google-Smtp-Source: APXvYqzF8M30uMymNg+oRQF6xIHsdRqrwCQAV476rsMT6qiwvwQc+W6YAxwNkYRMZS4DKXLF/hf+Ow==
X-Received: by 2002:a63:b642:: with SMTP id v2mr3339550pgt.126.1579778367395;
        Thu, 23 Jan 2020 03:19:27 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id y6sm2627559pgc.10.2020.01.23.03.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 03:19:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/16] bus: mhi: core: Add uevent support for module autoloading
Date:   Thu, 23 Jan 2020 16:48:32 +0530
Message-Id: <20200123111836.7414-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uevent support to MHI bus so that the client drivers can be autoloaded
by udev when the MHI devices gets created. The client drivers are
expected to provide MODULE_DEVICE_TABLE with the MHI id_table struct so
that the alias can be exported.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c       |  9 +++++++++
 include/linux/mod_devicetable.h   |  1 +
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 10 ++++++++++
 4 files changed, 23 insertions(+)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 40dcf8353f6f..152d12066bec 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -1229,6 +1229,14 @@ void mhi_driver_unregister(struct mhi_driver *mhi_drv)
 }
 EXPORT_SYMBOL_GPL(mhi_driver_unregister);
 
+static int mhi_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+
+	return add_uevent_var(env, "MODALIAS=" MHI_DEVICE_MODALIAS_FMT,
+					mhi_dev->chan_name);
+}
+
 static int mhi_match(struct device *dev, struct device_driver *drv)
 {
 	struct mhi_device *mhi_dev = to_mhi_device(dev);
@@ -1255,6 +1263,7 @@ struct bus_type mhi_bus_type = {
 	.name = "mhi",
 	.dev_name = "mhi",
 	.match = mhi_match,
+	.uevent = mhi_uevent,
 };
 
 static int __init mhi_init(void)
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index be15e997fe39..f10e779a3fd0 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -821,6 +821,7 @@ struct wmi_device_id {
 	const void *context;
 };
 
+#define MHI_DEVICE_MODALIAS_FMT "mhi:%s"
 #define MHI_NAME_SIZE 32
 
 /**
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 054405b90ba4..fe3f4a95cb21 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -231,5 +231,8 @@ int main(void)
 	DEVID(wmi_device_id);
 	DEVID_FIELD(wmi_device_id, guid_string);
 
+	DEVID(mhi_device_id);
+	DEVID_FIELD(mhi_device_id, chan);
+
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index c91eba751804..cae6a4e471b5 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1335,6 +1335,15 @@ static int do_wmi_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/* Looks like: mhi:S */
+static int do_mhi_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD_ADDR(symval, mhi_device_id, chan);
+	sprintf(alias, MHI_DEVICE_MODALIAS_FMT, *chan);
+
+	return 1;
+}
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
@@ -1407,6 +1416,7 @@ static const struct devtable devtable[] = {
 	{"typec", SIZE_typec_device_id, do_typec_entry},
 	{"tee", SIZE_tee_client_device_id, do_tee_entry},
 	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
+	{"mhi", SIZE_mhi_device_id, do_mhi_entry},
 };
 
 /* Create MODULE_ALIAS() statements.
-- 
2.17.1

