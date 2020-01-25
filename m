Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D74EC35242
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060692077C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgAYJxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 04:53:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48850 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYJxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 04:53:25 -0500
Received: from localhost (unknown [147.229.117.36])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 43B4415A32105;
        Sat, 25 Jan 2020 01:53:23 -0800 (PST)
Date:   Sat, 25 Jan 2020 10:53:21 +0100 (CET)
Message-Id: <20200125.105321.1408762540319080985.davem@davemloft.net>
To:     mpe@ellerman.id.au
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, ivansprundel@ioactive.com, vishal@chelsio.com
Subject: Re: [PATCH] net: cxgb3_main: Add CAP_NET_ADMIN check to
 CHELSIO_GET_MEM
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200124094144.15831-1-mpe@ellerman.id.au>
References: <20200124094144.15831-1-mpe@ellerman.id.au>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 25 Jan 2020 01:53:24 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 24 Jan 2020 20:41:44 +1100

> The cxgb3 driver for "Chelsio T3-based gigabit and 10Gb Ethernet
> adapters" implements a custom ioctl as SIOCCHIOCTL/SIOCDEVPRIVATE in
> cxgb_extension_ioctl().
> 
> One of the subcommands of the ioctl is CHELSIO_GET_MEM, which appears
> to read memory directly out of the adapter and return it to userspace.
> It's not entirely clear what the contents of the adapter memory
> contains, but the assumption is that it shouldn't be accessible to all
> users.
> 
> So add a CAP_NET_ADMIN check to the CHELSIO_GET_MEM case. Put it after
> the is_offload() check, which matches two of the other subcommands in
> the same function which also check for is_offload() and CAP_NET_ADMIN.
> 
> Found by Ilja by code inspection, not tested as I don't have the
> required hardware.
> 
> Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied and queued up for -stable.
