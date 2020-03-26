Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C26C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C11A2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hrCA3qCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZApa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:45:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgCZAp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 20:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=MWwomHnbhJIHVLVpUPf/22EMeHWN9bGAPIBVZmcKq3I=; b=hrCA3qCLYzT+ZlkiTVxH2XRaJS
        9UGeR5/h64IyIq1GjJh7p1t+oUzr6yrD1h9TxLyNrG9GXJl7fM6Nz02odrprjToUzGMoc2zIC8bCD
        aaJ7ypDcWXYzm8QdfmWLuqYomZjiTTnL7ni3Do7ao+nlycRe4d4Uhy5RBrW1pE7Zowt23knvKgHhD
        /+jByArVEDYhsphlLVTlGlBwEw/VQ/Dkn3L5gMpvz4FwYIw7mHVXD+GltYFupfbCEozM1K9Kmf7Ae
        6khm/FheGyzoQRflhKzzLrpJTuj1gDkz/ijMNx7ZpZLVwGX0EbmikT6jT+6EQb2MyBEm1bIu35gwR
        y8+L7Zwg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHGeG-00014f-0K; Thu, 26 Mar 2020 00:45:28 +0000
Subject: [PATCH] mm: mempolicy: require at least one nodeid for MPOL_PREFERRED
To:     Entropy Moe <3ntr0py1337@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org
References: <CALzBtjLSqFhSNAf4YusxuE1piUTzOSLFGFD4RrhPLQAmgpyL5g@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <89526377-7eb6-b662-e1d8-4430928abde9@infradead.org>
Date:   Wed, 25 Mar 2020 17:45:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALzBtjLSqFhSNAf4YusxuE1piUTzOSLFGFD4RrhPLQAmgpyL5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Using an empty (malformed) nodelist that is not caught during
mount option parsing leads to a stack-out-of-bounds access.

The option string that was used was: "mpol=prefer:,".
However, MPOL_PREFERRED requires a single node number,
which is not being provided here.

Add a check that 'nodes' is not empty after parsing for
MPOL_PREFERRED's nodeid.

Fixes: 095f1fc4ebf3 ("mempolicy: rework shmem mpol parsing and display")
Reported-by: Entropy Moe <3ntr0py1337@gmail.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: Lee Schermerhorn <lee.schermerhorn@hp.com>
---
 mm/mempolicy.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- lnx-56-rc6.orig/mm/mempolicy.c
+++ lnx-56-rc6/mm/mempolicy.c
@@ -2841,7 +2841,9 @@ int mpol_parse_str(char *str, struct mem
 	switch (mode) {
 	case MPOL_PREFERRED:
 		/*
-		 * Insist on a nodelist of one node only
+		 * Insist on a nodelist of one node only, although later
+		 * we use first_node(nodes) to grab a single node, so here
+		 * nodelist (or nodes) cannot be empty.
 		 */
 		if (nodelist) {
 			char *rest = nodelist;
@@ -2849,6 +2851,8 @@ int mpol_parse_str(char *str, struct mem
 				rest++;
 			if (*rest)
 				goto out;
+			if (nodes_empty(nodes))
+				goto out;
 		}
 		break;
 	case MPOL_INTERLEAVE:

