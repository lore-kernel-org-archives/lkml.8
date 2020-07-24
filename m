Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE49C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F932074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Nnd2DW6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgGXMm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:42:57 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:33206 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgGXMmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595594575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Tw4G/V7kxbTklR4OkIgBDvRcTQey+xrJa3KZIIL0yE=;
  b=Nnd2DW6MmAEeZtU4bHtBWreBcqZi6wBvSpTqVLHJoDR2SkbjNPs4bAHf
   ojKOJbc/ItzbVs76POKF+R+zw5KfwdPE78toKDCYB1Ztq9ViO6wLV8wNr
   5KuMVkmM6EOE40lf5pVdPz6U0xXqdpybdOvvc3DOoYu9LoqTrl8T0omA+
   U=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: 1RmtWXLEVLsjBBebMyNb9dJntTLAmrgMDJmAs3T9l48/E9hvv/9Zz/JGcwmC/qk907TZ5cCnhv
 JD3rZBNMfCwCn/WlbKh5LBFv7oL/dKr6eU4+jdqj7dHQOQQqNjdvpYQ66LyEy3gb9PIHCC1MrD
 kmD0iJEk7E1uJWWtM02WnuIA+Yoq9Ra2+LyjJAAjbuuR1etEvwEpbBKBYFOxclIwriVbLZlQRM
 khIh9nzeMT3Dhtv9/vt6aqAXVFbKhToIhnx5qJOUTVfm1CHLGLlsws80oqkAFKPc/SW8TD/l4h
 FnA=
X-SBRS: 2.7
X-MesageID: 23139909
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,390,1589256000"; 
   d="scan'208";a="23139909"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>, <stable@vger.kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH v2 2/4] xen/balloon: make the balloon wait interruptible
Date:   Fri, 24 Jul 2020 14:42:39 +0200
Message-ID: <20200724124241.48208-3-roger.pau@citrix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724124241.48208-1-roger.pau@citrix.com>
References: <20200724124241.48208-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it can be killed, or else processes can get hung indefinitely
waiting for balloon pages.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Cc: stable@vger.kernel.org
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/balloon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 3cb10ed32557..292413b27575 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -568,11 +568,13 @@ static int add_ballooned_pages(int nr_pages)
 	if (xen_hotplug_unpopulated) {
 		st = reserve_additional_memory();
 		if (st != BP_ECANCELED) {
+			int rc;
+
 			mutex_unlock(&balloon_mutex);
-			wait_event(balloon_wq,
+			rc = wait_event_interruptible(balloon_wq,
 				   !list_empty(&ballooned_pages));
 			mutex_lock(&balloon_mutex);
-			return 0;
+			return rc ? -ENOMEM : 0;
 		}
 	}
 
-- 
2.27.0

