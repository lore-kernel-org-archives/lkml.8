Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D216C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100A22173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588974600;
	bh=qkUTRLFzcDxgORfpd+BCzu4AQ/LotKSi2xDg0Aqh5Is=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MTj+cy/bTF2dAU0UkHPhLLWn08+qSYiAtmQwpQMjo/zaa8pCWYej02Dq4hJ+ZnDrM
	 ZJsW8ixUFjEUYcnlk/Esj05FS6718j19OBk0Jw5FcMB1tdAxm04FaMN1Icdvd7PsTe
	 jerDDclLywWHSKpb1s/AAmpgSO/mWY9PLiILY3zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEHVt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgEHVt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:49:58 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C703921655;
        Fri,  8 May 2020 21:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588974598;
        bh=qkUTRLFzcDxgORfpd+BCzu4AQ/LotKSi2xDg0Aqh5Is=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UHYOPg40kPT5bYMEEAeNbyA+aZeFkKmexvZ20xB9xEwmwkigFcWeY9vFrgfRa78aX
         adsRCEaL7y3uwSHoxmKkZi5+3EjYFlyWQwX9tlH9F1u+VOtoPOjHBu3Nt7ORDF4L7Y
         fwoj4ErTR6pTR+BWd6qE0lrR3KdUfv5QOkzkdfuw=
Date:   Fri, 8 May 2020 14:49:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
Subject: Re: [PATCH net-next v1] hinic: add three net_device_ops of vf
Message-ID: <20200508144956.19d2af7c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200507182119.20494-1-luobin9@huawei.com>
References: <20200507182119.20494-1-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 18:21:19 +0000 Luo bin wrote:
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
> index 564fb2294a29..bc2f87e6cb5d 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
> @@ -627,7 +627,7 @@ wait_for_mbox_seg_completion(struct hinic_mbox_func_to_func *func_to_func,
>  	struct hinic_hwdev *hwdev = func_to_func->hwdev;
>  	struct completion *done = &send_mbox->send_done;
>  	u32 cnt = 0;
> -	ulong jif;
> +	unsigned long jif;
>  
>  	if (poll) {
>  		while (cnt < MBOX_MSG_POLLING_TIMEOUT) {
> @@ -869,7 +869,7 @@ int hinic_mbox_to_func(struct hinic_mbox_func_to_func *func_to_func,
>  {
>  	struct hinic_recv_mbox *mbox_for_resp;
>  	struct mbox_msg_info msg_info = {0};
> -	ulong timeo;
> +	unsigned long timeo;
>  	int err;
>  
>  	mbox_for_resp = &func_to_func->mbox_resp[dst_func];

Unrelated cleanup.

> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
> index b66bb86cff96..3d6569d7bac8 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
> @@ -427,10 +427,6 @@ static int hinic_open(struct net_device *netdev)
>  		goto err_func_port_state;
>  	}
>  
> -	if (!HINIC_IS_VF(nic_dev->hwdev->hwif))
> -		/* Wait up to 3 sec between port enable to link state */
> -		msleep(3000);

Why is this no longer needed?

>  	down(&nic_dev->mgmt_lock);
>  
>  	err = hinic_port_link_state(nic_dev, &link_state);

> +	if (link_state == HINIC_LINK_STATE_DOWN) {
> +		netif_err(nic_dev, drv, netdev,
> +			  "Link status must be up when setting vf tx rate\n");
> +		return -EPERM;
> +	}

Does this also mean the configuration is lost if link goes down?
