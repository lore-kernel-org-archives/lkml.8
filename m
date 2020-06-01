Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FC8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5207520734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgFAEyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 00:54:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:58498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFAEyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 00:54:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EFA63AE6E;
        Mon,  1 Jun 2020 04:54:14 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id C97FA6045E; Mon,  1 Jun 2020 06:54:11 +0200 (CEST)
Date:   Mon, 1 Jun 2020 06:54:11 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     netdev@vger.kernel.org
Cc:     Luo bin <luobin9@huawei.com>, davem@davemloft.net,
        linux-kernel@vger.kernel.org, luoxianjun@huawei.com,
        yin.yinshi@huawei.com, cloud.wangxiaoyun@huawei.com
Subject: Re: [PATCH net-next v4] hinic: add set_channels ethtool_ops support
Message-ID: <20200601045411.6hgos2pyxum4o2sd@lion.mk-sys.cz>
References: <20200601094206.20785-1-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601094206.20785-1-luobin9@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 09:42:06AM +0000, Luo bin wrote:
> add support to change TX/RX queue number with ethtool -L ethx combined
> 
> Signed-off-by: Luo bin <luobin9@huawei.com>
> ---
[...]

The patch looks correct but I'm not sure how is this change

> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
> index 4c66a0bc1b28..6da761d7a6ef 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
> @@ -470,6 +470,11 @@ netdev_tx_t hinic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
>  	struct hinic_txq *txq;
>  	struct hinic_qp *qp;
>  
> +	if (unlikely(!netif_carrier_ok(netdev))) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
> +
>  	txq = &nic_dev->txqs[q_id];
>  	qp = container_of(txq->sq, struct hinic_qp, sq);
>  

related to the rest. It rather looks as a fix/workaround for a race
condition you encountered while testing it but which could also happen
under other circumstances.

Michal
