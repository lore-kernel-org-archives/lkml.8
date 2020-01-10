Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C3BC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C482072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578664654;
	bh=g72j9tTq2u6/XnTAoZ5jJdjryhj0EJvdohY3UpgLLG4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iVD1Ptk1IVis/Y/VAJWxUjHDtnq8aT/ZOOK53cN957K950k3EQYBvSQY16yETip/7
	 PnPUYrp6Aofnqm86mGKcd5yxtBb8yVhXmjBPqi0olycVys98o+m0Rv9Jldk0DQsb8G
	 boQJPI6M2WyoctnEex6/utK9zwWaeuEJXohd+i0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgAJN5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:57:33 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:25572 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgAJN5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:57:32 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 00ADuLH8021001;
        Fri, 10 Jan 2020 22:56:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 00ADuLH8021001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578664582;
        bh=zVyX+jnC81yFPW4LBhJZnImuwwlFDcqtIGqjvmZlyqg=;
        h=From:To:Cc:Subject:Date:From;
        b=vwOmdHD4C4wa/uGHgTN9FkESn/XEWK+Uevv4ZerrGKBY1PZMEDPK7/IWY78IuB2Mg
         4sGcQi7DeKxMh93gH9tb9e5OTYcmRtDlOlgj2FJP7o/S+vnzRE0FEhO29I2LlM9G70
         pLjgpTZ5+v9HHS7E9f+5BUTWn//cnwGU5oXYOi8NfAzmB6X/5vFUzsugJ9Za6S2Hqr
         DzuvkJaDVrha+uERl+0LNUmJC9ys9+d1BUA1BQEg6t3YC6vRiQfWmuFBtSSZZcALJz
         NbDpOLMUsOlv7cxWnKuD1Dln0Rvk0GIuNl1zSysPA3whmpr9SBm+7ufHhfEAZAHV5J
         ga5SnnQ6h6Uaw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v2] staging: vc04_services: remove header include path to vc04_services
Date:   Fri, 10 Jan 2020 22:56:15 +0900
Message-Id: <20200110135615.11617-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up some relative paths in #include "..." directives, and remove
the include path to drivers/staging/vc04_services.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - fix up some relative paths.
    I tested with/without O= option this time.

 drivers/staging/vc04_services/Makefile                        | 2 +-
 drivers/staging/vc04_services/interface/vchi/vchi.h           | 4 ++--
 .../staging/vc04_services/interface/vchiq_arm/vchiq_shim.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index afe43fa5a6d7..54d9e2f31916 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -13,5 +13,5 @@ vchiq-objs := \
 obj-$(CONFIG_SND_BCM2835)	+= bcm2835-audio/
 obj-$(CONFIG_VIDEO_BCM2835)	+= bcm2835-camera/
 
-ccflags-y += -Idrivers/staging/vc04_services -D__VCCOREVER__=0x04000000
+ccflags-y += -D__VCCOREVER__=0x04000000
 
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 56b1037d8e25..ff2b960d8cac 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -4,8 +4,8 @@
 #ifndef VCHI_H_
 #define VCHI_H_
 
-#include "interface/vchi/vchi_cfg.h"
-#include "interface/vchi/vchi_common.h"
+#include "vchi_cfg.h"
+#include "vchi_common.h"
 
 /******************************************************************************
  * Global defs
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 0ce3b08b3441..efdd3b1c7d85 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -3,7 +3,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
-#include "interface/vchi/vchi.h"
+#include "../vchi/vchi.h"
 #include "vchiq.h"
 #include "vchiq_core.h"
 
-- 
2.17.1

