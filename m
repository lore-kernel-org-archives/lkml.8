Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3ACC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C98624676
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAUJqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:46:39 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35854 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUJqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:46:38 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C5A1115BBD4F6;
        Tue, 21 Jan 2020 01:46:36 -0800 (PST)
Date:   Tue, 21 Jan 2020 10:46:35 +0100 (CET)
Message-Id: <20200121.104635.663739014554850228.davem@davemloft.net>
To:     wenyang@linux.alibaba.com
Cc:     edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp_bbr: improve arithmetic division in bbr_update_bw()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200120100456.45609-1-wenyang@linux.alibaba.com>
References: <20200120100456.45609-1-wenyang@linux.alibaba.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jan 2020 01:46:38 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang@linux.alibaba.com>
Date: Mon, 20 Jan 2020 18:04:56 +0800

> do_div() does a 64-by-32 division. Use div64_long() instead of it
> if the divisor is long, to avoid truncation to 32-bit.
> And as a nice side effect also cleans up the function a bit.
> 
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>

Applied, thank you.
