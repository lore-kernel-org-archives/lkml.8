Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EF4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6727F20709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgGWNek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:34:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51416 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGWNej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:34:39 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jybMm-006WGL-FO; Thu, 23 Jul 2020 15:34:32 +0200
Date:   Thu, 23 Jul 2020 15:34:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] net: dsa: mv88e6xxx: Use chip-wide max frame size
 for MTU
Message-ID: <20200723133432.GE1553578@lunn.ch>
References: <20200723035942.23988-1-chris.packham@alliedtelesis.co.nz>
 <20200723035942.23988-5-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723035942.23988-5-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 03:59:42PM +1200, Chris Packham wrote:
> Some of the chips in the mv88e6xxx family don't support jumbo
> configuration per port. But they do have a chip-wide max frame size that
> can be used. Use this to approximate the behaviour of configuring a port
> based MTU.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Hi Chris

This patch will need a bit of rework for net-next, but the basic idea
is O.K.

   Andrew
