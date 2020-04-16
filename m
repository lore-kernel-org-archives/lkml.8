Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBE7C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B1920732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587044209;
	bh=nLk72JFj+2vX8XnZrO5sy89nEwKxWMogbtUOdGa0KEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nd2DPcbYEw5yOluVMYaP83suP1RO9QffhRztEHUeXotKtxC2KSTO42piCpt5pfN8s
	 JOmsiCgb4yDH38yOrKfAdybJtNPfE6Z6ygl+9+n1OaOVwwS5GubEeNlsEosKGZ/sB2
	 xNU1dre5eg1v/C1/VInBvS5CGJDB8ayCo/Wkt8pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896748AbgDPNgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896067AbgDPN3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:29:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41441217D8;
        Thu, 16 Apr 2020 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043785;
        bh=nLk72JFj+2vX8XnZrO5sy89nEwKxWMogbtUOdGa0KEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3DSmEWGvphcXQhabx8mo1GL/PJsxVZrsbBoRrjYEX7tyTQcPZvTsCSd4QfVx7uJE
         Fy+rZFSog7xbTZUdESX9BnugyXVZO7ztHXGa7kPv9grhxpVpGZ/sfYBvsiF44XS1VD
         JkKMDtIjglXqiJznYYHfVVf/QZ7EpDbsyjg8eqsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 099/146] mm: Use fixed constant in page_frag_alloc instead of size + 1
Date:   Thu, 16 Apr 2020 15:24:00 +0200
Message-Id: <20200416131256.290378274@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

commit 8644772637deb121f7ac2df690cbf83fa63d3b70 upstream.

This patch replaces the size + 1 value introduced with the recent fix for 1
byte allocs with a constant value.

The idea here is to reduce code overhead as the previous logic would have
to read size into a register, then increment it, and write it back to
whatever field was being used. By using a constant we can avoid those
memory reads and arithmetic operations in favor of just encoding the
maximum value into the operation itself.

Fixes: 2c2ade81741c ("mm: page_alloc: fix ref bias in page_frag_alloc() for 1-byte allocs")
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4537,11 +4537,11 @@ refill:
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
-		page_ref_add(page, size);
+		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
-		nc->pagecnt_bias = size + 1;
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		nc->offset = size;
 	}
 
@@ -4557,10 +4557,10 @@ refill:
 		size = nc->size;
 #endif
 		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, size + 1);
+		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
 
 		/* reset page count bias and offset to start of new frag */
-		nc->pagecnt_bias = size + 1;
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		offset = size - fragsz;
 	}
 


