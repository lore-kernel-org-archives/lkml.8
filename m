Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3663FC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 18:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBFB214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589048010;
	bh=ZvfcP8iKmBJsOOsYuB1cFVtXFkMyiFexkKn+eQSnu1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=d5kquOsPSjS6gcleioSoitGkrmeYrl/njX3uJjw2liZff/ZIOuAFT/iI7guxL8idw
	 u5Ul5o26f0CfHLJb13ljQbys/q/MWYjzuhrvWLeB8E6X6vJtIW94hmjEwViaRcf27j
	 40y/lIOks8oT3lKtu/Zl8ook3tFTaZ6LlvG3PYPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgEISN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 14:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgEISN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 14:13:28 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (c-67-180-217-166.hsd1.ca.comcast.net [67.180.217.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6FBB21473;
        Sat,  9 May 2020 18:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589048008;
        bh=ZvfcP8iKmBJsOOsYuB1cFVtXFkMyiFexkKn+eQSnu1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oHDtZjNMF4UUKE9+bMS4H/MSNGlbRT64LaiEVszUAFnG6h71myoEF453iy/2/h/Lh
         YWzVRPaEKfXxualsCAS1x2XIRpANu61rt8CVUDEfiwD9d8N+1WPiP+s4PR00VNhgmX
         M2fLqDQLI5dRxg4K6S0X68J6dj+F+c4Az8ThTUGE=
Date:   Sat, 9 May 2020 11:13:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, fthain@telegraphics.com.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/sonic: Fix some resource leaks in error handling
 paths
Message-ID: <20200509111321.51419b19@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <50ef36cd-d095-9abe-26ea-d363d11ce521@wanadoo.fr>
References: <20200508172557.218132-1-christophe.jaillet@wanadoo.fr>
        <20200508185402.41d9d068@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <50ef36cd-d095-9abe-26ea-d363d11ce521@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020 18:47:08 +0200 Christophe JAILLET wrote:
> Le 09/05/2020 =C3=A0 03:54, Jakub Kicinski a =C3=A9crit=C2=A0:
> > On Fri,  8 May 2020 19:25:57 +0200 Christophe JAILLET wrote: =20
> >> @@ -527,8 +531,9 @@ static int mac_sonic_platform_remove(struct platfo=
rm_device *pdev)
> >>   	struct sonic_local* lp =3D netdev_priv(dev);
> >>  =20
> >>   	unregister_netdev(dev);
> >> -	dma_free_coherent(lp->device, SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp=
->dma_bitmode),
> >> -	                  lp->descriptors, lp->descriptors_laddr);
> >> +	dma_free_coherent(lp->device,
> >> +			  SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
> >> +			  lp->descriptors, lp->descriptors_laddr);
> >>   	free_netdev(dev);
> >>  =20
> >>   	return 0; =20
> > This is a white-space only change, right? Since this is a fix we should
> > avoid making cleanups which are not strictly necessary.
>
> Right.
>=20
> The reason of this clean-up is that I wanted to avoid a checkpatch=20
> warning with the proposed patch and I felt that having the same layout=20
> in the error handling path of the probe function and in the remove=20
> function was clearer.
> So I updated also the remove function.

I understand the motivation is good.

> Fell free to ignore this hunk if not desired. I will not sent a V2 only=20
> for that.

That's not how it works. Busy maintainers don't have time to hand edit
patches. I'm not applying this to the networking tree and I'm tossing it
from patchwork. Please address the basic feedback.

Thank you.
