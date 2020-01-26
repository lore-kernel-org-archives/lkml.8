Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE99C35240
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 23:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1235A2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 23:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jPHrUIOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgAZXfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 18:35:02 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55020 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgAZXfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 18:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eP1QHin6WcwPywRr0JnrTc+g/xaEK5RZqlnAvQ7pZhg=; b=jPHrUIOr/EGmhAbALC6PCiiOsi
        66fxc4sxqlsjYfIsNIfCxFR5WpPLxQqUrVC+HfQbO/jr1GEvw81mK8nZBesFIR4cTNKQiN+BSoriU
        WIXK3Pu8zAHlfRAP1lP3GzfbIfkM8h1tv3S3FcIMwiTEh8vzpoHDCuIvV9w6t5Z0Yigk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1ivrQW-0003Wz-Q9; Mon, 27 Jan 2020 00:34:48 +0100
Date:   Mon, 27 Jan 2020 00:34:48 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] ethtool netlink interface, part 2
Message-ID: <20200126233448.GA12816@lunn.ch>
References: <cover.1580075977.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1580075977.git.mkubecek@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 11:10:58PM +0100, Michal Kubecek wrote:
> This shorter series adds support for getting and setting of wake-on-lan
> settings and message mask (originally message level). Together with the
> code already in net-next, this will allow full implementation of
> "ethtool <dev>" and "ethtool -s <dev> ...".

Hi Michal

It is nice to see more of this work being posted. But what about the
user space side? Do you plan to post that soon?

Thanks
	Andrew
