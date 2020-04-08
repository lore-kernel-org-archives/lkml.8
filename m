Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF48C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 22:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB5220730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 22:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QNvwhanR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDHWm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 18:42:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36500 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgDHWm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 18:42:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id l25so2125277qkk.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 15:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gx7CIn2jLm5j4xdRTQllP3gtsV1GD1rqAZK1dgPXufs=;
        b=QNvwhanRxS4Sp2j2LHSLQcsnvtI8nKLKCO4iJmFGW1B92LmBwTjRXgMu6hoA+3nu6a
         +AncNDjcl0kSubqIIKDmhQ/B4P0DWLjY944vQvPzXqfIZ/sCSq0fDEsgem3Gc5iICbyv
         0Y39n5KQM6xKjbVgPorJhsaiN2AuYU7Q0/dWwDhxN1r5mtViSRqRNidGJ/zth/jmXnAd
         Fj7J66gfSRWdqqRboP1FK189wHiA2ZAzhPdo2Mp8SJP9vg7U1rEBSGTCCasAVssBxBTy
         zYpfsDYyG5+n/7srZdc6jeXEQR+u64TxJV40NMVebs8Xh6UEw6KOAP5b0PcZX96oRtnX
         4fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gx7CIn2jLm5j4xdRTQllP3gtsV1GD1rqAZK1dgPXufs=;
        b=oINQfnwCtansffd7n4cRrPntuKRqiJXayrvDqggLgkevHC7ikBl+30Cga2I+Gi7gsU
         toDVHnJjvhxEzC/gt8HXr/7jiqjRZDBSrZt3fDXWxcRf5MHOnAktZ+TqJVH+V8wC8PNX
         kyGouWYgnMfDe/G6QRw3Cxido3tg08n7ymI44nXYqB10Zu0HbX9zt2ztWGZ5Q6D1Cm/t
         I59Deilj+oNdGoF+S8Al4ecnNbBvvFI6mJNkSU+ZXjqwBji9NvzNewFW4PeB69mJyNDs
         JVqJCuH7laBH+TufYRMc4I1hJ2VKTHrX6WXf7gmg8rAHdpM3k/B1s5rA89+IJrQGcupa
         /hXw==
X-Gm-Message-State: AGi0PubSImH9L6eVnLhenCPVCNx4eZtEPDq/gduHmADBOsOZPrfn6zAp
        qWDb7nvGrqL7hcxpnGrut+o46Q==
X-Google-Smtp-Source: APiQypK2bX+tqIpGntcBk1/CwwpnTCfzPu8OVIuVdpAy/314r42K0ZVFzsGT+xEEVrPrBkQ7VCf5XA==
X-Received: by 2002:a05:620a:4f2:: with SMTP id b18mr9768314qkh.433.1586385745928;
        Wed, 08 Apr 2020 15:42:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x17sm19797204qkb.87.2020.04.08.15.42.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Apr 2020 15:42:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jMJOq-0006Fv-Ln; Wed, 08 Apr 2020 19:42:24 -0300
Date:   Wed, 8 Apr 2020 19:42:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        "David S. Miller" <davem@davemloft.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [RFC 0/6] Regressions for "imply" behavior change
Message-ID: <20200408224224.GD11886@ziepe.ca>
References: <20200408202711.1198966-1-arnd@arndb.de>
 <nycvar.YSQ.7.76.2004081633260.2671@knanqh.ubzr>
 <CAK8P3a2frDf4BzEpEF0uwPTV2dv6Jve+6N97z1sSuSBUAPJquA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2frDf4BzEpEF0uwPTV2dv6Jve+6N97z1sSuSBUAPJquA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 10:49:48PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 8, 2020 at 10:38 PM Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Wed, 8 Apr 2020, Arnd Bergmann wrote:
> > > I have created workarounds for the Kconfig files, which now stop using
> > > imply and do something else in each case. I don't know whether there was
> > > a bug in the kconfig changes that has led to allowing configurations that
> > > were not meant to be legal even with the new semantics, or if the Kconfig
> > > files have simply become incorrect now and the tool works as expected.
> >
> > In most cases it is the code that has to be fixed. It typically does:
> >
> >         if (IS_ENABLED(CONFIG_FOO))
> >                 foo_init();
> >
> > Where it should rather do:
> >
> >         if (IS_REACHABLE(CONFIG_FOO))
> >                 foo_init();
> >
> > A couple of such patches have been produced and queued in their
> > respective trees already.
> 
> I try to use IS_REACHABLE() only as a last resort, as it tends to
> confuse users when a subsystem is built as a module and already
> loaded but something relying on that subsystem does not use it.
> 
> In the six patches I made, I had to use IS_REACHABLE() once,
> for the others I tended to use a Kconfig dependency like
> 
> 'depends on FOO || FOO=n'

It is unfortunate kconfig doesn't have a language feature for this
idiom, as the above is confounding without a lot of kconfig knowledge

> I did come up with the IS_REACHABLE() macro originally, but that
> doesn't mean I think it's a good idea to use it liberally ;-)

It would be nice to have some uniform policy here

I also don't like the IS_REACHABLE solution, it makes this more
complicated, not less..

Jason
