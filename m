Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05679C352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD10020674
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="fbUqiFBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgBELqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:46:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45748 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgBELqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:46:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id f25so1950224ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 03:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jy6I9lCZXmqSIc0Oo7ZwAUc0APIjOD7+FskXlmNX0dE=;
        b=fbUqiFBKKWfMvUVGayetzT7gBoVUOArtTvKe87cxlG4ADzVrq73rMKZXdR+K95XCj8
         2tpgG6t6IONw5sP60aDQPIi6bEjTxNmgDQRNTBOF6qrPugG05rtCHYMncko/ND4Oe2J6
         r5juTmm4ovUmOcVa1aFbKe9GkKmUd7VDww+dSp8QucR9SspUNhqp/6/XnMDjtqCOZCm+
         qKdTR/LxfUsAecDs7AmpEc7Cuc0WG8lutxYO9rxW3DP42v5HUE+fiSgAC2sl51AiqrDI
         7tiuH8OzxbBfsLnmX2PGY8JuKutQO0wJaxcNMEFDaSlRFOuKzWYVhw0WG5ELGFSaNkOP
         JFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jy6I9lCZXmqSIc0Oo7ZwAUc0APIjOD7+FskXlmNX0dE=;
        b=Do1W6Yyvcs6i0gJCrXY1Xp2hhr/1c066pdmg/l9sCWaqWkVX980sq9XAAEJcBLjMZn
         fP/MUWCLWwcSYtpDJyMlc3oPpEvUoDFrvrzwhWq1fwC4x5BM5a7I5z2bXF4iVTAxGz6h
         ugoch/Tc8tinBlxtGShOIshyhNagetgo+r3nEPZmUO7dARa7UyfGyE5yp4h3eS/eTbl9
         DwGsGj7gyImRWW2LEBeNHa4sgpzGEDVXMd38HnLO1dFBC8ODa8qjKLIL6mts/mMCiTz9
         nWaB5FZmYB7CzLFlssX0efQTjcOgg1HM2/MH0Kgs4WuZCvMqjftv3JiIgMSB4MxQ4c5p
         NO6A==
X-Gm-Message-State: APjAAAWJlxzwQjkhL9TEOaDIPi8v5lgeUxcFfVsxWbGQdPwjobXi1eW7
        LnF5BxHI8zgvDonuRVOyHK0zoQ==
X-Google-Smtp-Source: APXvYqyYwLXyW1HUby3u5z2IhHyV0WiYO1K3JWIkU6l6dX312E3ieNWtdHp2AH5LJPi+2PXC1G4V7w==
X-Received: by 2002:a2e:5056:: with SMTP id v22mr20108284ljd.164.1580903158629;
        Wed, 05 Feb 2020 03:45:58 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w3sm13028052ljo.66.2020.02.05.03.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 03:45:58 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0BF46100AF6; Wed,  5 Feb 2020 14:46:12 +0300 (+03)
Date:   Wed, 5 Feb 2020 14:46:12 +0300
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
Subject: Re: [PATCH v4 11/12] mm/gup_benchmark: support pin_user_pages() and
 related calls
Message-ID: <20200205114612.foo7zrcplgxwmylt@box>
References: <20200204234117.2974687-1-jhubbard@nvidia.com>
 <20200204234117.2974687-12-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204234117.2974687-12-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:41:16PM -0800, John Hubbard wrote:
> Up until now, gup_benchmark supported testing of the
> following kernel functions:
> 
> * get_user_pages(): via the '-U' command line option
> * get_user_pages_longterm(): via the '-L' command line option
> * get_user_pages_fast(): as the default (no options required)
> 
> Add test coverage for the new corresponding pin_*() functions:
> 
> * pin_user_pages_fast(): via the '-a' command line option
> * pin_user_pages():      via the '-b' command line option
> 
> Also, add an option for clarity: '-u' for what is now (still) the
> default choice: get_user_pages_fast().
> 
> Also, for the commands that set FOLL_PIN, verify that the pages
> really are dma-pinned, via the new is_dma_pinned() routine.
> Those commands are:
> 
>     PIN_FAST_BENCHMARK     : calls pin_user_pages_fast()
>     PIN_BENCHMARK          : calls pin_user_pages()
> 
> In between the calls to pin_*() and unpin_user_pages(),
> check each page: if page_maybe_dma_pinned() returns false, then
> WARN and return.
> 
> Do this outside of the benchmark timestamps, so that it doesn't
> affect reported times.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
-- 
 Kirill A. Shutemov
