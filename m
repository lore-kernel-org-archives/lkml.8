Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73F0C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B8A20797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T2cUP7Az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgIEBVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 21:21:09 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13432 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgIEBVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 21:21:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52e7f50001>; Fri, 04 Sep 2020 18:20:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 18:21:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 04 Sep 2020 18:21:07 -0700
Received: from [10.2.57.180] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 5 Sep
 2020 01:21:06 +0000
Subject: Re: [linux-next PATCH v4] drivers/virt/fsl_hypervisor: Fix error
 handling path
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, <timur@freescale.com>,
        <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <1598995271-6755-1-git-send-email-jrdr.linux@gmail.com>
 <a3b36dfa-b7bb-e69b-95d5-e7d6dd7bda3f@nvidia.com>
 <CAFqt6zaB_wcrUzmOJ6kQWMqdcPrENyJO4FNc_UU5z-AQQh_e3w@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4d63100c-fe60-57ad-2924-7b28dbd14c20@nvidia.com>
Date:   Fri, 4 Sep 2020 18:21:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zaB_wcrUzmOJ6kQWMqdcPrENyJO4FNc_UU5z-AQQh_e3w@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599268854; bh=8cwZIHW3lTIPxoBgATDuEfoROnV0gZSfdfpr1UGyl3A=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=T2cUP7Az12y+ecDRmwZEeraYHEUQTpdVp7MupRQkw6U++uw7KdmhRjib8zjp6DsT9
         xTQlXpHvC/2zIsDMNJwwqKPc6bOsWPIl+Jwfxxf4q+Ema0bdGjjJ/ijbzMFZWGyTsI
         Yx4JfDGC+x3V0meCkvaD3fxCs7BB/vQrXRMNAAStP9uxQ1+LVNyYhwTzsDRb/xZ3vp
         JMupXYjGDiXHz0Wt+fwpnPCLwP9C9WPbzruaTDMYTjamRch9bNtjKLlh62dLyH+M+v
         tEZ6YwoOzfYuAA85ncqC2M7RQaSS+zNafdNywqfb8jney51op3YLB0zG/rXpD2p7fh
         AwBHAKlj0VusA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 6:16 PM, Souptick Joarder wrote:
> Hi Andrew,
> 
> On Wed, Sep 2, 2020 at 3:00 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 9/1/20 2:21 PM, Souptick Joarder wrote:
>>> First, when memory allocation for sg_list_unaligned failed, there
>>> is a bug of calling put_pages() as we haven't pinned any pages.
>>>
>>> Second, if get_user_pages_fast() failed we should unpin num_pinned
>>> pages.
>>>
>>> This will address both.
>>>
>>> As part of these changes, minor update in documentation.
>>>
>>> Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor
>>> management driver")
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>>> ---
>>
>> This looks good to me.
> 
> Can you please take this patch through the mm tree ?
> 

Is there a problem with sending it through it's normal tree? It would probably
get better testing coverage there.


thanks,
-- 
John Hubbard
NVIDIA
