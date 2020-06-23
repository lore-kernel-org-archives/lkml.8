Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F0CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182E02072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948197;
	bh=EHaTjvHX7cveCes1GIEDu70R+KTHtORbW9TF6z7OUOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mqq04Xy/KjRpdrRFdxuccDnk4FK3ePKyf6hmXUWl5X4ZXN5CFNcSjgHJQkhW1Ndmk
	 ZrYKhhP0RB7dF5+UHmVvIX8ja3RGnei+PzG/I6LQu0JS8IVztljZkfdwdpPQyOoN1n
	 Q6FA60DBhs3x25uR5Y7A7/BETnBx8FvxwH+djVJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393786AbgFWVga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388430AbgFWUJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:09:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E112082F;
        Tue, 23 Jun 2020 20:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942993;
        bh=EHaTjvHX7cveCes1GIEDu70R+KTHtORbW9TF6z7OUOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+TCQWet+c1W34ViTT7px70xk8HtsOKL1KXzvIuk1jD5twxzATZVh9kv2jBBFanxt
         idiwgWdGk4PwyVPc8RsnoBoE+E2I1C3rcyBlJOiEBUEcxhqW/SX8D+8ippoefqEl0J
         rG2/szkC4Ec2ITAv9wcv6ywWsBBIpYUsUPP50BxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 217/477] powerpc/pseries/ras: Fix FWNMI_VALID off by one
Date:   Tue, 23 Jun 2020 21:53:34 +0200
Message-Id: <20200623195417.843037898@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit deb70f7a35a22dffa55b2c3aac71bc6fb0f486ce ]

This was discovered developing qemu fwnmi sreset support. This
off-by-one bug means the last 16 bytes of the rtas area can not
be used for a 16 byte save area.

It's not a serious bug, and QEMU implementation has to retain a
workaround for old kernels, but it's good to tighten it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Link: https://lore.kernel.org/r/20200508043408.886394-7-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/ras.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 1d1da639b8b7e..16ba5c542e55c 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -395,10 +395,11 @@ static irqreturn_t ras_error_interrupt(int irq, void *dev_id)
 /*
  * Some versions of FWNMI place the buffer inside the 4kB page starting at
  * 0x7000. Other versions place it inside the rtas buffer. We check both.
+ * Minimum size of the buffer is 16 bytes.
  */
 #define VALID_FWNMI_BUFFER(A) \
-	((((A) >= 0x7000) && ((A) < 0x7ff0)) || \
-	(((A) >= rtas.base) && ((A) < (rtas.base + rtas.size - 16))))
+	((((A) >= 0x7000) && ((A) <= 0x8000 - 16)) || \
+	(((A) >= rtas.base) && ((A) <= (rtas.base + rtas.size - 16))))
 
 static inline struct rtas_error_log *fwnmi_get_errlog(void)
 {
-- 
2.25.1



