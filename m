Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B24FC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB9420675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgCIHip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:38:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbgCIHip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:38:45 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9AFAC3E34ED54075E5DE;
        Mon,  9 Mar 2020 15:38:39 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.205) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Mar 2020
 15:38:30 +0800
Subject: Re: [PATCH] kretprobe: check re-registration of the same kretprobe
 earlier
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <xiexiuqi@huawei.com>,
        <bobo.shaobowang@huawei.com>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>
References: <1583487306-81985-1-git-send-email-cj.chengjian@huawei.com>
 <20200307002115.b96be2310cc553a922e1ba31@kernel.org>
 <9b122a6f-f5fa-3eb4-4fd7-f101b8aec205@huawei.com>
 <20200307185439.9e88f3c8b55a3f11923ea694@kernel.org>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <d5343941-b483-679e-d0f9-09793fa51200@huawei.com>
Date:   Mon, 9 Mar 2020 15:38:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307185439.9e88f3c8b55a3f11923ea694@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.133.217.205]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/3/7 17:54, Masami Hiramatsu wrote:
> Ah, I see. I thought that you said ri is use-after-free, but in reality,
> rp is use-after-free (use-after-init). OK.
>
>> And the problem here is destructive, it destroyed all the data of the
>> previously registered kretprobe,
>> it can lead to a system crash, memory leak, use-after-free and even some
>> other unexpected behavior.
> Yes, so I think we should do
>
> +	/* Return error if it's being re-registered */
> +	ret = check_kprobe_rereg(&rp->kp);
> +	if (WARN_ON(ret))
> +		return ret;
>
> This will give a warning message to the developer.
>
> Thank you,

OK, I will add the WARN_ON in V2.

Thank you.


----Cheng Jian


