Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668C4C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 23:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367472253D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 23:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgATX2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 18:28:45 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:45950 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgATX2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 18:28:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id B0D7F22BF2;
        Mon, 20 Jan 2020 18:28:41 -0500 (EST)
Date:   Tue, 21 Jan 2020 10:28:39 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     David Miller <davem@davemloft.net>
cc:     tsbogend@alpha.franken.de, chris@zankel.net, laurent@vivier.eu,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 00/19] Fixes for SONIC ethernet driver
In-Reply-To: <20200120.110647.1431085662863704351.davem@davemloft.net>
Message-ID: <alpine.LNX.2.21.1.2001211026190.8@nippy.intranet>
References: <cover.1579474569.git.fthain@telegraphics.com.au> <20200120.110647.1431085662863704351.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020, David Miller wrote:

> 
> This is a mix of cleanups and other things and definitely not bug fixes.
> 

That's true. Sorry if the subject line was somehow misleading. That was 
not intentional.

> Please separate out the true actual bug fixes from the cleanups.
> 
> The bug fixes get submitted to 'net'
> 
> And the rest go to 'net-next'
> 
> Thank you.
> 

OK.
