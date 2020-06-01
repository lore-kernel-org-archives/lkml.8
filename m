Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E0DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3272073E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QbVXe76i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgFAFLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:11:51 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12104 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAFLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:11:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed48dbf0000>; Sun, 31 May 2020 22:10:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 31 May 2020 22:11:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 31 May 2020 22:11:50 -0700
Received: from [10.2.56.10] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Jun
 2020 05:11:49 +0000
From:   John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/2] docs: mm/gup: pin_user_pages.rst: add a "case 5"
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20200529234309.484480-1-jhubbard@nvidia.com>
 <20200529234309.484480-2-jhubbard@nvidia.com>
 <CAFqt6zaCSngh7-N_qZ6-S3Cj8CHF8DTSPv8anP_oJg5E6UWu9g@mail.gmail.com>
X-Nvconfidentiality: public
Message-ID: <b8de5a5e-b53a-81e8-9165-405d203deb33@nvidia.com>
Date:   Sun, 31 May 2020 22:11:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zaCSngh7-N_qZ6-S3Cj8CHF8DTSPv8anP_oJg5E6UWu9g@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590988224; bh=9bFIJ1fdeUjA5o+dFxctvjpXw8nTkPS99fUnc8XcE0I=;
        h=X-PGP-Universal:From:Subject:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QbVXe76ixZyU/4kNOFUP5irHut9M8oYwtRvqVPMBs8MwCPoBca+201MH6KAunI+hC
         YI80foKFhnvqpOlbkPGohIsaFJrF/KNCZGr+3ThzCd3bCk1avxVy3WXxbF/4r2quEF
         7yrNewG5QVpWJoVuLj1oHvaRgry+KxpeM1VOIv3nmyznPJUllYlOKwL+c7N4xh6Uz+
         +qU9FTcgG6RIPcdtoZ+KUxCbcCvD5lTT2AvEWImzE7NSJc+NbL3ZKHm+rp245WmBsC
         +sdrJvoCqXCZvICidj76kgi5z1yDjAHsgJtBx183NoBxycsge6pMGpAdd0nSqbWfbK
         z4XykyLCQxZNg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-31 00:11, Souptick Joarder wrote:
...
>> diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
>> index 4675b04e8829..b9f2688a2c67 100644
>> --- a/Documentation/core-api/pin_user_pages.rst
>> +++ b/Documentation/core-api/pin_user_pages.rst
>> @@ -171,6 +171,26 @@ If only struct page data (as opposed to the actual memory contents that a page
>>   is tracking) is affected, then normal GUP calls are sufficient, and neither flag
>>   needs to be set.
>>
>> +CASE 5: Pinning in order to write to the data within the page
>> +-------------------------------------------------------------
>> +Even though neither DMA nor Direct IO is involved, just a simple case of "pin,
>> +access page's data, unpin" can cause a problem.
> 
> Will it be, *"pin, access page's data, set page dirty, unpin" * ?

Well...the problem can show up with just accessing (writing) the data.
But it is true that this statement is a little different from the
patterns below, which is confusing. I'll delete set_page_dirty() from each
of them, in order to avoid confusing things. (Although each is correct.)
And I'll also change the above to "pin, write to a page's data, upin".

set_page_dirty() interactions are really just extra credit here. :) And
fully read-only situations won't cause a problem.

> 
> Case 5 may be considered a
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
>> +

I'll send a v2 shortly.

thanks,
-- 
John Hubbard
NVIDIA
