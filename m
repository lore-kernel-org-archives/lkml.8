Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B4BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F25207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgERQr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:47:29 -0400
Received: from verein.lst.de ([213.95.11.211]:39348 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:47:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40DCC68B02; Mon, 18 May 2020 18:47:25 +0200 (CEST)
Date:   Mon, 18 May 2020 18:47:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] sit: refactor ipip6_tunnel_ioctl
Message-ID: <20200518164725.GA17302@lst.de>
References: <20200518114655.987760-1-hch@lst.de> <20200518114655.987760-6-hch@lst.de> <20200518094356.039e934c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518094356.039e934c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 09:43:56AM -0700, Jakub Kicinski wrote:
> On Mon, 18 May 2020 13:46:51 +0200 Christoph Hellwig wrote:
> > Split the ioctl handler into one function per command instead of having
> > a all the logic sit in one giant switch statement.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> net/ipv6/sit.c: In function ipip6_tunnel_prl_ctl:
> net/ipv6/sit.c:460:6: warning: variable err set but not used [-Wunused-but-set-variable]
>   460 |  int err;

The warning looks correct, although my compiler doesn't report it :(
