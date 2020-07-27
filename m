Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B84BC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6E92072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="KZInzin2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgG0JPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:15:11 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:7835 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgG0JPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595841309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nq9yI9ZapjAU3I2ISQYBx01cREm8iD5IrXb3HWdctu0=;
  b=KZInzin2gcDJQRvZdUwizW0PAokuwA9G1EfiBgPiA+O49KeLaeSfkJMr
   f1GNSEvLtMTwrrUrVsUcnLOhOR1fZr6H5SwkForVztBAWQcQ/rljyQO/d
   Ao6+E4cvtv4YW6j2Xns7IBOVSd5u4r3hr5DvPx21Z+N4q7tfFY29NztrC
   Y=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: CaWT5LIbKdSm6bglJh6wY7Rm9pQCl8a6jhy9q8a+NizdhgIBcUgMJIVzAoXIXdLIYwEyNXjysu
 jSQTvNe1bbYVQi7e3KcyTmEZFi3CsDbUMupe+asAciCVSRx7faRfhMETYPniYTT+tB4f4E/ny3
 8Z9NHVXMK/B/ZfpG36jfHVTra6T4EWIxWxLV5SwAHLLEW5I157sJPAJSregsF8/dAdp6FxmzH3
 k9ZqiAppaKjGEJvBHAgFr+VIUtwQG6LUpdZxvOwrLfYO2QKjsRrmZ1Z54Lp0a4thonvBtWrRo4
 ohI=
X-SBRS: 2.7
X-MesageID: 23233916
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,402,1589256000"; 
   d="scan'208";a="23233916"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH v3 3/4] Revert "xen/balloon: Fix crash when ballooning on x86 32 bit PAE"
Date:   Mon, 27 Jul 2020 11:13:41 +0200
Message-ID: <20200727091342.52325-4-roger.pau@citrix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727091342.52325-1-roger.pau@citrix.com>
References: <20200727091342.52325-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit dfd74a1edfaba5864276a2859190a8d242d18952.

This has been fixed by commit dca4436d1cf9e0d237c which added the out
of bounds check to __add_memory, so that trying to add blocks past
MAX_PHYSMEM_BITS will fail.

Note the check in the Xen balloon driver was bogus anyway, as it
checked the start address of the resource, but it should instead test
the end address to assert the whole resource falls below
MAX_PHYSMEM_BITS.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/balloon.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 292413b27575..b1d8b028bf80 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -266,20 +266,6 @@ static struct resource *additional_memory_resource(phys_addr_t size)
 		return NULL;
 	}
 
-#ifdef CONFIG_SPARSEMEM
-	{
-		unsigned long limit = 1UL << (MAX_PHYSMEM_BITS - PAGE_SHIFT);
-		unsigned long pfn = res->start >> PAGE_SHIFT;
-
-		if (pfn > limit) {
-			pr_err("New System RAM resource outside addressable RAM (%lu > %lu)\n",
-			       pfn, limit);
-			release_memory_resource(res);
-			return NULL;
-		}
-	}
-#endif
-
 	return res;
 }
 
-- 
2.27.0

