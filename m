Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5052AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 04:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D3420747
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 04:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PZCBn1VC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgFOELL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 00:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgFOELK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 00:11:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82F6C061A0E;
        Sun, 14 Jun 2020 21:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=010wDv/U5XhtaTaNAqWWuMgS5+UAVZXKJT9y0jGO0Zs=; b=PZCBn1VC8GnyvhTrIiq8CYD89U
        rffLULe71O3ObsZ677IYZJhxyAw+hqAgiB7C8N0vgfYeGoESxBdmPk5KyRbqwAk9Zti2Cba8XfT3Q
        HKb6hHV8JLokWLwKMC/K61uDgiqm0zFIAewTNRdCboKFmmRpgyH/90cVksGgG2nzh0pnU++9Zm6dK
        wcSGv3HcuT0mj2NRRG1hNKjczMYOaREQy5YoDCoS5UlsO7Pi3TtKSWLcdQwOgrXZ7UJA3H3yOypBk
        hgdapLJ/7otqo2fdoACvA4gCyOW9MJbC45+GZCZpngjgG+rDQum3tRpx9sStRsaGkI0SPUVEWGuPL
        FMXqYo6Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkgSb-0004Ks-Vt; Mon, 15 Jun 2020 04:11:02 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fix sysctl/kernel.rst heading format warnings
Message-ID: <8af1cb77-4b5a-64b9-da5d-f6a95e537f99@infradead.org>
Date:   Sun, 14 Jun 2020 21:11:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix heading format warnings in admin-guide/sysctl/kernel.rst:

Documentation/admin-guide/sysctl/kernel.rst:339: WARNING: Title underline too short.
hung_task_all_cpu_backtrace:
================

Documentation/admin-guide/sysctl/kernel.rst:650: WARNING: Title underline too short.
oops_all_cpu_backtrace:
================

Fixes: 0ec9dc9bcba0 ("kernel/hung_task.c: introduce sysctl to print all traces when a hung task is detected")
Fixes: 60c958d8df9c ("panic: add sysctl to dump all CPUs backtraces on oops event")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Guilherme G. Piccoli <gpiccoli@canonical.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 Documentation/admin-guide/sysctl/kernel.rst |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- lnx-58-rc1.orig/Documentation/admin-guide/sysctl/kernel.rst
+++ lnx-58-rc1/Documentation/admin-guide/sysctl/kernel.rst
@@ -335,8 +335,8 @@ Path for the hotplug policy agent.
 Default value is "``/sbin/hotplug``".
 
 
-hung_task_all_cpu_backtrace:
-================
+hung_task_all_cpu_backtrace
+===========================
 
 If this option is set, the kernel will send an NMI to all CPUs to dump
 their backtraces when a hung task is detected. This file shows up if
@@ -646,8 +646,8 @@ rate for each task.
 scanned for a given scan.
 
 
-oops_all_cpu_backtrace:
-================
+oops_all_cpu_backtrace
+======================
 
 If this option is set, the kernel will send an NMI to all CPUs to dump
 their backtraces when an oops event occurs. It should be used as a last

