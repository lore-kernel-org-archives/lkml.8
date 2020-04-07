Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4E7C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12F1206F5
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586238216;
	bh=f4zBSzGQroby1C5YQlwI3K2ZZKv+UEnm9JRTLRxnuVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sBNruoImvO0n4DBOoWmL5ut5NNvb31kMYv6/OiFUMCKHa93319kFMSXu+I67lbWvW
	 tWgVxyKdmvc2nWjKbMCCHYjCz8z4xu6mJ7V6By95j01gRi2asnn24299kcL0cfJU1U
	 YFC/WYy/gG3pLvQyqwnyJlu4GmoCoD8ZUKH6PEz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgDGFnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgDGFne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:43:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 795B8206F5;
        Tue,  7 Apr 2020 05:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586238214;
        bh=f4zBSzGQroby1C5YQlwI3K2ZZKv+UEnm9JRTLRxnuVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BhjTUHK6rfgOQOow47upoLydCbz1A1zra8g0JKDFZmkfip45CWso89+wGI7aWuFwN
         7+vyH0lc0qYskBWeLV41dx6l3kBvTG96hUtyiapXmmYbfvwvAYMbCUnTftC3yiTKvS
         txa0pmYkGBVLjEQGfSv2m7wdCK81fyl7M9Sk6Z8Y=
Date:   Tue, 7 Apr 2020 07:43:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-stable@vger.kernel.org, sashal@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH stable-4.9.y]] net: dsa: tag_brcm: Fix
 skb->fwd_offload_mark location
Message-ID: <20200407054331.GA258967@kroah.com>
References: <1586220853-34769-1-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586220853-34769-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 05:54:12PM -0700, Florian Fainelli wrote:
> When the backport of upstream commit
> 0e62f543bed03a64495bd2651d4fe1aa4bcb7fe5 ("net: dsa: Fix duplicate
> frames flooded by learning") was done the assignment of
> skb->fwd_offload_mark would land in brcm_tag_xmit() which is incorrect,
> it should have been in brcm_tag_rcv().
> 
> Fixes: 5e845dc62f38 ("net: dsa: Fix duplicate frames flooded by learning")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  net/dsa/tag_brcm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Now queued up, thanks.

greg k-h
