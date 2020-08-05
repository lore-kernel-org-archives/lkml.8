Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0C6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D42E22B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596658014;
	bh=yFYTa998NKrtDfXdDzp1QLN7+n8qgvxQI8H6upuXPM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uDbNTT1GUgAOCGXfi/7qM8C/F13POeEskGiynlVUjgSULeIsbyes+06sv77HDHMth
	 jkyPLarkp086PrgiJlat3NMPMQPqY4x2MfZ9Vh+HUBu4T0Ph+vsKXpULz/iuoB9vzW
	 MipHL1OHUEA4kBYbV4Bjxr4X+nOHm1W/vfHbmlqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHEUGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgHEQeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:34:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A7B233FA;
        Wed,  5 Aug 2020 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596642827;
        bh=yFYTa998NKrtDfXdDzp1QLN7+n8qgvxQI8H6upuXPM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2CAA+zLs41rHPezyGRZksu6+YhrO0485Rcl6azROb/J4aLyHFqROJyFENqOPgnh2
         SNPJiK4nvOeqzCXVd1QLtZRN8s4RrWQ9lcCoYmf97ky9Q6n8ETo25yLewbQIRNZg+d
         xWc1h0MPStsqfvMMlOKf/CO9tv5aH7p9Naeft+Js=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.14 8/8] ARM: 8702/1: head-common.S: Clear lr before jumping to start_kernel()
Date:   Wed,  5 Aug 2020 17:53:34 +0200
Message-Id: <20200805153507.382671788@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200805153507.005753845@linuxfoundation.org>
References: <20200805153507.005753845@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit 59b6359dd92d18f5dc04b14a4c926fa08ab66f7c upstream.

If CONFIG_DEBUG_LOCK_ALLOC=y, the kernel log is spammed with a few
hundred identical messages:

    unwind: Unknown symbol address c0800300
    unwind: Index not found c0800300

c0800300 is the return address from the last subroutine call (to
__memzero()) in __mmap_switched().  Apparently having this address in
the link register confuses the unwinder.

To fix this, reset the link register to zero before jumping to
start_kernel().

Fixes: 9520b1a1b5f7a348 ("ARM: head-common.S: speed up startup code")
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

---
 arch/arm/kernel/head-common.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -101,6 +101,7 @@ __mmap_switched:
 	str	r2, [r6]			@ Save atags pointer
 	cmp	r7, #0
 	strne	r0, [r7]			@ Save control register values
+	mov	lr, #0
 	b	start_kernel
 ENDPROC(__mmap_switched)
 


