Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCFCC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D84208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="AYXh370S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgD2Qx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:53:26 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:49553 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726836AbgD2Qx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:53:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588179205; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=xhYN2QWZK+xOvZ83m2HJKcXlXIC6qwCWYYV5qQiwaZg=; b=AYXh370SCUTKre/ZEhlmwng9jPjPGDUo2SsRllMjTdar7PAHLm7snF88xbeyu3ANHMexqqpM
 mAujGqMjbttJXQCRlHC7Ea3ogGwEfX2IDlbrormGnrku7IHu/7MmMXbB5gL0eVbcBgwvRakH
 tnBVWnrI6F3ZEv3NRD+LJVpZ+cM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea9b0f0.7fe0ab509f10-smtp-out-n04;
 Wed, 29 Apr 2020 16:53:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14586C433CB; Wed, 29 Apr 2020 16:53:04 +0000 (UTC)
Received: from [192.168.0.102] (unknown [183.83.143.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EAB0C433D2;
        Wed, 29 Apr 2020 16:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EAB0C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: Avoid double lock for cp_rwsem during
 checkpoint
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <07a820a2-b3b3-32ca-75ce-ceaca106d2c6@web.de>
 <433d4ad5-22e5-fd2b-cab3-9752ed0c66fb@codeaurora.org>
 <20200429124402.GP2014@kadam>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <71c37cbb-03cd-134f-8b68-cf06bfa05317@codeaurora.org>
Date:   Wed, 29 Apr 2020 22:22:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429124402.GP2014@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/29/2020 6:14 PM, Dan Carpenter wrote:
> On Wed, Apr 29, 2020 at 10:28:36AM +0530, Sayali Lokhande wrote:
>> Hi Markus
>>
>> On 4/27/2020 4:08 PM, Markus Elfring wrote:
>>>> … This results in deadlock as
>>>> iput() tries to hold cp_rwsem, which is already held at the
>>>> beginning by checkpoint->block_operations().
>>> Will another imperative wording become helpful besides the provided information
>>> for this change description?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=6a8b55ed4056ea5559ebe4f6a4b247f627870d4c#n151
>>>
>>> Would you like to add the tag “Fixes” because of adjustments
>>> for the data synchronisation?
>> I couldn't find any past commit which suits to be added under "Fixes" here.
>> Let me know if you have any other comment.
> This looks really old.  Maybe commit 399368372ed9 ("f2fs: introduce a
> new global lock scheme")?
Yes. Let me update it in Fixes tag in V3 and post it. Thanks for 
pointing it.
>
> regards,
> dan carpenter
>
