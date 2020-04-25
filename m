Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509D7C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277F2206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZAznOdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgDYXyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 19:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDYXyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 19:54:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BF9C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 16:54:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so15521405wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kIF3Ha6AYtF1LF/TcQJoOGghWoQ3P/dbZp/m08LM174=;
        b=HZAznOdRkWHcoD8g5JCei5bVBsT1NPftaaC9tjiIJmMhUcPwweKTLoa/qam0jU5LZn
         ipC6GIOCoIJCJRpyrDryP61fpLhvjTiIa2nDyUo0fdUkXirVGUr6bf41le9zK13zwKqH
         sdAbwGgJLCAEHvSrz3BLFPEc4rsIJG9RPIiiUZp6JOLkMmuXqwrzJ34uTxEKAgTTbylX
         tdDhJWMD92D4g1wDmOpqWvc0kTU3rfFaOGA9DZvK15vG7sR9jiBZOvfnQu98KazP9e7M
         FOoPivK+0aT+j3FUc8Zd4zCMDruhEBhdovUuUvr3wVL0PlE++IJfsFCLF0b09OU6R5tU
         U+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kIF3Ha6AYtF1LF/TcQJoOGghWoQ3P/dbZp/m08LM174=;
        b=oyI7RfHdb+gQADKwY25SaS3PXFkhR+ciswZ5GpuCfdiGHPIwtDHqD07bwaqjm2u6IT
         dqjjN11RPvFpnEacWLlQEjuk8Nz14zUeTBDIkjmbm9MChmUGmF4b5rYPYN4TJQqHg/SD
         l1w1TTSttL49mE7cI60rpQH1uFcpw4SlmchJMXkuxvMm0A5XNpl578oUPNQ/tOy4Cnp/
         apmm6ci/zQUEX0BtYDzWDCn3zexDQFQeyNNxnQx9evMsT/YoT7H8HEtUb6pdrVx6z8Ko
         Bp50P8QlrEx/IojkcvBFqIe5uHVcNo/71BpoIqCZe/8WSkrEp0PAc+8IoEYCwWQmWCVk
         gwkw==
X-Gm-Message-State: AGi0PuZS8GQ/e11YrjPS1BG0UojjxnClwlz0c0GW6nTD+oqbXAi7Jh1T
        oF5oGEhAsRBSFd+/U6OaThU=
X-Google-Smtp-Source: APiQypK/wShvy0FpwtkXE6nfjCogbfBy0VzPVy606nMddpf2hdyc+NEUMEkRaYasZpK1LpqzhKj59Q==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr17298439wme.115.1587858890068;
        Sat, 25 Apr 2020 16:54:50 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id g74sm9140037wme.44.2020.04.25.16.54.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 16:54:49 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] soundwire: intel: Remove unused function
