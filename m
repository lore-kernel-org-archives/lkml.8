Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFD9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0779D21527
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbgFSTZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387944AbgFSTZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:25:31 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913BDC06174E;
        Fri, 19 Jun 2020 12:25:31 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 308F62CD;
        Fri, 19 Jun 2020 19:25:31 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:25:30 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: Re: [PATCH] Documentation: fix sysctl/kernel.rst heading format
 warnings
Message-ID: <20200619132530.7f329134@lwn.net>
In-Reply-To: <8af1cb77-4b5a-64b9-da5d-f6a95e537f99@infradead.org>
References: <8af1cb77-4b5a-64b9-da5d-f6a95e537f99@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020 21:11:00 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix heading format warnings in admin-guide/sysctl/kernel.rst:
> 
> Documentation/admin-guide/sysctl/kernel.rst:339: WARNING: Title underline too short.
> hung_task_all_cpu_backtrace:
> ================
> 
> Documentation/admin-guide/sysctl/kernel.rst:650: WARNING: Title underline too short.
> oops_all_cpu_backtrace:
> ================
> 
> Fixes: 0ec9dc9bcba0 ("kernel/hung_task.c: introduce sysctl to print all traces when a hung task is detected")
> Fixes: 60c958d8df9c ("panic: add sysctl to dump all CPUs backtraces on oops event")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Guilherme G. Piccoli <gpiccoli@canonical.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon
