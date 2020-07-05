Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78069C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ECB12074F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=c0d3.blue header.i=@c0d3.blue header.b="nLmzWjcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgGETtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgGETtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:49:18 -0400
Received: from mail.aperture-lab.de (mail.aperture-lab.de [IPv6:2a01:4f8:171:314c::100:a1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399A2C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 12:49:18 -0700 (PDT)
Date:   Sun, 5 Jul 2020 21:49:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1593978556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKHluXxwUVzurMKE6PUs6fbpMqBoqqTeZ7p5ILBCNf0=;
        b=nLmzWjczwQSgfZJJDP856kNnRZO0Dg5HeFABdFqkVbnIv2qTovOJEIsv2+aMQW4t+AVtBC
        P7LatRyPUuuTZrzJCbIxKsVEYrpl5qkQA849wBGxqO7Ib79joFGqJQtvPK5mAgmY3/NDo7
        VrhHn2XvixQ6zxwpGSv8EAOkpQa82ETkxTleK9tv9zImAp1m48rWREXy3i9ECssE7WRGea
        G/v2lrL4BkSYcrGzqnEPOPQrOAZERqMuehaKgPgwBIbHE63rtK/FINX0oXw/N/EaXzkkEr
        1ixqhgJoos1Ag5wdmuMzmtvbBYfKZH7XVufaE/wqIs6gP5xSp7USewr/jRCfMA==
From:   Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To:     Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc:     netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>,
        Martin Weinelt <martin@linuxlounge.net>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bridge: mcast: Fix MLD2 Report IPv6 payload length
 check
Message-ID: <20200705194915.GD2648@otheros>
References: <20200705182234.10257-1-linus.luessing@c0d3.blue>
 <093beb97-87e8-e112-78ad-b3e4fe230cdb@cumulusnetworks.com>
 <20200705190851.GC2648@otheros>
 <4728ef5e-0036-7de6-8b6f-f29885d76473@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4728ef5e-0036-7de6-8b6f-f29885d76473@cumulusnetworks.com>
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 10:11:39PM +0300, Nikolay Aleksandrov wrote:
> On 7/5/20 10:08 PM, Linus Lüssing wrote:
> > On Sun, Jul 05, 2020 at 09:33:13PM +0300, Nikolay Aleksandrov wrote:
> > > On 05/07/2020 21:22, Linus Lüssing wrote:
> > > > Commit e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in
> > > > igmp3/mld2 report handling") introduced a small bug which would potentially
> > > > lead to accepting an MLD2 Report with a broken IPv6 header payload length
> > > > field.
> > > > 
> > > > The check needs to take into account the 2 bytes for the "Number of
> > > > Sources" field in the "Multicast Address Record" before reading it.
> > > > And not the size of a pointer to this field.
> > > > 
> > > > Fixes: e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in igmp3/mld2 report handling")
> > > > Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> > > > ---
> > > >   net/bridge/br_multicast.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > 
> > > I'd rather be more concerned with it rejecting a valid report due to wrong size. The ptr
> > > size would always be bigger. :)
> > > 
> > > Thanks!
> > > Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> > 
> > Aiy, you're right, it's the other way round. I'll update the
> > commit message and send a v2 in a minute, with your Acked-by
> > included.
> > 
> 
> By the way, I can't verify at the moment, but I think we can drop that whole
> hunk altogether since skb_header_pointer() is used and it will simply return
> an error if there isn't enough data for nsrcs.
> 

Hm, while unlikely, the IPv6 packet / header payload length might be
shorter than the frame / skb size.

And even though it wouldn't crash reading over the IPv6 packet
length, especially as skb_header_pointer() is used, I think we should
still avoid reading over the size indicated by the IPv6 header payload
length field, to stay protocol compliant.

Does that make sense?
