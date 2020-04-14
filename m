Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89B5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FF520578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xo16gqyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732875AbgDNNtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:49:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32020 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732845AbgDNNtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586872151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kHDd15U+utIVIYTBnW0m937vVJqUYSl9E32F9MiM/Ow=;
        b=Xo16gqyNi1Xgmp2JnAkREmThiJLHqZT6E0HWAaqpxNxnI5nmV9n07bEM2wCwWO74f7xFVk
        MIP5cmvPlCrsTMMdXB/1J1wMab9Tf4k4choaJujvY9Bvmg9tOZxCwkzcIuahrjvLDvw/uF
        5167Uwvy/X+IvuqLpoOhGi2OBBek2iA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-EcfC1Hj9NgqdJcb85Fgj8w-1; Tue, 14 Apr 2020 09:49:10 -0400
X-MC-Unique: EcfC1Hj9NgqdJcb85Fgj8w-1
Received: by mail-qk1-f197.google.com with SMTP id g63so4110517qkd.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kHDd15U+utIVIYTBnW0m937vVJqUYSl9E32F9MiM/Ow=;
        b=pxnEVbCiHsEnH5H4TNu7v/Z24Bde+2hPNj5oDet+JgKS0QywdWPbEaINA9tQ4TmZey
         ylBMbn2CbGgOYYOCXfnYAP0wvpGmI8ullGV5Jg0K00c1H37QW+N0orhtayCnehMd0vQ+
         uH+SzrE52SecoxpPfOlSDyG3zzEYPrRD/oS+fYwaq9ZT7/2Z5jyJN8UtA426EzV9aD7W
         zvqoNumlHIMMf1SjZVtf0uyBi938QGbfWaBVXiYEjGXQXF96pgtZIVAsDSIJFty9if90
         isj8JcTwx1P+boOFU66hayDGvpUB8pw9N4uyFXaG0rU1LWlO6rePARERutCt6XReU9b3
         OhWQ==
X-Gm-Message-State: AGi0PubyDbB2Lcvb6TAMxaMf3xUQT0tTwBQpSkChPwyH/SCYRQLGMdmC
        jPk5ZTokut8tvYzTrOCu3iW6X2kJVRsJbL+0Xh+yR80cmSOkRQiHn93vCmD8QwSgIZnqHR4klHP
        ZTG60xUeuUyFcKoOCqfwlGHZy
X-Received: by 2002:ac8:23ed:: with SMTP id r42mr16349883qtr.372.1586872149304;
        Tue, 14 Apr 2020 06:49:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypKk1CxvePF721u7zCAPiQ9xQbBy20rE/GYRkwegXAxvCmLozUAOeoCxNg/oiUCi+k1GjuUhog==
X-Received: by 2002:ac8:23ed:: with SMTP id r42mr16349845qtr.372.1586872148758;
        Tue, 14 Apr 2020 06:49:08 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id c41sm7218899qta.96.2020.04.14.06.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 06:49:07 -0700 (PDT)
Date:   Tue, 14 Apr 2020 09:49:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200414134906.GF38470@xz-x1>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
 <20200409070253.GB18386@dhcp22.suse.cz>
 <CAHk-=whwRqkwdaJQf4g0-Evd6RmXR3dkkKyfnPjbnkeia=b1ug@mail.gmail.com>
 <20200414110429.GF4629@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200414110429.GF4629@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 01:04:29PM +0200, Michal Hocko wrote:

[...]

> @@ -1247,6 +1248,10 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
>  }
>  EXPORT_SYMBOL_GPL(fixup_user_fault);
>  
> +/*
> + * Please note that this function, unlike __get_user_pages will not
> + * return 0 for nr_pages > 0 without FOLL_NOWAIT
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

Hi, Michal,

IIUC this is not the only place that we check against ret==0 for gup.
For example, the other direct caller of the same function,
get_vaddr_frames(), which will set -EFAULT too if ret==0.  So do we
want to change all the places and don't check against zero explicitly?

I'm now thinking whether this would be good even if we refactored gup
and only allow it to return either >0 as number of page pinned, or <0
for all the rest.  I'm not sure how others will see this, but the
answer is probably the same at least to me as before for this issue.

As a caller, I'll see gup as a black box.  Even if the gup function
guarantees that the retcode won't be zero and documented it, I (as a
caller) will be using that to index page array so I'd still better to
check that value before I do anything (because it's meaningless to
index an array with zero size), and a convertion of "ret==0" -->
"-EFAULT" (or some other failures) in this case still makes sense.
While removing that doesn't help a lot, imho, but instead make it
slightly unsafer.

Maybe that's also why ret==0 hasn't been reworked for years?  Maybe
there is just never a reason strong enough to do that explicitly,
because it's still good to check against ret==0 after all...

Thanks,

-- 
Peter Xu

