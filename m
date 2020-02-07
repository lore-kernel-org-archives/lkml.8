Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CB9C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2628214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 14:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="gRimdg7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBGO07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:26:59 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:51046 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgBGO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 09:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1581085618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=uXvsgNu6MmeKipdO1plI3DH/B0ELhbFMcurpPA0b8Ak=;
  b=gRimdg7IHRDsGYJKBykmsnHWA2LjozKxq7m8Imnpg8xc5zkVRfURTVBV
   NyQIWdDHrlq1JHZolabnTTbv37VixPVZPIDRqpDFxXLMbMk4/bvwX/osD
   MaVvlrKvKQWAzXQqLtlx5TrQHDLI+XOdHPCHaQMGyu9VnzTCJNKrsM4CP
   4=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: kMMz1oyZramg5ckLxUaxLPT0jR449vrClgivhA3Gm8ZlVz5SUPPvSuwAPwqhJfmuBnoLUKlldo
 E+J7QlpDxutZ8TB8H+ybgc3fuUAHYrc0xcqNp+avLDJaZ2qnpb18hAzEQv4+OTQdbt/JjvDsj4
 ZSVShM3LgJf74tPuBoogRoUg0zc8a2K/oa4k1g1OX6EJulg+1+I7f94ytjWhEYWSDWKiheSTej
 4qyTHoOgsuA9cFUCoVK99dgYp/L2Yj9LBmIw62LAEemsgElBhmTzRPXuV1ZG0Km2IZK39HnLOM
 BzU=
X-SBRS: 2.7
X-MesageID: 12479584
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,413,1574139600"; 
   d="scan'208";a="12479584"
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
To:     <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Dyasli <sergey.dyasli@citrix.com>
Subject: [PATCH v3 3/4] xen: teach KASAN about grant tables
Date:   Fri, 7 Feb 2020 14:26:51 +0000
Message-ID: <20200207142652.670-4-sergey.dyasli@citrix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207142652.670-1-sergey.dyasli@citrix.com>
References: <20200207142652.670-1-sergey.dyasli@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

Otherwise it produces lots of false positives when a guest starts using
PV I/O devices.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
---
v2 --> v3: no changes

v1 --> v2: no changes

RFC --> v1:
- Slightly clarified the commit message
---
 drivers/xen/grant-table.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 7b36b51cdb9f..ce95f7232de6 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1048,6 +1048,7 @@ int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
 			foreign = xen_page_foreign(pages[i]);
 			foreign->domid = map_ops[i].dom;
 			foreign->gref = map_ops[i].ref;
+			kasan_alloc_pages(pages[i], 0);
 			break;
 		}
 
@@ -1084,8 +1085,10 @@ int gnttab_unmap_refs(struct gnttab_unmap_grant_ref *unmap_ops,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < count; i++)
+	for (i = 0; i < count; i++) {
 		ClearPageForeign(pages[i]);
+		kasan_free_pages(pages[i], 0);
+	}
 
 	return clear_foreign_p2m_mapping(unmap_ops, kunmap_ops, pages, count);
 }
-- 
2.17.1

