Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CFEC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F6621D81
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgIJTjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbgIJPmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:42:36 -0400
Received: from brightrain.aerifal.cx (unknown [IPv6:2002:d80c:560d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88731C0617A9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:06:21 -0700 (PDT)
Date:   Thu, 10 Sep 2020 10:19:36 -0400
From:   Rich Felker <dalias@libc.org>
To:     linux-sh@vger.kernel.org
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH] sh: remove spurious circular inclusion from asm/smp.h
Message-ID: <20200910141934.GF3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0cd39f4600ed4de8 added inclusion of smp.h to lockdep.h,
creating a circular include dependency where arch/sh's asm/smp.h in
turn includes spinlock.h which depends on lockdep.h. Since our
asm/smp.h does not actually need spinlock.h, just remove it.

Fixes: 0cd39f4600ed4de8 ("locking/seqlock, headers: Untangle the spaghetti monster")
Signed-off-by: Rich Felker <dalias@libc.org>
---
 arch/sh/include/asm/smp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/include/asm/smp.h b/arch/sh/include/asm/smp.h
index 1a0d7cf71c10..100bf241340b 100644
--- a/arch/sh/include/asm/smp.h
+++ b/arch/sh/include/asm/smp.h
@@ -8,7 +8,6 @@
 
 #ifdef CONFIG_SMP
 
-#include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <asm/current.h>
 #include <asm/percpu.h>
-- 
2.21.0

