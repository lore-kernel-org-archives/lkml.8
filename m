Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DF0C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895BD208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340002;
	bh=n9OSzAOIsvEWYv3sAheV6vBFUKxRjlQxE4m3TbbWGOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NJd3NketePC9ueuTRKfTzohu/LGlnmlNwNFJOpsaw4KWGJE4h5s4ArfOdsE4jOJ0W
	 V2PUWAUgby6ENCOOBuKuLVVkayzR2UYAajeLgkgDRtMTOWb9P90q+ejHCx2c+S/F+j
	 X3b6E8lPZVRVBSZgdEw9KmiaETHcZZJgn/W33v80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgEANdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbgEANdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:33:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E50E216FD;
        Fri,  1 May 2020 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339996;
        bh=n9OSzAOIsvEWYv3sAheV6vBFUKxRjlQxE4m3TbbWGOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTP6Y1kIjgH5X7hAE2mdoJi8i0tuWFbvL4SxL7oGCFBYwk+xkj2L+1POeL/neH+N8
         j3n7MFngktfpy85lR64yKQQa97rLm84J0pVvVpxf4PNWcDAAgWnNgAkuTE+n06K5wy
         0dUMRSxLM0Q4WeCPx5RAxZLbuWtcBC/1D5IHRdGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Kelly <martin@martingkelly.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 052/117] tools/vm: fix cross-compile build
Date:   Fri,  1 May 2020 15:21:28 +0200
Message-Id: <20200501131550.957971934@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

commit cf01699ee220c38099eb3e43ce3d10690c8b7060 upstream.

Commit 7ed1c1901fe5 ("tools: fix cross-compile var clobbering") moved
the setup of the CC variable to tools/scripts/Makefile.include to make
the behavior consistent across all the tools Makefiles.

As the vm tools missed the include we end up with the wrong CC in a
cross-compiling evironment.

Fixes: 7ed1c1901fe5 (tools: fix cross-compile var clobbering)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Kelly <martin@martingkelly.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200416104748.25243-1-l.stach@pengutronix.de
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/vm/Makefile |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/vm/Makefile
+++ b/tools/vm/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm tools
 #
+include ../scripts/Makefile.include
+
 TARGETS=page-types slabinfo page_owner_sort
 
 LIB_DIR = ../lib/api


