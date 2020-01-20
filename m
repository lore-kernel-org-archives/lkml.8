Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F3CC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E81F2073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgATJD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:03:56 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:54936 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:03:56 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 53315153D0495;
        Mon, 20 Jan 2020 01:03:46 -0800 (PST)
Date:   Mon, 20 Jan 2020 10:03:45 +0100 (CET)
Message-Id: <20200120.100345.1624559406391044919.davem@davemloft.net>
To:     sfr@canb.auug.org.au
Cc:     netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, niu_xilei@163.com
Subject: Re: linux-next: build failure after merge of the net-next tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200116185337.0fbb9398@canb.auug.org.au>
References: <20200116185337.0fbb9398@canb.auug.org.au>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Jan 2020 01:03:55 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 16 Jan 2020 18:53:37 +1100

> After merging the net-next tree, today's linux-next build (sparc
> defconfig) failed like this:
> 
> ERROR: "__umoddi3" [net/core/pktgen.ko] undefined!
> 
> Caused by commit
> 
>   7786a1af2a6b ("pktgen: Allow configuration of IPv6 source address range")
> 
> I have reverted that commit for today.

Niu Xilei, you must fix this or else I will have to revert your pktgen
changes.

You cannot do direct division or modulus on 64-bit integer values,
instead you must use the various div*() helper macros so that it works
on all 32-bit systems too.

Thank you.
