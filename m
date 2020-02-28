Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C779C3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537DE246AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IH1npzZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgB1BVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:21:15 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:50439 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbgB1BVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:21:14 -0500
Received: by mail-yw1-f74.google.com with SMTP id w197so2488752ywd.17
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 17:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MkaS0G1bk+Q5OhBTj99Zlxgrs85NSvS6F5H6SOsXVyU=;
        b=IH1npzZ+v8JTFD9rsz35zQYEul6R/W7yA2D6y+OHVbHvXqTHNvw94iwhkAAP2DDbVi
         GBl13bzJPRjEuu19+D47ufplr6qg9wjANWrvanrNpgcqF3wYeITyoFt3EBjPEKAChMee
         DeaGGyUBsY44m410q88ZWKqK3we31TbcCkm2I/9FYqcTsjtfZrtU59w7sW8UgKR1PAJe
         CAKr9zLHEDRGuRNAQVHoLYwNfztD6WsUdwPciC+p1QF6ZslfNc/x8Hy7CBCjDGP7F1O7
         OMmtpISW28bF/hQBE0TciN5jdd+8PFqiw4ehn8+83YXO6s8MOtXeeqCaCT+kJgk3y0WI
         ockg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MkaS0G1bk+Q5OhBTj99Zlxgrs85NSvS6F5H6SOsXVyU=;
        b=Fioup3KdEs2r73uc1zoOHGy9p5HslUyMFFZEYFRIC9lZqqdCex9bp2xFlI9Ye2ApEW
         q1TRiF4KCeTYSSImSyk3CzZdGZch4pi5IgJoj6kXGFgKcrWOPYqdT5pqJY7rFdjuGiJO
         9up8O5egnSMRJL56VuaxYLb17xJAUTLABtUL9MZlpNljll5DxPCK2Lm6bmrENaTek8R+
         F9uiRxpr7gaAp2s2w/l0loqwW2LPkprCOhH8VNtEroxqI6BgBqVuBeP5LsLsiZeq/HlX
         +IexUUzlzda0+yTLCfXAMGZ3gp7VnkGlRkqK4yREy8f3XgxJLNEMbed9GTjbssPkpqTi
         qDcQ==
X-Gm-Message-State: APjAAAVhe7i9/nxvFGCDs8raOetl1LSNY7PDPLa7yQIJcgCI7EuM2MJM
        IoMJ9jAnXbsT97wyGn8sScR77c3UWC5EDeYNgCo9OQ==
X-Google-Smtp-Source: APXvYqw/2+N2t2lLq1K+89TJ7bx2qoTvJJopuhhqt7f6cbBPG3uSnhVLpCVqqF2LFAFntCjNNsq3zJIjfvM4Xn6GSUj6sQ==
X-Received: by 2002:a0d:c584:: with SMTP id h126mr2210425ywd.173.1582852873384;
 Thu, 27 Feb 2020 17:21:13 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:20:36 -0800
In-Reply-To: <20200228012036.15682-1-brendanhiggins@google.com>
Message-Id: <20200228012036.15682-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v3 7/7] Documentation: Add kunit_shutdown to kernel-parameters.txt
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kunit_shutdown, an option to specify that the kernel shutsdown after
running KUnit tests, to the kernel-parameters.txt documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dbc22d6846275..6ad63e98916f9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2099,6 +2099,14 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown	[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
+			running built-in tests. Tests configured as modules will
+			not be run.
+			Default:	(flag not present) don't shutdown
+			poweroff:	poweroff the kernel after running tests
+			halt:		halt the kernel after running tests
+			reboot:		reboot the kernel after running tests
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
-- 
2.25.1.481.gfbce0eb801-goog

