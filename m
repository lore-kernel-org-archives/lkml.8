Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50C6C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A68320722
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584909840;
	bh=7uuqlv+KI6oHqzf5REliAD4qvrHfNNTC3/A5CRNxtlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uPWPH4pkaVWsv8aHQgA4Ee1MYaZ+xGh1dJGHl7N0NdNjGxpzN6SRExRAbMFzsnU8W
	 NsYSk9WhmOTtJkHx63m+s35kI88hzPvyjHGu739zPEWrE8TRFkXorMaJMOofuboWe1
	 g9hk8eW411yIUAzGWFgZQbHzBDlURRlkkwwhKREI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgCVUn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 16:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCVUn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 16:43:58 -0400
Received: from kicinski-fedora-PC1C0HJN (c-67-180-217-166.hsd1.ca.comcast.net [67.180.217.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DDCD20722;
        Sun, 22 Mar 2020 20:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584909838;
        bh=7uuqlv+KI6oHqzf5REliAD4qvrHfNNTC3/A5CRNxtlE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fjyxfmz64rth8we0JsUiekHM4GD0DLhWUaRV6MU4r5Vox8tMT+WoX4/vooS5/mCIO
         xu8pnawqRACqxCLyz4ivT+u7DOR6e+2BhQq3AuFzJwL0RVAk6ovIwqh14tU6Fl59PC
         lEQgMVqL6/4h8UWPI7nZr3y9JSDMgQKLBKin7Cc4=
Date:   Sun, 22 Mar 2020 13:43:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ethtool: fix reference leak in some *_SET handlers
Message-ID: <20200322134356.55f7d9b8@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20200322201551.E11BAE0FD3@unicorn.suse.cz>
References: <20200322201551.E11BAE0FD3@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Mar 2020 21:15:51 +0100 (CET) Michal Kubecek wrote:
> Andrew noticed that some handlers for *_SET commands leak a netdev
> reference if required ethtool_ops callbacks do not exist. A simple
> reproducer would be e.g.
> 
>   ip link add veth1 type veth peer name veth2
>   ethtool -s veth1 wol g
>   ip link del veth1
> 
> Make sure dev_put() is called when ethtool_ops check fails.

Fixes: e54d04e3afea ("ethtool: set message mask with DEBUG_SET request")
Fixes: a53f3d41e4d3 ("ethtool: set link settings with LINKINFO_SET request")
Fixes: bfbcfe2032e7 ("ethtool: set link modes related data with LINKMODES_SET request")
Fixes: 8d425b19b305 ("ethtool: set wake-on-lan settings with WOL_SET request")
 
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
