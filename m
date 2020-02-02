Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD5CC35240
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 10:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1377C206D3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 10:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgBBKzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 05:55:22 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52100 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBBKzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 05:55:22 -0500
Received: from localhost (dhcp-077-249-119-090.chello.nl [77.249.119.90])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6E6FB15A047FD;
        Sun,  2 Feb 2020 02:55:18 -0800 (PST)
Date:   Sun, 02 Feb 2020 11:55:14 +0100 (CET)
Message-Id: <20200202.115514.196916055025174984.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     akpm@linux-foundation.org, matorola@gmail.com,
        ebiederm@xmission.com, deepa.kernel@gmail.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: fix adjtimex regression
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200201212104.575657-1-arnd@arndb.de>
References: <20200201212104.575657-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Feb 2020 02:55:19 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Sat,  1 Feb 2020 22:20:52 +0100

> Anatoly Pugachev reported one of the y2038 patches to introduce
> a fatal bug from a stupid typo:
> 
> [   96.384129] watchdog: BUG: soft lockup - CPU#8 stuck for 22s!
> ...
> [   96.385624]  [0000000000652ca4] handle_mm_fault+0x84/0x320
> [   96.385668]  [0000000000b6f2bc] do_sparc64_fault+0x43c/0x820
> [   96.385720]  [0000000000407754] sparc64_realfault_common+0x10/0x20
> [   96.385769]  [000000000042fa28] __do_sys_sparc_clock_adjtime+0x28/0x80
> [   96.385819]  [00000000004307f0] sys_sparc_clock_adjtime+0x10/0x20
> [   96.385866]  [0000000000406294] linux_sparc_syscall+0x34/0x44
> 
> Fix the code to dereference the correct pointer again.
> 
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Tested-by: Anatoly Pugachev <matorola@gmail.com>
> Fixes: 251ec1c159e4 ("y2038: sparc: remove use of struct timex")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The bug was introduced through my y2038 branch and is now in
> mainline, but not in v5.5. Who should pick up the fix to
> get it into v5.6-rc1?

I'll pick it up.

Applied, thanks.
