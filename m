Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD444C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62DF2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HeZ0cUBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgIAAF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 20:05:27 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14530 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIAAFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:05:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d90160002>; Mon, 31 Aug 2020 17:04:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 17:05:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 31 Aug 2020 17:05:24 -0700
Received: from [10.2.61.194] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Sep
 2020 00:05:22 +0000
Subject: Re: [linux-next PATCH v3] drivers/virt/fsl_hypervisor: Fix error
 handling path
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <timur@freescale.com>,
        <galak@kernel.crashing.org>, <linux-kernel@vger.kernel.org>
References: <1598911668-6178-1-git-send-email-jrdr.linux@gmail.com>
 <CAFqt6zaAWL-f9YnosMhy7oOh8wT48cPSrhrwxn4qGPspvFz-=w@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <d6df3303-8580-d806-3941-0561a20d5b97@nvidia.com>
Date:   Mon, 31 Aug 2020 17:05:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zaAWL-f9YnosMhy7oOh8wT48cPSrhrwxn4qGPspvFz-=w@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598918678; bh=agNV2Aylb9h3c45mVq/weENCCNhsN69VCA7wrvLO6ec=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HeZ0cUBkFN0XbbqhmMq+zXg6t0cLRjCSHzfnWXDfNbcwkreFGOS9dlC0X3fiTZTqW
         o8IIYvf32fykVki9dKCbu8Nu7FWkfn2dSuTvIe3zHaB1l9kDMkMtr2efjyB8wZo1AB
         dPh/bRkx2gl/nd3+nIqPX0RQ+OaAvLP7ok36ET6k1XVmUGPK7jprwrhRAxzADEnd+B
         zfRTzY3RUn7jCg/HibwU1hEBL84NDIPgcViclhbVrVLZdlWXyLEVFxq7+rBbnY1gG7
         ql6F/c9wySqswiX4F9Oj73f+vXdKcMmGHIYb1rO51oGtAKpITr480Of5oq0nw2jSsR
         2K1Lkupbtswrw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/20 3:10 PM, Souptick Joarder wrote:
> Hi John,
> 
> On Tue, Sep 1, 2020 at 3:38 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> First, when memory allocation for sg_list_unaligned failed, there
>> is a bug of calling put_pages() as we haven't pinned any pages.
>>
>> Second, if get_user_pages_fast() failed we should unpinned num_pinned
>> pages instead of checking till num_pages.
>>
>> This will address both.
>>
>> As part of these changes, minor update in documentation.
>>
>> Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor
>> management driver")
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 
> Few questions ->
> 
> First, there are minor updates from v2 -> v3 other than addressing your
> review comments in v2. Would you like to review it again?

I reviewed it again.

> 
> Second, I think, as per Documentation/core-api/pin_user_pages.rst,
> this is case 5.
> Shall I make the conversion as part of this series ?


Not entirely sure what you mean, but if you just want to add words to the
effect that "this is case 5" to the commit description I certainly don't
see why not. (It would be ideal for a domain expert to weigh in on the
cases here, too.)



thanks,
-- 
John Hubbard
NVIDIA
