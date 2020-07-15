Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAA6C433EB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B2020578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="p31QfGJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbgGOMs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:48:59 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60234 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbgGOMsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:48:55 -0400
Received: from Q.local (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B4630564;
        Wed, 15 Jul 2020 14:48:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594817334;
        bh=JAoja8y90Xy1LA7xMhyZO7bkk+OVjLIs4Sokc2AZVl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p31QfGJiiHK3OXiQ9t9Ho+Ehnjj//bbFf/LBRwbXZXkykpyJ/aOirn7qRan2/3HUb
         EBt63jNmXPYlkFFf8fBS6VL7ZLzIWqYYZU1Mz44q6gTRoTXN0T/r300BCQi/a8KOkc
         o1KIOmP5YQGLf6/zY6U1T+zQBvInnJBA1cNwXRGI=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     trivial@kernel.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jason Baron <jbaron@akamai.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/8] include: dynamic_debug.h: Fix trivial spelling
Date:   Wed, 15 Jul 2020 13:48:36 +0100
Message-Id: <20200715124839.252822-6-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
References: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word 'descriptor' is misspelled throughout the tree.

Fix it up accordingly:
    decriptor -> descriptor

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
v2:
 - Fix commit message to reflect actual word replaced
---
 include/linux/dynamic_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index abcd5fde30eb..a06ef7380b2d 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -133,7 +133,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 /*
  * "Factory macro" for generating a call to func, guarded by a
- * DYNAMIC_DEBUG_BRANCH. The dynamic debug decriptor will be
+ * DYNAMIC_DEBUG_BRANCH. The dynamic debug descriptor will be
  * initialized using the fmt argument. The function will be called with
  * the address of the descriptor as first argument, followed by all
  * the varargs. Note that fmt is repeated in invocations of this
-- 
2.25.1

