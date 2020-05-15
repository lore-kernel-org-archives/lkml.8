Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7618EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504B420728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgEOT53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:57:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:45884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgEOT52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:57:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D612CB131;
        Fri, 15 May 2020 19:57:29 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id BD97C604B1; Fri, 15 May 2020 21:57:26 +0200 (CEST)
Date:   Fri, 15 May 2020 21:57:26 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     netdev@vger.kernel.org
Cc:     Luo bin <luobin9@huawei.com>, davem@davemloft.net,
        linux-kernel@vger.kernel.org, luoxianjun@huawei.com,
        yin.yinshi@huawei.com, cloud.wangxiaoyun@huawei.com
Subject: Re: [PATCH net-next] hinic: add set_channels ethtool_ops support
Message-ID: <20200515195726.GE21714@lion.mk-sys.cz>
References: <20200515003547.27359-1-luobin9@huawei.com>
 <20200515181330.GC21714@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515181330.GC21714@lion.mk-sys.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 08:13:30PM +0200, Michal Kubecek wrote:
[...]
> > +int hinic_set_channels(struct net_device *netdev,
> > +		       struct ethtool_channels *channels)
> > +{
> > +	struct hinic_dev *nic_dev = netdev_priv(netdev);
> > +	unsigned int count = channels->combined_count;
> > +	int err;
> > +
> > +	if (!count) {
> > +		netif_err(nic_dev, drv, netdev,
> > +			  "Unsupported combined_count: 0\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (channels->tx_count || channels->rx_count || channels->other_count) {
> > +		netif_err(nic_dev, drv, netdev,
> > +			  "Setting rx/tx/other count not supported\n");
> > +		return -EINVAL;
> > +	}
> 
> With max_* reported as 0, these will be caught in ethnl_set_channels()
> or ethtool_set_channels().
> 
> > +	if (!(nic_dev->flags & HINIC_RSS_ENABLE)) {
> > +		netif_err(nic_dev, drv, netdev,
> > +			  "This function doesn't support RSS, only support 1 queue pair\n");
> > +		return -EOPNOTSUPP;
> > +	}
> 
> I'm not sure if the request should fail even if requested count is
> actually 1.

Thinking about it again, as long as you report max_combined=1 in this
case, anything higher than 1 would be rejected by general ethtool code
and 0 is rejected by the first check above so that you can in fact only
get here for combined_count=1 - and only for ioctl requests as netlink
code path won't call the ethtool_ops callback if there is no change.

Michal
