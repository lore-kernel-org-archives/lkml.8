Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A572BC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 05:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7152320725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 05:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT4sOGyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGKFRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 01:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgGKFRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 01:17:49 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13855C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 22:17:49 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t11so3621544qvk.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 22:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GzXTS4m3rCOOpnrerEcomBiD8dmhLr3JU2CTL1O2Bsc=;
        b=LT4sOGyjqpSbR9+6PrMuiySR+3hjOqLpfXQ0t32ggsTa9EX9nFNZfWPt/UGEwO/7Ky
         RldtwaLK7AhRQbGl8jzsEGHBDz8G1I6pa3dmaMEcuL5pt9ErqKwSOPtNv8yL7y2OvCtE
         B+G1DLWwNAY0IvSREPlK7/ZbTx01lEGuy5iUcfkj92L+kpoVMISvncld0XgRpQ/+0I/2
         P3FCK8JOfAaLVgC5y5iealmoLwEv5egvVgCfNGDUqCczkhOCwrRo2gUPaUOudB/zLhgw
         Jf90yTOXSzB+VnhxAziBf00yfU0eKuagm45R6n53Prsyfwo+v5wa+4c3ZD+lgxwyLwIb
         t1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GzXTS4m3rCOOpnrerEcomBiD8dmhLr3JU2CTL1O2Bsc=;
        b=NF1IsQHcZLs1Z1y5epumm7xYtMonNDdKaiXxdbgczDnDPxfdoBQJ9fPXLVZve9y98t
         RPu411IDfscomFsUWWJ0EnynGD3mlaPOq/gM9YUg9R+AtE9gMlHMO/nJyR9wuoRG2L9X
         uB30/A5bPTlS7e9a3WJByR+ZFEewRCGiH81nF1mImq4GaQKvcgrEWaeZsMWXMJdWxY35
         4hQtW0QsAEilS/zNT4voTWTrAYRO3S0o10y/eEGfoREZ/+NXzWwNDFnsL+AUQtggqd5Y
         xuzPmcdl1TD3RtbmLGAz+h50cMxhBie9BB65B8i6Eh+aXYV1RV4NYZ1bMRkoOQN2xlZC
         jS+g==
X-Gm-Message-State: AOAM531iJgWv1vRk368hFvq3IpIwFT2IGr7+XS7U2pRi4Re5SJUEwkII
        LXlNpKUV1nOaL58h0IH/oBo=
X-Google-Smtp-Source: ABdhPJw7boukObNBwOl1Q3VgCNX3hvhJ2LnbVRnPICc6cNdXMi9NQE9CROaPdXa2IGkQMKJ0ooKwWw==
X-Received: by 2002:a05:6214:a85:: with SMTP id ev5mr68585618qvb.153.1594444668169;
        Fri, 10 Jul 2020 22:17:48 -0700 (PDT)
Received: from DESKTOP-2I1VNC3.cable.rcn.com ([209.94.140.104])
        by smtp.gmail.com with ESMTPSA id g17sm9609446qto.73.2020.07.10.22.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 22:17:47 -0700 (PDT)
From:   Changming <charley.ashbringer@gmail.com>
To:     willy@infradead.org, rdunlap@infradead.org
Cc:     keescook@chromium.org, mcgrof@kernel.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Changming Liu <charley.ashbringer@gmail.com>
Subject: [PATCH v2] panic: prevent panic_timeout * 1000 from overflow
Date:   Sat, 11 Jul 2020 01:17:28 -0400
Message-Id: <20200711051728.1499-1-charley.ashbringer@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <0d4601d65709a0e2d80e2a8880gmail.com>
References: <0d4601d65709a0e2d80e2a8880gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changming Liu <charley.ashbringer@gmail.com>

Since panic_timeout is an integer passed-in through sysctl,
the loop boundary panic_timeout * 1000 could overflow and
result in a zero-delay panic when panic_timeout is greater
than INT_MAX/1000.

Fix this by moving 1000 to the left, also in case i/1000
might never be greater than panic_timeout, change i to
long long so that it strictly has more bits.

Signed-off-by: Changming Liu <charley.ashbringer@gmail.com>
---
Changes in v2:
- change the loop in panic, instead of change the sysctl

 kernel/panic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index e2157ca387c8..941848aac0ee 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -178,7 +178,8 @@ void panic(const char *fmt, ...)
 {
 	static char buf[1024];
 	va_list args;
-	long i, i_next = 0, len;
+	long long i;
+	long i_next = 0, len;
 	int state = 0;
 	int old_cpu, this_cpu;
 	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
@@ -315,7 +316,7 @@ void panic(const char *fmt, ...)
 		 */
 		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
 
-		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
+		for (i = 0; i / 1000 < panic_timeout; i += PANIC_TIMER_STEP) {
 			touch_nmi_watchdog();
 			if (i >= i_next) {
 				i += panic_blink(state ^= 1);
-- 
2.17.1

