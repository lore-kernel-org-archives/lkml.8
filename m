Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA72C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD3C21741
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uMg77BV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBCNYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:24:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42394 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgBCNYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:24:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so14577866ljl.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zkts+cGeEEtVuxNtWUSWiHH/b9CvDi3byTsQsBOoffc=;
        b=uMg77BV0yqbAokDjCIsX7WMm2+rljZD30A9Pgzvg2whq0fdLlCKNcVner/6Vldy+Do
         FJQe9cz1HwrRCTkHR76IWJkaU5PiNAe3jfkVCM41ucop+Vhsr3TE8nBD+OZBkeOwg1tK
         tIwWZLieJoA/GglHEidrlbm6zzJlqI84LHEJYsB4i6yqavXKRSdIIRjV07xPQ9irUsii
         fqWGRS0az2183mpkYJlDAldhbLf4FtoF5fIgpFJmgnWg+6SKmWS1oF6zqS+n4NWU8e0P
         L1jvslaK69PxYYY/eLHnnLHG+RZYhMnLAKnh/UgEnV0qIGCLCEPbaD8fIfWosAQBpGkK
         18JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zkts+cGeEEtVuxNtWUSWiHH/b9CvDi3byTsQsBOoffc=;
        b=JPVFqn4lVapvJKT+p2fcuwlfotaRqs4cP067PMFifCyX7x57BB0bPZfTWD5Gtxx3LU
         V4TsbT6xFxLuEc/KI1V8gxIF8DbBONbtEtqVH6rRrp+By73ROybwG8FQXdaAFlnDX6fV
         8Fg3ocZqBaVia3dQ+D190vsFGuszklLt6lox8s1suy2p0pgBiuo/vR6ae3X9MLtlHSQw
         n1GQqBpnp2NrrSEgRD7EYkCE1SLsRCy3Q9MdzJLb6A0Rb0D/fQC2UsT9YeubkFQvRZRn
         zCE0nksGaqPnpGcABsTXFyQ75dKVkEeOoin9XmebSVk9BGm4vzrZtakkkF5/xZh3H6na
         th1g==
X-Gm-Message-State: APjAAAV0PN5yqH+n5R0jFCHNZM4tMcMiydKOtu4MzIfLFPW9ZC9Oyvqm
        wHlonyuS0Y2VWVLW5tlmIgk++w==
X-Google-Smtp-Source: APXvYqxyrBwcLQLkKywdLgZRmnj/Xxrleln4eaTTDtgmBedmh/EgtmO52sB+qALEUQcISXFUYFMPnA==
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr13991181ljm.53.1580736269586;
        Mon, 03 Feb 2020 05:24:29 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n23sm8931924lfa.41.2020.02.03.05.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:24:28 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id B6499100DC8; Mon,  3 Feb 2020 16:24:41 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:24:41 +0300
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
Subject: Re: [PATCH v3 05/12] mm/gup: pass gup flags to two more routines
Message-ID: <20200203132441.ig7qihjvz5mfgcnc@box>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-6-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-6-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 07:40:22PM -0800, John Hubbard wrote:
> In preparation for an upcoming patch, send gup flags args to two more
> routines: put_compound_head(), and undo_dev_pagemap().
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
