Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9F1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF9820738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598030485;
	bh=qPyHyNfco18mQTkDq3vxRcTyVpTFndICNo8YCySJlHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FUXb+SQ4i1w5qaGVkUuSXovlnRtv4ZN4XnR9Nr6bCvy7KCq224O2HdJUYmpsrj2i9
	 WkGjo7QksupyASmUskHuHv42ogvjLzHOL+1JyDnO0/O9UiHwEze2uNrHW/+IdwM6wj
	 xReOx2elS0cMIMQdO2XyYbXBdUO7Pajn82oYerNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgHURVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgHUQQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:16:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46F0422B40;
        Fri, 21 Aug 2020 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026562;
        bh=qPyHyNfco18mQTkDq3vxRcTyVpTFndICNo8YCySJlHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZwhmzC+GcAymoCje5uQjp7Znzwjzc9Yup67Dqc9oSz8laUb6c5n8V1ytgg5M7DXn
         9dq8ut69GdQzi5ImTWP0hlahJ6e5Vr4p6upXQlO/j94i0UW1PevNW3PgGQFZ0GVblF
         3qforLpC38mnZ7tyDZEHKBenfmPzhRISpW6seeDI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 14/61] gcc-plugins/stackleak: Don't instrument itself
Date:   Fri, 21 Aug 2020 12:14:58 -0400
Message-Id: <20200821161545.347622-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161545.347622-1-sashal@kernel.org>
References: <20200821161545.347622-1-sashal@kernel.org>
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
index 4cb4130ced329..d372134ac9ec1 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_RSEQ) += rseq.o
 
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
+CFLAGS_stackleak.o += $(DISABLE_STACKLEAK_PLUGIN)
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
-- 
2.25.1

