Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F979C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090312074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ZUkJgIb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgFKXPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:15:02 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60884 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgFKXPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rIUgVXxvzfu5SKxDzXpSuKU5d3tG9aRNXyTtF3+t6ng=; b=ZUkJgIb23p8Muz3mTI1uxW06AC
        ly+hkxXBSh+nnVOogG5wTHatZBMHbhnVLG4zhP8efP8FPZ0iXiFOMxV8Z/aBrBx27j7m1PacFqQPV
        T/aQ+hCUzqDP24QoJsARjin7+hCSeLTWDRRZTi/eYaHyXGHiS+XWGWY/UZ/BgbcK5BhJ45clbiwCZ
        mWfuIWXkrfuKxpiMQnt7qOEGlUyDCwHQLpKZOQ+Ox6Kt5RCCAurwpp614a4pUyHCf/AtRLG+g+brx
        dnVHGevGM5lEKLzDUCUOFqsWvBTZgIPn54U9982w9RU2xIEY3ba5Ml8IM8eYC7Fvg8MCn7ath7qBT
        eHvQpJ0Q==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jjWPN-0001pB-PY; Thu, 11 Jun 2020 17:14:55 -0600
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-9-logang@deltatee.com>
 <BYAPR04MB4965E830CF6FDEE90FBC950B86800@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <36ea5fb0-ff95-fa27-0659-84c91f6b0587@deltatee.com>
Date:   Thu, 11 Jun 2020 17:14:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965E830CF6FDEE90FBC950B86800@BYAPR04MB4965.namprd04.prod.outlook.com>
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



On 2020-06-11 5:05 p.m., Chaitanya Kulkarni wrote:
> On 5/14/20 10:23 AM, Logan Gunthorpe wrote:
>> +	if (subsys->nr_namespaces) {
>> +		pr_info("cannot enable both passthru and regular namespaces for a single subsystem");
> 
> Let's try and keep the error message witin 80 char per line or split the
> message into two pr_info() calls,how about this ?
> 
> 
> pr_info("cannot enable passthru & regular namespaces\n")

Honestly, I think that is too brief. The error message is only 74 chars
and there's a long standing exception for long lines in the kernel for
printks. Even Linus has recently suggested that keeping to the 80 char
limit is not recommended when it harms readability (though I don't
generally agree with this 100%)[1].

Logan

[1]
https://lwn.net/ml/linux-kernel/CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com/
