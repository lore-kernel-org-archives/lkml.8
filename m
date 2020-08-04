Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E99FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8F022B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgHDTYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:24:49 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42642 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgHDTYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:24:48 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1k32Y7-008GVn-Cq; Tue, 04 Aug 2020 21:24:35 +0200
Date:   Tue, 4 Aug 2020 21:24:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ilia Lin <ilia.lin@gmail.com>
Cc:     David Miller <davem@davemloft.net>, ilial@codeaurora.org,
        kuba@kernel.org, jiri@mellanox.com, edumazet@google.com,
        ap420073@gmail.com, xiyou.wangcong@gmail.com, maximmi@mellanox.com,
        Ilia Lin <ilia.lin@kernel.org>, netdev@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dev: Add API to check net_dev readiness
Message-ID: <20200804192435.GG1919070@lunn.ch>
References: <1595792274-28580-1-git-send-email-ilial@codeaurora.org>
 <20200726194528.GC1661457@lunn.ch>
 <20200727.103233.2024296985848607297.davem@davemloft.net>
 <CA+5LGR1KwePssqhCkZ6qT_W87fO2o1XPze53mJwjkTWtphiWrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+5LGR1KwePssqhCkZ6qT_W87fO2o1XPze53mJwjkTWtphiWrA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 08:47:18PM +0300, Ilia Lin wrote:
> Hi Andrew and David,

Hi Ilia

Please don't top post.

> 
> Thank you for your comments!
> 
> The client driver is still work in progress, but it can be seen here:
> https://source.codeaurora.org/quic/la/kernel/msm-4.19/tree/drivers/platform/msm/ipa/ipa_api.c#n3842
> 
> For HW performance reasons, it has to be in subsys_initcall.

Well, until the user of this new API is ready, we will not accept the
patch.

You also need to explain "For HW performance reasons". Why is this
driver special that it can do things which no over driver does?

And you should really be working on net-next, not this dead kernel
version, if you want to get merged into mainline.

Network drivers do not belong is drivers/platform. There is also ready
a drivers/net/ipa, so i assume you will move there.

  Andrew
