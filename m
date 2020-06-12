Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D76C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98AB720723
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Mrwrs2/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFLUDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:03:12 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14320 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFLUDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 16:03:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee3df4d0000>; Fri, 12 Jun 2020 13:02:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Jun 2020 13:03:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Jun 2020 13:03:07 -0700
Received: from [10.2.62.89] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Jun
 2020 20:03:07 +0000
Subject: Re: [PATCH 1/2] docs: mm/gup: pin_user_pages.rst: add a "case 5"
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20200529234309.484480-1-jhubbard@nvidia.com>
 <20200529234309.484480-2-jhubbard@nvidia.com>
 <20200612192426.GK8681@bombadil.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <d717e596-4ac7-9350-8734-379852c151d2@nvidia.com>
Date:   Fri, 12 Jun 2020 13:03:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612192426.GK8681@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591992141; bh=fN6zAnkb8dRIBQrks+Oz4+vRiYcHSYaYUuw0BewGGEk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Mrwrs2/WN8fnEejZcAvFi1E+ICWIQc+5sT7wEIyruy1+L8O2vF2rU8etd+2m3Rcye
         /0MGen72j1T2YMz8qzXatSCP76QXdLxycn/9MxrzFz+r0k+oGKr5wqPp43sFbsvvxJ
         kG6DIrwJ31WVrfLqK6RrOt/FtCmOVWN8cByBMW2OYkwN5lYUueiqAzGuWU0cmQv94Q
         Uvvv505bPXRH5YPkRvyIKX1owhLczul7/YDNdthyhbC86t0EtjEp8X1e75YFPqEGn9
         iBucQvKo4smd+Vzmm9MOxV5oQ6ufLiUCUz2qRrkZ0AZiZ94MfBBuULhA48FkMlAfRC
         xpX4UyB4FOplg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-12 12:24, Matthew Wilcox wrote:
> On Fri, May 29, 2020 at 04:43:08PM -0700, John Hubbard wrote:
>> +CASE 5: Pinning in order to write to the data within the page
>> +-------------------------------------------------------------
>> +Even though neither DMA nor Direct IO is involved, just a simple case of "pin,
>> +access page's data, unpin" can cause a problem. Case 5 may be considered a
>> +superset of Case 1, plus Case 2, plus anything that invokes that pattern. In
>> +other words, if the code is neither Case 1 nor Case 2, it may still require
>> +FOLL_PIN, for patterns like this:
>> +
>> +Correct (uses FOLL_PIN calls):
>> +    pin_user_pages()
>> +    access the data within the pages
>> +    set_page_dirty_lock()
>> +    unpin_user_pages()
>> +
>> +INCORRECT (uses FOLL_GET calls):
>> +    get_user_pages()
>> +    access the data within the pages
>> +    set_page_dirty_lock()
>> +    put_page()
> 
> Why does this case need to pin?  Why can't it just do ...
> 
> 	get_user_pages()
> 	lock_page(page);
> 	... modify the data ...
> 	set_page_dirty(page);
> 	unlock_page(page);
> 

Yes, it could do that. And that would also make a good additional "correct"
example. Especially for the case of just dealing with a single page,
lock_page() has the benefit of completely fixing the problem *today*,
without waiting for the pin_user_pages*() handling improvements to get
implemented.

And it's also another (probably better) way to fix the vhost.c problem, than
commit 690623e1b496 ("vhost: convert get_user_pages() --> pin_user_pages()").

I'm inclined to leave vhost.c alone for now, unless someone really prefers
it to be changed, but to update the Case 5 documentation with your point
above. Sound about right?


thanks,
-- 
John Hubbard
NVIDIA
