Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F74C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4BFD207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598557448;
	bh=/OMoWZDB19QXDd4Yva0fm4n58UX+rsvfXaW/xr4mTHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rdaL1gLMKiVP3Ve+FLoBbYGxOHdmSy7F1UGSIJ7v5efaqVZqknUykncIiWdCXC8eB
	 NC6Jmcu8md+MknIoIxYH76/VgdkiZl4WBCaBtr7xo+FvdGCcB4kfrGPENj/VqwXniT
	 8Ifa7V89Q4H661eltjcsP7yWOKNT47cFbNvLptzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgH0ToH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgH0ToG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:44:06 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4428920714;
        Thu, 27 Aug 2020 19:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598557446;
        bh=/OMoWZDB19QXDd4Yva0fm4n58UX+rsvfXaW/xr4mTHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k6m5ICIl9N4LyhjiH/JaX2g1nCkzDe4kqUvskX0jtsz3pFha4N+AxGQQ/f1PeV7X2
         OjsJi/7+nXMEgznOAbbzN6bIeH0qd96S+F/xNHWcSe2AdrnfQ4FSwTNQKOwSYmwGj8
         A0U5px6SOB7bNzaWPCgxaQ0d9hUQkcqVwke7BErk=
Date:   Thu, 27 Aug 2020 12:44:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <chiqijun@huawei.com>
Subject: Re: [PATCH net-next v1 3/3] hinic: add support to query function
 table
Message-ID: <20200827124404.496ff40b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200827111321.24272-4-luobin9@huawei.com>
References: <20200827111321.24272-1-luobin9@huawei.com>
        <20200827111321.24272-4-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 19:13:21 +0800 Luo bin wrote:
> +	switch (idx) {
> +	case VALID:
> +		return funcfg_table_elem->dw0.bs.valid;
> +	case RX_MODE:
> +		return funcfg_table_elem->dw0.bs.nic_rx_mode;
> +	case MTU:
> +		return funcfg_table_elem->dw1.bs.mtu;
> +	case VLAN_MODE:
> +		return funcfg_table_elem->dw1.bs.vlan_mode;
> +	case VLAN_ID:
> +		return funcfg_table_elem->dw1.bs.vlan_id;
> +	case RQ_DEPTH:
> +		return funcfg_table_elem->dw13.bs.cfg_rq_depth;
> +	case QUEUE_NUM:
> +		return funcfg_table_elem->dw13.bs.cfg_q_num;

The first two patches look fairly unobjectionable to me, but here the
information does not seem that driver-specific. What's vlan_mode, and
vlan_id in the context of PF? Why expose mtu, is it different than
netdev mtu? What's valid? rq_depth?
