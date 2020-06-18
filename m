Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F387C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0312080D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fODOZVVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgFRNxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbgFRNw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:52:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC6C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:52:57 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s1so7375944ljo.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9P1JCHrt7FUW+xiuM5vRud2sFx/m9qpZviiIZWSxrs0=;
        b=fODOZVVAnIrwoUAGSdktk0kNRi39TD3Lykb/NupWJ2fkCd44VpIcQ3OX6t7gFZc8bv
         9mkwvZ5UOQt9GsXUcQhK6Anuggx62lhuOCS4LMARk8o5hYREwyQChzBoKG5ohuca9Gfu
         0sHcIPcV4k7pQCIDqLEHPkYlOEwxMVR1KnC383+RumsOcY/yRwcIItVdUkaCX5aCKSKS
         in5FTKhUADwrQfDy3FcD2qcW0tqfRCF+uOMSo3RTkuBuXIEcvA/dK+1IoJetlpLm6366
         MB9g77DSsG5kxYlIlToWw7tpxgjTC4LI7hOqg9DEd8mg2oTmInUJOdeVoFF0U+PXVKcR
         FbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9P1JCHrt7FUW+xiuM5vRud2sFx/m9qpZviiIZWSxrs0=;
        b=LgFIruJWcVrh5Uoy2xi0Ad5rEYwvtIIlyQDCiQCn9Q0HUdlqfLpzEUOjcmVelD9TSw
         P98xgxfoiLlvNR45KSaMnemNJVnF4DL+b0FlzRql/I/xX/J00xOqG3DeDB2d369HdjcA
         pEPenN2I4yjgzLKQzw9qE3kQJT4cz9xWrWxUuMC9kAG5xVMA9X8z11c6kEOeHCIEvbC+
         y/A63Dg0nVNXnBXwbHceZQMvdDvOc6BzdJIAG5pE6ghM21g8Roqbp8l8T3dTeNuGGzYj
         7KXPPjpjota8CS3eTBemIn2x/JuKzJLgRiL+1HMyL36d728JQ3cMR8ZLmi4UJRSFdbHZ
         tcMQ==
X-Gm-Message-State: AOAM533IPP43uqVB+RMVdFnzxoJAdLXOpJ/MVU+pB7EqwnSNAEfVsujd
        Pz/QDPUScs5lcQOqnxfus+Q5iFsswNE=
X-Google-Smtp-Source: ABdhPJyCXiCIvGCC262AeAojPgSkk69Vv7ksw/of2eKCXEYedcwranKM17EXQYCe8ycY+gsWuOgfHQ==
X-Received: by 2002:a05:651c:108:: with SMTP id a8mr2424578ljb.326.1592488375701;
        Thu, 18 Jun 2020 06:52:55 -0700 (PDT)
Received: from maximlap.d-systems.local ([185.75.190.112])
        by smtp.gmail.com with ESMTPSA id f2sm768324lfc.11.2020.06.18.06.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 06:52:55 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 1/3] optee: use uuid for sysfs driver entry
Date:   Thu, 18 Jun 2020 16:52:49 +0300
Message-Id: <20200618135251.5761-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618135251.5761-1-maxim.uvarov@linaro.org>
References: <20200618135251.5761-1-maxim.uvarov@linaro.org>
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
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
 MAINTAINERS                                       | 1 +
 drivers/tee/optee/device.c                        | 9 ++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
new file mode 100644
index 000000000000..0f58701367b6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
@@ -0,0 +1,8 @@
+What:		/sys/bus/tee/devices/optee-ta-<uuid>/
+Date:           May 2020
+KernelVersion   5.8
+Contact:        op-tee@lists.trustedfirmware.org
+Description:
+		OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
+		matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
+		are free to create needed API under optee-ta-<uuid> directory.
diff --git a/MAINTAINERS b/MAINTAINERS
index 301330e02bca..b9536cb5b8b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12697,6 +12697,7 @@ OP-TEE DRIVER
 M:	Jens Wiklander <jens.wiklander@linaro.org>
 L:	tee-dev@lists.linaro.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-optee-devices
 F:	drivers/tee/optee/
 
 OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index e3a148521ec1..e91b7db5f49e 100644
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
+	if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
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

