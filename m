Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9909C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2382087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Qvgtk33f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBCN0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:26:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32862 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgBCN0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:26:16 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so14641524lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/c8JqFBoF+Wyv0y7vjPLE9bVpeDasBR2S69E+7r2TtY=;
        b=Qvgtk33ftlbcsS5ozma4SkqBFwKXe/etS4q98w1ik72KUgLvZCb5LF6bX9en+6X9bo
         RZkuxEhczs1LHPUxff5YONZLAinu2abSX1x8hd1YrVMhXhSPB6YnCGS2IgB7n4ZvycwY
         4guibrya0uJJxVpAXyYDoHuuVBQYz+s5yLsNWj8sly+tVIODbFFekbsty1PMf0QzYhud
         yGJvBqTV33CGmK5iIJ6dNPJY9ofEyM3bweM9PnVwm793arTmLHxyQ5c99wp2YWiXJHjo
         fRwKRyBoSNe9NapKkTYXp8GqbEXUwRw4pFOvGuL+bWN/i5mbQ7e2xKkp1bS2QFcw0bFF
         p4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/c8JqFBoF+Wyv0y7vjPLE9bVpeDasBR2S69E+7r2TtY=;
        b=EDnlGp2zhuN5FQlY3PVR5FgNz3cXCOXI7nH7voPtW5AAKWYQLGhhWo52eg+juCPa0h
         /weGo5TWSadbx8emZXxo6uSMsxUveEI8DqPfdOCqi+uGN0bvO0364uEmfhCtpme9/duy
         BA49yop1gHNVBQexkqih7hluArdm6mxJAUjYNRX8nmEPpAempTTQQ2m9qzw5rTPA1bUb
         vaGrLwsgeXlLg26zmNTKym0SldFSYFQpaT9RNCdxviMGjnTk9WY2mBNzebr50bNDUJPB
         fEr1HvIjyd7k3Au7ruINCoOWVdiT5n00tmPREGdVSXYrlFMxmScl43DQ7FMvy+Knej4V
         Pr7A==
X-Gm-Message-State: APjAAAUJtYVEXELo2r1tADTnO0mN7auoSvjL4FkK5ZYlBCUP0Z/rWG8o
        g0YPD80iN8lhGSm1CMOFw1kuWg==
X-Google-Smtp-Source: APXvYqyAwd06U5sHJ6RJuXAzdAU4K5P7qW3PVQBSvKIMhVgDvbt0mabo67VXojbyegXmFIr9BORhmw==
X-Received: by 2002:a05:651c:1bb:: with SMTP id c27mr14397156ljn.277.1580736374697;
        Mon, 03 Feb 2020 05:26:14 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m24sm11753539ljb.81.2020.02.03.05.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:26:13 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A788C100DC8; Mon,  3 Feb 2020 16:26:26 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:26:26 +0300
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
Subject: Re: [PATCH v3 06/12] mm/gup: require FOLL_GET for
 get_user_pages_fast()
Message-ID: <20200203132626.ckkozepykxmqxf6a@box>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-7-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 07:40:23PM -0800, John Hubbard wrote:
> Internal to mm/gup.c, require that get_user_pages_fast()
> and __get_user_pages_fast() identify themselves, by setting
> FOLL_GET. This is required in order to be able to make decisions
> based on "FOLL_PIN, or FOLL_GET, or both or neither are set", in
> upcoming patches.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
