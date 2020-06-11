Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7A9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186FE2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Y1cJBAK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgFKTTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:19:39 -0400
Received: from ale.deltatee.com ([204.191.154.188]:57866 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKTTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Iul3mhrear09phmCu8JOZ2yhnz8/T9YMeSEnL8Miao0=; b=Y1cJBAK8vNbryfPIus+U/Dma8B
        i9banNR5DsvyXjk4Tsu/Pdq2z1YMAZRkMwetYqGGCELrWYoUbzaurNF4w2d6qpznr/8sbiZjCZNUv
        S28/T6ox5aly2VhOIDJuARkPfJZMx6RxbyjwuFGLQwV/wAOFDo8rWC+JPzfnwT3wD4ZvQKQXia7fb
        jZn2LBT+g9zg28zvTzs5/kF+WNn6DazAyCLruKhMp14UK2xCMPFPzL02MbywHPyWkSblTtH4ffFSW
        w4PHDUQG+ZZO1TbwkzKyS+2kpivcHW2f2U7kXrM65CQhtJKG2gKUWF3K5GtqXY9Puab32WEnRZkUK
        o4AsM/dw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jjSjV-0004uU-IV; Thu, 11 Jun 2020 13:19:26 -0600
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <BYAPR04MB4965CEDB8E3AE4B7F4C527AF86800@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <973eb071-45ad-26f1-17d0-325d637a9750@deltatee.com>
Date:   Thu, 11 Jun 2020 13:19:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965CEDB8E3AE4B7F4C527AF86800@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v13 0/9] nvmet: add target passthru commands support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-06-11 1:16 p.m., Chaitanya Kulkarni wrote:
> On 5/14/20 10:23 AM, Logan Gunthorpe wrote:
>> This is v13 of the passthru patchset which is mostly a resend of v12
>> with Sagi's reviewed-by tags collected.
>>
>> Below, I'll reiterrate some points I made previously that haven't been
>> responded to:
>>
>> I don't think cloning the ctrl_id or the subsysnqn is a good idea.
>> I sent an email trying to explain why here[1] but there was no response.
>> In short, I think cloning the ctrl_id will break multipathing over
>> fabrics and copying the subsysnqn only has the effect of breaking
>> loopback; the user can always copy the underlying subsysnqn if it
>> makes sense for their overall system.
>>
>> I maintain overriding the CMIC bit in the ctrl id is necessary to
>> allow multipath over fabrics even if the underlying device did
>> not support multipath.
>>
>> I also think the black list for admin commands is appropriate, and I
>> added it based on Sagi's feedback[2]. There are plenty of commands that
>> may be dangerous like firmware update and format NVM commands, and NS
>> attach commands won't work out of the box because we don't copy the
>> ctrl_id. It seems like there's more commands to be careful of than ones
>> that are that are obviously acceptable. So, I think the prudent course
>> is blacklisting by default until someone has a usecase and can show
>> the command is safe seems and makes sense. For our present use cases,
>> the identify, log page and vendor specific commands are all that we
>> care about.
>>
>> A git branch is available here and is based on v5.7-rc5:
>>
>> https://github.com/sbates130272/linux-p2pmem  nvmet_passthru_v13
>>
>> [1]https://lore.kernel.org/linux-block/247eca47-c3bc-6452-fb19-f7aa27b05a60@deltatee.com/
>> [2]https://lore.kernel.org/linux-block/e4430207-7def-8776-0289-0d58689dc0cd@grimberg.me/
>>
>> --
>>
>> v13 Changes:
>>    1. Rebased onto v5.7-rc5
>>    2. Collected Sagi's Reviewed-by tags
> 
> Are you planning to send V14 based on nvme-5.9 branch ?
> 

I don't have any plans to yet, but I certainly can. I usually wait until
after the merge window to resend. I can certainly look at rebasing onto
nvme-5.9 for next time.

Logan
