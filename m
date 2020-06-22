Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEF7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626FA2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592863680;
	bh=SSywIkWg6GWEBS3TWErUmWRYk7RPK2kD2HB2RH8xBB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wd2d7zMvsypUGkQmtCllfJZmBpp4JQrFaiQD+ZWM2mz3bxxwPFdLApD9v002s79g9
	 RsxvJ9Bg2j76vquauMJ9rHGUxqYHYThiUfmeeIM9U0fgWEeNEPeOL8ZtpWhyMCfSRZ
	 bOR5K4OTq5dIg/VsRkEDzCiFZK1YzANZUMUyT01I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgFVWH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgFVWH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:07:58 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF0320716;
        Mon, 22 Jun 2020 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592863678;
        bh=SSywIkWg6GWEBS3TWErUmWRYk7RPK2kD2HB2RH8xBB8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wa7YZQLqsODY9oz5q27T1BAr8MXyx2ZHpjj9kz0tF8kEJy7FvlKN0SFAMLOfpXrCg
         bKIEsbTek664Bd+NkKcfSZd0CUEZzI/hoxDzU8kXeUvgNBlm3loLFYenTFudM8W/cb
         SjIOLy8xwDJkZGO+SJOnKip1/8dYT1MPeIOQp328=
Date:   Mon, 22 Jun 2020 15:07:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
Subject: Re: [PATCH net-next v1 2/5] hinic: add support to set and get irq
 coalesce
Message-ID: <20200622150756.3624dab2@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20200620094258.13181-3-luobin9@huawei.com>
References: <20200620094258.13181-1-luobin9@huawei.com>
        <20200620094258.13181-3-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jun 2020 17:42:55 +0800 Luo bin wrote:
> @@ -1144,8 +1190,16 @@ static int nic_dev_init(struct pci_dev *pdev)
>  		goto err_reg_netdev;
>  	}
>  
> +	err = hinic_init_intr_coalesce(nic_dev);
> +	if (err) {
> +		netif_err(nic_dev, drv, netdev, "Failed to init_intr_coalesce\n");
> +		goto err_init_intr;
> +	}
> +
>  	return 0;
>  
> +err_init_intr:
> +	unregister_netdev(netdev);
>  err_reg_netdev:
>  err_set_features:
>  	hinic_hwdev_cb_unregister(nic_dev->hwdev,

A little suspicious - you should finish all init before device is
registered, once registered the interface can be immediately brought
up.