Date:   Sun, 26 Apr 2020 00:54:48 +0100
Message-Id: <20200425235448.3946-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function sdw_intel_init() is not used anywhere, remove it for now.
And that makes sdw_intel_add_controller(), sdw_intel_acpi_cb() and
link_mask unused, so remove them as well.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/soundwire/intel_init.c | 162 -----------------------------------------
 1 file changed, 162 deletions(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index ad7053463889..d90929a5043b 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -23,10 +23,6 @@
 #define SDW_LINK_BASE		0x30000
 #define SDW_LINK_SIZE		0x10000
 
-static int link_mask;
-module_param_named(sdw_link_mask, link_mask, int, 0444);
-MODULE_PARM_DESC(sdw_link_mask, "Intel link mask (one bit per link)");
-
 static int sdw_intel_cleanup_pdev(struct sdw_intel_ctx *ctx)
 {
 	struct sdw_intel_link_res *link = ctx->links;
@@ -47,164 +43,6 @@ static int sdw_intel_cleanup_pdev(struct sdw_intel_ctx *ctx)
 	return 0;
 }
 
-static struct sdw_intel_ctx
-*sdw_intel_add_controller(struct sdw_intel_res *res)
-{
-	struct platform_device_info pdevinfo;
-	struct platform_device *pdev;
-	struct sdw_intel_link_res *link;
-	struct sdw_intel_ctx *ctx;
-	struct acpi_device *adev;
-	int ret, i;
-	u8 count;
-	u32 caps;
-
-	if (acpi_bus_get_device(res->handle, &adev))
-		return NULL;
-
-	/* Found controller, find links supported */
-	count = 0;
-	ret = fwnode_property_read_u8_array(acpi_fwnode_handle(adev),
-					    "mipi-sdw-master-count", &count, 1);
-
-	/* Don't fail on error, continue and use hw value */
-	if (ret) {
-		dev_err(&adev->dev,
-			"Failed to read mipi-sdw-master-count: %d\n", ret);
-		count = SDW_MAX_LINKS;
-	}
-
-	/* Check SNDWLCAP.LCOUNT */
-	caps = ioread32(res->mmio_base + SDW_SHIM_BASE + SDW_SHIM_LCAP);
-	caps &= GENMASK(2, 0);
-
-	/* Check HW supported vs property value and use min of two */
-	count = min_t(u8, caps, count);
-
-	/* Check count is within bounds */
-	if (count > SDW_MAX_LINKS) {
-		dev_err(&adev->dev, "Link count %d exceeds max %d\n",
-			count, SDW_MAX_LINKS);
-		return NULL;
-	} else if (!count) {
-		dev_warn(&adev->dev, "No SoundWire links detected\n");
-		return NULL;
-	}
-
-	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
-
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return NULL;
-
-	ctx->count = count;
-	ctx->links = kcalloc(ctx->count, sizeof(*ctx->links), GFP_KERNEL);
-	if (!ctx->links)
-		goto link_err;
-
-	link = ctx->links;
-
-	/* Create SDW Master devices */
-	for (i = 0; i < count; i++) {
-		if (link_mask && !(link_mask & BIT(i))) {
-			dev_dbg(&adev->dev,
-				"Link %d masked, will not be enabled\n", i);
-			link++;
-			continue;
-		}
-
-		link->registers = res->mmio_base + SDW_LINK_BASE
-					+ (SDW_LINK_SIZE * i);
-		link->shim = res->mmio_base + SDW_SHIM_BASE;
-		link->alh = res->mmio_base + SDW_ALH_BASE;
-
-		link->ops = res->ops;
-		link->dev = res->dev;
-
-		memset(&pdevinfo, 0, sizeof(pdevinfo));
-
-		pdevinfo.parent = res->parent;
-		pdevinfo.name = "int-sdw";
-		pdevinfo.id = i;
-		pdevinfo.fwnode = acpi_fwnode_handle(adev);
-
-		pdev = platform_device_register_full(&pdevinfo);
-		if (IS_ERR(pdev)) {
-			dev_err(&adev->dev,
-				"platform device creation failed: %ld\n",
-				PTR_ERR(pdev));
-			goto pdev_err;
-		}
-
-		link->pdev = pdev;
-		link++;
-	}
-
-	return ctx;
-
-pdev_err:
-	sdw_intel_cleanup_pdev(ctx);
-link_err:
-	kfree(ctx);
-	return NULL;
-}
-
-static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
-				     void *cdata, void **return_value)
-{
-	struct sdw_intel_res *res = cdata;
-	struct acpi_device *adev;
-	acpi_status status;
-	u64 adr;
-
-	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &adr);
-	if (ACPI_FAILURE(status))
-		return AE_OK; /* keep going */
-
-	if (acpi_bus_get_device(handle, &adev)) {
-		pr_err("%s: Couldn't find ACPI handle\n", __func__);
-		return AE_NOT_FOUND;
-	}
-
-	res->handle = handle;
-
-	/*
-	 * On some Intel platforms, multiple children of the HDAS
-	 * device can be found, but only one of them is the SoundWire
-	 * controller. The SNDW device is always exposed with
-	 * Name(_ADR, 0x40000000), with bits 31..28 representing the
-	 * SoundWire link so filter accordingly
-	 */
-	if ((adr & GENMASK(31, 28)) >> 28 != SDW_LINK_TYPE)
-		return AE_OK; /* keep going */
-
-	/* device found, stop namespace walk */
-	return AE_CTRL_TERMINATE;
-}
-
-/**
- * sdw_intel_init() - SoundWire Intel init routine
- * @parent_handle: ACPI parent handle
- * @res: resource data
- *
- * This scans the namespace and creates SoundWire link controller devices
- * based on the info queried.
- */
-static void *sdw_intel_init(acpi_handle *parent_handle,
-			    struct sdw_intel_res *res)
-{
-	acpi_status status;
-
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
-				     parent_handle, 1,
-				     sdw_intel_acpi_cb,
-				     NULL, res, NULL);
-	if (ACPI_FAILURE(status))
-		return NULL;
-
-	return sdw_intel_add_controller(res);
-}
-
 /**
  * sdw_intel_exit() - SoundWire Intel exit
  * @arg: callback context
-- 
2.11.0

