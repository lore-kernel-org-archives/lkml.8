Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52562247F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159080;
	bh=dFnDNSHS2+OAHO0LGMtY8LKC5e1OPYAD0D0Dw5/i9t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eU1d3VOGgC7yPeBhGzd+4Sw28az0EJrrkkgRWmd93plrbDg5STsdsMqODErYVehgk
	 OFCGQQ73a4zMG23tytIVs5xZp2yIHFwyVwUtUsfadxKcUE/JRWnmCqvqyqoIfc12rd
	 6Nrk4zjs/uoxxiySDBceEzzTyfrG0JrPttPY9Jag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgEVOvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbgEVOvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:51:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC5B2242B;
        Fri, 22 May 2020 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159072;
        bh=dFnDNSHS2+OAHO0LGMtY8LKC5e1OPYAD0D0Dw5/i9t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqzAse1yv0LCI1ZnkhuOkSRGjufGIlPO5lg7QLAX+vr9cams4Ho7tQQLOgqLBwtZH
         VrnROmQGiSWYPh8OvRdHBapdnOvQZI21VOKYPMZkaH9vy5PSelWcnQ/dmEVI6iwBlx
         xVu2rI6MQzdezerhR8NW5YUl0M/DNmrflQULm7vw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liu Yibin <jiulong@linux.alibaba.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 25/32] csky: Fixup msa highest 3 bits mask
Date:   Fri, 22 May 2020 10:50:37 -0400
Message-Id: <20200522145044.434677-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145044.434677-1-sashal@kernel.org>
References: <20200522145044.434677-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Yibin <jiulong@linux.alibaba.com>

[ Upstream commit 165f2d2858013253042809df082b8df7e34e86d7 ]

Just as comment mentioned, the msa format:

 cr<30/31, 15> MSA register format:
 31 - 29 | 28 - 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
   BA     Reserved  SH  WA  B   SO SEC  C   D   V

So we should shift 29 bits not 28 bits for mask

Signed-off-by: Liu Yibin <jiulong@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/abiv1/inc/abi/entry.h | 4 ++--
 arch/csky/abiv2/inc/abi/entry.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/entry.h b/arch/csky/abiv1/inc/abi/entry.h
index 5056ebb902d1..61d94ec7dd16 100644
--- a/arch/csky/abiv1/inc/abi/entry.h
+++ b/arch/csky/abiv1/inc/abi/entry.h
@@ -167,8 +167,8 @@
 	 *   BA     Reserved  C   D   V
 	 */
 	cprcr	r6, cpcr30
-	lsri	r6, 28
-	lsli	r6, 28
+	lsri	r6, 29
+	lsli	r6, 29
 	addi	r6, 0xe
 	cpwcr	r6, cpcr30
 
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index 111973c6c713..9023828ede97 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -225,8 +225,8 @@
 	 */
 	mfcr	r6, cr<30, 15> /* Get MSA0 */
 2:
-	lsri	r6, 28
-	lsli	r6, 28
+	lsri	r6, 29
+	lsli	r6, 29
 	addi	r6, 0x1ce
 	mtcr	r6, cr<30, 15> /* Set MSA0 */
 
-- 
2.25.1

