Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62022C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0821020872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598635172;
	bh=alXfXWyjeCC+Y9Ph5sCPNsdaWdumqkWEgNkamywB1tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HlTKTqXuKCLHvixG69jfw98c9bP3bHGW5wnuueE6jfY55PwuKEDj8JDbrt+5JbEwM
	 OCiPpx25VBsxueryDIa8/E+/1ZBWGUQEU5qWIsGq9/S5qNX3weFtFjELIPzfOd7q/R
	 DY9QXDiTCOOLuYVdzcsEAYx22Ee9L0lqlTYsDQds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgH1RTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgH1RT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:19:27 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72F7D20848;
        Fri, 28 Aug 2020 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598635166;
        bh=alXfXWyjeCC+Y9Ph5sCPNsdaWdumqkWEgNkamywB1tc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UfZnx+gLqk5r6tBqGGGNmQyOoB57+KOZTJ8hZFY/o167swKJZlOOfEyyqihawwFWF
         9NvQxcv6YhbecnPPPTiaCBdNzkB9I+M9brO4j82H6hht0nxHwzVzVfPomjJhfkEAkE
         jIN80CXFvTvJbW/cj3rR729BUByTECidvBH6mzSs=
Date:   Fri, 28 Aug 2020 10:19:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "luobin (L)" <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <chiqijun@huawei.com>
Subject: Re: [PATCH net-next v1 3/3] hinic: add support to query function
 table
Message-ID: <20200828101924.30372b7e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <ef510fbe-8b73-a50e-445f-2b3771072529@huawei.com>
References: <20200827111321.24272-1-luobin9@huawei.com>
        <20200827111321.24272-4-luobin9@huawei.com>
        <20200827124404.496ff40b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <ef510fbe-8b73-a50e-445f-2b3771072529@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 11:16:22 +0800 luobin (L) wrote:
> On 2020/8/28 3:44, Jakub Kicinski wrote:
> > On Thu, 27 Aug 2020 19:13:21 +0800 Luo bin wrote:  
> >> +	switch (idx) {
> >> +	case VALID:
> >> +		return funcfg_table_elem->dw0.bs.valid;
> >> +	case RX_MODE:
> >> +		return funcfg_table_elem->dw0.bs.nic_rx_mode;
> >> +	case MTU:
> >> +		return funcfg_table_elem->dw1.bs.mtu;
> >> +	case VLAN_MODE:
> >> +		return funcfg_table_elem->dw1.bs.vlan_mode;
> >> +	case VLAN_ID:
> >> +		return funcfg_table_elem->dw1.bs.vlan_id;
> >> +	case RQ_DEPTH:
> >> +		return funcfg_table_elem->dw13.bs.cfg_rq_depth;
> >> +	case QUEUE_NUM:
> >> +		return funcfg_table_elem->dw13.bs.cfg_q_num;  
> > 
> > The first two patches look fairly unobjectionable to me, but here the
> > information does not seem that driver-specific. What's vlan_mode, and
> > vlan_id in the context of PF? Why expose mtu, is it different than
> > netdev mtu? What's valid? rq_depth?
> > .
> >   
> The vlan_mode and vlan_id in function table are provided for VF in QinQ scenario
> and they are useless for PF. Querying VF's function table is unsupported now, so
> there is no need to expose vlan_id and vlan mode and I'll remove them in my next
> patchset. The function table is saved in hw and we expose the mtu to ensure the
> mtu saved in hw is same with netdev mtu. The valid filed indicates whether this
> function is enabled or not and the hw can judge whether the RQ buffer in host is
> sufficient by comparing the values of rq depth, pi and ci.

Queue depth is definitely something we can add to the ethtool API.
You already expose raw producer and consumer indexes so the calculation
can be done, anyway.
