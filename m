Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345ECC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5792084E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="o5Ff7bts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgBCNRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:17:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42650 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgBCNRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:17:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id d10so14553809ljl.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vyFT4rLw7oKG03KTCLsTCkr74zWtEKjYEEOBftr+6P0=;
        b=o5Ff7btsNGi9NOXnjubu+7cTXPZzjIguylFxg2meFJKfZpUujo4sDiBm4/PoClx4Kf
         wAG+40lcRzRFD2Co4z/dCvXZkYHngCJJvQG6Ro/d5Jm8BkZvOVNgFHKyhYYFkEvWw0aa
         4VwPcAc6uWQZ0Yd3ylaVtft2ryUHgm9OCWOQ5Hh6uzsALWd6gB3mINfr5rfMNTl765vG
         uALlx7fVFek/4XK+QVXRG+jLYeMHLD4cZqm8RYCS6Mqdrfm8thosqdfb6bNYw5rBicmE
         HJsg9ArBJmbt0pkJ1ndiDf0a6JSC2Os6yrRXqftoz+cbYoumzUNhzEWAGvRcPkk36K3w
         IIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vyFT4rLw7oKG03KTCLsTCkr74zWtEKjYEEOBftr+6P0=;
        b=Hy9EAvsZRdyfm7V70SMyBkI7jNgm8HUPKXjqfGSFb2zvgO8gPIoiM9YzMzOHTV8+sv
         oTP2MWctjcTNCo7Cs77xVLsue7CeUYuWA7SP+C041i3q7dVspKxYTme2VEpP1Z99h9Sf
         XSgj3B/1Zhf5Jigaxm0pie0zqKSLZnoedtt5MKtcMvxgyVEwapHWVmxt98wWyLta7SIs
         fyP2P4gQ0hJn3VPJQOyqnCVSyxtT9rTLJ3P41ff0uEoI+y/pU4Vl9GgmTftFSuz4oBOS
         jHwXev17SeZBcXwF/dx4skaCQMwRPuU02NdWxNLpQCOOmGaBmC++MgGXw8L5R8WhBWeq
         Rj5A==
X-Gm-Message-State: APjAAAVeFaf1/DktT+9FNfUxkz7Nris4ny9ZgUd3CvNoCRjmIP9dkuD/
        3Sfqfbyx0QbRl9c2dUE0pjoZMg==
X-Google-Smtp-Source: APXvYqzNUL0o3i1b2tHehpWzfV/mFHtL+96xJ6zWYkW97kHAQ906cHrLM/Ge9Zfr+Ej7Vk691i4ZeQ==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr13816964lji.177.1580735852643;
        Mon, 03 Feb 2020 05:17:32 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z8sm9754153ljk.13.2020.02.03.05.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:17:31 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 79B2B100DC8; Mon,  3 Feb 2020 16:17:44 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:17:44 +0300
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
Subject: Re: [PATCH v3 02/12] mm/gup: split get_user_pages_remote() into two
 routines
Message-ID: <20200203131744.6idhpu2ho3ajfu55@box>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-3-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 07:40:19PM -0800, John Hubbard wrote:
> An upcoming patch requires reusing the implementation of
> get_user_pages_remote(). Split up get_user_pages_remote() into an outer
> routine that checks flags, and an implementation routine that will be
> reused. This makes subsequent changes much easier to understand.
> 
> There should be no change in behavior due to this patch.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
