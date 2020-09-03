Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00C9C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C413720737
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CCWZt9gQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgICHXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:23:37 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19279 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgICHXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:23:35 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5099740000>; Thu, 03 Sep 2020 00:21:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 00:23:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 03 Sep 2020 00:23:33 -0700
Received: from [10.2.53.12] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 07:23:24 +0000
Subject: Re: [PATCH] mm/gup: don't permit users to call get_user_pages with
 FOLL_LONGTERM
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Barry Song <song.bao.hua@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michal Hocko" <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <20200819110100.23504-1-song.bao.hua@hisilicon.com>
 <e4265ac0-793d-053b-81b1-15e57c04b830@nvidia.com>
 <CAFqt6zb2GjO9KOVdKT1P0P-Wn+isnArous5gpw-AJ3va+fi9rw@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <14e62718-a8fc-f41d-7c4a-2767cbd65c7b@nvidia.com>
Date:   Thu, 3 Sep 2020 00:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zb2GjO9KOVdKT1P0P-Wn+isnArous5gpw-AJ3va+fi9rw@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599117684; bh=jUExDbKjqVqcLv5dEUKCzQYjKag+aQT+X4HUSyIZ59Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CCWZt9gQTcL+N+ivitisGhKJUdlkj/dUkQ8rWWwJecO2vZw4RUHdwbxS7+FGai+pr
         RetiQgJNalU/IEYNdhyfJazILE3UvbU8M5OiwImK/WM1dqTq58SB1o/9EyrAzdvJcp
         MuK9xqXBmY2LYEzH9njFrAEw3CAj1jYnkhnu7G7/fRbXw3OVSLkBP0Vt8Dil7FRsnf
         So24/WkIVnBFtgLZw2MBbXjK0sGytFmNoeC10dGfAhcOxjKghcoUrK6k0H9gDaGibi
         OI+pNDesCV5UxwnU0UXci+H/pBkfqPGrZYWtB4CCVOsaH48vY3j1bUvZIe4BeJe1BH
         Lut0/zwgDU7lA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/20 12:12 AM, Souptick Joarder wrote:
> On Wed, Aug 19, 2020 at 11:45 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 8/19/20 4:01 AM, Barry Song wrote:
>>> gug prohibits users from calling get_user_pages() with FOLL_PIN. But it
>>
>> Maybe Andrew can fix the typo above: gug --> gup.
>>
>>
>>> allows users to call get_user_pages() with FOLL_LONGTERM only. It seems
>>> insensible.
>>>
>>> since FOLL_LONGTERM is a stricter case of FOLL_PIN, we should prohibit
>>> users from calling get_user_pages() with FOLL_LONGTERM while not with
>>> FOLL_PIN.
>>>
>>> mm/gup_benchmark.c used to be the only user who did this improperly.
>>> But it has been fixed by moving to use pin_user_pages().
>>
>> For future patches, you don't have to write everything in the
>> commit log. Some things are better placed in a cover letter or after
>> the "---" line, because they don't need to be recorded forever.
>>
>> Anyway, the diffs seem fine, assuming that you've audited the call sites.
> 
> We can use is_valid_gup_flags() inside ->
> get_user_pages_locked(),
> get_user_pages_unlocked(),
> pin_user_pages_locked() as well.

Probably it's best to discern between valid pup flags, and valid gup flags.
As in: separate functions for those. Maybe one is a subset of the other, but
still.

> 
> Are you planning to add it in future patches ?
> 

It's not on my list. I don't see anything wrong with doing so, other
than avoiding the minor pitfall I called out above. So if you want to
do that, then feel free...


thanks,
-- 
John Hubbard
NVIDIA
