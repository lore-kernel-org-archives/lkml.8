Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B83C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176D820747
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgEGAEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 20:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgEGAEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 20:04:08 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE57C061A0F;
        Wed,  6 May 2020 17:04:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5D51A12777A7F;
        Wed,  6 May 2020 17:04:07 -0700 (PDT)
Date:   Wed, 06 May 2020 17:04:06 -0700 (PDT)
Message-Id: <20200506.170406.1373961782517203412.davem@davemloft.net>
To:     hkallweit1@gmail.com
Cc:     tglx@linutronix.de, corbet@lwn.net, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] timer: add fsleep for flexible sleeping
From:   David Miller <davem@davemloft.net>
In-Reply-To: <8e3c56ca-b43f-3877-0104-a1a279d5a6c5@gmail.com>
References: <8e3c56ca-b43f-3877-0104-a1a279d5a6c5@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 May 2020 17:04:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Fri, 1 May 2020 23:26:21 +0200

> Sleeping for a certain amount of time requires use of different
> functions, depending on the time period.
> Documentation/timers/timers-howto.rst explains when to use which
> function, and also checkpatch checks for some potentially
> problematic cases.
> 
> So let's create a helper that automatically chooses the appropriate
> sleep function -> fsleep(), for flexible sleeping
> Not sure why such a helper doesn't exist yet, or where the pitfall is,
> because it's a quite obvious idea.
> 
> If the delay is a constant, then the compiler should be able to ensure
> that the new helper doesn't create overhead. If the delay is not
> constant, then the new helper can save some code.
> 
> First user is the r8169 network driver. If nothing speaks against it,
> then this series could go through the netdev tree.

I haven't seen any objections voiced over the new fsleep helper, so
I've applied this series to net-next.

Thank you.
