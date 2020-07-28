Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF3FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC32A206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="bUXmoniN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgG1Lmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:42:46 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:20038 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbgG1Lmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595936565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iwLhOsjZtYhl+WFa5BUY/82Z8FbB6FQLSph99aT8EGw=;
  b=bUXmoniNbcgNLgTZrtsAy8hkZPifzvSJ2ngAdDu8ViXXL+I3ppmCjQnQ
   ZlNs4DYzOfoPX9hkaEqQ1eAQ/89fQHeAND2lER3/qQQ9fRRkJriKcHvJM
   YKRWOgmlM+APPf5kAeWvR41GtQP4SJYHDIumsGLdJijWco3FlDscVjqJR
   A=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: eST4pcblEO9C4zMoJzXs8FUL90X3L5/U0rACoVj/dtaz69BM1mQPX91USa/YLWbf/s5kkvs3z3
 QoxfVkTFF9gEtfVjJ2yybcqAH46FK8ACLdf97hJ6Hifthnze4ZxYG9Nc41FuSq47pXZeBrwobb
 TZ9GbHrh1h//0/sZC1rIdcSLxLAhbUvoZpFO4DAN7DuYKGEmcrKTu+MzROy8YleM2D0DxUYTLp
 s4j/3TQR8RoAyxfz2785glGSM5s8yBtxv6NnlJwLCUT3EhorCmMCbHdUMduNkBYU4PVBX7wQYr
 O9w=
X-SBRS: 2.7
X-MesageID: 23666671
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,406,1589256000"; 
   d="scan'208";a="23666671"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH] xen/balloon: add header guard
Date:   Tue, 28 Jul 2020 13:42:35 +0200
Message-ID: <20200728114235.58619-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727091342.52325-5-roger.pau@citrix.com>
References: <20200727091342.52325-5-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to protect against the header being included multiple times
on the same compilation unit.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
---
This is required as a pre-patch to use ZONE_DEVICE, or else the
fallback of including the balloon header might not work properly.
---
 include/xen/balloon.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/xen/balloon.h b/include/xen/balloon.h
index 6fb95aa19405..6dbdb0b3fd03 100644
--- a/include/xen/balloon.h
+++ b/include/xen/balloon.h
@@ -2,6 +2,8 @@
 /******************************************************************************
  * Xen balloon functionality
  */
+#ifndef _XEN_BALLOON_H
+#define _XEN_BALLOON_H
 
 #define RETRY_UNLIMITED	0
 
@@ -34,3 +36,5 @@ static inline void xen_balloon_init(void)
 {
 }
 #endif
+
+#endif	/* _XEN_BALLOON_H */
-- 
2.27.0

