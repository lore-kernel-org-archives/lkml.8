Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE25C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AF624656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="nCTyujXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgBTMF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:05:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45082 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:05:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id e18so3902119ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 04:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/F0m14q92xAvUbGQY+SUfQGBMeQQ31Qf1lU+hso038=;
        b=nCTyujXbQg69Al7nC2tyFH3LBvuItoy6y8yuO9qs/Ul4X1upo3TE+W+BCY/FB5Ha5D
         zxS9Diqwk4kw+kC3AfA2seYwyZWV3b9QzEsSto0fCFyVfhxtVKC48EMFkqZ+HAbuArLh
         JOZj7D7Oa6GH8bqJAYgTLO/I8aH9hWZr6eHvVRQjYs98XMrZo6RGuCmB1lKk2NOfXE6D
         LPJAGKgPAiULkWdCQXic/tUCHMayHERW+Py1ixBICEKuxv1uLSYNeqs7Drxb5UED5uAr
         RLj2B4f/4SHtCs/suN2lB+pe02P3e7a63LGBGzyUqvgWd5qBtqNpdvPd9WuTifBaI/lP
         U+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/F0m14q92xAvUbGQY+SUfQGBMeQQ31Qf1lU+hso038=;
        b=Yi/HWj4jEZz3fMyKRGmycDHO8x30LnrdPAA6zRa94j0+35BtYZ/GAo/BPbC48E2OV4
         dDZD1WrLPgKjECkI/kGCBInIP0fda/ppFradncEdoF5luJD+weXMHP4JKSNK9bsd2+7W
         6CXsKyk90gr4ReJhUBUqlvNGv1cfUtve4idCtZBeV4x4O/if5f0OFLxeZZW/PQ2Creym
         Rpk4Ko4EKgGuZnPuIi6AT36vyVRESgCMH/stfS/RbBQ3/HMOT+scXHiYra0ic87kL3Ql
         0CbT2Qf7pL8NHW7XTqFHsanOtABWDCudH22vf1GyXK9PREtVzCYE3xas6V7rtQyLNnjM
         NIiw==
X-Gm-Message-State: APjAAAWgSZmou8tEEsq9Cubdl22Qm+85hzv2pcam/i2zD05EqvMJW+cl
        /yQWtE1aQbtGKYRzedw7+oSb4A==
X-Google-Smtp-Source: APXvYqw30Wh8xFW8oe/YZTPJzEUTh4djRBIsJA/QjZFK3RpNa1d1Oyx94eIr6NBEiHYunT5vUWI2Hg==
X-Received: by 2002:a05:651c:111a:: with SMTP id d26mr18565322ljo.153.1582200353119;
        Thu, 20 Feb 2020 04:05:53 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h19sm1635453lji.86.2020.02.20.04.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 04:05:52 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id B9015100FBB; Thu, 20 Feb 2020 15:06:21 +0300 (+03)
Date:   Thu, 20 Feb 2020 15:06:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Justin He <Justin.He@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] mm: Avoid data corruption on CoW fault into PFN-mapped
 VMA
Message-ID: <20200220120621.m2mmgih6bdzoqbck@box>
References: <20200218154151.13349-1-kirill.shutemov@linux.intel.com>
 <20200219132239.92a22479e4bff7ec73ae6bdb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219132239.92a22479e4bff7ec73ae6bdb@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:22:39PM -0800, Andrew Morton wrote:
> On Tue, 18 Feb 2020 18:41:51 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> 
> > Jeff Moyer has reported that one of xfstests triggers a warning when run
> > on DAX-enabled filesystem:
> > 
> > 	WARNING: CPU: 76 PID: 51024 at mm/memory.c:2317 wp_page_copy+0xc40/0xd50
> > 	...
> > 	wp_page_copy+0x98c/0xd50 (unreliable)
> > 	do_wp_page+0xd8/0xad0
> > 	__handle_mm_fault+0x748/0x1b90
> > 	handle_mm_fault+0x120/0x1f0
> > 	__do_page_fault+0x240/0xd70
> > 	do_page_fault+0x38/0xd0
> > 	handle_page_fault+0x10/0x30
> > 
> > The warning happens on failed __copy_from_user_inatomic() which tries to
> > copy data into a CoW page.
> > 
> > This happens because of race between MADV_DONTNEED and CoW page fault:
> > 
> > 	CPU0					CPU1
> >  handle_mm_fault()
> >    do_wp_page()
> >      wp_page_copy()
> >        do_wp_page()
> > 					madvise(MADV_DONTNEED)
> > 					  zap_page_range()
> > 					    zap_pte_range()
> > 					      ptep_get_and_clear_full()
> > 					      <TLB flush>
> > 	 __copy_from_user_inatomic()
> > 	 sees empty PTE and fails
> > 	 WARN_ON_ONCE(1)
> > 	 clear_page()
> > 
> > The solution is to re-try __copy_from_user_inatomic() under PTL after
> > checking that PTE is matches the orig_pte.
> > 
> > The second copy attempt can still fail, like due to non-readable PTE,
> > but there's nothing reasonable we can do about, except clearing the CoW
> > page.
> 
> You don't think this is worthy of a cc:stable?

Please, add it.

Although, if I read history correctly, it is 15 year old bug that nobody
noticed until we added WARN() there :/

-- 
 Kirill A. Shutemov
