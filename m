Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0156DC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EE220717
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBQDtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:49:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48462 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgBQDtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:49:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ADF51157D8A42;
        Sun, 16 Feb 2020 19:49:02 -0800 (PST)
Date:   Sun, 16 Feb 2020 19:49:02 -0800 (PST)
Message-Id: <20200216.194902.108594610616498832.davem@davemloft.net>
To:     fthain@telegraphics.com.au
Cc:     tsbogend@alpha.franken.de, chris@zankel.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] Improvements for SONIC ethernet drivers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1581800613.git.fthain@telegraphics.com.au>
References: <cover.1581800613.git.fthain@telegraphics.com.au>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 16 Feb 2020 19:49:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Sun, 16 Feb 2020 08:03:32 +1100

> Now that the necessary sonic driver fixes have been merged, and the merge
> window has closed again, I'm sending the remainder of my sonic driver
> patch queue.
> 
> A couple of these patches will have to be applied in sequence to avoid
> 'git am' rejects. The others are independent and could have been submitted
> individually. Please let me know if I should do that.
> 
> The complete sonic driver patch queue was tested on National Semiconductor
> hardware (macsonic), qemu-system-m68k (macsonic) and qemu-system-mips64el
> (jazzsonic).

Series applied, thanks.
