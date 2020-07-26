Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D43C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 19:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD3D206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 19:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgGZTpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:45:39 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56146 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgGZTpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 15:45:39 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jzmaO-006zNB-FQ; Sun, 26 Jul 2020 21:45:28 +0200
Date:   Sun, 26 Jul 2020 21:45:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ilia Lin <ilial@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, jiri@mellanox.com,
        edumazet@google.com, ap420073@gmail.com, xiyou.wangcong@gmail.com,
        maximmi@mellanox.com, ilia.lin@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dev: Add API to check net_dev readiness
Message-ID: <20200726194528.GC1661457@lunn.ch>
References: <1595792274-28580-1-git-send-email-ilial@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595792274-28580-1-git-send-email-ilial@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 10:37:54PM +0300, Ilia Lin wrote:
> From: Ilia Lin <ilia.lin@kernel.org>
> 
> Add an API that returns true, if the net_dev_init was already called,
> and the driver was initialized.
> 
> Some early drivers, that are initialized during the subsys_initcall
> may try accessing the net_dev or NAPI APIs before the net_dev_init,
> and will encounter a kernel bug. This API provides a way to handle
> this and manage by deferring or by other way.

Hi Ilia

You need to include a user of this new API.

I also have to wonder why a network device driver is being probed the
subsys_initcall.

    Andrew
