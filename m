Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E202C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 00:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131C520704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 00:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587601322;
	bh=ic4v7Bk99U/2TTEq7gGalaOGjQfJ77Qj/nZpBQvFafs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YLvj6+BfmS+ClhLssAvBK7aoGU8qPaG1odKZ37M36KrmZVdfpK0rHESdDiePvDBVC
	 DrtxrP9PTv12vjP/bDaudJKLssKopM+GZZxMnhDjNlifWsRhpu9a2WAZ8TwL6C7GGV
	 aW4AtUvjhQVTcfyHdCn/ioKBZL+yFb2kH3cG+Jn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDWAVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgDWAVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 20:21:51 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB9D20704;
        Thu, 23 Apr 2020 00:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587601311;
        bh=ic4v7Bk99U/2TTEq7gGalaOGjQfJ77Qj/nZpBQvFafs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xc9xahHPbLcSTN9pbScT2pW9xqYT8eG4za17xS7KW0hqL5f8ky+TvyRUlzYD7UDxK
         9mC40qyTljL+k3WCcuv0KpkXtpcQKlpln6tpk4EeuutnkIte5xANP2nXsSiU/CMa0p
         hZUQL6dJAZIQGCam4N+q19C2SKnoqbTcRLE3yagA=
Date:   Wed, 22 Apr 2020 17:21:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     khalasa@piap.pl, davem@davemloft.net, linus.walleij@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH v2] net: ethernet: ixp4xx: Add error handling in
 ixp4xx_eth_probe()
Message-ID: <20200422172149.787fdc3c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200422010922.17728-1-tangbin@cmss.chinamobile.com>
References: <20200422010922.17728-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 09:09:22 +0800 Tang Bin wrote:
> The function ixp4xx_eth_probe() does not perform sufficient error
> checking after executing devm_ioremap_resource(), which can result
> in crashes if a critical error path is encountered.
> 
> Fixes: f458ac479777 ("ARM/net: ixp4xx: Pass ethernet physical base as resource")
> 

No extra lines, between the tags, though, please.

> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
