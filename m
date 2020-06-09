Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351EDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1B9206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/I94cLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbgFIU3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbgFIU3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:29:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5532C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 13:29:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so4024777wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 13:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfC1OeZlzvC82G4floLC0Zw276NOk/q2cFwSD6N7xKw=;
        b=t/I94cLS3N8EINQ1/0Jxqjbe3TO3DARuZcAa66s9PrJqJ5b4PX1OBrtjw/g30W9Cgr
         NCRl1uCRrHbGFR9JbjRfYz0M6Ve525XZZOICOD8qYdMv69DCAwF2Cd8RYZz1hQ3z6bFS
         6PdnV5lNJVSSxMvGw9EItVqXpXHVyaHD7pDOGv2HktRvjZeoutpe3oXjhdY9G63sTYZB
         LO34rT+wBRaQRqAidX+zEAipOjtuPY4w+ty/m0NxJAXe1QmUGcWAtRqyJdf/6hyMDrqP
         rocVst8oVRExijG095HJsKV8EjjpP+MVPEXAk3DrcesSIBZ/YnXI+xVwxllKndA8P+tN
         W8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=DfC1OeZlzvC82G4floLC0Zw276NOk/q2cFwSD6N7xKw=;
        b=a328pUnrjgyp60yLrb9ogoyr+KXumUY3xU5tElyZTqrkci9z3HKN1dTVdqnoNDoVQI
         tZBjoFXhKZYkzdF7K0M3bz2+bt/5zkWYPV9/u0kYLvjXHTBcV4yXM0o7KKELgCULh8xh
         W+2n3uOUyAqufAuPMGIZ9zXOWsjxC8djLVNCIW+hDH146Qr5ZqsIluBiYCeWB2H4LTBI
         wql6q0FjQCt9tHOJDx2eGOegTkmEpJcgvZ45OYXzqejW17fXLBaaROTxlfwkrsyj41/s
         VvxKVPaKHcsk2thd4SgBfHncy7v+yYyVxsXPqS5Mzaqa8GoeEafTmcxr1ZLCAFRMdGVr
         b5gw==
X-Gm-Message-State: AOAM533w4aSyE2lo215vtrzap55n+30xi+J/27lgrq6/xENdmfeV0ye4
        ZVTjrhIJZtXFMdb7mlXDqMI=
X-Google-Smtp-Source: ABdhPJxgGATU09n3WWfGRMKa73eSNJiCvYsszsAU9ycH98PYXFAZqLL9LcJAqRgJCwIiuI3WBw7I+A==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr6054789wmc.155.1591734568465;
        Tue, 09 Jun 2020 13:29:28 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id s5sm3878699wme.37.2020.06.09.13.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 13:29:27 -0700 (PDT)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Mark Gross <mgross@linux.intel.com>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] docs: hw-vuln: SRBDS: Fix "Title underline too short" warnings during build
Date:   Tue,  9 Jun 2020 22:28:56 +0200
Message-Id: <20200609202856.2283975-1-carnil@debian.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the title underlining did not have the correct length causing a few
warnings when building the htmldocs. Line up each of the title underlinings
with the text they are under.

Fixes: 7222a1b5b874 ("x86/speculation: Add SRBDS vulnerability and mitigation documentation")
Cc: Mark Gross <mgross@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 .../hw-vuln/special-register-buffer-data-sampling.rst       | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
index 47b1b3afac99..3b1ce68d2456 100644
--- a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
+++ b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
@@ -14,7 +14,7 @@ to the core through the special register mechanism that is susceptible
 to MDS attacks.
 
 Affected processors
---------------------
+-------------------
 Core models (desktop, mobile, Xeon-E3) that implement RDRAND and/or RDSEED may
 be affected.
 
@@ -59,7 +59,7 @@ executed on another core or sibling thread using MDS techniques.
 
 
 Mitigation mechanism
--------------------
+--------------------
 Intel will release microcode updates that modify the RDRAND, RDSEED, and
 EGETKEY instructions to overwrite secret special register data in the shared
 staging buffer before the secret data can be accessed by another logical
@@ -118,7 +118,7 @@ with the option "srbds=".  The option for this is:
   ============= =============================================================
 
 SRBDS System Information
------------------------
+------------------------
 The Linux kernel provides vulnerability status information through sysfs.  For
 SRBDS this can be accessed by the following sysfs file:
 /sys/devices/system/cpu/vulnerabilities/srbds
-- 
2.27.0

