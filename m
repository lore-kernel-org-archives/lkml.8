Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86069C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C782068D
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="niSJVFuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgEaTwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 15:52:22 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13384 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgEaTwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 15:52:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed40aa00000>; Sun, 31 May 2020 12:50:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 31 May 2020 12:52:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 31 May 2020 12:52:21 -0700
Received: from [10.2.56.10] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 31 May
 2020 19:52:21 +0000
Subject: Re: [PATCH 1/2] mm/gup: introduce pin_user_pages_locked()
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20200527223243.884385-1-jhubbard@nvidia.com>
 <20200527223243.884385-2-jhubbard@nvidia.com>
 <CAFqt6zZr9rUZaXEpjwmtmicdNP9KhJ8UrjPPjk4bMHJ20VsVsg@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <d11d52f8-d54c-bb45-bde9-198235a03921@nvidia.com>
Date:   Sun, 31 May 2020 12:52:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZr9rUZaXEpjwmtmicdNP9KhJ8UrjPPjk4bMHJ20VsVsg@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590954656; bh=6z/YbkHrZ9dm2YGHFYSzu/H1Xlj5+faKi/stD2aHkKc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=niSJVFuXnA8b/d8oNH3x2buUJqhUh6oEEmS2KE+lFnzt6CdbVqe7eeC9FZpgAWunx
         6K5Wy7pSLZFZ/+LjqI7xVFVji2xi3+PQJNhVozOI23fuvG3iFCXN/+3x/nRnPh/SXd
         3PXGOfBDR2GenwT/ZidAV3k73EpUSI5H4x8fxrryISuauAFU9H6r9exMkWy9w5ipMk
         ncAkI+lyhQBMmIh4Nzwx76gfSYMKXTTMNFaQVAnmNeGbt7JKrMFbscNYvP3IhX2qAb
         FlxzvoThc9xYA/Om9PI9VLJPnkkiarHdRXslLxAHuU9jBrHyTyxW3BLbeU0C622whY
         8SNLn598TALkQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-31 00:04, Souptick Joarder wrote:
...
>> +/*
>> + * pin_user_pages_locked() is the FOLL_PIN variant of get_user_pages_locked().
>> + * Behavior is the same, except that this one sets FOLL_PIN and rejects
>> + * FOLL_GET.
>> + */
>> +long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
>> +                          unsigned int gup_flags, struct page **pages,
>> +                          int *locked)
>> +{
>> +       /*
>> +        * FIXME: Current FOLL_LONGTERM behavior is incompatible with
>> +        * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
>> +        * vmas.  As there are no users of this flag in this call we simply
>> +        * disallow this option for now.
>> +        */
>> +       if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
>> +               return -EINVAL;
>> +
>> +       /* FOLL_GET and FOLL_PIN are mutually exclusive. */
>> +       if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>> +               return -EINVAL;
>> +
>> +       gup_flags |= FOLL_PIN;
> 
> Right now get_user_pages_locked() doesn't have similar check for FOLL_PIN

Yes, that should be added...

> and also not setting FOLL_GET internally irrespective of gup_flags
> passed by user.
> Do we need to add the same in get_user_pages_locked() ?

...and no, that should not.

Yes, it's prudent to assert that FOLL_PIN is *not* set, at all the
get_user_pages*() API calls, thanks for spotting that. I'll add that to
this patch and send out a v2.

The same check should also be added to get_user_pages_unlocked(). I'll send
out a correction (I think just a v3 of that patchset) to add that.

The setting of FOLL_GET, on the other hand, is something best left as-is
so far. Some call sites set FOLL_GET, some want it *not* set, and some
expect that FOLL_GET is implied, and at the moment, the delicate balance is
correct. :)


thanks,
-- 
John Hubbard
NVIDIA
