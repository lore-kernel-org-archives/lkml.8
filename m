Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02B2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 12:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DE720578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 12:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chYAt6y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgCOMWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 08:22:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39333 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgCOMWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 08:22:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id r15so17766812wrx.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 05:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Kx5mSt5kBh7FsLH+0N/pfeCSX6lxtBaeY/mUDaY9J4=;
        b=chYAt6y0eCvcUVZE3gi3UBUzNUzKL+vQ1CMKCFG1y5sNExXx+3T8iGg0e83kjBmxrm
         YWmLFF335HRNA7cfnN7z9efqWMpah8o9G5+f28jKF1e4G4yCwB83Q2nieWSKqsz8zf4f
         +WtQUcWBgizHrzbXLH6FYcUPSIulaR8QifpA6Hn8IoGSYYJMBfR+tKDtX765FwgXq93R
         PX67+DjGRSnNHhNZYg0a7qjblj627lIvZ6g/JDDcMXNWzIP7GqbemQvAsJP4stqJEv4s
         pH+LeEsvuP8ljdQg0TjWtOVX2zyy5XDMgasvecY67rK/oc+2X0CrzzzWi9WkG/amCziB
         6iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Kx5mSt5kBh7FsLH+0N/pfeCSX6lxtBaeY/mUDaY9J4=;
        b=qJdqq2N44mNGqNro1ZgB3WTOJvgGdRBTDMPjYxCvDycwDmeO7Ky9oxW4fWRbNUxMsf
         aj0lXnNHP8mKqaWCohHvvUdeyb4OZk9XkX5MhVHxWa8cPNXFv/dWdaA08K064ZVdzjdQ
         92kXsfcKsDvR3+/dTp/jbYxnT6OkAW2kBo8mXrgUBviqIPyMoWCcRgKnJ3rp7BCaSDxW
         KBwZhLA+K+qXmJSIzhGvZbKd3Y1zX7jovsgsFJaCMHlZ9A5rCs5uT4siHPEOqOlIke3c
         5lh+rn7hrVq4o8qt8PUejt8Oh+ljruL98YdJTXqa+6SrnLdwd6kjbOPrTvPuwZZ/4qct
         5teA==
X-Gm-Message-State: ANhLgQ199SLudcxtP1OMKUBey9Y4yK3GQCdrleqrhpM1Bj1+2lbGet34
        FdrAS30dSDHc5KuVhbygIc1pW1ES
X-Google-Smtp-Source: ADFU+vt66/Ql4uCVh3eduLr+kYFsxKgtN259zBw/vcwySrA50rU0Bvrq10gHgvRGjWQI7Jq7qzwsIg==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr29885645wru.260.1584274939361;
        Sun, 15 Mar 2020 05:22:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id x16sm23743836wrg.44.2020.03.15.05.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 05:22:18 -0700 (PDT)
Date:   Sun, 15 Mar 2020 12:22:17 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Mika Penttil?? <mika.penttila@nextfour.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
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
Message-ID: <20200315122217.45mioaxzuulwvx2f@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200228033819.3857058-1-ying.huang@intel.com>
 <20200228033819.3857058-3-ying.huang@intel.com>
 <20200315081854.rcqlmfckeqrh7fbt@master>
 <92d4b0fe-f592-8da6-0282-2ea8a015b247@nextfour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92d4b0fe-f592-8da6-0282-2ea8a015b247@nextfour.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 10:54:03AM +0200, Mika Penttil?? wrote:
>
>
>On 15.3.2020 10.18, Wei Yang wrote:
>> On Fri, Feb 28, 2020 at 11:38:18AM +0800, Huang, Ying wrote:
>> > From: Huang Ying <ying.huang@intel.com>
>> > 
>> > Now !PageSwapBacked() is used as the flag for the pages freed lazily
>> > via MADV_FREE.  This isn't obvious enough.  So Dave suggested to add a
>> > new page flag for that to improve the code readability.
>> I am confused with the usage of PageSwapBacked().
>> 
>> Previously I thought this flag means the page is swapin, set in
>> swapin_readahead(). While I found page_add_new_anon_rmap() would set it too.
>> This means every anon page would carry this flag. Then what is this flag
>> means?
>> 
>> 
>
>But not all PageSwapBacked() pages are anon, like shmem.
>

Yes, while it looks shmem is the only exception.

I am still struggling to understand the meaning of this flag.

>
>--Mika

-- 
Wei Yang
Help you, Help me
