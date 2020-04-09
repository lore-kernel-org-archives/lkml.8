Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2525DC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE6C214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFUvtVbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgDIMxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:53:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52572 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgDIMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586436783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UJ8l1p54wLtVDTNVzRQ+mEc9oxmPqrcpsMPGlGWNMSI=;
        b=DFUvtVbvwulizyyAWGFhV2vud0UWmvt1natizmEWmoQVVfnSab1wpKHn5gQTLklldSJRr3
        3UnMPwcC1pq8J68eiHd/HaKdMdLfw19UycrR5ABPUk9vipitvGbZ+09QrldBaoySPj6d2Z
        xB5LLDKDyp3Km9ZX7nv977ipa0a7914=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-u6V_zCS4PfSpUt36VHxsaQ-1; Thu, 09 Apr 2020 08:53:01 -0400
X-MC-Unique: u6V_zCS4PfSpUt36VHxsaQ-1
Received: by mail-qk1-f198.google.com with SMTP id a21so3311861qkg.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 05:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UJ8l1p54wLtVDTNVzRQ+mEc9oxmPqrcpsMPGlGWNMSI=;
        b=oUDux/tr4D/q1Z+MdLzCC6Hpl2oJJbH6vtwvYcBnSpyn2P1Au0rKpSgNn+IeQ9ZEer
         qfE4mN963xZbIpIn0yoWWGcALgJLDeHA/mLTSPpe1fQ8IgTSZWyxbwnGj7mWicRyrp5O
         p2eReku8gfEre4hU8J3Cx+aC48M0U5SCX1A0pvfMh0/NPTN2Qw+O2Tae4u4xya4m/jvo
         n8DMN2JkECDIW/iV6o9zjjl8BEwRp9qaF+6njXjAY5urH8269tdS6hbcdXvV2j38mrBY
         qf5HzJkuCd4On3lxQ53YCM6Mmod5KDBqqfNhtXuzwQJbD2fiEWnu0nJMW1G599S/DIw2
         I05A==
X-Gm-Message-State: AGi0PuZdWik3FU2Xx4if/AFVMorPH44RA1bn0wL36RwGbO0tK05kLUGX
        rBu/TTFglMac/pAk9YO5Yr3XblA0xSfnBDKdrOGq5c0+OOKgADmXopqIp+WQltYUhV/F7q6bT+Y
        ONQnjG3bv8JICz2EFBKd0DQ70
X-Received: by 2002:a37:7c81:: with SMTP id x123mr12364967qkc.287.1586436781005;
        Thu, 09 Apr 2020 05:53:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypKs46HRUuA2iZ26LOxmT8ROmbHlW4Gx1GyFUpSOTrLv6m31QwIZ+9VHuUOBK95dWFIrE+zZOQ==
X-Received: by 2002:a37:7c81:: with SMTP id x123mr12364944qkc.287.1586436780743;
        Thu, 09 Apr 2020 05:53:00 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p10sm2274167qtu.14.2020.04.09.05.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 05:52:59 -0700 (PDT)
Date:   Thu, 9 Apr 2020 08:52:58 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200409125258.GA362416@xz-x1>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
 <20200409070253.GB18386@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200409070253.GB18386@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 09:02:53AM +0200, Michal Hocko wrote:
> This patch has been merged and it is actually wrong after ae46d2aa6a7f
> has been merged. We can either revert or I suggest just handling >0,
> like the patch below:
> 
> From 03fbe30ec61e65b0927d0d41bccc7dff5f7eafd8 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Thu, 9 Apr 2020 08:26:57 +0200
> Subject: [PATCH] mm, mempolicy: fix up gup usage in lookup_node
> 
> ba841078cd05 ("mm/mempolicy: Allow lookup_node() to handle fatal signal") has
> added a special casing for 0 return value because that was a possible
> gup return value when interrupted by fatal signal. This has been fixed
> by ae46d2aa6a7f ("mm/gup: Let __get_user_pages_locked() return -EINTR
> for fatal signal") in the mean time so ba841078cd05 can be reverted.
> This patch however doesn't go all the way to revert it because 0 return
> value is impossible. We always get an error or 1 for a single page
> request.
> 
> Fixes: ba841078cd05 ("mm/mempolicy: Allow lookup_node() to handle fatal signal")
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/mempolicy.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 48ba9729062e..1965e2681877 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -927,10 +927,7 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
>  
>  	int locked = 1;
>  	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> -	if (err == 0) {
> -		/* E.g. GUP interrupted by fatal signal */
> -		err = -EFAULT;
> -	} else if (err > 0) {
> +	if (err > 0) {
>  		err = page_to_nid(p);
>  		put_page(p);
>  	}

Hi, Michal,

I'm totally not against this, but note that get_user_pages_locked()
could still return zero. Although I'm not 100% sure now on whether
npages==0 will be the only case, it won't hurt to keep this ret==0
check until we consolidate the whole gup code to never return zero.

Assuming there's another case (even possible for a future gup bug)
that could return a zero, your patch will let err be anything (which
you didn't initialize err with your patch), then the function will
return a random value.  So even if you really want this change, I
would suggest you initialize err to some error code.

I just don't see much gain we get from removing that check.

Thanks,

-- 
Peter Xu

