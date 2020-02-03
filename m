Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA13C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4D120658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="KobgtCTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgBCVaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:30:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44321 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgBCVaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:30:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id q8so16227116ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ySSbnLN31i7Gv0dEujqlmedo6RywQfw4YrrrpttJLgk=;
        b=KobgtCTPqTOidmxNwdxQ0hjvbnszX+R4RWcWLWxJ+uvTDI/rP69kW8duPgWbHo1LVu
         Sai4Dm4sazBGzwERWccFEXaI598eq6EWecYp34MW8ILJVsyleE407qEGsPN5qJ4lgyQ/
         8K7jri+GO3U75nnDYdlociAEKfXothG/+7X7ABSQeFCAAQT2t8Iss0GJiF9iv6h6I4UP
         D3lM3GXquVFErJ1lYr6xVbbVnSqatuWVwE8qbSdpnrtqyce3rATRSAmpPf7mROafnEyP
         VBMpp8JU2l/Tn2SByXuuWLdhBDykIbMvQ4LgrqFcuIVRgpsVbRcK9eCcpoO2Zlcy6tZZ
         SvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ySSbnLN31i7Gv0dEujqlmedo6RywQfw4YrrrpttJLgk=;
        b=U6BbIMMtOEvBK0xlQxCbmKXQuvsBhSIwuJod/8WkVsARwd0Txa93ZmqdS5Gs/1HIWr
         dwlCDUphtj1cyws45BYqYbsju7U46/3QUgbJGzzt2a845ltJ5GvAOMUHM7gncnlyaX0f
         mjKXEx9Sfzm3VPWEQDo9lSfFLEbBhcrhe6aJ88zecksZ1yr5iYIr6ol44Q09fiJIMljM
         ht6dTk9bsg1Ktt6sef8AUSRD4rXXcx3oMnt1Id2M5VAjKgowiWp0otKByjh24hAgBOr9
         u/g0xZcrl20E/tc0PK0r1W2W+4pTDCwSuBSO6MVVRf+2tnkL42sQczwUZ7r74j6CTup6
         Nlsw==
X-Gm-Message-State: APjAAAXJkqeLHugMCFHj14IMYgHb5ayPfelufRmpDsXCrD2jff2Fisqd
        Gp2l1ahmCNbUhL8QsBu4rHvxbA==
X-Google-Smtp-Source: APXvYqzZ8QqSIH6wmy7AnrvnvdyFJ/nn3W6Ulq1Wz+pKu0iT1z5Hjs/H587kjfOvuXRpwubRreoNeQ==
X-Received: by 2002:a2e:9c85:: with SMTP id x5mr15245701lji.50.1580765409905;
        Mon, 03 Feb 2020 13:30:09 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k24sm12450538ljj.27.2020.02.03.13.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:30:09 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 19070100AF6; Tue,  4 Feb 2020 00:30:22 +0300 (+03)
Date:   Tue, 4 Feb 2020 00:30:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/12] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN)
 reporting
Message-ID: <20200203213022.rltjlohvaswk32ln@box.shutemov.name>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-11-jhubbard@nvidia.com>
 <20200203135320.edujsfjwt5nvtiit@box>
 <0425e1e6-f172-91df-2251-7583fcfed3e6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0425e1e6-f172-91df-2251-7583fcfed3e6@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 01:04:04PM -0800, John Hubbard wrote:
> On 2/3/20 5:53 AM, Kirill A. Shutemov wrote:
> > On Fri, Jan 31, 2020 at 07:40:27PM -0800, John Hubbard wrote:
> >> diff --git a/mm/gup.c b/mm/gup.c
> >> index c10d0d051c5b..9fe61d15fc0e 100644
> >> --- a/mm/gup.c
> >> +++ b/mm/gup.c
> >> @@ -29,6 +29,19 @@ struct follow_page_context {
> >>  	unsigned int page_mask;
> >>  };
> >>  
> >> +#ifdef CONFIG_DEBUG_VM
> > 
> > Why under CONFIG_DEBUG_VM? There's nothing about this in the cover letter.
> > 
> 
> Early on, gup_benchmark showed a really significant slowdown from using these 
> counters. And I don't doubt that it's still the case.
> 
> I'll re-measure and add a short summary and a few numbers to the patch commit
> description, and to the v4 cover letter.

Looks like you'll show zeros for these counters if debug is off. It can be
confusing to the user. I think these counters should go away if you don't
count them.

-- 
 Kirill A. Shutemov
