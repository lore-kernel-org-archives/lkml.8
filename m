Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2E9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF24206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4UfZa+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgFDR7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbgFDR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:58:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7A6C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:58:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h188so4157978lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y1Q9f/owSvUftqSD1Hv4bVUGbDrPIGyfax6gzi32kpI=;
        b=z4UfZa+lMLv9ShPYyfh+GzumSq3gGE6u750clZOuQxq+iIssvL53B15ckxMDWbgilT
         Y97NO2inkyooaFl1RiKXYZPZfxYD8JeuP4lWbC6+prNZCPutbHdXuHMJpmlSDSS9L3Ld
         KFdTxuAMWY5A+D25hrJgRYNgpzikvi7ybP1j01lLvfUG/C56nYtin72DfPI1WHKJyoU+
         FkaU3ZYqOaDOJLwOIds3gYBJcDJ7b8tSCjT3fgJrOkTXXVmwiKovflV+ylKlM9fiqOgF
         rCV1SDmSSsSTYbJg05hNbA3Zc98hKNB1FqSpFR8uHqLOu08tFXaK6WISHRVTQxb34LBI
         A0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y1Q9f/owSvUftqSD1Hv4bVUGbDrPIGyfax6gzi32kpI=;
        b=ajycV5p0VsdPNL47K8kxU0+z/Uo5kpHQD2TWhZLegmHShM5Y2YysjotW1sbZnE+fVR
         JJzArgZpF5JPFd8hEgJ2fKghnKqQs/d4xaajF3pi33Mx6qLeSa6pcH3JrqDhmZYgLrlo
         f1FNMhLRmUI0784rht96nvmy1t31HRHaTPu1aJ8ivZ1t8vQgGrGmtHQ3+SYnc1D08HaM
         KyMyHdug5GPUNmEm0ekXE+R0GPusDSUeeOwFIfiyn5YomOMfrBG1Ud6AP6G9wjWZGS/l
         geS4F5cK4I5C1klNiHHi52gvL5ZS9Q/VMRfKOdrYEe72LX1mlo3L+MzoRdBJ2khRMKg2
         IKZw==
X-Gm-Message-State: AOAM533uRRV+j8gBXFxqR4uIdg9+TIm4attDHY4O0S/NpKaxSYYQcmSp
        Wis3IloR8cxohYb1+Br0J71pZKJUKdM=
X-Google-Smtp-Source: ABdhPJzADlJyHJpTMoqBhWa2Fe/0GPccN4bZcPvL36+iqkbtKBaCtVHpO1PfCmnC0izcJYKWlfrGiA==
X-Received: by 2002:ac2:490f:: with SMTP id n15mr3155675lfi.39.1591293537372;
        Thu, 04 Jun 2020 10:58:57 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y17sm72404lfa.77.2020.06.04.10.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:58:56 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv8 1/3] optee: use uuid for sysfs driver entry
Date:   Thu,  4 Jun 2020 20:58:49 +0300
Message-Id: <20200604175851.758-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200604175851.758-1-maxim.uvarov@linaro.org>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the evolving use-cases for TEE bus, now it's required to support
multi-stage enumeration process. But using a simple index doesn't
suffice this requirement and instead leads to duplicate sysfs entries.
So instead switch to use more informative device UUID for sysfs entry
like:
/sys/bus/tee/devices/optee-ta-<uuid>

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
 MAINTAINERS                                       | 1 +
 drivers/tee/optee/device.c                        | 9 ++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
new file mode 100644
index 000000000000..0ae04ae5374a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
@@ -0,0 +1,8 @@
+What:		/sys/bus/tee/devices/optee-ta-<uuid>/
+Date:           May 2020
+KernelVersion   5.7
+Contact:        tee-dev@lists.linaro.org
+Description:
+		OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
+		matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
+		are free to create needed API under optee-ta-<uuid> directory.
diff --git a/MAINTAINERS b/MAINTAINERS
index ecc0749810b0..6717afef2de3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12516,6 +12516,7 @@ OP-TEE DRIVER
 M:	Jens Wiklander <jens.wiklander@linaro.org>
 L:	tee-dev@lists.linaro.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-optee-devices
 F:	drivers/tee/optee/
 
 OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index e3a148521ec1..23d264c8146e 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
 	return 0;
 }
 
-static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
+static int optee_register_device(const uuid_t *device_uuid)
 {
 	struct tee_client_device *optee_device = NULL;
 	int rc;
@@ -75,7 +75,10 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
 		return -ENOMEM;
 
 	optee_device->dev.bus = &tee_bus_type;
-	dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
+	if (dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {
+		kfree(optee_device);
+		return -ENOMEM;
+	}
 	uuid_copy(&optee_device->id.uuid, device_uuid);
 
 	rc = device_register(&optee_device->dev);
@@ -144,7 +147,7 @@ int optee_enumerate_devices(void)
 	num_devices = shm_size / sizeof(uuid_t);
 
 	for (idx = 0; idx < num_devices; idx++) {
-		rc = optee_register_device(&device_uuid[idx], idx);
+		rc = optee_register_device(&device_uuid[idx]);
 		if (rc)
 			goto out_shm;
 	}
-- 
2.17.1

