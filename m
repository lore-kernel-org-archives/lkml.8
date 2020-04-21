Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F99C55182
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA13E206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="juAWy4UL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDUUCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDUUCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:02:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA4C0610D5;
        Tue, 21 Apr 2020 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=spA0yht61SX/nlft9ZjTifopY+knPCrtbt6HVKbDaj0=; b=juAWy4ULyiTHIGDhaOz70MnkO2
        BT6z0CYCa5cdd84BF+WeivLQiDsLhiGLr9tDzFuLEQAhjC9reHf9SDRsXIWUNXl+MQ7Xa2fNXPW3X
        rEa0o0OuLpk/zwwZ1n177BTwj50DadzLUJAtZFGQLgIfCM7vHANnuhBwkSYecbXCyZEqTBw9pKdKZ
        bgdFcNgy+UZcMQu1y9Iri6a9uLxqZ0qpSprU4MRrNCFCrUj+PXbI8ixpDBOHTy/QhM0rhkxDeaLFS
        M3jFi//gvDzqcHBMTiZwqV+vPKYuopQtZHhAedzTYxwoTNm5TS8st1O8bTjEPx04V8aYV1TwrevyU
        FYol1LbA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQz6P-0004R8-Nf; Tue, 21 Apr 2020 20:02:41 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] Documentation: admin-guide: sysctl/kernel.h: fix
 underlines and headings
Message-ID: <83eef4ae-8a31-aef6-038e-1d1de51a5c00@infradead.org>
Date:   Tue, 21 Apr 2020 13:02:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
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

@Andrew: Jonathan says that this needs to go via you since it fixes something
that went via your tree. ("introduced by patch 93a0fba3de9a")


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

