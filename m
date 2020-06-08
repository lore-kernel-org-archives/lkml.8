Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD05C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 411402078D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658134;
	bh=CwE1cZJHVaxT5PiruDHHWkhSXCAJv5i2dJ9hewlQBwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QuM4RdrpTVUtxItX7yvl+1BYGwl2ZoQdvHozDG8o6up1UxBgOhaxBp/dp6hsZzi6s
	 QFUUMQcAYtxRYAxJYQcqnsuuW6Dlv78iQKRpSV8Qlk1erzd1ZaszeTrMPrjk9p/8uF
	 YXQ4knmUtKiWkm91pK6exQgtOECdmBxkX7kLZTZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbgFHXPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgFHXM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:12:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05D4214F1;
        Mon,  8 Jun 2020 23:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657976;
        bh=CwE1cZJHVaxT5PiruDHHWkhSXCAJv5i2dJ9hewlQBwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPxpIre9sRhBPyiA1Ugq/kmZuvrfxPNG1JqZof9zh+ShQMZWYpV+L4NfhdKSaePwq
         d5k+xB/llBLCVLVjUlPO1qYfslca8hie+Pm07nvlKXpS6pM+MFVXDXMvCxUhXKP7tL
         5mgb8IwcqXFxXEjasSCv3Hkaafys/JG1bWJkTM+s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.6 038/606] powerpc/vdso32: Fallback on getres syscall when clock is unknown
Date:   Mon,  8 Jun 2020 19:02:43 -0400
Message-Id: <20200608231211.3363633-38-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

commit e963b7a28b2bf2416304e1a15df967fcf662aff5 upstream.

There are other clocks than the standard ones, for instance
per process clocks. Therefore, being above the last standard clock
doesn't mean it is a bad clock. So, fallback to syscall instead
of returning -EINVAL inconditionaly.

Fixes: e33ffc956b08 ("powerpc/vdso32: implement clock_getres entirely")
Cc: stable@vger.kernel.org # v5.6+
Reported-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Link: https://lore.kernel.org/r/7316a9e2c0c2517923eb4b0411c4a08d15e675a4.1589017281.git.christophe.leroy@csgroup.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/vdso32/gettimeofday.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index a3951567118a..e7f8f9f1b3f4 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -218,11 +218,11 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	blr
 
 	/*
-	 * invalid clock
+	 * syscall fallback
 	 */
 99:
-	li	r3, EINVAL
-	crset	so
+	li	r0,__NR_clock_getres
+	sc
 	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_clock_getres)
-- 
2.25.1

