Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD12C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6092080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrtLON9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHLSCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgHLSCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:02:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662EBC061383;
        Wed, 12 Aug 2020 11:02:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f9so1523475pju.4;
        Wed, 12 Aug 2020 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+2FLDP8PgvnOqN3lOjuKePZvqChpYay81DbMgncLlRg=;
        b=JrtLON9DKM1pqIX/nbvZUqsL7ppyhIFHJF8Cc2utWT5yMhdfKmnV71uDbQcZB3youv
         ZL2gKDHJVViuHZzTTT1HIFtkAY8mBIt5xHOMXKQmMPHzzC8wE/J8KPbBdZUqwU7Lo7sI
         KYGfdv1UJNd0ucJ+a+pgVF2Jcpid7ZraiBnqGG7vVpGpjf312nXSBt047Sj6bUCGiiYg
         POpVSlLpqdqAWCm+aQXPn1Q44rAfgoRTM3dM71Igqb5Omqi96Qq7MkEi6zfl2A0sP0jp
         cV4PO1a2hBFctxcmf9hV+hQC9oMPNkppXnTUe8hMXr1OlF1pbotIxRIR5QVEaSUrINT8
         PWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+2FLDP8PgvnOqN3lOjuKePZvqChpYay81DbMgncLlRg=;
        b=K8/WLdwc3I4aBA3Vv2EBGflY0+3bmHU2oDhfAwYOMl4u22dtQ0UMWxEYM3PZ8yKNS/
         a15qb0mzpCrcTzrqr1Y3YlIT9LLUmpbklLdqt6aGacMi0G8dGM5A91PEP4kqvYFUUy0p
         M5ahm/k80K66v+178YFfMBko4jJvNaiFRDn0dzamSPRCu9Ofvpokm9RO99FSskTfX3B0
         2p8hlyWCXmkvTLpUPu9r2aCUvTZThyCKhrPkj7l1JzH5Aauy5hPIkhul+CSs4JA7YFc2
         SW9Lnmfg7NOCIXRPonFqFFkOgKlfBsnHM5ceB3GPH4dF+CGWU+LIwtAYwPrlC803sCJ6
         jYYQ==
X-Gm-Message-State: AOAM531HANfckTSu5IyceBhVZNba1LkznvdszjCj3dr6tzF/qYwi5GSC
        QJSOupZO6kAP1kThDRD2YBs=
X-Google-Smtp-Source: ABdhPJx3ti9NhmT1zfOyoE7AfMkaXJMyldDkxP92HhW21yw3mugev+E75bf2BonapqOlzQvbUFEATg==
X-Received: by 2002:a17:90a:cf15:: with SMTP id h21mr1276296pju.108.1597255366752;
        Wed, 12 Aug 2020 11:02:46 -0700 (PDT)
Received: from localhost.localdomain ([124.253.105.122])
        by smtp.googlemail.com with ESMTPSA id n26sm3065470pff.30.2020.08.12.11.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 11:02:45 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fpga: Documentation: Replace deprecated :c:func: Usage
Date:   Wed, 12 Aug 2020 23:32:24 +0530
Message-Id: <20200812180224.24810-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace :c:func: with func() as the previous usage is deprecated.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 Documentation/driver-api/fpga/fpga-bridge.rst  |  6 +++---
 Documentation/driver-api/fpga/fpga-mgr.rst     |  6 +++---
 .../driver-api/fpga/fpga-programming.rst       | 16 ++++++++--------
 Documentation/driver-api/fpga/fpga-region.rst  | 18 +++++++++---------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
index 71c5a40da320..ccd677ba7d76 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -6,9 +6,9 @@ API to implement a new FPGA bridge
 
 * struct :c:type:`fpga_bridge` — The FPGA Bridge structure
 * struct :c:type:`fpga_bridge_ops` — Low level Bridge driver ops
-* :c:func:`devm_fpga_bridge_create()` — Allocate and init a bridge struct
-* :c:func:`fpga_bridge_register()` — Register a bridge
-* :c:func:`fpga_bridge_unregister()` — Unregister a bridge
+* devm_fpga_bridge_create() — Allocate and init a bridge struct
+* fpga_bridge_register() — Register a bridge
+* fpga_bridge_unregister() — Unregister a bridge
 
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
    :functions: fpga_bridge
diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 576f1945eacd..af5382af1379 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -104,9 +104,9 @@ API for implementing a new FPGA Manager driver
 * ``fpga_mgr_states`` —  Values for :c:member:`fpga_manager->state`.
 * struct :c:type:`fpga_manager` —  the FPGA manager struct
 * struct :c:type:`fpga_manager_ops` —  Low level FPGA manager driver ops
