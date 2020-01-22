Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF83FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922932465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="alAeVfIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAVBYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 20:24:36 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33590 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbgAVBYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:24:36 -0500
Received: by mail-pj1-f66.google.com with SMTP id u63so1455433pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 17:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abNVxjFLq6tr9jL4hLpxUGBmSdTjzjRYJG+vJlFoPpQ=;
        b=alAeVfIRBU7PYqeWe/RvGfcIBBrhtjbMHl3qZL+4lWMvHESegen86rGdJCN9XeGmxm
         YfMugsxYWq+tF6B213lyUyfcFclYuJ5Y8fQk6A1z05YglVLcOsp+uncTTSw0eKi3Ny/3
         wf62NCTMhvXsgMxuWwQRKrCgQzCmBnHSin6Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abNVxjFLq6tr9jL4hLpxUGBmSdTjzjRYJG+vJlFoPpQ=;
        b=sW8JnkTPsGlJxqiLJMiwCiNPofT3R2KMgvD3GRpMMzKvlVsMhm/ZCYVdoKT+6/HSuN
         iqBGP6Loy2iMPNYquj6st8oNmZE52nN9en4QalFZtmkeVGzfofri4X4LMeNwRyT+Uurh
         oX/oEg3SNYlhO/5nyF/NrroKKO0Jt7wo62fbQNraGLg1gTmNngN4rpk/juUQi22HknDK
         izrPBK5vxwLx4QaTyvDNWI+2ddYnEwdyCrCj5nAIG2ExbxKB33k2hj0SGrdp1QktmQ6b
         Jn7UcOT+FU1ON6j+56/f/QGsZmxST8YKzA6E4LQxAx3TvUByFrtsQcJIR/kGKbVzVgYC
         4NvQ==
X-Gm-Message-State: APjAAAWcnlze4B+6CBQ7qq3gxcrRjzIqiaa7Ju2wOZ3/PrKlFpFoPIxs
        Lg+9NGyGYjWu/v67HAQ5sjdztA==
X-Google-Smtp-Source: APXvYqwQtXM3T2sZXnP306/4GmNNkoYDnMPJddtHn+ah1g6GQUfd6SlMwsNuIWyy7RXsyB/5KSUHrA==
X-Received: by 2002:a17:90b:344f:: with SMTP id lj15mr127263pjb.0.1579656275941;
        Tue, 21 Jan 2020 17:24:35 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a195sm45250723pfa.120.2020.01.21.17.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 17:24:35 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: wilco_ec: Allow wilco to be compiled in COMPILE_TEST
Date:   Tue, 21 Jan 2020 17:24:34 -0800
Message-Id: <20200122012434.88274-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable this Kconfig on COMPILE_TEST enabled configs so we can get more
build coverage.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/wilco_ec/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index 365f30e116ee..49e8530ca0ac 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config WILCO_EC
 	tristate "ChromeOS Wilco Embedded Controller"
-	depends on ACPI && X86 && CROS_EC_LPC && LEDS_CLASS
+	depends on X86 || COMPILE_TEST
+	depends on ACPI && CROS_EC_LPC && LEDS_CLASS
 	help
 	  If you say Y here, you get support for talking to the ChromeOS
 	  Wilco EC over an eSPI bus. This uses a simple byte-level protocol
-- 
Sent by a computer, using git, on the internet

