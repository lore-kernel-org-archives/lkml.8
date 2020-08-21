Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE80DC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914D222BEA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598030921;
	bh=oTjC9jfaLqaZgNMzxkpn5Xgk4LZV2PW+EeOGjegi/zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j1G6xAYugox3yWPLMfDp/Y9nLtjlkn1QOz//oZQm1Ygnt1oODAj4VrsCnHL5dVHe3
	 CThtqOser2bta5+W5Hddtt1iSyNVTbNBTrBkDrAb/dMV+p8yXRwHASX+X9vwF4zXMz
	 FBwONgD64hlmYkLbXz/Z+TQ4p72dZ9C1/PpBJ3TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgHUR2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgHUQOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:14:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD2CF22BED;
        Fri, 21 Aug 2020 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026481;
        bh=oTjC9jfaLqaZgNMzxkpn5Xgk4LZV2PW+EeOGjegi/zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2RIaFJ1sLf2LhZGIIxhVAZE43Oo+KLH/eXBni4hxHTs4TEPJ5xS78wEd1EiAT5vZT
         kZYNaLu4yZW2BhqiisiD6qXrJ2Fs7zQUpujmBoFwQkZvOvB0nHdadbrjWqZm229rV+
         suar4PQUpuocamw5ATaSA9TmG5F8IeOpyK4OfJug=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.8 14/62] gcc-plugins/stackleak: Don't instrument itself
Date:   Fri, 21 Aug 2020 12:13:35 -0400
Message-Id: <20200821161423.347071-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161423.347071-1-sashal@kernel.org>
References: <20200821161423.347071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Popov <alex.popov@linux.com>

[ Upstream commit 005e696df65d0ff90468ecf38a50aa584dc82421 ]

There is no need to try instrumenting functions in kernel/stackleak.c.
Otherwise that can cause issues if the cleanup pass of stackleak gcc plugin
is disabled.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
Link: https://lore.kernel.org/r/20200624123330.83226-2-alex.popov@linux.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/Makefile b/kernel/Makefile
index f3218bc5ec69f..155b5380500ad 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -125,6 +125,7 @@ obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
 
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
+CFLAGS_stackleak.o += $(DISABLE_STACKLEAK_PLUGIN)
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
 KCSAN_SANITIZE_stackleak.o := n
-- 
2.25.1

