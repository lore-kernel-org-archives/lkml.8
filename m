Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5976CC1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 21:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F0720658
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 21:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584911187;
	bh=tRJ4p7lKYiN6wX+ALChAuCV0TylJs+y6wN/8sB1COwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xhGhV4O2Y6LPzl8UjLTYjZ9dqxO3sDiF9vBk82obYPHJWUDukbpULBUHeRDYx839h
	 wuuN6pottE+eNrydCLNra4bFynEHmuV0ouugmc07/27nCH7cVZxaL8LSB2BeYnDYKn
	 qLLbauHBX9MP3whP5StKNiwp6G4aqiL6byQx7Qnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCVVG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 17:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgCVVGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 17:06:25 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC45920658;
        Sun, 22 Mar 2020 21:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584911185;
        bh=tRJ4p7lKYiN6wX+ALChAuCV0TylJs+y6wN/8sB1COwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gT6DVqwXG6yLiPzou40rj+Z1VEwlqihyMU06pRPfCfRyUk1ddJn3Gk4H87N47oTm+
         Zy8pT0eVNZu0wu3040m8kefDmZeanKVdGIVN9DImzZYxpffMlY3gFf+5NLU0fs0naU
         97Wb0Y8d+71NvFeK37zooQERZcA2i7z7pU8sVi2Q=
Date:   Sun, 22 Mar 2020 14:06:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ethtool: fix reference leak in some *_SET handlers
Message-ID: <20200322140623.633d3446@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20200322205109.GF31519@unicorn.suse.cz>
References: <20200322201551.E11BAE0FD3@unicorn.suse.cz>
        <20200322134356.55f7d9b8@kicinski-fedora-PC1C0HJN>
        <20200322205109.GF31519@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Mar 2020 21:51:09 +0100 Michal Kubecek wrote:
> On Sun, Mar 22, 2020 at 01:43:56PM -0700, Jakub Kicinski wrote:
> > On Sun, 22 Mar 2020 21:15:51 +0100 (CET) Michal Kubecek wrote:  
> > > Andrew noticed that some handlers for *_SET commands leak a netdev
> > > reference if required ethtool_ops callbacks do not exist. A simple
> > > reproducer would be e.g.
> > > 
> > >   ip link add veth1 type veth peer name veth2
> > >   ethtool -s veth1 wol g
> > >   ip link del veth1
> > > 
> > > Make sure dev_put() is called when ethtool_ops check fails.  
> > 
> > Fixes: e54d04e3afea ("ethtool: set message mask with DEBUG_SET request")
> > Fixes: a53f3d41e4d3 ("ethtool: set link settings with LINKINFO_SET request")
> > Fixes: bfbcfe2032e7 ("ethtool: set link modes related data with LINKMODES_SET request")
> > Fixes: 8d425b19b305 ("ethtool: set wake-on-lan settings with WOL_SET request")  
> 
> Yes, thank you, I forgot about Fixes tags.
> 
> Should I resubmit or will patchworks pick the tags from your reply?

Patchwork sees them, I think, but I don't think it adds them to the
patch as downloaded by git-pw. Probably easiest to repost.

> > > Reported-by: Andrew Lunn <andrew@lunn.ch>
> > > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>  
> > 
> > Reviewed-by: Jakub Kicinski <kuba@kernel.org>  

