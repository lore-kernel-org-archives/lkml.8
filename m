Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFE3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28EB208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585044941;
	bh=Wn32YEXlsFeyH0U1lHQAPIpXDBsqxsEtcqAGcnsGtIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=womQbwwQJoPOXcRy3Gw1XoCXlrkXfoP81kZ/RGv89NLshF9UmkuNE7xFVeLvJ6S4S
	 k5Hr6+DjmYupLGrFdrG/1IuoqLfVP8zk7imPUfn7BztLJEnEaCGv7hBont3mOs8phw
	 Syv+e4x776G32EnWdVPIOUSPztSkUvjqQd2WM4yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCXKPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbgCXKPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:15:25 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CE27208D5;
        Tue, 24 Mar 2020 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585044924;
        bh=Wn32YEXlsFeyH0U1lHQAPIpXDBsqxsEtcqAGcnsGtIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYPQRWsdemnzRxor+vpdN3kHgdH0o+EIb4rfEdsX6fCNAyhOZUvJCwWb0adJW46S9
         2N7Le/JQLxppZ6eVSCQAwuN+IFJXVDWtt4Rtb8rIFtYEIB9JQeHtfCBc495eYZY7J5
         brclO4Z/trTf8g5AqRIQaqHk+pgRZWukGEez9JbA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGgag-001pjn-F2; Tue, 24 Mar 2020 11:15:22 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 7/8] media: Kconfig: add an option to filter in/out the embedded drivers
Date:   Tue, 24 Mar 2020 11:15:20 +0100
Message-Id: <c1c6fa7878baf71b025898bb0e18398a47089561.1585044374.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585044374.git.mchehab+huawei@kernel.org>
References: <cover.1585044374.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most systems don't need support for those, while others only
need those, instead of the others.

So, add an option to filter in/out the SoC specific drivers.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index e266d1afa912..a57e2198b2db 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -88,6 +88,14 @@ config MEDIA_CEC_SUPPORT
 	  Say Y when you have an HDMI receiver, transmitter or a USB CEC
 	  adapter that supports HDMI CEC.
 
+config MEDIA_EMBEDDED_SUPPORT
+	bool "Embedded devices (SoC)"
+	help
+	  Enable support for complex cameras, codecs, and other hardware
+	  found on Embedded hardware (SoC).
+
+	  Say Y when you have a software defined radio device.
+
 endmenu # media support types
 
 if MEDIA_SUPPORT
@@ -177,9 +185,13 @@ source "drivers/media/radio/Kconfig"
 
 # Common driver options
 source "drivers/media/common/Kconfig"
+
+if MEDIA_EMBEDDED_SUPPORT
+
 source "drivers/media/platform/Kconfig"
 source "drivers/media/mmc/Kconfig"
 
+endif # MEDIA_EMBEDDED_SUPPORT
 
 comment "FireWire (IEEE 1394) Adapters"
 	depends on DVB_CORE && FIREWIRE
-- 
2.24.1

