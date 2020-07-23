Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9175C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9B120888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ceKjNjFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgGWIpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:45:45 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:57889 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGWIpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595493944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Tw4G/V7kxbTklR4OkIgBDvRcTQey+xrJa3KZIIL0yE=;
  b=ceKjNjFl5vtlf8S/k3q8TVj9RWGzPfxh30dVW5mRkQhb/oPVdwkdxxEz
   NnngsNUdQrXzo6/Yn3/8dq0gmv08gzIbnuYjm9NMdyaaaOfxoX9E5UPjn
   Y8AnJ9WIOm0mtzWey54EvhPztY3jMpYtf42MTzqTGXpNkkoia3mfLmLo/
   E=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: XvT0C2bz7SBG/PGU4X8x9SKjeEDHKXC2DnQh4Ohf3AOgAn+fTf2GBFquaKPJBrljF3EVlbn2no
 Lzfc3CouKYANDaPfndD65nop2ySPLmK0BRz+SfUhqzhkTkvyl+hHr4Z0fdpAz1X2ZWwbByPwxE
 txf4kH+VPc2cNl/2s6fQcd2ImZSNihdbZ55qd9S6RkyMdKww02zAxd/G43mz0DnCOq5uctvKGf
 qm8BXn1hp7fmezUGGl0A0/xagekyzRUqjT8GjK/+LO+PDB2u/KfTu3f//hJBi5jthWymPxhGdP
 Ppc=
X-SBRS: 2.7
X-MesageID: 23880204
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,386,1589256000"; 
   d="scan'208";a="23880204"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>, <stable@vger.kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH 2/3] xen/balloon: make the balloon wait interruptible
Date:   Thu, 23 Jul 2020 10:45:22 +0200
Message-ID: <20200723084523.42109-3-roger.pau@citrix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723084523.42109-1-roger.pau@citrix.com>
References: <20200723084523.42109-1-roger.pau@citrix.com>
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

