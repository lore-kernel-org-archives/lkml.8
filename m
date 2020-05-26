Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8F4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0F32086A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519665;
	bh=o6xEWP3l3NxJIyh56Zls/j+EDwwS16Hn5+vt1XvPQsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iVPOEzBrU8L5no+nh263NzbpGs/LXofDjrXuu4KX2UPi40KHTPPLEClKy9tt5a146
	 M5YllEmJpzeH4GTiYFFwTXtBbMHJDunCwm8ncLh0JpLnBsijANGwP2e0rlPS9D3f4T
	 btkAAOuwcyt89wzFnwFXV/wL33o0IIH7wqpL9U5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390852AbgEZTBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389748AbgEZTA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:00:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1386208C3;
        Tue, 26 May 2020 19:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519659;
        bh=o6xEWP3l3NxJIyh56Zls/j+EDwwS16Hn5+vt1XvPQsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJ5zDCDsaXZVKWh10z1VyXJ/8SkONRX9E6zfFwJcTKA4jdXqOgusrSPoqZY2Tct36
         8WMgWk5Rb4sPKW11zUUiRD+ISF2WTqaP3a92Sq1qC9CyvPksVe1xcAXX00jQC78HO+
         4D0DF7wTLtyX5xUD2Lbl2wt5LceX5obcGJuA+cEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 25/59] ARM: futex: Address build warning
Date:   Tue, 26 May 2020 20:53:10 +0200
Message-Id: <20200526183916.587025373@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183907.123822792@linuxfoundation.org>
References: <20200526183907.123822792@linuxfoundation.org>
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
index ffebe7b7a5b7..91ca80035fc4 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -163,8 +163,13 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
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



