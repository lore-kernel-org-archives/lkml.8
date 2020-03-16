Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CB7C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFCD20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIU/bY9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbgCPWiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:38:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55158 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732739AbgCPWiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:38:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id n8so19452628wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1fBBOx02VcEYppdCNi5Xl2Em7WTei4uipjmvF9jzRYs=;
        b=VIU/bY9At5xVG9wGhnfLBhqN5QhHGKCCXmnN0KqYvjF5a52JUlieZIV/k3W7Zj8g1F
         MFNBVubiu0gUfDZ9X2oPNmd5daPqxz2V2TAmpJkUMKOmsWxB11u4e9+XB4aMZZpiWATd
         aLmESwpnTHPZNYPpBtRmFdVWiS/8d3rxkCcyUENSLnbb/NZq2Su3zNs3hOJJ4Iwsv6kY
         6OAmsB+ki3dgNsnGBnnPErL28p9mGumyb/c6ufE/eE0zt4wX7PLbjPI09wsx+mjohR2y
         XeRLugX//utJqPKRSD2TAVvv1avqSVifEO0XR1NrCG75QuxCio5D4R8Qb/FXNN/Sp+lD
         Ml2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1fBBOx02VcEYppdCNi5Xl2Em7WTei4uipjmvF9jzRYs=;
        b=o56cAxHzXi+eIwUuB7gBXD0vJPN4K9b0nUZfO6GMZrO53ftQckWFuRcle3uWOsq9sQ
         nfqDRo+jRPIAzNK5F9kLVVubIqrIcr4E5g1qoA+iDwQBXhh+1+rir3U5t3lk8gnGWo7N
         /BpuHGtwnNIzhOVJwFgWZU95YQSZLjumCin2SxtVkiW/GF7kbyvA6ulhIFlYp0Uu4hI/
         PAnfrU/Dbj65aBqhCyIRVecZ2stYJmYK4Jpq+3CGZeGFhfRl5Dm2IX/phez24jLn/ILR
         H6762d9dXHKnVMdWEyzFVaQbTv5vzsIrB5EeBg5TUWsAhoAjeQeKPEmTnycfQJoG8DIj
         2YDA==
X-Gm-Message-State: ANhLgQ35ODq7xy/b/80D2UJ4AAhNgZ5g2fA5JhciLjChTwsGF9LIfQHo
        c3hytMM58ok8pWI7nRB39k8=
X-Google-Smtp-Source: ADFU+vtChtP3lSKZ8/B9vEVi/mPCHm0+iHAc+RkasjUxXmYPvAx9TcuNhExKUL1CJUWuiaYhpG/LpA==
X-Received: by 2002:a1c:3dd7:: with SMTP id k206mr1292164wma.147.1584398296193;
        Mon, 16 Mar 2020 15:38:16 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w204sm1427927wma.1.2020.03.16.15.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 15:38:15 -0700 (PDT)
Date:   Mon, 16 Mar 2020 22:38:14 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Mika Penttil?? <mika.penttila@nextfour.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [RFC 2/3] mm: Add a new page flag PageLayzyFree() for MADV_FREE
Message-ID: <20200316223814.dpzlmfpb6a2cus25@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200228033819.3857058-1-ying.huang@intel.com>
 <20200228033819.3857058-3-ying.huang@intel.com>
 <20200315081854.rcqlmfckeqrh7fbt@master>
 <92d4b0fe-f592-8da6-0282-2ea8a015b247@nextfour.com>
 <20200315122217.45mioaxzuulwvx2f@master>
 <87pnddrt5t.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnddrt5t.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 09:21:34AM +0800, Huang, Ying wrote:
>Wei Yang <richard.weiyang@gmail.com> writes:
>
>> On Sun, Mar 15, 2020 at 10:54:03AM +0200, Mika Penttil?? wrote:
>>>
>>>
>>>On 15.3.2020 10.18, Wei Yang wrote:
>>>> On Fri, Feb 28, 2020 at 11:38:18AM +0800, Huang, Ying wrote:
>>>> > From: Huang Ying <ying.huang@intel.com>
>>>> > 
>>>> > Now !PageSwapBacked() is used as the flag for the pages freed lazily
>>>> > via MADV_FREE.  This isn't obvious enough.  So Dave suggested to add a
>>>> > new page flag for that to improve the code readability.
>>>> I am confused with the usage of PageSwapBacked().
>>>> 
>>>> Previously I thought this flag means the page is swapin, set in
>>>> swapin_readahead(). While I found page_add_new_anon_rmap() would set it too.
>>>> This means every anon page would carry this flag. Then what is this flag
>>>> means?
>>>> 
>>>> 
>>>
>>>But not all PageSwapBacked() pages are anon, like shmem.
>>>
>>
>> Yes, while it looks shmem is the only exception.
>
>Another exception is the pages freed lazily via MADV_FREE.
>
>> I am still struggling to understand the meaning of this flag.
>
>You can use `git blame` to find out the commit which introduces this
>flag.  Which describes why this flag is introduced.

Thanks, I see the purpose is to distinguish a page:

   a) file backed
   b) or otheres

This sound more clear.

And now this flag is also used for MADV_FREE, which sounds a little abuse.
This is the purpose of this patch to make a dedicate flag for MADV_FREE.

BTW, the name, swapbacked, is a little misleading. Maybe just to me. But I
can't come up with better naming. :-)

>
>Best Regards,
>Huang, Ying
>
>>>
>>>--Mika

-- 
Wei Yang
Help you, Help me
