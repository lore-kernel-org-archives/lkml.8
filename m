Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2079BC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FB72074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Czt7CIUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgGXMnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:43:01 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:34762 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgGXMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595594578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9vtgZWvCFbf23f9EcBa2/BD85tIDxfXjWQT+ZKvEIkQ=;
  b=Czt7CIUx0nuOtcFFImq/Lq+aTFgHTtUp6IoZl/XgDTav3ihP76Tw4QkQ
   Fta6Q9dZZpy43XhWnibp0U0lFGILLn00+TiO1QW6xkX0DiL3ISp4nbKGZ
   IFOOox7mwYuX9uzH+BpxwIVx6pEkBERteak3IlFwXgFLRmkfKjigL5QnI
   M=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: Dc8nqelwNvG0/+NMY4+cPWhthOaCyoSnUTP+8s1m6cGyixWFyqmz0D0lOYHL0AUzwySXw/Dsum
 o63shKP7+8p2KQKTGtvB48PgrA6dEpk+FjgHPkyzfK2BdO9RZy5LFaeWiHSJ7I+WDhXsT2jHOT
 wwolMT+yZOPpLqEFoJMnTdrZTr/gAGSMeUDtDsDdVOpmphY1HzwjTNCmNpwC1cqbLeglQMR3MV
 SEkdE4rvDQv+7kDNXpiuvhHJxFMiP7UZpwCwBW/hxpICmMVwcLWyQ/67BEdhKdnVHEXcmpAL5L
 8z8=
X-SBRS: 2.7
X-MesageID: 23454363
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,390,1589256000"; 
   d="scan'208";a="23454363"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH v2 3/4] Revert "xen/balloon: Fix crash when ballooning on x86 32 bit PAE"
Date:   Fri, 24 Jul 2020 14:42:40 +0200
Message-ID: <20200724124241.48208-4-roger.pau@citrix.com>
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

This reverts commit dfd74a1edfaba5864276a2859190a8d242d18952.

This has been fixed by commit dca4436d1cf9e0d237c which added the out
of bounds check to __add_memory, so that trying to add blocks past
MAX_PHYSMEM_BITS will fail.

Note the check in the Xen balloon driver was bogus anyway, as it
checked the start address of the resource, but it should instead test
the end address to assert the whole resource falls below
MAX_PHYSMEM_BITS.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
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

