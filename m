Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFD4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F34D208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825175;
	bh=FgZLxAPgb7DLaY9FCyci9lQV4m8kCQb9DxJA1gfHYXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A5pLFz4stEY58Eku96tp1e2FMy4ZxECORaw/lZo9pz5LrYhfkq7P01BlN8naSMcmQ
	 vGMxB1mvPjM+tiOF5AT9Ddh5dXMX1xlXGINVw73ULa7pZwJq7tAnwYAxGk32JWvHP8
	 QOad3fhtwzwjxUQ/jI8hKru5W+5K9/4mK7yWVDaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbgERSGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733104AbgERSGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:06:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5CEA20671;
        Mon, 18 May 2020 18:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825165;
        bh=FgZLxAPgb7DLaY9FCyci9lQV4m8kCQb9DxJA1gfHYXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqcBcTHO2+E+bHJEDvYMipN+bI7QsGu8B18jqlkWoPR5o2MGRtw2plGy2mIr7evU3
         1OWkpND9DExi/v8L9K9qHghWqGDFcJZ4yWRugxWpuqo8x5KeNp//+HN8gPs4rmy/pg
         LQIvRiBhXkYkalhTvmrBHqwR2YA4aOyliBeiFXBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.6 154/194] powerpc/vdso32: Fallback on getres syscall when clock is unknown
Date:   Mon, 18 May 2020 19:37:24 +0200
Message-Id: <20200518173544.061842259@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 arch/powerpc/kernel/vdso32/gettimeofday.S |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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


