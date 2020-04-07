Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB86C2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FAC20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586223585;
	bh=FGE0CiASS4H74Fv60kNs4z4meKqo7Lbq8lu+ziLI3ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pZd5Fx32zGldW5wvmXCWJ8BsWn5tAmckF6mOX9YrTMhuWqJ4MOmWTJQlsLtsMK9cI
	 HY6gViBXpGOC7V5QbTCWDKyAs/1TXnNbBC02PUMyYcJd6qC6GmSIbdmwUo9UDwfbTO
	 H8eeR9OSDg6fsjj9+M327Sj35t+pfPhn8sXwmSZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgDGBjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgDGBjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:39:44 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194E720644;
        Tue,  7 Apr 2020 01:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586223582;
        bh=FGE0CiASS4H74Fv60kNs4z4meKqo7Lbq8lu+ziLI3ss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KObnXzVcgKqoIE9NBaKjl4jbo2odfyGEhXCBI8/frPvKEwViWXh1tH6IdXCEXePhp
         sixw+tGl7oEVC1B50d15ns1aWbsvSWINlR9cQ7NWL9tVfsi3Xyj7b4SK2lbQC0/U+o
         x4Q2d9HF8quUc1xswJJv9jIDWUpzB8mEmRJNh/GI=
Date:   Mon, 6 Apr 2020 18:39:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     syzbot <syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com>,
        bgeffon@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Subject: Re: BUG: unable to handle kernel paging request in
 kernel_get_mempolicy
Message-Id: <20200406183941.38a2e52026e42dbfde239a56@linux-foundation.org>
In-Reply-To: <20200407004745.GA48345@xz-x1>
References: <0000000000002b25f105a2a3434d@google.com>
        <20200407004745.GA48345@xz-x1>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020 20:47:45 -0400 Peter Xu <peterx@redhat.com> wrote:

> >From 23800bff6fa346a4e9b3806dc0cfeb74498df757 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Mon, 6 Apr 2020 20:40:13 -0400
> Subject: [PATCH] mm/mempolicy: Allow lookup_node() to handle fatal signal
> 
> lookup_node() uses gup to pin the page and get node information.  It
> checks against ret>=0 assuming the page will be filled in.  However
> it's also possible that gup will return zero, for example, when the
> thread is quickly killed with a fatal signal.  Teach lookup_node() to
> gracefully return an error -EFAULT if it happens.
> 
> ...
>
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -902,7 +902,10 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
>  
>  	int locked = 1;
>  	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> -	if (err >= 0) {
> +	if (err == 0) {
> +		/* E.g. GUP interupted by fatal signal */
> +		err = -EFAULT;
> +	} else if (err > 0) {
>  		err = page_to_nid(p);
>  		put_page(p);
>  	}

Doh.  Thanks.

Should it have been -EINTR?
