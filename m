Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7647EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336A820829
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDZD1E/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbgF2VVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbgF2Swn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899B4C02E2DA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g18so16717329wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LaDrQKEmYDpmhOISw+HFewU1l3tDs3w3ogOpoIA2uN8=;
        b=QDZD1E/9mwp7cfrgqZrqgaE7lGA3ei+Rg22ZRYVh4tYM3xOIaNa6YJFDsY+D4RevD+
         IuuHKr6BYZrAkktht/fH5EhOkmgn0TcBTvOwS+uQZ9OOqteNofjMA3qFe1bL559UJz7o
         9tNOkQ6OLJcIRlAp0ZWeYUKjxl/aITEh6LZlI5jxtPmX0fQqGGHCL33GvnFQOJh5ROzC
         XCTP06lHVpX6iVNZBsyPaTuw2Q3BPpQ7jfa8djKvbxNFfyVexLanjtdIIal32c+uXq9j
         sBGNaQu+/99e6YWBTZADXxTfDipb5V/hldrKYAWLg9Sn4Mv9dLipmeYmXfm9s5rsKp6h
         3itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaDrQKEmYDpmhOISw+HFewU1l3tDs3w3ogOpoIA2uN8=;
        b=EnAKXCX3Zcmuyws6lpaMuK81Sdi76PT1BYL43HDQkh9qE2pcZfU/tw7mCVPjDH5P+h
         mJLWvzEw9PJp9AIr+cnOWLNBNVG+1MSwBBKArJzrYcZ505X21LvcX2QFdOJgtjYJIeO8
         zbqULFEgSMfxagVs11Yr3D/hRTNH83+ZL989BeDYl/S4oFbC4K3n5vuX13J7PxptmMmp
         Lzbo4KmA2Kf9DTSmxsYgRMG6iCjinlOkJXaZOwjh6C4/+bLtbHY8SSw9i5YeyRs20QGl
         yXZXN2kDNvqB+/lypk2a192g9p3MA4LmgoPRAXKD+JqSM6Rp+KOLvMMSqJKzRqEbc9Hp
         eEQw==
X-Gm-Message-State: AOAM5307AzgDHy613BwYUfovLobl3cp1O7aRJW2NZJVNiej0J6Shdf2M
        x60PDDOahbPfFGLH8PDXKIGmkQ==
X-Google-Smtp-Source: ABdhPJzl12/NkxoNTuG2tDJ4lxfsOxRelqQlweCR8UDDSuqOm/zLruwEJaWtVaWl3vuHMZEHwHqTvg==
X-Received: by 2002:a5d:684f:: with SMTP id o15mr12582829wrw.148.1593439508252;
        Mon, 29 Jun 2020 07:05:08 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:05:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: [PATCH 18/20] misc: genwqe: card_base: Whole host of kerneldoc fixes
Date:   Mon, 29 Jun 2020 15:04:40 +0100
Message-Id: <20200629140442.1043957-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From missing documentation for function arguments, to promotion
obvious kerneldoc headers and incorrectly named arguments.

Fixes the following W=1 warnings:

 drivers/misc/genwqe/card_base.c:175: warning: Function parameter or member 'cd' not described in 'genwqe_bus_reset'
 drivers/misc/genwqe/card_base.c:272: warning: Function parameter or member 'cd' not described in 'genwqe_recovery_on_fatal_gfir_required'
 drivers/misc/genwqe/card_base.c:293: warning: Function parameter or member 'cd' not described in 'genwqe_T_psec'
 drivers/misc/genwqe/card_base.c:314: warning: Function parameter or member 'cd' not described in 'genwqe_setup_pf_jtimer'
 drivers/misc/genwqe/card_base.c:334: warning: Function parameter or member 'cd' not described in 'genwqe_setup_vf_jtimer'
 drivers/misc/genwqe/card_base.c:557: warning: Function parameter or member 'cd' not described in 'genwqe_stop'
 drivers/misc/genwqe/card_base.c:617: warning: Function parameter or member 'cd' not described in 'genwqe_fir_checking'
 drivers/misc/genwqe/card_base.c:760: warning: Function parameter or member 'pci_dev' not described in 'genwqe_pci_fundamental_reset'
 drivers/misc/genwqe/card_base.c:889: warning: Function parameter or member 'data' not described in 'genwqe_health_thread'
 drivers/misc/genwqe/card_base.c:1046: warning: Function parameter or member 'cd' not described in 'genwqe_pci_setup'
 drivers/misc/genwqe/card_base.c:1131: warning: Function parameter or member 'cd' not described in 'genwqe_pci_remove'
 drivers/misc/genwqe/card_base.c:1151: warning: Function parameter or member 'pci_dev' not described in 'genwqe_probe'
 drivers/misc/genwqe/card_base.c:1151: warning: Function parameter or member 'id' not described in 'genwqe_probe'
 drivers/misc/genwqe/card_base.c:1151: warning: Excess function parameter 'pdev' description in 'genwqe_probe'
 drivers/misc/genwqe/card_base.c:1207: warning: Function parameter or member 'pci_dev' not described in 'genwqe_remove'
 drivers/misc/genwqe/card_base.c:1336: warning: Function parameter or member 'dev' not described in 'genwqe_devnode'
 drivers/misc/genwqe/card_base.c:1336: warning: Function parameter or member 'mode' not described in 'genwqe_devnode'

