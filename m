Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB10C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430A020848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583270306;
	bh=9nZtCyRm9ddWtpuTWo561LEWtyColZSm3B3JWQB0Fso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bDKQTX5jbNsGfB1ZRVod5HDSNhFg1EwQS/e2RZm1dSUSKCmlCxPSy7c9ZZVrCiBrH
	 jE++dT8HRAYY8o7U22/+L2tZD/bJXmaVRKKpxe2Gg0C1TKTz9LOtj/uJgwTv/EkLCQ
	 Geft89GD7HIfTLjUM8MWBYs1Je69rc6qkkVzpnJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbgCCVSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:18:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41030 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732075AbgCCVSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:18:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id j9so2118407pfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 13:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Al6Dba4vILzb1qGfePPll7WwcKDQ0se1L1GE0jp6m8=;
        b=BA/d+Rs5vr4vZfcSXEN8gZw1/tyxpNLiyJnUgSQPAWrFPEnY5zoXLi8iwGcp8uPM7u
         byhoung4nkNM7ARSc4msBvvFfFsGgWDk6nMvvdIPvBXa5Tsbu1C1kllPumuG/t6sbiik
         ZUxvzUVW3fn7SGs6BmTxQYQE8KawqTY32dPx7JvbmKn7viuzwsBI2cyHeknKK6+flvki
         YGfueIWiFCjYK/aVodY/FLqMypenlebQk242WUQvee2Ei0pc+gWRuq37V174eFjqh+Oe
         PBJUXFhGKBOCSMWToWAHJJqweMRSKKypOtfdRqVJ0mObww4RLIuf039/8OTPqD0qTCi3
         Iv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Al6Dba4vILzb1qGfePPll7WwcKDQ0se1L1GE0jp6m8=;
        b=Ef+//Omw8oovR0R51T2UZBlg5Yj/oW2AAL6kFFbljJHZPk+cxxJ3/3tyWOFKQk4blS
         Pq63hbAM2beyZIBmfAG/M+KgjZqWl8tRej7ywgDIu7invEZ9GLAjNj5/cAefufKz2s1Y
         h93EJ9D8orxy8EzUxK45gdrwUyBClS/w+XwHjTP+ZEB5gFUeihPZmDFrNdtVGYzUnrJK
         3d/UthN0aZsfHOcUt7xtyvnjTpi3wxmb2JdEDCtIpaDn6uvbamaINu3LR3DxF9VSKkvi
         oLS7x4O9qBMBZ4+fyJDbiJgJVGL59uUTr3ThsBshqvpZk8cKSi3tAaQWg93SOx3cn69N
         VEgQ==
X-Gm-Message-State: ANhLgQ2i53AH8uJqR4YyXC43l/ebuNw9sQD3v8SMZ/c+fnw5b/hR/mI8
        9FrG/n4MjV4GzNv3+hbKZ+GFAhu+
X-Google-Smtp-Source: ADFU+vutWbwjVREvrg7CwC+hKBwCnK7xhctkxH3euoL5afj5wLtv2BcaDSZsz5PXxKy/44oEMlWueg==
X-Received: by 2002:a05:6a00:cb:: with SMTP id e11mr5969571pfj.88.1583270303364;
        Tue, 03 Mar 2020 13:18:23 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id d77sm12688895pfd.109.2020.03.03.13.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 13:18:21 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:18:19 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] mm: fix long time stall from mm_populate
Message-ID: <20200303211819.GB219683@google.com>
References: <20200303002638.206421-1-minchan@kernel.org>
 <20200303012203.GR29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303012203.GR29971@bombadil.infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 05:22:03PM -0800, Matthew Wilcox wrote:
> On Mon, Mar 02, 2020 at 04:26:38PM -0800, Minchan Kim wrote:
> > @@ -1196,6 +1196,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
> >  	struct vm_area_struct *vma = NULL;
> >  	int locked = 0;
> >  	long ret = 0;
> > +	bool tried = false;
> 
> How about ...
> 
> 	int *lockedp = &locked;
> 
> >  
> >  	end = start + len;
> >  
> > @@ -1226,14 +1227,18 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
> >  		 * double checks the vma flags, so that it won't mlock pages
> >  		 * if the vma was already munlocked.
> >  		 */
> > -		ret = populate_vma_page_range(vma, nstart, nend, &locked);
> > +		ret = populate_vma_page_range(vma, nstart, nend,
> > +						tried ? NULL : &locked);
> 
> 		ret = populate_vma_page_range(vma, nstart, nend, lockedp);
> 
> >  		if (ret < 0) {
> >  			if (ignore_errors) {
> >  				ret = 0;
> >  				continue;	/* continue at next VMA */
> >  			}
> >  			break;
> > -		}
> > +		} else if (ret == 0)
> > +			tried = true;
> > +		else
> > +			tried = false;
> 
> 		} else if (ret == 0)
> 			lockedp = NULL;
> 
> Maybe there's a better name than lockedp.

Thanks for the review, Matthew.

It changes the behavior from mine in that it never set lockedp as "non-NULL"
since it had retried so that we lose fault retrying optimization for
successive addresses

I understand the code is not pretty there so that hard to follow it but
I am not sure the your suggestion makes it better.
