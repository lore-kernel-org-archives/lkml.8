Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7C52176B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGUEhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:37:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:2715 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgGUEhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:37:50 -0400
IronPort-SDR: +/4h1hhuCdc8DZRaJXuLlAAlxUFDjtzN8jf5E7V3Uwk/uvb1Rqv6q2qcAuijwWbbH4FCjksgzD
 vLVhHufWV0dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="214724510"
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="214724510"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 21:37:49 -0700
IronPort-SDR: 6aJP3lGvzKKW1Tez1KCaohuaZWy3R+sWUgYhN6mY4rVnyHpH7ZfZbFQQD4Gy+8G3copSU/qlHS
 xJPpbfqmCXTw==
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="287782877"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 21:37:49 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu: Add Lakefield, Alder Lake and Rocket Lake to Intel family
Date:   Mon, 20 Jul 2020 21:37:49 -0700
Message-Id: <20200721043749.31567-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200709192353.21151-1-tony.luck@intel.com>
References: <20200709192353.21151-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three new CPU models.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

This patch supercedes
  https://lore.kernel.org/lkml/20200709192353.21151-1-tony.luck@intel.com/
That one just added Rocket Lake

 arch/x86/include/asm/intel-family.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index a338a6deb950..5e658ba2654a 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -89,8 +89,15 @@
 #define INTEL_FAM6_COMETLAKE		0xA5
 #define INTEL_FAM6_COMETLAKE_L		0xA6
 
+#define INTEL_FAM6_ROCKETLAKE		0xA7
+
 #define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F
 
+/* Hybrid Core/Atom Processors */
+
+#define	INTEL_FAM6_LAKEFIELD		0x8A
+#define INTEL_FAM6_ALDERLAKE		0x97
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
-- 
2.21.1