Cc: Michael Jung <mijung@gmx.net>
Cc: Michael Ruettger <michael@ibmra.de>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/genwqe/card_base.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 809a6f46f6de3..93d2ed91c85b2 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -165,6 +165,7 @@ static void genwqe_dev_free(struct genwqe_dev *cd)
 
 /**
  * genwqe_bus_reset() - Card recovery
+ * @cd: GenWQE device information
  *
  * pci_reset_function() will recover the device and ensure that the
  * registers are accessible again when it completes with success. If
@@ -262,6 +263,7 @@ static void genwqe_tweak_hardware(struct genwqe_dev *cd)
 
 /**
  * genwqe_recovery_on_fatal_gfir_required() - Version depended actions
+ * @cd: GenWQE device information
  *
  * Bitstreams older than 2013-02-17 have a bug where fatal GFIRs must
  * be ignored. This is e.g. true for the bitstream we gave to the card
@@ -280,6 +282,7 @@ int genwqe_flash_readback_fails(struct genwqe_dev *cd)
 
 /**
  * genwqe_T_psec() - Calculate PF/VF timeout register content
+ * @cd: GenWQE device information
  *
  * Note: From a design perspective it turned out to be a bad idea to
  * use codes here to specifiy the frequency/speed values. An old
@@ -303,6 +306,7 @@ static int genwqe_T_psec(struct genwqe_dev *cd)
 
 /**
  * genwqe_setup_pf_jtimer() - Setup PF hardware timeouts for DDCB execution
+ * @cd: GenWQE device information
  *
  * Do this _after_ card_reset() is called. Otherwise the values will
  * vanish. The settings need to be done when the queues are inactive.
@@ -329,6 +333,7 @@ static bool genwqe_setup_pf_jtimer(struct genwqe_dev *cd)
 
 /**
  * genwqe_setup_vf_jtimer() - Setup VF hardware timeouts for DDCB execution
+ * @cd: GenWQE device information
  */
 static bool genwqe_setup_vf_jtimer(struct genwqe_dev *cd)
 {
@@ -543,6 +548,7 @@ static int genwqe_start(struct genwqe_dev *cd)
 
 /**
  * genwqe_stop() - Stop card operation
+ * @cd: GenWQE device information
  *
  * Recovery notes:
  *   As long as genwqe_thread runs we might access registers during
@@ -606,6 +612,7 @@ static int genwqe_health_check_cond(struct genwqe_dev *cd, u64 *gfir)
 
 /**
  * genwqe_fir_checking() - Check the fault isolation registers of the card
+ * @cd: GenWQE device information
  *
  * If this code works ok, can be tried out with help of the genwqe_poke tool:
  *   sudo ./tools/genwqe_poke 0x8 0xfefefefefef
@@ -750,6 +757,7 @@ static u64 genwqe_fir_checking(struct genwqe_dev *cd)
 
 /**
  * genwqe_pci_fundamental_reset() - trigger a PCIe fundamental reset on the slot
+ * @pci_dev:	PCI device information struct
  *
  * Note: pci_set_pcie_reset_state() is not implemented on all archs, so this
  * reset method will not work in all cases.
@@ -814,8 +822,9 @@ static int genwqe_platform_recovery(struct genwqe_dev *cd)
 	return rc;
 }
 
-/*
+/**
  * genwqe_reload_bistream() - reload card bitstream
+ * @cd: GenWQE device information
  *
  * Set the appropriate register and call fundamental reset to reaload the card
  * bitstream.
@@ -868,6 +877,7 @@ static int genwqe_reload_bistream(struct genwqe_dev *cd)
 
 /**
  * genwqe_health_thread() - Health checking thread
+ * @data: GenWQE device information
  *
  * This thread is only started for the PF of the card.
  *
@@ -1041,6 +1051,7 @@ static int genwqe_health_check_stop(struct genwqe_dev *cd)
 
 /**
  * genwqe_pci_setup() - Allocate PCIe related resources for our card
+ * @cd: GenWQE device information
  */
 static int genwqe_pci_setup(struct genwqe_dev *cd)
 {
@@ -1126,6 +1137,7 @@ static int genwqe_pci_setup(struct genwqe_dev *cd)
 
 /**
  * genwqe_pci_remove() - Free PCIe related resources for our card
+ * @cd: GenWQE device information
  */
 static void genwqe_pci_remove(struct genwqe_dev *cd)
 {
@@ -1140,7 +1152,8 @@ static void genwqe_pci_remove(struct genwqe_dev *cd)
 
 /**
  * genwqe_probe() - Device initialization
- * @pdev:	PCI device information struct
+ * @pci_dev:	PCI device information struct
+ * @id:		PCI device ID
  *
  * Callable for multiple cards. This function is called on bind.
  *
@@ -1200,6 +1213,7 @@ static int genwqe_probe(struct pci_dev *pci_dev,
 
 /**
  * genwqe_remove() - Called when device is removed (hot-plugable)
+ * @pci_dev:	PCI device information struct
  *
  * Or when driver is unloaded respecitively when unbind is done.
  */
@@ -1219,8 +1233,10 @@ static void genwqe_remove(struct pci_dev *pci_dev)
 	genwqe_dev_free(cd);
 }
 
-/*
+/**
  * genwqe_err_error_detected() - Error detection callback
+ * @pci_dev:	PCI device information struct
+ * @state:	PCI channel state
  *
  * This callback is called by the PCI subsystem whenever a PCI bus
  * error is detected.
@@ -1328,6 +1344,8 @@ static struct pci_driver genwqe_driver = {
 
 /**
  * genwqe_devnode() - Set default access mode for genwqe devices.
+ * @dev:	Pointer to device (unused)
+ * @mode:	Carrier to pass-back given mode (permissions)
  *
  * Default mode should be rw for everybody. Do not change default
  * device name.
-- 
2.25.1

