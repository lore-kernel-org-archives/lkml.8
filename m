Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA00C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52ED920657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597682503;
	bh=7gyPJKW97AuJsGRcf2153Bp6vcw0jR86aMwsAmCpXpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x4ExxcbWdBrwIW4Cea8spsNKLO5Uko9Esl+vDWPB2N2CmFrjBhwSn5Ssn8h9rEJsm
	 D7+ut3WRLpk6cccKVZ+p5ktTZwQ6Z0gEzEqwPrzSRLPJp50Of3dKHiNDmSijP0UY+y
	 JdVUbgnxEjXJV0vhUTHi+C2bxo15D9nOQOP5w1nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbgHQQlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387809AbgHQP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:58:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 525A820885;
        Mon, 17 Aug 2020 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679902;
        bh=7gyPJKW97AuJsGRcf2153Bp6vcw0jR86aMwsAmCpXpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjJuLSB85s9vM+8gfCnGmRqHB8tfWNoZIDJcQ9nz1Xf9Aky6kTjvvMsWeFRWM6lDS
         o/ADQBrtFk8BzouJ3YbdRLptL2J4CBP5oY0G5AneYNEEdlTw4I843US+E23zTnu837
         lKNUYYmlTapalqZEDNvRQmqPHJBXom/CsqdPpCLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.7 373/393] parisc: Do not use an ordered store in pa_tlb_lock()
Date:   Mon, 17 Aug 2020 17:17:03 +0200
Message-Id: <20200817143837.701651611@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John David Anglin <dave.anglin@bell.net>

commit e72b23dec1da5e62a0090c5da1d926778284e230 upstream.

No need to use an ordered store in pa_tlb_lock() and update the comment
regarng usage of the sid register to unlocak a spinlock in
tlb_unlock0().

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v5.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/entry.S |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -455,7 +455,7 @@
 	LDREG		0(\ptp),\pte
 	bb,<,n		\pte,_PAGE_PRESENT_BIT,3f
 	b		\fault
-	stw,ma		\spc,0(\tmp)
+	stw		\spc,0(\tmp)
 99:	ALTERNATIVE(98b, 99b, ALT_COND_NO_SMP, INSN_NOP)
 #endif
 2:	LDREG		0(\ptp),\pte
@@ -463,7 +463,12 @@
 3:
 	.endm
 
-	/* Release pa_tlb_lock lock without reloading lock address. */
+	/* Release pa_tlb_lock lock without reloading lock address.
+	   Note that the values in the register spc are limited to
+	   NR_SPACE_IDS (262144). Thus, the stw instruction always
+	   stores a nonzero value even when register spc is 64 bits.
+	   We use an ordered store to ensure all prior accesses are
+	   performed prior to releasing the lock. */
 	.macro		tlb_unlock0	spc,tmp
 #ifdef CONFIG_SMP
 98:	or,COND(=)	%r0,\spc,%r0


