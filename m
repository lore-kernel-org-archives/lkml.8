Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59450C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C866206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgH1DVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 23:21:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbgH1DVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:21:46 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 229623A5125A796D7393;
        Fri, 28 Aug 2020 11:16:22 +0800 (CST)
Received: from [10.174.61.242] (10.174.61.242) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 28 Aug 2020 11:16:22 +0800
Subject: Re: [PATCH net-next v1 3/3] hinic: add support to query function
 table
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <chiqijun@huawei.com>
References: <20200827111321.24272-1-luobin9@huawei.com>
 <20200827111321.24272-4-luobin9@huawei.com>
 <20200827124404.496ff40b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   "luobin (L)" <luobin9@huawei.com>
Message-ID: <ef510fbe-8b73-a50e-445f-2b3771072529@huawei.com>
Date:   Fri, 28 Aug 2020 11:16:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200827124404.496ff40b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.61.242]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/28 3:44, Jakub Kicinski wrote:
> On Thu, 27 Aug 2020 19:13:21 +0800 Luo bin wrote:
>> +	switch (idx) {
>> +	case VALID:
>> +		return funcfg_table_elem->dw0.bs.valid;
>> +	case RX_MODE:
>> +		return funcfg_table_elem->dw0.bs.nic_rx_mode;
>> +	case MTU:
>> +		return funcfg_table_elem->dw1.bs.mtu;
>> +	case VLAN_MODE:
>> +		return funcfg_table_elem->dw1.bs.vlan_mode;
>> +	case VLAN_ID:
>> +		return funcfg_table_elem->dw1.bs.vlan_id;
>> +	case RQ_DEPTH:
>> +		return funcfg_table_elem->dw13.bs.cfg_rq_depth;
>> +	case QUEUE_NUM:
>> +		return funcfg_table_elem->dw13.bs.cfg_q_num;
> 
> The first two patches look fairly unobjectionable to me, but here the
> information does not seem that driver-specific. What's vlan_mode, and
> vlan_id in the context of PF? Why expose mtu, is it different than
> netdev mtu? What's valid? rq_depth?
> .
> 
The vlan_mode and vlan_id in function table are provided for VF in QinQ scenario
and they are useless for PF. Querying VF's function table is unsupported now, so
there is no need to expose vlan_id and vlan mode and I'll remove them in my next
patchset. The function table is saved in hw and we expose the mtu to ensure the
mtu saved in hw is same with netdev mtu. The valid filed indicates whether this
function is enabled or not and the hw can judge whether the RQ buffer in host is
sufficient by comparing the values of rq depth, pi and ci.


