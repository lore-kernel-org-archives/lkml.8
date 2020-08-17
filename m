Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86410C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52160205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597682406;
	bh=E6OS2FT95VtV0/IV0WeRwCdybz7w+OojF51B7w+0eog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zJbG5vHUgbwKi7ru36u4Sr+YRrB/ov0PZ6nqybsL/tfmQPrjwCyGF1maWQZoZT5Vo
	 B6L+4I709cb4gYlL8RStCD5N6QVcvIr5tK3VklL9tJRb0XDaoHT2i+74uYZfWTBRL5
	 JiNffOI8QaoV5swOS77reqoVOrEYNrS9t8zxwpgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbgHQQkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388113AbgHQP6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:58:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0EF207FF;
        Mon, 17 Aug 2020 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679891;
        bh=E6OS2FT95VtV0/IV0WeRwCdybz7w+OojF51B7w+0eog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0ZWXYyG0aCK1XTw+b5BiUOmEpzwaGWTEFvyJMCOh+ff5GQSFrL+8VnNe8ICL/+NM
         8NcQcBAdU0Ly+UgFYzgU1VHE3nX9/NfthsQmChh4kmqmxXFVN+7Kp8VVEMId/PLr32
         4hY4NmnLfu6JU92NLXTZF/8+lP/fUh15k8OPH/Hw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 5.7 370/393] Revert "parisc: Drop LDCW barrier in CAS code when running UP"
Date:   Mon, 17 Aug 2020 17:17:00 +0200
Message-Id: <20200817143837.553240967@linuxfoundation.org>
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

From: Helge Deller <deller@gmx.de>

commit 462fb756c7de1ffe5bc6099149136031c2d9c02a upstream.

This reverts commit e6eb5fe9123f05dcbf339ae5c0b6d32fcc0685d5.
We need to optimize it differently. A follow up patch will correct it.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v5.2+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/syscall.S |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -641,8 +641,7 @@ cas_action:
 2:	stw	%r24, 0(%r26)
 	/* Free lock */
 #ifdef CONFIG_SMP
-98:	LDCW	0(%sr2,%r20), %r1			/* Barrier */
-99:	ALTERNATIVE(98b, 99b, ALT_COND_NO_SMP, INSN_NOP)
+	LDCW	0(%sr2,%r20), %r1			/* Barrier */
 #endif
 	stw	%r20, 0(%sr2,%r20)
 #if ENABLE_LWS_DEBUG
@@ -659,8 +658,7 @@ cas_action:
 	/* Error occurred on load or store */
 	/* Free lock */
 #ifdef CONFIG_SMP
-98:	LDCW	0(%sr2,%r20), %r1			/* Barrier */
-99:	ALTERNATIVE(98b, 99b, ALT_COND_NO_SMP, INSN_NOP)
+	LDCW	0(%sr2,%r20), %r1			/* Barrier */
 #endif
 	stw	%r20, 0(%sr2,%r20)
 #if ENABLE_LWS_DEBUG
@@ -864,8 +862,7 @@ cas2_action:
 cas2_end:
 	/* Free lock */
 #ifdef CONFIG_SMP
-98:	LDCW	0(%sr2,%r20), %r1			/* Barrier */
-99:	ALTERNATIVE(98b, 99b, ALT_COND_NO_SMP, INSN_NOP)
+	LDCW	0(%sr2,%r20), %r1			/* Barrier */
 #endif
 	stw	%r20, 0(%sr2,%r20)
 	/* Enable interrupts */
@@ -878,8 +875,7 @@ cas2_end:
 	/* Error occurred on load or store */
 	/* Free lock */
 #ifdef CONFIG_SMP
-98:	LDCW	0(%sr2,%r20), %r1			/* Barrier */
-99:	ALTERNATIVE(98b, 99b, ALT_COND_NO_SMP, INSN_NOP)
+	LDCW	0(%sr2,%r20), %r1			/* Barrier */
 #endif
 	stw	%r20, 0(%sr2,%r20)
 	ssm	PSW_SM_I, %r0


