Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D383C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 01:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB492070B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 01:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgGYBTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:19:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726777AbgGYBTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 21:19:50 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 0FCCDB8834938B0A3D5F;
        Sat, 25 Jul 2020 09:19:49 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 25 Jul 2020 09:19:48 +0800
Received: from [10.174.61.242] (10.174.61.242) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 25 Jul 2020 09:19:33 +0800
Subject: Re: [PATCH net-next v4 1/2] hinic: add support to handle hw abnormal
 event
To:     David Miller <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoxianjun@huawei.com>, <yin.yinshi@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>
References: <20200724091732.19819-1-luobin9@huawei.com>
 <20200724091732.19819-2-luobin9@huawei.com>
 <20200724.170415.1190789583922952011.davem@davemloft.net>
From:   "luobin (L)" <luobin9@huawei.com>
Message-ID: <aa6e490a-2c02-5deb-0df5-ed6dab0f7c8b@huawei.com>
Date:   Sat, 25 Jul 2020 09:19:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200724.170415.1190789583922952011.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.61.242]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/25 8:04, David Miller wrote:
> From: Luo bin <luobin9@huawei.com>
> Date: Fri, 24 Jul 2020 17:17:31 +0800
> 
>> +static int hinic_fw_reporter_dump(struct devlink_health_reporter *reporter,
>> +				  struct devlink_fmsg *fmsg, void *priv_ctx,
>> +				  struct netlink_ext_ack *extack)
>> +{
>> +	int err;
>> +
>> +	if (priv_ctx) {
>> +		err = mgmt_watchdog_report_show(fmsg, priv_ctx);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> As Edward Cree pointed out for v3 of this patch series, this 'err' is not
> necessary at all.
> .
> 
Will fix. Thanks.
