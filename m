Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A88BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6798720849
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fytoxuUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbgEYLwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390294AbgEYLwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:52:47 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B478FC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:52:45 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q2so20406271ljm.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GGtb/VoRoWTmlojJAyBVCcYgsbrBsVJ+27ovJzUUe4Q=;
        b=fytoxuUYZUmziOocYOXa6Ua4TXMwv5acadaI6E+7PiGdl/arLQGPQaPfMmRUWo4Jnr
         ytKMK4XS3klP+uUdG9mtW+8fVxTUC7kzjkfy2oRh+WYetY6htW/KH2hvMU+/t4lQqsVo
         6RE0bXTJYhjsbPQluDB8ZVCaHsCX6KsSxqUdIwkANIpUxlLSPYQ+ZEBWIoUDA/VD+vF/
         s8nw46T/keKlv30EHWhasZop8jqmjcGVskS896QPH4RVbbK2OL8lMUW0grAOSllICALj
         08n7VTqdhShz1HDV4HuWYl5fH6YqvG7X1Kh/b5FflPhD+LaTXqjdjC2Xdh5guUNSLBWD
         DNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GGtb/VoRoWTmlojJAyBVCcYgsbrBsVJ+27ovJzUUe4Q=;
        b=INdMqw4cvWWmQSl09iEPqx3gj3AZ+ftIgwiN+UCS4nWQDmEHML3pHs7js6m+Wgl/2o
         ctzEJMdOShueTPauxsyINr8Yb3iXD7wa+mAZeWgQqMC/ycJFjVGLLhYMSJOQ22TEv574
         UeaCTGaOn53ELM7GWr6OU4phNBgV1Cy6Bkjb61mEOe6bLYsB5yujKEd5s+SWMod8PqRv
         ybKWVgw8K9ffLcoKTnYzG1+A3e1lX8vF0wEEc5F+cXSlI4ouAvvhb67VBkNVjfWlcUO6
         jPna6Ur4whd1vPYHqMgintQFlp2oI++ApBCPt/jt15ODTQmRVFTLZ7Swr0/ckQe9EubG
         /ycQ==
X-Gm-Message-State: AOAM533/OERwj3zTDB1PPSgxWh7sy0pLWABJxzS0FT4dBIJPU8AMbabk
        v26Z8FGjhkweBT4iv3SxxhhR6bHFAcw=
X-Google-Smtp-Source: ABdhPJzupvF9pjz+LSBC5BY8hC4Q+7Z8VeXmpJDxLeKXi4HEwS66Xwy96UpVjqQIb9TnNX/rcc/3cQ==
X-Received: by 2002:a2e:150f:: with SMTP id s15mr13209778ljd.102.1590407563923;
        Mon, 25 May 2020 04:52:43 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y130sm4847756lfc.22.2020.05.25.04.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 04:52:43 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv3 2/3] optee: use uuid for sysfs driver entry
Date:   Mon, 25 May 2020 14:52:34 +0300
Message-Id: <20200525115235.5405-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525115235.5405-1-maxim.uvarov@linaro.org>
References: <20200525115235.5405-1-maxim.uvarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optee device names for sysfs needed to be unique
and it's better if they will mean something. UUID for name
looks like good solution:
/sys/bus/tee/devices/optee-clnt-<uuid>

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 drivers/tee/optee/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index d4931dad07aa..aab917605e74 100644
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
@@ -75,7 +75,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
 		return -ENOMEM;
 
 	optee_device->dev.bus = &tee_bus_type;
-	dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
+	dev_set_name(&optee_device->dev, "optee-clnt-%pUl", device_uuid);
 	uuid_copy(&optee_device->id.uuid, device_uuid);
 
 	rc = device_register(&optee_device->dev);
@@ -144,7 +144,7 @@ static int __optee_enumerate_devices(u32 func)
 	num_devices = shm_size / sizeof(uuid_t);
 
 	for (idx = 0; idx < num_devices; idx++) {
-		rc = optee_register_device(&device_uuid[idx], idx);
+		rc = optee_register_device(&device_uuid[idx]);
 		if (rc)
 			goto out_shm;
 	}
-- 
2.17.1

