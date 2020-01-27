Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF89C35240
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 00:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC1820702
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 00:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5tv7xVan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgA0AWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 19:22:13 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55080 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgA0AWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 19:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9rUQVlLvGqFvHyfWHm2VLMp3C2XF+wuO1ILfr9Iv0Ik=; b=5tv7xVanXELUILmtsCOvn3L0k1
        2qVv+kH/AXtaitKkf7TaQdRBckW/G7TsVwwJWewduTVp81qsE9e9ITzzoUrQ0JwDPsFp8BVC1IFFK
        xRkEzKc9ecFFqT7sshZHdgu8wXXbOjlT4Vwv+5QNLuI567HqrN3saNsZAB3n6BSlXZzI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1ivsAI-0003gt-64; Mon, 27 Jan 2020 01:22:06 +0100
Date:   Mon, 27 Jan 2020 01:22:06 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/7] ethtool: set message mask with DEBUG_SET
 request
Message-ID: <20200127002206.GC12816@lunn.ch>
References: <cover.1580075977.git.mkubecek@suse.cz>
 <844bf6bf518640fbfc67b5dd7976d9e8683c2d2d.1580075977.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <844bf6bf518640fbfc67b5dd7976d9e8683c2d2d.1580075977.git.mkubecek@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 11:11:07PM +0100, Michal Kubecek wrote:
> Implement DEBUG_SET netlink request to set debugging settings for a device.
> At the moment, only message mask corresponding to message level as set by
> ETHTOOL_SMSGLVL ioctl request can be set. (It is called message level in
> ioctl interface but almost all drivers interpret it as a bit mask.)
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> +int ethnl_set_debug(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nlattr *tb[ETHTOOL_A_DEBUG_MAX + 1];
> +	struct ethnl_req_info req_info = {};
> +	struct net_device *dev;
> +	bool mod = false;
> +	u32 msg_mask;
> +	int ret;
> +
> +	ret = nlmsg_parse(info->nlhdr, GENL_HDRLEN, tb,
> +			  ETHTOOL_A_DEBUG_MAX, debug_set_policy,
> +			  info->extack);
> +	if (ret < 0)
> +		return ret;
> +	ret = ethnl_parse_header(&req_info, tb[ETHTOOL_A_DEBUG_HEADER],
> +				 genl_info_net(info), info->extack, true);
> +	if (ret < 0)
> +		return ret;
> +	dev = req_info.dev;
> +	if (!dev->ethtool_ops->get_msglevel || !dev->ethtool_ops->set_msglevel)
> +		return -EOPNOTSUPP;

This seems like a new requirement, that both get and set callbacks are
implemented. However, A quick look thought the code suggests all
drivers already do have both get and set. So i think this is safe.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
