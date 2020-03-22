Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03378C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 21:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B7E206F9
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 21:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCVVZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 17:25:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:57224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgCVVZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 17:25:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A3A79AB7F;
        Sun, 22 Mar 2020 21:25:09 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 5698EE0FD3; Sun, 22 Mar 2020 22:25:09 +0100 (CET)
Date:   Sun, 22 Mar 2020 22:25:09 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ethtool: fix reference leak in some *_SET handlers
Message-ID: <20200322212509.GG31519@unicorn.suse.cz>
References: <20200322201551.E11BAE0FD3@unicorn.suse.cz>
 <20200322134356.55f7d9b8@kicinski-fedora-PC1C0HJN>
 <20200322205109.GF31519@unicorn.suse.cz>
 <20200322140623.633d3446@kicinski-fedora-PC1C0HJN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322140623.633d3446@kicinski-fedora-PC1C0HJN>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 02:06:23PM -0700, Jakub Kicinski wrote:
> On Sun, 22 Mar 2020 21:51:09 +0100 Michal Kubecek wrote:
> > On Sun, Mar 22, 2020 at 01:43:56PM -0700, Jakub Kicinski wrote:
> > > On Sun, 22 Mar 2020 21:15:51 +0100 (CET) Michal Kubecek wrote:  
> > > > Andrew noticed that some handlers for *_SET commands leak a netdev
> > > > reference if required ethtool_ops callbacks do not exist. A simple
> > > > reproducer would be e.g.
> > > > 
> > > >   ip link add veth1 type veth peer name veth2
> > > >   ethtool -s veth1 wol g
> > > >   ip link del veth1
> > > > 
> > > > Make sure dev_put() is called when ethtool_ops check fails.  
> > > 
> > > Fixes: e54d04e3afea ("ethtool: set message mask with DEBUG_SET request")
> > > Fixes: a53f3d41e4d3 ("ethtool: set link settings with LINKINFO_SET request")
> > > Fixes: bfbcfe2032e7 ("ethtool: set link modes related data with LINKMODES_SET request")
> > > Fixes: 8d425b19b305 ("ethtool: set wake-on-lan settings with WOL_SET request")  
> > 
> > Yes, thank you, I forgot about Fixes tags.
> > 
> > Should I resubmit or will patchworks pick the tags from your reply?
> 
> Patchwork sees them, I think, but I don't think it adds them to the
> patch as downloaded by git-pw. Probably easiest to repost.

Sent v2 with Fixes and Reviewed-by tags.

Michal

> > > > Reported-by: Andrew Lunn <andrew@lunn.ch>
> > > > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>  
> > > 
> > > Reviewed-by: Jakub Kicinski <kuba@kernel.org>  
> 
