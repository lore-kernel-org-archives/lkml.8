Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E96EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9042072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nnz1DA/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHUT66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:58:58 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8979 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgHUT64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:58:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4027710001>; Fri, 21 Aug 2020 12:58:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 12:58:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Aug 2020 12:58:55 -0700
Received: from [10.2.94.162] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Aug
 2020 19:58:55 +0000
Subject: Re: [GIT PULL] tee subsystem pin_user_pages for v5.8
To:     Olof Johansson <olof@lixom.net>,
        Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
CC:     <arm@kernel.org>, <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <tee-dev@lists.linaro.org>
References: <20200526131259.GA97001@jade> <20200821184910.GB3407@lx2k>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f7c8bb6e-e732-2565-8b50-20f5504701c9@nvidia.com>
Date:   Fri, 21 Aug 2020 12:58:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821184910.GB3407@lx2k>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598039921; bh=931QlgWgkSLnaXy3M6zhhPT2hTM3lsmrxSz7sNfiqzM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nnz1DA/cKW4KvK7uDJzLxRuIqIXK+DuN9tuKtlC5zqI3Y03Xe4x0V7/obhtO9LINQ
         bPzqUheBtXuKWJL4qJNiCC56pkkMFxkQ5055n1AvEYyrDCGeDs1IeOzCFnLmwtYMN1
         vkRAme4qWDo9m3P6sYPYlAy48DmSMjA8V4yhSfkqJm5EENV9HSZ/razc0w8lVxqU30
         PPZqQhh0tXpe5McsFrTs2uReW5ouYPhW1YXZMP0kEzcZZRws8X7ar1YS76zNH9yDXt
         JP7HNZk2aWlBGMybHSAo4WuO3vUcf2H9IBZci8IYgRNO4irVpziG49BUtHJPY6JqRe
         679ahwfMrEgkQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/20 11:49 AM, Olof Johansson wrote:
> On Tue, May 26, 2020 at 03:12:59PM +0200, Jens Wiklander wrote:
>> Hello arm-soc maintainers,
>>
>> Please pull this small patch converting the tee subsystem to use
>> pin_user_pages() instead of get_user_pages().
>>
>> Thanks,
>> Jens
>>
>> The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
>>
>>    Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
>>
>> are available in the Git repository at:
>>
>>    git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-pin-user-pages-for-5.8
>>
>> for you to fetch changes up to 37f6b4d5f47b600ec4ab6682c005a44a1bfca530:
>>
>>    tee: convert get_user_pages() --> pin_user_pages() (2020-05-26 10:42:41 +0200)
> 
> Hi, I noticed this never got merged, but I don't see any follow-up here that
> retracts it. Is it still pending merge such that I should queue it for v5.10?
> 

I think so. I had marked it in my notes as "accepted, and the maintainer will
eventually merge it", and I left it at that. It's still desirable.

thanks,
-- 
John Hubbard
NVIDIA
