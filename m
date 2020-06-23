Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C67C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E809C207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592949757;
	bh=7eJfE0siEUKsnDRAW9ZV6NcOIY7onZdbsXkDRT2g9WA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xN9K236HsFDmhGGskE6IBwTgzWLGryuk340vhsQ0y+KvZu0sC7PV7IN2xhGQ6Yo4l
	 gz1WZegRpaClmC8/PAYYSpr7c/LJG+7f278v1jVQhoEhmT1rQqAbsaxjZfI0s+Mn2/
	 NVBns7mqBV40gfJdZ+8vDudYKYT/AxOdV4estG9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbgFWWCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387860AbgFWWCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:02:35 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BA472078E;
        Tue, 23 Jun 2020 22:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592949754;
        bh=7eJfE0siEUKsnDRAW9ZV6NcOIY7onZdbsXkDRT2g9WA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P/6PjQSyv9vn9AD1Fm2m0GZB4FpQ5zu9rjETDTUjAjl5VrclzYcSeCQ2TVVnl42QA
         iaPa92PSv7oO+gPi7wtSo314vcJtq1wrGWmMwxPEOzsDby0oumampZCn50ijrbkG6M
         4nFuuW4sxdO/Fs6Z7Ze9b5njU5p9YcbtWiveN+KA=
Date:   Tue, 23 Jun 2020 15:02:33 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
Subject: Re: [PATCH net-next v2 5/5] hinic: add support to get eeprom
 information
Message-ID: <20200623150233.440583b8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200623142409.19081-6-luobin9@huawei.com>
References: <20200623142409.19081-1-luobin9@huawei.com>
        <20200623142409.19081-6-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 22:24:09 +0800 Luo bin wrote:
> +int hinic_get_sfp_eeprom(struct hinic_hwdev *hwdev, u8 *data, u16 *len)
> +{
> +	struct hinic_cmd_get_std_sfp_info sfp_info = {0};
> +	u16 out_size = sizeof(sfp_info);
> +	u8 port_id;
> +	int err;
> +
> +	if (!hwdev || !data || !len)
> +		return -EINVAL;

> +int hinic_get_sfp_type(struct hinic_hwdev *hwdev, u8 *data0, u8 *data1)
> +{
> +	u8 sfp_data[STD_SFP_INFO_MAX_SIZE];
> +	u16 len;
> +	int err;
> +
> +	if (!hwdev || !data0 || !data1)
> +		return -EINVAL;

No need to check these, callers are correct. We don't do defensive
programming in the kernel.

> +	return  0;

double space
