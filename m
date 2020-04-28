Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F9BC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB8A20575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099643;
	bh=n9OSzAOIsvEWYv3sAheV6vBFUKxRjlQxE4m3TbbWGOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IpKJoGnEA8y9hN6Fw1BdYPXAnMrp7SLU7m5C+9gj7fWUv/OVL3lPbyv1+M1Rbb/yQ
	 HbqioDspT3UMIUlDEsbDk5pDFwz4AxSMcjjDQFFRieIt+Glm4FKp7L6DFPGpv4SPCB
	 1hqQlZ/krP8sC7INlAKdAaqXpMLKxi5sb1sz+LWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgD1SrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731063AbgD1SmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:42:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C26320575;
        Tue, 28 Apr 2020 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099329;
        bh=n9OSzAOIsvEWYv3sAheV6vBFUKxRjlQxE4m3TbbWGOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UoU/YrjRC4i3oAuHYZJphY8MoVkeKHlZ4cGqYay79iLzU7BYOuUAgvru3IrGH3AbY
         yoy+SCK2anPNkgoHODu2AbBUn+/3tI6c0zaO0rWJhQ8BN6i1t48AMk1SH+kuN8C9v8
         yqg5cmlwmgcKxONxOpiHlcaVKB280hDEDt0Pw6RI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Kelly <martin@martingkelly.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 107/168] tools/vm: fix cross-compile build
Date:   Tue, 28 Apr 2020 20:24:41 +0200
Message-Id: <20200428182245.977504170@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
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


