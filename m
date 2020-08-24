Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B7DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E72E2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258444;
	bh=cBWRrPXAZq+OpXD8QP6SeV0mkgjHFxpB8eaf/FyXlsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VdlNMjRxR492V10MS9yiTp3DgAB6AUXc9BI4gnbI3anHb+oBwf6UV3XKvmPKuPQ1p
	 gLQJ8mYjmZQsFGSbAbg7eRe3ZtUUCBpL6SbbeCwTTiFHDOn0h/jU+IyOjy1M+Fw7d2
	 Ru3DJNZU3lfQQ+9gD5qaxpYNvmyBnWU2yOp7PUDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgHXIkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728751AbgHXIkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:40:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C16EF20FC3;
        Mon, 24 Aug 2020 08:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258425;
        bh=cBWRrPXAZq+OpXD8QP6SeV0mkgjHFxpB8eaf/FyXlsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BLNR9C48ReMQmbwtg62NLBpMww2myyMsIE/rH8NBK1kXPjWLx8vGFFegevbYNwJ2
         xqRtlfsTyKmM9FQORLEpYpqCmRDGKZUN8ARV03MpPI4bdselfgjx2xFj+Z6NOdDa3v
         nY8n7N80B9CjJh9oXf7SHQurVN+KSVL+vDq1JkHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 043/124] m68knommu: fix overwriting of bits in ColdFire V3 cache control
Date:   Mon, 24 Aug 2020 10:29:37 +0200
Message-Id: <20200824082411.544537405@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Ungerer <gerg@linux-m68k.org>

[ Upstream commit bdee0e793cea10c516ff48bf3ebb4ef1820a116b ]

The Cache Control Register (CACR) of the ColdFire V3 has bits that
control high level caching functions, and also enable/disable the use
of the alternate stack pointer register (the EUSP bit) to provide
separate supervisor and user stack pointer registers. The code as
it is today will blindly clear the EUSP bit on cache actions like
invalidation. So it is broken for this case - and that will result
in failed booting (interrupt entry and exit processing will be
completely hosed).

This only affects ColdFire V3 parts that support the alternate stack
register (like the 5329 for example) - generally speaking new parts do,
older parts don't. It has no impact on ColdFire V3 parts with the single
stack pointer, like the 5307 for example.

Fix the cache bit defines used, so they maintain the EUSP bit when
carrying out cache actions through the CACR register.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/include/asm/m53xxacr.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/m53xxacr.h b/arch/m68k/include/asm/m53xxacr.h
index 9138a624c5c81..692f90e7fecc1 100644
--- a/arch/m68k/include/asm/m53xxacr.h
+++ b/arch/m68k/include/asm/m53xxacr.h
@@ -89,9 +89,9 @@
  * coherency though in all cases. And for copyback caches we will need
  * to push cached data as well.
  */
-#define CACHE_INIT	  CACR_CINVA
-#define CACHE_INVALIDATE  CACR_CINVA
-#define CACHE_INVALIDATED CACR_CINVA
+#define CACHE_INIT        (CACHE_MODE + CACR_CINVA - CACR_EC)
+#define CACHE_INVALIDATE  (CACHE_MODE + CACR_CINVA)
+#define CACHE_INVALIDATED (CACHE_MODE + CACR_CINVA)
 
 #define ACR0_MODE	((CONFIG_RAMBASE & 0xff000000) + \
 			 (0x000f0000) + \
-- 
2.25.1



