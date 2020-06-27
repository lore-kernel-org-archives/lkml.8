Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5632CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 02:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E0120720
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 02:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgF0CLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 22:11:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2551 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbgF0CLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 22:11:37 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id DEF4C21CB25F7E0F9FE4;
        Sat, 27 Jun 2020 10:11:35 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 27 Jun 2020 10:11:35 +0800
Received: from [10.174.61.242] (10.174.61.242) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 27 Jun 2020 10:11:35 +0800
Subject: Re: [PATCH net-next v2 5/5] hinic: add support to get eeprom
 information
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
References: <20200623142409.19081-1-luobin9@huawei.com>
 <20200623142409.19081-6-luobin9@huawei.com>
 <20200623150233.440583b8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   "luobin (L)" <luobin9@huawei.com>
Message-ID: <6bfe95da-7166-d141-235b-2b7ab4b88b43@huawei.com>
Date:   Sat, 27 Jun 2020 10:11:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200623150233.440583b8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.61.242]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/24 6:02, Jakub Kicinski wrote:
> On Tue, 23 Jun 2020 22:24:09 +0800 Luo bin wrote:
>> +int hinic_get_sfp_type(struct hinic_hwdev *hwdev, u8 *data0, u8 *data1)
>> +{
>> +	u8 sfp_data[STD_SFP_INFO_MAX_SIZE];
>> +	u16 len;
>> +	int err;
>> +
>> +	if (!hwdev || !data0 || !data1)
>> +		return -EINVAL;
> 
> No need to check these, callers are correct. We don't do defensive
> programming in the kernel.
> 
Will fix. Thank you for your review.
>> +	return  0;
> 
> double space
Will fix. Thank you for your review.

