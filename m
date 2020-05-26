Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F8CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F4E2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520807;
	bh=tp/HQEMAxy6eE4ZBdZZxf6X4ju8GZ6SIyB/TvQ0Vugc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VEK25p+/HBacQYTUEVcu8Xx2/YdHEcdjwnK4U3q9CoUYaZReB0JARpKtfX/keRTUE
	 gRWoaJcB4v9q6//ezrVhXEOMPjDCfv4MisWv+RBcBVDOc4k8SD5KGtmQ4arxqld/IH
	 7H+O2lpbQx9vIyXPb3rcTeOSI3xgeXHu0mwEY2rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404457AbgEZTUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404153AbgEZTMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:12:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 271B2208B3;
        Tue, 26 May 2020 19:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520374;
        bh=tp/HQEMAxy6eE4ZBdZZxf6X4ju8GZ6SIyB/TvQ0Vugc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyJh5N8ynZxx+fTQuZk+ukl4O1Et5ybjy8cW1faw+W1f7rByVLOfEI4NB/Fmzbs+3
         W603qRJ6WBRIbXyXbL1LSx2ZBFfUXjpL2jcTRVVDN/UjWoMvl/Bq/+pWz0h0cRMbJK
         4Wn8cUxrJhVyIMFzWo0/M5iTOLL/JppQy2EBrOuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 053/126] ARM: futex: Address build warning
Date:   Tue, 26 May 2020 20:53:10 +0200
Message-Id: <20200526183942.515211467@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 8101b5a1531f3390b3a69fa7934c70a8fd6566ad ]

Stephen reported the following build warning on a ARM multi_v7_defconfig
build with GCC 9.2.1:

kernel/futex.c: In function 'do_futex':
kernel/futex.c:1676:17: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]
 1676 |   return oldval == cmparg;
      |          ~~~~~~~^~~~~~~~~
kernel/futex.c:1652:6: note: 'oldval' was declared here
 1652 |  int oldval, ret;
      |      ^~~~~~

introduced by commit a08971e9488d ("futex: arch_futex_atomic_op_inuser()
calling conventions change").

While that change should not make any difference it confuses GCC which
fails to work out that oldval is not referenced when the return value is
not zero.

GCC fails to properly analyze arch_futex_atomic_op_inuser(). It's not the
early return, the issue is with the assembly macros. GCC fails to detect
that those either set 'ret' to 0 and set oldval or set 'ret' to -EFAULT
which makes oldval uninteresting. The store to the callsite supplied oldval
pointer is conditional on ret == 0.

The straight forward way to solve this is to make the store unconditional.

Aside of addressing the build warning this makes sense anyway because it
removes the conditional from the fastpath. In the error case the stored
value is uninteresting and the extra store does not matter at all.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/87pncao2ph.fsf@nanos.tec.linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/futex.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 83c391b597d4..fdc4ae3e7378 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -164,8 +164,13 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 	preempt_enable();
 #endif
 
-	if (!ret)
-		*oval = oldval;
+	/*
+	 * Store unconditionally. If ret != 0 the extra store is the least
+	 * of the worries but GCC cannot figure out that __futex_atomic_op()
+	 * is either setting ret to -EFAULT or storing the old value in
+	 * oldval which results in a uninitialized warning at the call site.
+	 */
+	*oval = oldval;
 
 	return ret;
 }
-- 
2.25.1



