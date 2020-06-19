Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06431C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CACF521924
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580118;
	bh=GjH5L22u8zmqFxwcOGD/ISwdqSLtKKlx0fQxJYOfG3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dx2B41h4K4DWMZnqr96NllXhyQyvOVDeTcnqwU3/Y9EpsiYbLnT+CYASla4Psuu2w
	 ZMx1W93994NsYwZAuxT/Xnj/Ulh9usNEiU+YNZKKtshcGmJ7GndlEl94ILLrv/LXrt
	 Mth5BaKcQxVG0r7uEMzlJNzTrrMH7+9aILKYWdaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392931AbgFSPV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392419AbgFSPPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:15:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 701E2206DB;
        Fri, 19 Jun 2020 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579754;
        bh=GjH5L22u8zmqFxwcOGD/ISwdqSLtKKlx0fQxJYOfG3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1bGpfqciStZR1Rl1b8r1mfx2qeFXl7XtdKZxRghFbti9v3oAf7raImtL/6mhf3nOo
         +H+8znLf9ZcLEgS4Z8wjHH3xW/DihjaoAjAtqv+gZpL+dPalk1XJiH+fJ0zZK+HVRy
         1McxaQGqc0SKpYaqsbV02QNwUnivX+G0ABuAySW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 223/261] powerpc/fadump: Account for memory_limit while reserving memory
Date:   Fri, 19 Jun 2020 16:33:54 +0200
Message-Id: <20200619141700.556508567@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hari Bathini <hbathini@linux.ibm.com>

commit 9a2921e5baca1d25eb8d21f21d1e90581a6d0f68 upstream.

If the memory chunk found for reserving memory overshoots the memory
limit imposed, do not proceed with reserving memory. Default behavior
was this until commit 140777a3d8df ("powerpc/fadump: consider reserved
ranges while reserving memory") changed it unwittingly.

Fixes: 140777a3d8df ("powerpc/fadump: consider reserved ranges while reserving memory")
Cc: stable@vger.kernel.org
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/159057266320.22331.6571453892066907320.stgit@hbathini.in.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/fadump.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -601,7 +601,7 @@ int __init fadump_reserve_mem(void)
 		 */
 		base = fadump_locate_reserve_mem(base, size);
 
-		if (!base) {
+		if (!base || (base + size > mem_boundary)) {
 			pr_err("Failed to find memory chunk for reservation!\n");
 			goto error_out;
 		}


