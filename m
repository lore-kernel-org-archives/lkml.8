Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C82C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E456E20756
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgESJUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:20:00 -0400
Received: from kernel.crashing.org ([76.164.61.194]:36390 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgESJT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:19:59 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 04J9JQKV002662
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 May 2020 04:19:30 -0500
Message-ID: <5a6de40ebbf0587f245fcff2636080977fda9d96.camel@kernel.crashing.org>
Subject: Re: [PATCH] net: bmac: Fix stack corruption panic in bmac_probe()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Jeremy Kerr <jk@ozlabs.org>, userm57@yahoo.com,
        Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Paul Mackerras <paulus@samba.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 19 May 2020 19:19:25 +1000
In-Reply-To: <f23cf92ee3639e0112e67051009651a88dd0b53b.camel@ozlabs.org>
References: <769e9041942802d0e9ff272c12ee359a04b84a90.1589761211.git.fthain@telegraphics.com.au>
         <43d5717e7157fd300fd5bf893e517bbdf65c36f4.camel@ozlabs.org>
         <05aa357d-4b9c-4038-c0f4-1bfea613c6e4@yahoo.com>
         <f23cf92ee3639e0112e67051009651a88dd0b53b.camel@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-19 at 08:59 +0800, Jeremy Kerr wrote:
> Hi Stan,
> 
> > The new kernel compiled and booted with no errors, with these
> > STACKPROTECTOR options in .config (the last two revealed the bug):
> > 
> > CONFIG_HAVE_STACKPROTECTOR=y
> > CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> > CONFIG_STACKPROTECTOR=y
> > CONFIG_STACKPROTECTOR_STRONG=y
> 
> Brilliant, thanks for testing. I'll send a standalone patch to
> netdev.

Nice catch :-) Lots of people used these machines for years without
noticing :-) .... Granted most people used newer generation stuff with
a gmac instead.

Cheers,
Ben.


