Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AC4C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EF120722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgBUUA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:00:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40244 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgBUUA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:00:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id z7so1515084pgk.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 12:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pNlnTirvfiB7WYuVJDwmUBab2nwnkqDGWJI3ppaa8x4=;
        b=lqKYWI0yd57fZnKZV27m0ZR7sZT9ChWBdjT9x/Q+O/3AvlvKwzBNDIxp0sRufSmWPZ
         o+Y2s7U+JwhNI7/VhZl8+6/zuKsQN4v5gIOVAU6FAVDzcl7l2e+VSDwesRKKBQONulN0
         0w2MAe/basBWN2X00/wQK4w+DOWcK2qiFy0OCcXhxvVozw3vPnucImIm+NtgyMrHDVt1
         QSII7vkDQU0ikXIwxIu3UScocJA8DEBqaf4QSGOpxIhlNvkbAqQsawF2arRrCvPs7Jf8
         4Ppqlqk6jp3E7xApkj8SnryZRBAWAmqWHkGOs2/xLqOIdJ2MnkaTa2h1oUiTfXjqwfh+
         Xbsg==
X-Gm-Message-State: APjAAAUTuo6ONztr9kzvmY/VR4NsxQdog+csk18iKiNczYuHfXxthwLg
        eK5qqxGyNHxSvqxwyqDS+KsaLASlOrk=
X-Google-Smtp-Source: APXvYqyDH+RnreMq6IQELcDHf3TG+giHPDTLYj++X9i8qmnDj85M589gPmQyJC0Wr3jodkDVJucX1w==
X-Received: by 2002:aa7:9aa7:: with SMTP id x7mr37599786pfi.78.1582315257906;
        Fri, 21 Feb 2020 12:00:57 -0800 (PST)
Received: from sultan-book.localdomain ([2620:15c:f:fd00:d989:fbb1:a399:c92d])
        by smtp.gmail.com with ESMTPSA id g7sm3853756pfq.33.2020.02.21.12.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 12:00:57 -0800 (PST)
Date:   Fri, 21 Feb 2020 12:00:54 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Stop kswapd early when nothing's waiting for it
 to free pages
Message-ID: <20200221200054.GA3851@sultan-book.localdomain>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
 <20200221043052.3305-1-sultan@kerneltoast.com>
 <20200221182201.GB4462@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221182201.GB4462@iweiny-DESK2.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:22:02AM -0800, Ira Weiny wrote:
> On Thu, Feb 20, 2020 at 08:30:52PM -0800, Sultan Alsawaf wrote:
> > From: Sultan Alsawaf <sultan@kerneltoast.com>
>  
> [snip]
> 
> > @@ -4640,9 +4647,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >  		goto retry;
> >  	}
> >  fail:
> > -	warn_alloc(gfp_mask, ac->nodemask,
> > -			"page allocation failure: order:%u", order);
> >  got_pg:
> 
> I have no insight into if this is masking a deeper problem or if this fixes
> something but doesn't the above result in 'fail' and 'got_pg' being the same
> label?
> 
> Ira
> 
> > +	if (woke_kswapd)
> > +		atomic_dec(&pgdat->kswapd_waiters);
> > +	if (!page)
> > +		warn_alloc(gfp_mask, ac->nodemask,
> > +				"page allocation failure: order:%u", order);
> >  	return page;
> >  }
>   
> [snip]

Yes,. This was to reduce the patch delta for the initial submission so it's
clearer what's going on; it can be altered of course to coalesce the labels into
a single one. I typically produce my patches to upstream components to be as
uninvasive as possible to aid in backporting and forward porting in case it's
rejected and I want to keep it for myself.

Sultan
