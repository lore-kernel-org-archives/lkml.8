Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CB9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306532078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="E0ox2Slo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgIAUwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:52:11 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15688 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIAUwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:52:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eb44c0000>; Tue, 01 Sep 2020 13:51:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 13:52:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 13:52:10 -0700
Received: from [10.2.63.6] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Sep
 2020 20:52:07 +0000
Subject: Re: [linux-next PATCH v3] drivers/virt/fsl_hypervisor: Fix error
 handling path
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <timur@freescale.com>,
        <galak@kernel.crashing.org>, <linux-kernel@vger.kernel.org>
References: <1598911668-6178-1-git-send-email-jrdr.linux@gmail.com>
 <82329783-739b-a315-8957-2c49a3ab1350@nvidia.com>
 <CAFqt6zYcTHDvhFgFNxy+MjD_h7nFUojOnB29v_-TbEsQtmXWCQ@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <10705531-7a03-44d9-3fc7-e520a7b1cd87@nvidia.com>
Date:   Tue, 1 Sep 2020 13:52:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYcTHDvhFgFNxy+MjD_h7nFUojOnB29v_-TbEsQtmXWCQ@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598993484; bh=uEQMEQauSdG5Y0zgHkx1tgB4MhXnUjYrABtFmwU3Rhw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=E0ox2SloH0eoJCFbFG+VRtbIogTe6SeMhYmPHB9syCZtfKXbtbKRJUwSBWcWoEC0W
         BBekW8WzPVo+DaK2F8qvKAda8xLbDmVajwsEx3mET2HSKirHsLd04Rok4oBgps0xMM
         jYl1R452ovsQ9LMnqD5d5RCfvxuUR9Ax+R30MY2wKzbdETVYeUhMkORZFGVpjk02Sj
         /JMe/U0m774LMvQrcowjAxjVPvwXhOIAplG8/PaUqcw6oZpF3SwzC/njJiRPks43W1
         SXEiYjK2jY2e/XfjWecvAf2uM5c4O2vkJXC/aZAgNW0Z0eKuDFhcFzYBVGpq59OyvO
         u/s5+mG8PKK7g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 1:14 PM, Souptick Joarder wrote:
> Hi John,
> 
> On Tue, Sep 1, 2020 at 4:28 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 8/31/20 3:07 PM, Souptick Joarder wrote:
>>> First, when memory allocation for sg_list_unaligned failed, there
>>> is a bug of calling put_pages() as we haven't pinned any pages.
>>
>> "we should unpin"
> 
> will it be "we shouldn't unpin" ? can you please clarify this ?

Whoops, I put my comment next to the wrong part of your email. Sorry
about that! It was supposed to be a correction to this sentence:

"
Second, if get_user_pages_fast() failed we should unpinned num_pinned
pages instead of checking till num_pages.
"

...which I wanted to change to:


Second, if get_user_pages_fast() failed we should unpin num_pinned pages
instead of checking till num_pages.

thanks,
-- 
John Hubbard
NVIDIA
