Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895E8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B91D206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrKSrN17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgGZSyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGZSyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:54:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78A5C0619D2;
        Sun, 26 Jul 2020 11:54:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so12735049wrh.10;
        Sun, 26 Jul 2020 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2TyrflKIYXBAkn9RBsvAVl/I+HwT1fUS4cp+668mHCA=;
        b=PrKSrN17IeWv+u7BNRGh7JhEzkecuPsxdxf/3Ct39tyQZiWgRVI94cU0jmNeCrJ8Dp
         Dv0VEKl8jhtlBx5OwX5c9g11s/7Ud6bpLYdM8A8/V48o+fltvLCWESzowyuS+jtVzehv
         IgQBPt4JLVNOf3hmckv+3daFcaOO41DGWD+bTqXiDbVzUOsQdDSJUeGek+x1FZEqQZ8x
         SIoaOL0zNvnZpR2hOWUd+eEa/y4OBTTbR6lz5JSwH9HCWY2h5jKnKg0/A7lSN3YtN6ZN
         UeCVRA9ab5Y96AJi4l2Fu5NAOFjo/PR7+8LzBaoVAqWoE/4aYzfv9H/DEm1/f2rUAzyP
         C6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2TyrflKIYXBAkn9RBsvAVl/I+HwT1fUS4cp+668mHCA=;
        b=mIpQUFPAudXlB3DnnRmDB7dQ5gfv19xTTctsx1AVhUKn0aiCSxxRgVQBBVbaMZny2v
         DkoxSkQ2k8+CpxjF0+R2ORMzJnSMGGbqgyCI5sb8InV3JfbYTZjYa+MLDGIRyDTWhFjr
         irnbYxVfoVDHYrKgFjtoyY3oikv0m4w1o328ODrxJw0SNo/2Dey1KUN0XTCjOJieCR6q
         8x9tcADdcY1BKAuiImvFN1t3aN+7bsm9klB7fSE0MAtromEZDUkR/whXdTSGzrPwcx8o
         n24UR/vdtZbTZ0dYd1a6fSbLdPQLdeWVbAl4niaGpo/4C49EacvSyszdNOkxPpfuIaPt
         HUOA==
X-Gm-Message-State: AOAM533cOb1arOp1VGWr4OmuqXEs9xrT47hS40cV41BVyALqyGy1giOM
        yarLPVsCcrd7xZZesdYq7hzgvc8NPB5oE8EXzgbOjq0PErM=
X-Google-Smtp-Source: ABdhPJySNULn/mzH9BagWSKsF3ZRWLijIibSdbYpF6FQm77N6iFAQbYif4O49k6dX47stbcpF60vPve11YpXZTZuS30=
X-Received: by 2002:adf:e84d:: with SMTP id d13mr1990522wrn.126.1595789691514;
 Sun, 26 Jul 2020 11:54:51 -0700 (PDT)
MIME-Version: 1.0
From:   Marta Rybczynska <rybczynska@gmail.com>
Date:   Sun, 26 Jul 2020 20:54:40 +0200
Message-ID: <CAApg2=SKxQ3Sqwj6TZnV-0x0cKLXFKDaPvXT4N15MPDMKq724g@mail.gmail.com>
Subject: [PATCH] Documentation/locking/locktypes: fix local_locks documentation
To:     peterz@infradead.org, will@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix issues with local_locks documentation:
- fix function names, local_lock.h has local_unlock_irqrestore(),
not local_lock_irqrestore()
- fix mapping table, local_unlock_irqrestore() maps to local_irq_restore(),
not _save()

Signed-off-by: Marta Rybczynska <rybczynska@gmail.com>
---
 Documentation/locking/locktypes.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/locking/locktypes.rst
b/Documentation/locking/locktypes.rst
index 1b577a8bf982..2a9c38bfdf16 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -164,14 +164,14 @@ by disabling preemption or interrupts.
 On non-PREEMPT_RT kernels local_lock operations map to the preemption and
 interrupt disabling and enabling primitives:

- =========================== ======================
- local_lock(&llock)          preempt_disable()
- local_unlock(&llock)        preempt_enable()
- local_lock_irq(&llock)      local_irq_disable()
- local_unlock_irq(&llock)    local_irq_enable()
- local_lock_save(&llock)     local_irq_save()
- local_lock_restore(&llock)  local_irq_save()
- =========================== ======================
+ ===============================  ======================
+ local_lock(&llock)               preempt_disable()
+ local_unlock(&llock)             preempt_enable()
+ local_lock_irq(&llock)           local_irq_disable()
+ local_unlock_irq(&llock)         local_irq_enable()
+ local_lock_irqsave(&llock)       local_irq_save()
+ local_unlock_irqrestore(&llock)  local_irq_restore()
+ ===============================  ======================

 The named scope of local_lock has two advantages over the regular
 primitives:
@@ -353,14 +353,14 @@ protection scope. So the following substitution is wrong::
   {
     local_irq_save(flags);    -> local_lock_irqsave(&local_lock_1, flags);
     func3();
-    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock_1, flags);
+    local_irq_restore(flags); -> local_unlock_irqrestore(&local_lock_1, flags);
   }

   func2()
   {
     local_irq_save(flags);    -> local_lock_irqsave(&local_lock_2, flags);
     func3();
-    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock_2, flags);
+    local_irq_restore(flags); -> local_unlock_irqrestore(&local_lock_2, flags);
   }

   func3()
@@ -379,14 +379,14 @@ PREEMPT_RT-specific semantics of spinlock_t. The
correct substitution is::
   {
     local_irq_save(flags);    -> local_lock_irqsave(&local_lock, flags);
     func3();
-    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock, flags);
+    local_irq_restore(flags); -> local_unlock_irqrestore(&local_lock, flags);
   }

   func2()
   {
     local_irq_save(flags);    -> local_lock_irqsave(&local_lock, flags);
     func3();
-    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock, flags);
+    local_irq_restore(flags); -> local_unlock_irqrestore(&local_lock, flags);
   }

   func3()
-- 
2.27.0
