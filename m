Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB6EC3F342
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FCE20801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812895;
	bh=7oJbFU+bhBED6CuMJZtavCeSHxcTQ/IBOQ85mSsX9oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vj4EFkf08H7OWh/A0RVsSY3KaTi0o5cirFVRGTmERQjl5dknzahrjB8k/I6D/e+WO
	 gV5bUq9H3Mk43AxkjI5oCuXFUfk99OXQgL4UfDuNSyWOBoYM6tK+Cv43uabwfpesch
	 fe2rM89Zu2pd66gKSh6Q0hRxiCg0/dZP2tFAsNgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbgB0OOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:14:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389189AbgB0OOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:14:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85BB320801;
        Thu, 27 Feb 2020 14:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812891;
        bh=7oJbFU+bhBED6CuMJZtavCeSHxcTQ/IBOQ85mSsX9oY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwNpz6nCXTSYEtZZaJdhxyegB/5rPPMjHXRcyobev7ZsC4xx7Fo8MnO48w15dnkyo
         fKSpGkAZkVn8erGFC/GVL2u4etZ/1egEJaGjquUYN7+QYJ8XQS91FcuKkUxI6RHDre
         Y+QNtceAe3L3w3+7hmCA7bbXyjL/M6VRg6xdvlRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.5 054/150] powerpc/entry: Fix an #if which should be an #ifdef in entry_32.S
Date:   Thu, 27 Feb 2020 14:36:31 +0100
Message-Id: <20200227132241.058255601@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 9eb425b2e04e0e3006adffea5bf5f227a896f128 upstream.

Fixes: 12c3f1fd87bf ("powerpc/32s: get rid of CPU_FTR_601 feature")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/a99fc0ad65b87a1ba51cfa3e0e9034ee294c3e07.1582034961.git.christophe.leroy@c-s.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/entry_32.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -778,7 +778,7 @@ fast_exception_return:
 1:	lis	r3,exc_exit_restart_end@ha
 	addi	r3,r3,exc_exit_restart_end@l
 	cmplw	r12,r3
-#if CONFIG_PPC_BOOK3S_601
+#ifdef CONFIG_PPC_BOOK3S_601
 	bge	2b
 #else
 	bge	3f
@@ -786,7 +786,7 @@ fast_exception_return:
 	lis	r4,exc_exit_restart@ha
 	addi	r4,r4,exc_exit_restart@l
 	cmplw	r12,r4
-#if CONFIG_PPC_BOOK3S_601
+#ifdef CONFIG_PPC_BOOK3S_601
 	blt	2b
 #else
 	blt	3f


