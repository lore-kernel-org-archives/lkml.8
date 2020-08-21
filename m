Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C55C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED8420702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgHUHa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:30:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726864AbgHUHa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:30:27 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 484C6D3BA6AE77980649;
        Fri, 21 Aug 2020 08:30:26 +0100 (IST)
Received: from [127.0.0.1] (10.47.8.200) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 21 Aug
 2020 08:30:25 +0100
From:   John Garry <john.garry@huawei.com>
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Keith Busch <kbusch@kernel.org>
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
 <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
 <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
 <20200820170729.GA4116@lx-t490>
 <83a3d1b6-1eb5-859b-3c5c-287d8d18a99b@kernel.dk>
 <20200820171214.GA15207@infradead.org>
Message-ID: <cd34f822-3f9d-80d1-f656-24f8cdeae42d@huawei.com>
Date:   Fri, 21 Aug 2020 08:28:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200820171214.GA15207@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.200]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2020 18:12, Christoph Hellwig wrote:
> On Thu, Aug 20, 2020 at 11:10:58AM -0600, Jens Axboe wrote:
>> To be fair, I've only heard this one complaint about it, so hopefully it's
>> not too widespread. I'm on an x86-64 laptop myself with nvme, and it works
>> just fine:-)
> The cause for this is the weird NVMe of by ones, where 0 in a field
> means 1.

I thought that this was a common trick by spec writers to fit a number 
in range (0, 2^x] in x bits (as opposed to x+1).
