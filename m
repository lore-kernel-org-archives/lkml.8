Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0981EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D114B20737
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbgGVTU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:20:56 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:33340 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgGVTU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:20:56 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id C10D9BDF0A;
        Wed, 22 Jul 2020 19:20:52 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH v2] ARM: STM32: Replace HTTP links with HTTPS ones
Date:   Wed, 22 Jul 2020 21:20:46 +0200
Message-Id: <20200722192046.69334-1-grandmaster@al2klimov.de>
In-Reply-To: <55c95208-de0f-b2d3-c20c-d19f3ce34e2a@st.com>
References: <55c95208-de0f-b2d3-c20c-d19f3ce34e2a@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 v2: Undone crypto changes.

 arch/arm/mach-stm32/Makefile.boot | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32/Makefile.boot b/arch/arm/mach-stm32/Makefile.boot
index cec195d4fcba..5dde7328a7a9 100644
--- a/arch/arm/mach-stm32/Makefile.boot
+++ b/arch/arm/mach-stm32/Makefile.boot
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Empty file waiting for deletion once Makefile.boot isn't needed any more.
 # Patch waits for application at
-# http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
+# https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
-- 
2.27.0

