Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616D5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F0920826
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589822287;
	bh=IyYcbei8Co7GNLziygCgwBnXeXn61wr7+vH1FJrXu0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M1B5NXNuhJ0zZCucTRMQok+2dj85F9GdX1bWCq9l4S1vLi144UIOPoQlvdb4xMQIW
	 lph3+PgnOBTzc/XPUofkMQZGDW3rFRLkAEEFTj0o5xfEwSdl2njSCmwhUd1+hDx9EB
	 U0aRUf9IbhxV0jQc+bjbC9uN2tAcxo4jwo8vTm2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgERRSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgERRSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:18:05 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92F2F207FB;
        Mon, 18 May 2020 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589822284;
        bh=IyYcbei8Co7GNLziygCgwBnXeXn61wr7+vH1FJrXu0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VBH3F+W1CAbLSdka4/B3jgesFQxfqtBV1ukO+pMsmtt921rpYRManmtbfx3qyjTyR
         UAtCyiR5M8vYLGNI+KWL1x1HOCDHmxus786zIFof0bwOPYiJd/ZYOdU+OYfKtxRYDc
         LIXembMFwleCaOTlFwL4iyMdeYfU64WNLN5wotj8=
Date:   Mon, 18 May 2020 10:18:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] sit: refactor ipip6_tunnel_ioctl
Message-ID: <20200518101802.3f81b4da@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200518164725.GA17302@lst.de>
References: <20200518114655.987760-1-hch@lst.de>
        <20200518114655.987760-6-hch@lst.de>
        <20200518094356.039e934c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200518164725.GA17302@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 18:47:25 +0200 Christoph Hellwig wrote:
> On Mon, May 18, 2020 at 09:43:56AM -0700, Jakub Kicinski wrote:
> > On Mon, 18 May 2020 13:46:51 +0200 Christoph Hellwig wrote:  
> > > Split the ioctl handler into one function per command instead of having
> > > a all the logic sit in one giant switch statement.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>  
> > 
> > net/ipv6/sit.c: In function ipip6_tunnel_prl_ctl:
> > net/ipv6/sit.c:460:6: warning: variable err set but not used [-Wunused-but-set-variable]
> >   460 |  int err;  
> 
> The warning looks correct, although my compiler doesn't report it :(

W=1, sorry, should've mentioned that!
