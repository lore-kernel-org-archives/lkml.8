Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E854DC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C692420714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sMLnPHb/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/qQyPiGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgH3SEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 14:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgH3SEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 14:04:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9145AC061236
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:04:04 -0700 (PDT)
Date:   Sun, 30 Aug 2020 18:03:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598810643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gPttVNtzoCyDCVOKj+4BwyVG+XD1YEYj5GLmqf4eOS0=;
        b=sMLnPHb/FqGUSEznTM3iCu5EEkmNAAwyfGHO53Z94A8BV3BPPJIn/ASDZNQPiOWTFbWwxF
        4MA0BRMSVAYlTz0jPw0Aw3KltM2T1k/oqhJaNpa2C52qdxMsfltC13xjSH0Aj2GIJ4p2zE
        ROXMVxgnFsjrSNvF6Cv9t3O2SJfytto0tYlr67ngwCaZADJKaPF3KRVvWdLAfyKkax4Ge8
        WUDNk2zP4WnY8E/WdUDAUrgo/qnpXLZTAjMZV3O7u0pz/xo97uDj/HP6rFFZXzPxZ5+dLD
        7pttOz2HVBBo4P9M9GG7qAz5EXBbwhlA1I2xBfQEiPel6e8WVXROb3wPGzidIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598810643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gPttVNtzoCyDCVOKj+4BwyVG+XD1YEYj5GLmqf4eOS0=;
        b=/qQyPiGIZQMQlFs1mrSXkrzVwJaTkUavo+fgnzR4Hro/6XlR+BpVLu0yz7miE4puIfmc2D
        tLd8XmyXT3D2WuDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v5.9-rc2
References: <159881061564.27993.11909051048930389391.tglx@nanos>
Message-ID: <159881061804.27993.16119786735164087221.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-08-30

up to:  c94a88f341c9: sched: Use __always_inline on is_idle_task()


A single fix for the scheduler:

 - Make is_idle_task() __always_inline to prevent the compiler from putting
   it out of line into the wrong section because it's used inside noinstr
   sections.

Thanks,

	tglx

------------------>
Marco Elver (1):
      sched: Use __always_inline on is_idle_task()


 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 93ecd930efd3..afe01e232935 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1666,7 +1666,7 @@ extern struct task_struct *idle_task(int cpu);
  *
  * Return: 1 if @p is an idle task. 0 otherwise.
  */
-static inline bool is_idle_task(const struct task_struct *p)
+static __always_inline bool is_idle_task(const struct task_struct *p)
 {
 	return !!(p->flags & PF_IDLE);
 }

