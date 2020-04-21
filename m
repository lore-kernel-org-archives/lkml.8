Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7368C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BC8206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFldD7iE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgDUN3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:29:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbgDUN3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587475761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1Ti1KIvSIMKpnNlcfoK/lyDq223f9fsTlxlc6OUn10=;
        b=GFldD7iENmILOzgqaxgwdtJ7oMh/N9R8VZigDSor6dHeKyEid4fHcY0w+PJYxctclHDQ74
        CBWA7PSwkSxIqg4emOlW9vfVBPiyootIsumYC2GjGFw23m6jTDtuCrNKfPa3gEo0JUeVpf
        oYPigCLgT1C7MgtcXz6Na0XAS1IUhOE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-zpQmYi5ZP1yCEmIbScggYw-1; Tue, 21 Apr 2020 09:29:19 -0400
X-MC-Unique: zpQmYi5ZP1yCEmIbScggYw-1
Received: by mail-qv1-f70.google.com with SMTP id p12so13805530qvm.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O1Ti1KIvSIMKpnNlcfoK/lyDq223f9fsTlxlc6OUn10=;
        b=muI/w4FHPAGpdK6CET9C7qIZF9Fu5krtTa5VF16d5176hgEt+00xNzJT5hOLufe9Zi
         1SlymDufwXOSxaPvyhW3J4v50NPhvPSTSAriuP06/8yu8WjK4SWfE3pwul945zfkhtGa
         Jd8Xcm8lu+DLlaWp3R9/k/UkiKshvkGG0FnIerQqlN+4H5TPWqwd+LBDFxxzd11cAWq5
         t9J+wylqPq0UOEDUE5gxSlMRb3HSgm70DdwEtrahA7KlLSGYSYH9oWl5jeaxqacqrUdu
         oopI0hc/hnS2ImpmBYX7nSvJNCxYxxxjYkYaT6TM+MPS+mAgNChRl5em7FBM2CZ5pZ1b
         XFHg==
X-Gm-Message-State: AGi0PuYjZiMCbTcJ7EmRYIWSmyQRpGtC7xFvnusQeQjUspNJpYjF+aLJ
        q+x1/3722SL8bCOrvoQQoNa5PQtvJOi8vPQ/dzXonOFH7TRqB/iSRRwA8oGbB6mup0TPuyBF8C4
        cbdGTrpDHOPrGIkFBY+fYIwNg
X-Received: by 2002:ad4:4182:: with SMTP id e2mr20461675qvp.61.1587475759127;
        Tue, 21 Apr 2020 06:29:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypJsiUBEHqJ13cKuqmmb3+dM/Zyr5+I1tbzXHGGGKGAJv4bPlLe0giYLbYXDDNiFHwxQe0usGg==
X-Received: by 2002:ad4:4182:: with SMTP id e2mr20461667qvp.61.1587475758859;
        Tue, 21 Apr 2020 06:29:18 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id v188sm1739882qkh.47.2020.04.21.06.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:29:18 -0700 (PDT)
Date:   Tue, 21 Apr 2020 09:29:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm, mempolicy: fix up gup usage in lookup_node
Message-ID: <20200421132916.GE420399@xz-x1>
References: <20200421071026.18394-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421071026.18394-1-mhocko@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 09:10:26AM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> ba841078cd05 ("mm/mempolicy: Allow lookup_node() to handle fatal signal") has
> added a special casing for 0 return value because that was a possible
> gup return value when interrupted by fatal signal. This has been fixed
> by ae46d2aa6a7f ("mm/gup: Let __get_user_pages_locked() return -EINTR
> for fatal signal") in the mean time so ba841078cd05 can be reverted.
> 
> This patch however doesn't go all the way to revert it because the check
> for 0 is wrong and confusing here. Firstly it is inherently unsafe to
> access the page when get_user_pages_locked returns 0 (aka no page
> returned).
> Fortunatelly this will not happen because get_user_pages_locked will not
> return 0 when nr_pages > 0 unless FOLL_NOWAIT is specified which is not
> the case here. Document this potential error code in gup code while we
> are at it.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/gup.c       | 5 +++++
>  mm/mempolicy.c | 5 +----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 50681f0286de..a8575b880baf 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -980,6 +980,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>   * -- If nr_pages is >0, but no pages were pinned, returns -errno.
>   * -- If nr_pages is >0, and some pages were pinned, returns the number of
>   *    pages pinned. Again, this may be less than nr_pages.
> + * -- 0 return value is possible when the fault would need to be retried.
>   *
>   * The caller is responsible for releasing returned @pages, via put_page().
>   *
> @@ -1247,6 +1248,10 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
>  }
>  EXPORT_SYMBOL_GPL(fixup_user_fault);
>  
> +/*
> + * Please note that this function, unlike __get_user_pages will not
> + * return 0 for nr_pages > 0 without FOLL_NOWAIT

It's a bit unclear to me on whether "will not return 0" applies to "this
function" or "__get_user_pages"...  Might be easier just to avoid mentioning
__get_user_pages?

> + */
>  static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>  						struct mm_struct *mm,
>  						unsigned long start,
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

Again, this is my totally humble opinion: I'm fine with removing the comment,
however I still don't think it's helpful at all to explicitly remove a check
against invalid return value (err==0), especially if that's the only functional
change in this patch.

Thanks,

-- 
Peter Xu

