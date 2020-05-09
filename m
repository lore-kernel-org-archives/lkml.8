Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8455C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2B1218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588993808;
	bh=muav7Ku8FbSohuOtsWfx+tFi4SClKLm/qhnXr9ZhIVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KLkRhqu0yiDZoXMizZ9WvArZGBQw+vgzHHe/VdQpmvwJ7cQ0Ip3Uh1gAZqvSyXxGV
	 VUIFjnifu7veIbsG69lVF52S0+a3rY9+a5qrAKtavNjDI0qhk3Wv58DveUjXwfi/vh
	 wgH15hf8ZD2SeILA3ugskt1xCf6wmuoUCWzp85wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgEIDKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 23:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbgEIDKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 23:10:07 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ABA9216FD;
        Sat,  9 May 2020 03:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588993806;
        bh=muav7Ku8FbSohuOtsWfx+tFi4SClKLm/qhnXr9ZhIVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rao5aE9d1L3JuJRkP8qJ0JsHHgrNt2zaHB65rM5qJs3ncfsOzoW62rs63Ms988lnW
         MoBX8Fd1hzZE8az2VHCfzv90Je4VGL37PRh8zhR0UkC9YSQIgj8YX1KghjIkGm+Xd0
         9yDyG131HhI7A34i6iXT2scq+ZhqGFsjw+tm4Rt8=
Date:   Fri, 8 May 2020 20:10:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "luobin (L)" <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
Subject: Re: [PATCH net-next v1] hinic: add three net_device_ops of vf
Message-ID: <20200508201004.0e2dc608@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <5253fd74-220d-d841-2bba-e9af98dbb1ba@huawei.com>
References: <20200507182119.20494-1-luobin9@huawei.com>
        <20200508144956.19d2af7c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <5253fd74-220d-d841-2bba-e9af98dbb1ba@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020 10:56:55 +0800 luobin (L) wrote:
> >> -	if (!HINIC_IS_VF(nic_dev->hwdev->hwif))
> >> -		/* Wait up to 3 sec between port enable to link state */
> >> -		msleep(3000);  
> > Why is this no longer needed?
> > ---When phsical port links up, hw will notify this event to hinic driver.Driver code can  
> 
> handle this event now, so need to wait for link up in hinic_open().

Makes sense.
