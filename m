Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19945C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7B32098B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945386;
	bh=vKgwmMDpAC/E00aTZFZh/dxHGGFK/leairZxCUsyfos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lge4Fhc77xTon+IlunvpOFJU2Z3GHCK+CoqpvNSaLqQQXZnlKGz1PFp9ypGliTwam
	 CCzir+t6aXs3P5R6QQi3kHFXs/77oGGBy22Ka8jciHqKqSw4XFlv5GjPYi7REiuWqK
	 3uMIFLa1JWUsTQsms6al337Zw6lLeDiOSZQCiE/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404181AbgFWUtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404172AbgFWUtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:49:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D6D21548;
        Tue, 23 Jun 2020 20:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945364;
        bh=vKgwmMDpAC/E00aTZFZh/dxHGGFK/leairZxCUsyfos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1KxMQQo1CsQCsf13XOvNoWpyHJ7KtQHNGLJ27lZMD+Kpg+nV5tzRGqQ6xakq8z++W
         JKnxWbm9SmETj6VI6vlOtblAPohZLVQS1DoRqMZALrjxB/lvS/2stiTHAOZ6R8wtOK
         V/Sllw8nE5cy8wtCOLTRS6Oozyi/sLGmkcUQvPQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 135/136] sched/rt, net: Use CONFIG_PREEMPTION.patch
Date:   Tue, 23 Jun 2020 21:59:51 +0200
Message-Id: <20200623195310.622612806@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 2da2b32fd9346009e9acdb68c570ca8d3966aba7 ]

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Update the comment to use CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: netdev@vger.kernel.org
Link: https://lore.kernel.org/r/20191015191821.11479-22-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ed552ad3f7834..9e4a00462f5c7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -901,7 +901,7 @@ EXPORT_SYMBOL(dev_get_by_napi_id);
  *
  *	The use of raw_seqcount_begin() and cond_resched() before
  *	retrying is required as we want to give the writers a chance
- *	to complete when CONFIG_PREEMPT is not set.
+ *	to complete when CONFIG_PREEMPTION is not set.
  */
 int netdev_get_name(struct net *net, char *name, int ifindex)
 {
-- 
2.25.1



