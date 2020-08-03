Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCAEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E0C2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457753;
	bh=gXEwiYtWJrb+EFFUrwnNNz7Jzhi9gU+IQFe3eDUXoAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v/QOgkfrsXhPyTiCy19+rGsGpxs8al8wPi7rRzd43RvEPzeUa0wvDsW33VKzrrh05
	 0YTT7nxxFO5BU2vl4BFmzV3aladPokuvPFUNK4KN3rNHNAx7IMnG71zTttf+X6tYyl
	 0DL3/MmgsYhQtZoTqJSwxWJ3i2qhvGqlQL1OAtg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgHCM3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgHCM3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:29:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA67207DF;
        Mon,  3 Aug 2020 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457747;
        bh=gXEwiYtWJrb+EFFUrwnNNz7Jzhi9gU+IQFe3eDUXoAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiiUbCL1imQVsSC/SzNB9eg751kkwDCt5CsV9n1jHKYitThiknB/TI7RZ/igQhewp
         6S8nXxfHlphLPVZ235/vCJrEfZQHOt+u8Y0lzQ0gi1s3Cnz7cey/z53Gs2VlROcYEK
         PXvywnlExP5Gyfm6HTyS5Di5IuYv6NnvBaUVM/zk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 29/90] random: fix circular include dependency on arm64 after addition of percpu.h
Date:   Mon,  3 Aug 2020 14:18:51 +0200
Message-Id: <20200803121859.033423367@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

commit 1c9df907da83812e4f33b59d3d142c864d9da57f upstream.

Daniel Díaz and Kees Cook independently reported that commit
f227e3ec3b5c ("random32: update the net random state on interrupt and
activity") broke arm64 due to a circular dependency on include files
since the addition of percpu.h in random.h.

The correct fix would definitely be to move all the prandom32 stuff out
of random.h but for backporting, a smaller solution is preferred.

This one replaces linux/percpu.h with asm/percpu.h, and this fixes the
problem on x86_64, arm64, arm, and mips.  Note that moving percpu.h
around didn't change anything and that removing it entirely broke
differently.  When backporting, such options might still be considered
if this patch fails to help.

[ It turns out that an alternate fix seems to be to just remove the
  troublesome <asm/pointer_auth.h> remove from the arm64 <asm/smp.h>
  that causes the circular dependency.

  But we might as well do the whole belt-and-suspenders thing, and
  minimize inclusion in <linux/random.h> too. Either will fix the
  problem, and both are good changes.   - Linus ]

Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
Reported-by: Kees Cook <keescook@chromium.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Fixes: f227e3ec3b5c
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/random.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -9,7 +9,7 @@
 
 #include <linux/list.h>
 #include <linux/once.h>
-#include <linux/percpu.h>
+#include <asm/percpu.h>
 
 #include <uapi/linux/random.h>
 


