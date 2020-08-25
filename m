Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7F0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911082068E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lTWHY8n7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w5qVkUqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgHYKu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbgHYKux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:50:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B611C061574;
        Tue, 25 Aug 2020 03:50:53 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:50:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598352650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ED1azcYB2bOCp+uGW26ISv+HcMQc4w7N8XVMWmOZdus=;
        b=lTWHY8n74kWp+FHXndblMS7QFJrSQ3ooZ5wKtiFnaWvJmmQ3zxKBGXmczXoKFJU+6P3gat
        82mfXNVkaGDMIjT8tcwC5TmL9f+21nFveTJn1bU3w60gQQ02Pvfh/8ce7chFTI4kyb0QLM
        6vg3v230d+hOmCF6KCLMY9IH7o7rvbUx7IOdrsbLhaq2+CzS7ZY/n7STqUxnrFfxnqOxdF
        S7DjRgbDNk2DnpmlvH3JccFAqyAhEeIMzrIG7KOwhASJBh3tF50VeckqybZ8pCNpfWAlMX
        cPLPLiuBm2IBbqc0IXmf5fsjyDlwmboT7XGKRo62OwmhF2lh8F/iGAV3/tzbMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598352650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ED1azcYB2bOCp+uGW26ISv+HcMQc4w7N8XVMWmOZdus=;
        b=w5qVkUqMb53mwlIrMZSsvru6WgYGK/44q87/q4rikG/UqaKhCT0j2OGr0kivvc0tWAkVtK
        lzCGLQ3bx25uVKBQ==
From:   "tip-bot2 for Xu Wang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimer: Convert comma to semicolon
Cc:     Xu Wang <vulab@iscas.ac.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818062651.21680-1-vulab@iscas.ac.cn>
References: <20200818062651.21680-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Message-ID: <159835264988.389.5627891620040384998.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ec02821c1d35f93b821bc9fdfa83a5f3e9d7275d
Gitweb:        https://git.kernel.org/tip/ec02821c1d35f93b821bc9fdfa83a5f3e9d7275d
Author:        Xu Wang <vulab@iscas.ac.cn>
AuthorDate:    Tue, 18 Aug 2020 06:26:51 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Aug 2020 12:45:53 +02:00

alarmtimer: Convert comma to semicolon

Replace a comma between expression statements by a semicolon.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20200818062651.21680-1-vulab@iscas.ac.cn

---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index ca223a8..f4ace1b 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -908,7 +908,7 @@ static int __init alarmtimer_init(void)
 	/* Initialize alarm bases */
 	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
 	alarm_bases[ALARM_REALTIME].get_ktime = &ktime_get_real;
-	alarm_bases[ALARM_REALTIME].get_timespec = ktime_get_real_ts64,
+	alarm_bases[ALARM_REALTIME].get_timespec = ktime_get_real_ts64;
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
 	alarm_bases[ALARM_BOOTTIME].get_ktime = &ktime_get_boottime;
 	alarm_bases[ALARM_BOOTTIME].get_timespec = get_boottime_timespec;
