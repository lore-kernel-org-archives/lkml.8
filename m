Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C9FC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E8120767
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sopfsph4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDVTIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgDVTIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 15:08:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50664C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:08:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u127so3778243wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+zDLeLkxWO2+hMNosAqgOgGEHIDnT4PWh0YVuszpFwo=;
        b=sopfsph4Ox9cam1LRYncWs+ATliTvE3+yCH1/n3zC+PX+46tWteEs5pbbO09FpD9Ld
         r/T8sQSTxn6hVmtEs5YuDM251mPwNVnwDPNvrrEdFtU/Ia5ZpYHG2mWVZp/WgoY7RzSf
         2zcKZDO5Skbh8RJr81lsXpB7rciNEqJdeFtu7FyXpJj6pEdA+xmnQUJj4L/F1enZxBep
         GJs7gobSR07T3i7GHMWgpHZec4chFv030zhxoWPVGqwYz9wZKBdv6ufhXypKqK87WOVS
         A4sCOjXPpfzDVmpHQit1mR5bJuE1U0tQNOUWNYqhNDefBIPReC8am1RubNFKiXDTpUIW
         w+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+zDLeLkxWO2+hMNosAqgOgGEHIDnT4PWh0YVuszpFwo=;
        b=NRmMNohgP0sCS1WbsVPP74Ps38HtpjuPoWBs3Y1KLrpBmBpNvRSLXCzrWiSjQ1J+th
         pIxoo4kKXpzw6GIPd9AXhXl8X0w82/8/2gT9MFBVayFvOrTkmUdJ+xKd6u5bpnFhlRO6
         7LUJudYIulmgwP7llJghhe/iW9aarrykhCAet/+tmc/s2k/GET0tncXHJUi+SgXQ7G99
         ozVaBK8XCQdF0egTyF97Vnozz+UIMyDgyjcapUwrMmNAMh401sRT7fxJ+qddD1G3nuKu
         R5rvJ8Rj+QVMzCqRzp3c8BqwM5StrUHKqCS76Cn0zRxn1xcDgBcOdG9u/0WgWH4JOx7X
         Vf5g==
X-Gm-Message-State: AGi0PubDLgz3th7fSWaXjbZjz6liNa3Cc7pbiZyzuiPASruSxGHghZUV
        i6xFtBMn44YeI7N2cwCXsZY=
X-Google-Smtp-Source: APiQypKKOtJHSktS3ZUja/AxftlJ/XBl/AguO72IhuFkq9dh8eOQNeBgIAM46126fomV+VYhlr96FA==
X-Received: by 2002:a1c:5403:: with SMTP id i3mr12817772wmb.10.1587582497902;
        Wed, 22 Apr 2020 12:08:17 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id f8sm201837wrm.14.2020.04.22.12.08.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 12:08:17 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] soundwire: intel: Remove unused function
Date:   Wed, 22 Apr 2020 20:08:15 +0100
Message-Id: <20200422190815.5975-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function sdw_intel_init() is not used anywhere, remove it for now.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/soundwire/intel_init.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index ad7053463889..2f37dad06321 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -183,29 +183,6 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 }
 
 /**
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
-/**
  * sdw_intel_exit() - SoundWire Intel exit
  * @arg: callback context
  *
-- 
2.11.0

