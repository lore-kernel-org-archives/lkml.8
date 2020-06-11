Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB5DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3EEE2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Dgncx6iP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFKXYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:24:43 -0400
Received: from ale.deltatee.com ([204.191.154.188]:32822 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgFKXYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ydIwmO/MULXPi8rtCPZ4Y4iv1RxHiR6w0Bg9uL3/YFM=; b=Dgncx6iPntPq8HtqqejEi5/6VL
        c9GevrXRwO+Gny+oYsMDG38XmZ7bRTG60VEiUx7rvV9NN2AcJLKoOkGlOaN17uY4bOHv0oozYWMca
        r11OeRcaQiojGqYHSWnWcRAAa0NC2nIu70NpFnJFCO05piUq03PtcvcaOHA5bWP3Y3euZTNt3GqcU
        z7Wxr3jJxz+q7XTrbMDoHFX2GiFQWlkIMmwLoAYiK/hQ/IQVwxKkAbNPjiy+wx9SENQmt4OrlSs1K
        jHYXDvwF8fUm0GuS8URSrMn05lhJi5iuw+iEZeCM59WnM1PyDSVuKn3ECVc+Z9X9BDUAWG/EDlVSb
        tiwc8gxw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jjWYh-0001zn-4i; Thu, 11 Jun 2020 17:24:32 -0600
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-9-logang@deltatee.com>
 <BYAPR04MB496581334E89E2E3086C268286800@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <078ffd88-d2f9-bfa1-5a81-97abe0b66653@deltatee.com>
Date:   Thu, 11 Jun 2020 17:24:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496581334E89E2E3086C268286800@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v13 8/9] nvmet-passthru: Add enable/disable helpers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-06-11 5:13 p.m., Chaitanya Kulkarni wrote:
> On 5/14/20 10:23 AM, Logan Gunthorpe wrote:
>> +	if (subsys->ver < NVME_VS(1, 2, 1)) {
>> +		pr_warn("nvme controller version is too old: %d.%d.%d, advertising 1.2.1\n",
> Is it more than 80 char ? can it be ?
>                   pr_warn("nvme controller version is too old: ");
>                   pr_warn("%d.%d.%d, advertising 1.2.1\n",

Splitting printks is a bad idea because they won't necessarily end up in
dmesg right next to each other -- other prints can be interleaved.
Moreover, it breaks any tools that are dealing with kernel logs as
single records (ie through /dev/kmsg). Continuations (or printks without
a trailing "\n") would require using pr_cont() and generally that's
discouraged.

>> +			(int)NVME_MAJOR(subsys->ver),
>> +			(int)NVME_MINOR(subsys->ver),
>> +			(int)NVME_TERTIARY(subsys->ver));
>> +		subsys->ver = NVME_VS(1, 2, 1);
>> +	}
> 
> NVMe blktests are running on QEMU based controller. This will generate 
> warning every-time.

Yup.

> Also, I didn't understand int type cast, I wonder under what condition 
> all these macros will return -ve values since ver of type u64 ?

Yes, I'm not sure what I was thinking when I put in the cast. Probably
better just to prints "%llu". I'll fix this for the next revision.

Thanks,

Logan
