Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1F4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 16:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35F5207EA
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 16:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgGSQEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 12:04:49 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43630 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgGSQEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 12:04:49 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jxBnt-005tGV-9f; Sun, 19 Jul 2020 18:04:41 +0200
Date:   Sun, 19 Jul 2020 18:04:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Eric Dumazet <edumazet@google.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/4] net: Call into DSA netdevice_ops wrappers
Message-ID: <20200719160441.GK1383417@lunn.ch>
References: <20200718030533.171556-1-f.fainelli@gmail.com>
 <20200718030533.171556-4-f.fainelli@gmail.com>
 <20200718211805.3yyckq23udacz4sa@skbuf>
 <d3a11ef5-3e4e-0c4a-790b-63da94a1545c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a11ef5-3e4e-0c4a-790b-63da94a1545c@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If we have the core network stack reference DSA as a module then we
> force DSA to be either built-in or not, which is not very practical,
> people would still want a modular choice to be possible. The static
> inline only wraps indirect function pointer calls using definitions
> available at build time and actual function pointer substitution at run
> time, so we avoid that problem entirely that way.

Hi Florian

The jumping through the pointer avoids the inbuilt vs module problems.

The helpers themselves could be in a net/core/*.c file, rather than
static inline in a header. Is it worth adding a net/core/dsa.c for
code which must always be built in? At the moment, probably not.  But
if we have more such redirect, maybe it would be?

     Andrew
