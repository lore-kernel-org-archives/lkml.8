Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A4BC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4304720781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgDWMIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:08:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgDWMIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:08:11 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 4EB3F4144C2054E3DE59;
        Thu, 23 Apr 2020 20:08:09 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 23 Apr 2020 20:08:08 +0800
Received: from [10.173.219.71] (10.173.219.71) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 23 Apr 2020 20:08:08 +0800
Subject: Re: [PATCH net-next 1/3] hinic: add mailbox function support
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
References: <20200421045635.8128-1-luobin9@huawei.com>
 <20200421045635.8128-2-luobin9@huawei.com>
 <20200421111352.263c7cbb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   "luobin (L)" <luobin9@huawei.com>
Message-ID: <7efeca68-004b-8b2a-eef1-ce62b3307386@huawei.com>
Date:   Thu, 23 Apr 2020 20:08:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200421111352.263c7cbb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.173.219.71]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your review. Will fix.

On 2020/4/22 2:13, Jakub Kicinski wrote:
> On Tue, 21 Apr 2020 04:56:33 +0000 Luo bin wrote:
>> virtual function and physical function can communicate with each
>> other through mailbox channel supported by hw
>>
>> Signed-off-by: Luo bin <luobin9@huawei.com>
>> +static int recv_vf_mbox_handler(struct hinic_mbox_func_to_func *func_to_func,
>> +				struct hinic_recv_mbox *recv_mbox,
>> +				void *buf_out, u16 *out_size)
>> +{
>> +	hinic_vf_mbox_cb cb;
>> +	int ret = 0;
>> +
>> +	if (recv_mbox->mod >= HINIC_MOD_MAX) {
>> +		dev_err(&func_to_func->hwif->pdev->dev, "Receive illegal mbox message, mod = %d\n",
>> +			recv_mbox->mod);
> You may want to rate limit these, otherwise VF may spam PFs logs.
>
>> +		return -EINVAL;
>> +	}
>> +static int mbox_func_params_valid(struct hinic_mbox_func_to_func *func_to_func,
>> +				  void *buf_in, u16 in_size)
>> +{
>> +	if (!buf_in || !in_size)
>> +		return -EINVAL;
> This is defensive programming, we don't do that in the kernel, callers
> should not pass NULL buffer and 0 size.
>
> Also you probably want the size to be size_t, otherwise it may get
> truncated before the check below.
>
>> +	if (in_size > HINIC_MBOX_DATA_SIZE) {
>> +		dev_err(&func_to_func->hwif->pdev->dev,
>> +			"Mbox msg len(%d) exceed limit(%d)\n",
>> +			in_size, HINIC_MBOX_DATA_SIZE);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int hinic_mbox_to_pf(struct hinic_hwdev *hwdev,
>> +		     enum hinic_mod_type mod, u8 cmd, void *buf_in,
>> +		     u16 in_size, void *buf_out, u16 *out_size, u32 timeout)
>> +{
>> +	struct hinic_mbox_func_to_func *func_to_func = hwdev->func_to_func;
>> +	int err = mbox_func_params_valid(func_to_func, buf_in, in_size);
>> +
>> +	if (err)
>> +		return err;
>> +
>> +	if (!HINIC_IS_VF(hwdev->hwif)) {
>> +		dev_err(&hwdev->hwif->pdev->dev, "Params error, func_type: %d\n",
>> +			HINIC_FUNC_TYPE(hwdev->hwif));
>> +		return -EINVAL;
>> +	}
>> +
>> +	err = hinic_mbox_to_func(func_to_func, mod, cmd,
>> +				 hinic_pf_id_of_vf_hw(hwdev->hwif), buf_in,
>> +				 in_size, buf_out, out_size, timeout);
>> +	return err;
> return hinic_mbox_to...
>
> directly
>
>> +}
>> +static int comm_pf_mbox_handler(void *handle, u16 vf_id, u8 cmd, void *buf_in,
>> +				u16 in_size, void *buf_out, u16 *out_size)
>> +{
>> +	struct hinic_hwdev *hwdev = handle;
>> +	struct hinic_pfhwdev *pfhwdev;
>> +	int err = 0;
>> +
>> +	pfhwdev = container_of(hwdev, struct hinic_pfhwdev, hwdev);
>> +
>> +	if (cmd == HINIC_COMM_CMD_START_FLR) {
>> +		*out_size = 0;
>> +	} else {
>> +		err = hinic_msg_to_mgmt(&pfhwdev->pf_to_mgmt, HINIC_MOD_COMM,
>> +					cmd, buf_in, in_size, buf_out, out_size,
>> +					HINIC_MGMT_MSG_SYNC);
>> +		if (err  && err != HINIC_MBOX_PF_BUSY_ACTIVE_FW)
> Double space, please run checkpatch --strict on the patches
>
>> +			dev_err(&hwdev->hwif->pdev->dev,
>> +				"PF mbox common callback handler err: %d\n",
>> +				err);
>> +	}
>> +
>> +	return err;
>> +}
> .
