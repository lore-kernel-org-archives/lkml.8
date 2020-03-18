Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EAEC4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BBF20752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ix5Z/nym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgCRVdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:33:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgCRVdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7C99gg0dFQ88jekGFXdIQKCeI7+noYOSr4It/4IKhXs=; b=ix5Z/nym4gWSAkSZ3dwnCjogYk
        g5HR2B8EKYlPJK4VmyBlhL7mGkwQG3+OmTvnXENcd19BI/COJXrw0nvngsrx68Uxd94L9l/y3s2sy
        Nn6BZjIZAzT/UgoHNldFa6UrSGGbHygCxL713OcmqBp7g9RwCy46xDTYDHRksUdAOrtUjQoR6oT+w
        SAtYLEuiHIuGTs0GRPNQsvrb65dUWWmvrL9nARiblnFNgyuD6yF+/ZPTiT+YU4o2bRDhk2x9W7Ej+
        fNR6Pjn2EUy0rGQn/b2Im/K3KWNmuib8j3OJSfuKI1m5jIOkyTvIfTQkig/3ZEAHxIdSKSZRcEeaG
        L5yHMdog==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEgJU-0007sv-7q; Wed, 18 Mar 2020 21:33:20 +0000
To:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] mm/hugetlb.c: fix printk format warning for 32-bit
 phys_addr_t
Message-ID: <b74dcb60-ef35-f06e-de2d-b165ed38036a@infradead.org>
Date:   Wed, 18 Mar 2020 14:33:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix printk format warnings when phys_addr_t is 32 bits, i.e.,
CONFIG_PHYS_ADDR_T_64BIT is not set/enabled.

Fixes these build warnings:
  CC      mm/hugetlb.o
In file included from ../include/linux/printk.h:7:0,
                 from ../include/linux/kernel.h:15,
                 from ../include/linux/list.h:9,
                 from ../mm/hugetlb.c:6:
../mm/hugetlb.c: In function ‘hugetlb_cma_reserve’:
../include/linux/kern_levels.h:5:18: warning: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 4 has type ‘unsigned int’ [-Wformat=]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^
../include/linux/kern_levels.h:12:22: note: in expansion of macro ‘KERN_SOH’
 #define KERN_WARNING KERN_SOH "4" /* warning conditions */
                      ^~~~~~~~
../include/linux/printk.h:306:9: note: in expansion of macro ‘KERN_WARNING’
  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         ^~~~~~~~~~~~
../mm/hugetlb.c:5472:4: note: in expansion of macro ‘pr_warn’
    pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
    ^~~~~~~
../mm/hugetlb.c:5472:67: note: format string is defined here
    pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
                                                                ~~~^
                                                                %u
In file included from ../include/linux/printk.h:7:0,
                 from ../include/linux/kernel.h:15,
                 from ../include/linux/list.h:9,
                 from ../mm/hugetlb.c:6:
../include/linux/kern_levels.h:5:18: warning: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘unsigned int’ [-Wformat=]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^
../include/linux/kern_levels.h:12:22: note: in expansion of macro ‘KERN_SOH’
 #define KERN_WARNING KERN_SOH "4" /* warning conditions */
                      ^~~~~~~~
../include/linux/printk.h:306:9: note: in expansion of macro ‘KERN_WARNING’
  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         ^~~~~~~~~~~~
../mm/hugetlb.c:5472:4: note: in expansion of macro ‘pr_warn’
    pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
    ^~~~~~~
../mm/hugetlb.c:5472:73: note: format string is defined here
    pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
                                                                      ~~~^
                                                                      %u

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 mm/hugetlb.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-next-20200318.orig/mm/hugetlb.c
+++ linux-next-20200318/mm/hugetlb.c
@@ -5469,8 +5469,10 @@ void __init hugetlb_cma_reserve(int orde
 					     0, false,
 					     "hugetlb", &hugetlb_cma[nid]);
 		if (res) {
-			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
-				res, nid, PFN_PHYS(min_pfn), PFN_PHYS(max_pfn));
+			phys_addr_t begpa = PFN_PHYS(min_pfn);
+			phys_addr_t endpa = PFN_PHYS(max_pfn);
+			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%pap, %pap)",
+				res, nid, &begpa, &endpa);
 			break;
 		}
 

