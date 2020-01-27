Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C68CC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF562168B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgA0J5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:57:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:52790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbgA0J5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:57:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BA7D2AED6;
        Mon, 27 Jan 2020 09:57:47 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 0B68EE0B78; Mon, 27 Jan 2020 10:57:44 +0100 (CET)
Date:   Mon, 27 Jan 2020 10:57:44 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, kuba@kernel.org, jiri@resnulli.us,
        andrew@lunn.ch, f.fainelli@gmail.com, linville@tuxdriver.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] ethtool netlink interface, part 2
Message-ID: <20200127095744.GG570@unicorn.suse.cz>
References: <cover.1580075977.git.mkubecek@suse.cz>
 <20200127.104049.2252228859572866640.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127.104049.2252228859572866640.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 10:40:49AM +0100, David Miller wrote:
> From: Michal Kubecek <mkubecek@suse.cz>
> Date: Sun, 26 Jan 2020 23:10:58 +0100 (CET)
> 
> > This shorter series adds support for getting and setting of wake-on-lan
> > settings and message mask (originally message level). Together with the
> > code already in net-next, this will allow full implementation of
> > "ethtool <dev>" and "ethtool -s <dev> ...".
> > 
> > Older versions of the ethtool netlink series allowed getting WoL settings
> > by unprivileged users and only filtered out the password but this was
> > a source of controversy so for now, ETHTOOL_MSG_WOL_GET request always
> > requires CAP_NET_ADMIN as ETHTOOL_GWOL ioctl request does.
> 
> It looks like this will need to be respun at least once, and net-next
> is closing today so....

The problem with ethnl_parse_header() name not making it obvious that it
takes a reference is not introduced in this series, the function is
already in net-next so that it does not matter if this series is merged
or not. Other than that, there is only the missing "the" in
documentation.

Michal
