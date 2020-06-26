Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9E1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 03:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE1720709
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 03:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="cxl/qzcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgFZDlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 23:41:10 -0400
Received: from alpha.anastas.io ([104.248.188.109]:53829 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgFZDlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 23:41:10 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 28E347EC0F;
        Thu, 25 Jun 2020 22:30:36 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1593142236; bh=02YN1ayW2X/zW5QiWWQyey8muOEEWO2Xr33scSYqXdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxl/qzcfdPj5oFVlBe2QdykR5DmahHEunE4aX/K3GMARuuOqeVuG1MPjA6VYd3O8+
         QzIsx5aXKgqADTJ8Gr3l8HLEIyGVxdDZabdO8UMqb2MFcwmjAy2OaQOAAeWrxB0+kq
         gmlSY6iTsCHuUhw6SWqN0ZUqtKM/IwtBOTipkJHPQKLipR+JovID0UYC6BDLB1WeL8
         JdEk+SBkFtFVd1G98iJHQbDCDnnI7hAAjAjqbl+D5yOK3vsBsIDcRyoc0Q3xI10OWX
         qCFO+sHaztOdB/BpQYFUfodzzVneSmN3mW6ES0A7cfm4oL2tX3nw8d2Ntmm2qxljDQ
         XI+W42dcLbcdA==
From:   Shawn Anastasio <shawn@anastas.io>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH 1/1] drm/bridge: analogix_dp: Add enable_psr param
Date:   Thu, 25 Jun 2020 22:30:23 -0500
Message-Id: <20200626033023.24214-2-shawn@anastas.io>
In-Reply-To: <20200626033023.24214-1-shawn@anastas.io>
References: <20200626033023.24214-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a toggle to enable/disable PSR from the kernel commandline.
This is useful in situations where PSR is supported by the hardware
but is not desired by the user. One such use case is working around
hardware errata.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 76736fb8ed94..9735ab71fca7 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -35,6 +35,10 @@
 
 static const bool verify_fast_training;
 
+static bool enable_psr = true;
+module_param(enable_psr, bool, 0644);
+MODULE_PARM_DESC(enable_psr, "PSR support (1 = enabled (default), 0 = disabled)");
+
 struct bridge_init {
 	struct i2c_client *client;
 	struct device_node *node;
@@ -979,7 +983,7 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
 	if (ret)
 		return ret;
 
-	if (analogix_dp_detect_sink_psr(dp)) {
+	if (enable_psr && analogix_dp_detect_sink_psr(dp)) {
 		ret = analogix_dp_enable_sink_psr(dp);
 		if (ret)
 			return ret;
-- 
2.26.2

