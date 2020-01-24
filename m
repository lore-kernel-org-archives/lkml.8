Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9D6C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7F72087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864644;
	bh=xo47iMd4fSvK6849rhg7FJ/0OLUiD5TP2a9VzGl3glw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V1phx6fgYK86olQ4tC4F6YdjLAqSkZEW+1PvsNsmtolTTyjIa1GhSpMB8BkRjCh98
	 LAiq/EJB37tRRZwqVAOsfjT+8B3jgQuvwl2teWfYzxRFs4Cr3K1DZfGb8k0EbbEc4i
	 atRepCnPglb3BrDTiS5HhIghuHTQ0AjOiNnyetrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390501AbgAXLRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:17:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389371AbgAXLRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:17:17 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E712087E;
        Fri, 24 Jan 2020 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864637;
        bh=xo47iMd4fSvK6849rhg7FJ/0OLUiD5TP2a9VzGl3glw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0ViAeGJb+f4MKi0GQ+6/gl7vFs7wxrq1nZREmxABcPcGezmfcns40ynvlLZ6fXfJ
         juoV22FIZNvi2JOOXPFwBcL3pkSWBJAkmF3WJBnq8cNAhNrdZiIIYYWUPdFsY8dSUC
         d4begl5jDAQhR6su532LbNcc6o/hi4q58vFo96xg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        Alexander Aring <aring@mojatatu.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 322/639] 6lowpan: Off by one handling ->nexthdr
Date:   Fri, 24 Jan 2020 10:28:12 +0100
Message-Id: <20200124093127.379892553@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
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



