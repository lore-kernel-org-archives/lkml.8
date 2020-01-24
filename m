Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A8B20718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859703;
	bh=xo47iMd4fSvK6849rhg7FJ/0OLUiD5TP2a9VzGl3glw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s4bkVzc7yP72S+q9iS9HJN1yqQ2wFkojjJgp/rwUryTRya5Sl8LbDCtuwRjjdyohC
	 E0H35oiUewjoZ6ASWK9oq3uglEwGPGrcun9YD5aLWHjmGE1Lh5q8Z7k5MZj/I1CG34
	 N69WHH9mvZPuYfx1nzodKlkvJ3KINs4+B7m5WwhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388398AbgAXJzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733081AbgAXJzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:55:00 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 694C720709;
        Fri, 24 Jan 2020 09:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859700;
        bh=xo47iMd4fSvK6849rhg7FJ/0OLUiD5TP2a9VzGl3glw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaANKTqbV/8kCCW2CkgsRYdn+FGGp4qk4vHsQq+6ulwIfMonebq754th+VCxxDUUu
         L1VfC+2v4SdcNHtzfx0UzfQcIVsHCepuEKOeyv+sZDP1hc6/kvZlB4KaQ4X4fOQGvK
         jjhcmOIzmgaJ4ISBc3S5cGRIEHs6iTjpgBjUIic4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        Alexander Aring <aring@mojatatu.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 175/343] 6lowpan: Off by one handling ->nexthdr
Date:   Fri, 24 Jan 2020 10:29:53 +0100
Message-Id: <20200124092943.039609589@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f57c4bbf34439531adccd7d3a4ecc14f409c1399 ]

NEXTHDR_MAX is 255.  What happens here is that we take a u8 value
"hdr->nexthdr" from the network and then look it up in
lowpan_nexthdr_nhcs[].  The problem is that if hdr->nexthdr is 0xff then
we read one element beyond the end of the array so the array needs to
be one element larger.

Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Acked-by: Alexander Aring <aring@mojatatu.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/6lowpan/nhc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
index 4fa2fdda174d0..9e56fb98f33cf 100644
--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -18,7 +18,7 @@
 #include "nhc.h"
 
 static struct rb_root rb_root = RB_ROOT;
-static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
+static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX + 1];
 static DEFINE_SPINLOCK(lowpan_nhc_lock);
 
 static int lowpan_nhc_insert(struct lowpan_nhc *nhc)
-- 
2.20.1



