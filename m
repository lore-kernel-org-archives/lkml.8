Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6D4C38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0EB2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BUsCDXPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgDTRZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbgDTRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:25:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40271C061A0C;
        Mon, 20 Apr 2020 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=o0F7wvKezOu2wsXXMOT9z5o4JRXsHpFEn7bOH8AcSV0=; b=BUsCDXPcgJ0GHccgFTQ25h1CkF
        Re0P+9gxGSlDlzMfVQgJBvuV+nTPMUiPe7TY4gU3XWzCbaQMy+ict/GKPTw1gItFFNyQi3ETs2ohR
        XIYHS4RI3/qCco/QhgNOmtCMT1yYGqDBGrChXeXD8utw/Ixf8fqn6Ase9AOrPdASpgBcKSyKeqpvu
        zaLtZWjMOMRIrb7WWgQ8fYDU3tCZ1LtughGTxFrEKQCwi96Y+xVhd8dXa4YOXWxUhjWUqr0sOEw18
        FY8QC+WLuXQxCARLSoYNZvzpnqdJ4ExtbGRhQ0kciMZDPAplxLENyU0TSU2CIuEcHZaOzPRLqYoEW
        tOAzM0ZQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQaAq-0001Di-0s; Mon, 20 Apr 2020 17:25:36 +0000
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] Documentation: admin-guide: sysctl/kernel: fix headings
 format and underlines
Message-ID: <5a343483-c896-ffd8-7a06-024e04f69053@infradead.org>
Date:   Mon, 20 Apr 2020 10:25:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix underline length warnings and drop the ending semi-colon from the
title so that they match other title lines.

linux-next-20200420/Documentation/admin-guide/sysctl/kernel.rst:281: WARNING: Title underline too short.

hung_task_all_cpu_backtrace:
================

linux-next-20200420/Documentation/admin-guide/sysctl/kernel.rst:564: WARNING: Title underline too short.

oops_all_cpu_backtrace:
================
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/admin-guide/sysctl/kernel.rst |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20200420.orig/Documentation/admin-guide/sysctl/kernel.rst
+++ linux-next-20200420/Documentation/admin-guide/sysctl/kernel.rst
@@ -277,8 +277,8 @@ Path for the hotplug policy agent.
 Default value is "``/sbin/hotplug``".
 
 
-hung_task_all_cpu_backtrace:
-================
+hung_task_all_cpu_backtrace
+===========================
 
 If this option is set, the kernel will send an NMI to all CPUs to dump
 their backtraces when a hung task is detected. This file shows up if
@@ -560,8 +560,8 @@ rate for each task.
 scanned for a given scan.
 
 
-oops_all_cpu_backtrace:
-================
+oops_all_cpu_backtrace
+======================
 
 If this option is set, the kernel will send an NMI to all CPUs to dump
 their backtraces when an oops event occurs. It should be used as a last