-* :c:func:`devm_fpga_mgr_create` —  Allocate and init a manager struct
-* :c:func:`fpga_mgr_register` —  Register an FPGA manager
-* :c:func:`fpga_mgr_unregister` —  Unregister an FPGA manager
+* devm_fpga_mgr_create() —  Allocate and init a manager struct
+* fpga_mgr_register() —  Register an FPGA manager
+* fpga_mgr_unregister() —  Unregister an FPGA manager
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
    :functions: fpga_mgr_states
diff --git a/Documentation/driver-api/fpga/fpga-programming.rst b/Documentation/driver-api/fpga/fpga-programming.rst
index b5484df6ff0f..f487ad64dfb9 100644
--- a/Documentation/driver-api/fpga/fpga-programming.rst
+++ b/Documentation/driver-api/fpga/fpga-programming.rst
@@ -6,9 +6,9 @@ Overview
 
 The in-kernel API for FPGA programming is a combination of APIs from
 FPGA manager, bridge, and regions.  The actual function used to
-trigger FPGA programming is :c:func:`fpga_region_program_fpga()`.
+trigger FPGA programming is fpga_region_program_fpga().
 
-:c:func:`fpga_region_program_fpga()` uses functionality supplied by
+fpga_region_program_fpga() uses functionality supplied by
 the FPGA manager and bridges.  It will:
 
  * lock the region's mutex
@@ -20,8 +20,8 @@ the FPGA manager and bridges.  It will:
  * release the locks
 
 The struct fpga_image_info specifies what FPGA image to program.  It is
-allocated/freed by :c:func:`fpga_image_info_alloc()` and freed with
-:c:func:`fpga_image_info_free()`
+allocated/freed by fpga_image_info_alloc() and freed with
+fpga_image_info_free()
 
 How to program an FPGA using a region
 -------------------------------------
@@ -84,10 +84,10 @@ will generate that list.  Here's some sample code of what to do next::
 API for programming an FPGA
 ---------------------------
 
-* :c:func:`fpga_region_program_fpga` —  Program an FPGA
-* :c:type:`fpga_image_info` —  Specifies what FPGA image to program
-* :c:func:`fpga_image_info_alloc()` —  Allocate an FPGA image info struct
-* :c:func:`fpga_image_info_free()` —  Free an FPGA image info struct
+* fpga_region_program_fpga() —  Program an FPGA
+* fpga_image_info() —  Specifies what FPGA image to program
+* fpga_image_info_alloc() —  Allocate an FPGA image info struct
+* fpga_image_info_free() —  Free an FPGA image info struct
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: fpga_region_program_fpga
diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index 0529b2d2231a..31118a8ba218 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -46,18 +46,18 @@ API to add a new FPGA region
 ----------------------------
 
 * struct :c:type:`fpga_region` — The FPGA region struct
-* :c:func:`devm_fpga_region_create` — Allocate and init a region struct
-* :c:func:`fpga_region_register` —  Register an FPGA region
-* :c:func:`fpga_region_unregister` —  Unregister an FPGA region
+* devm_fpga_region_create() — Allocate and init a region struct
+* fpga_region_register() —  Register an FPGA region
+* fpga_region_unregister() —  Unregister an FPGA region
 
 The FPGA region's probe function will need to get a reference to the FPGA
 Manager it will be using to do the programming.  This usually would happen
 during the region's probe function.
 
-* :c:func:`fpga_mgr_get` — Get a reference to an FPGA manager, raise ref count
-* :c:func:`of_fpga_mgr_get` —  Get a reference to an FPGA manager, raise ref count,
+* fpga_mgr_get() — Get a reference to an FPGA manager, raise ref count
+* of_fpga_mgr_get() —  Get a reference to an FPGA manager, raise ref count,
   given a device node.
-* :c:func:`fpga_mgr_put` — Put an FPGA manager
+* fpga_mgr_put() — Put an FPGA manager
 
 The FPGA region will need to specify which bridges to control while programming
 the FPGA.  The region driver can build a list of bridges during probe time
@@ -66,11 +66,11 @@ the list of bridges to program just before programming
 (:c:member:`fpga_region->get_bridges`).  The FPGA bridge framework supplies the
 following APIs to handle building or tearing down that list.
 
-* :c:func:`fpga_bridge_get_to_list` — Get a ref of an FPGA bridge, add it to a
+* fpga_bridge_get_to_list() — Get a ref of an FPGA bridge, add it to a
   list
-* :c:func:`of_fpga_bridge_get_to_list` — Get a ref of an FPGA bridge, add it to a
+* of_fpga_bridge_get_to_list() — Get a ref of an FPGA bridge, add it to a
   list, given a device node
-* :c:func:`fpga_bridges_put` — Given a list of bridges, put them
+* fpga_bridges_put() — Given a list of bridges, put them
 
 .. kernel-doc:: include/linux/fpga/fpga-region.h
    :functions: fpga_region
-- 
2.27.0

