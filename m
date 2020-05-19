Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B52C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417512075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589865158;
	bh=qrHKafA0ZTttPnEqF3hkLOvbCl6Fprw9RuG7qytReC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ly9I0IyDmBoaVeChcu4jB+dfgyB4H2LWKeVtTSMennyQ+PtWfuJ0nXCc9DFFJG9hL
	 z7737W+DkoZyOuyrbLJ5dWJSiuTMI90FZiWT1DksQxmlvPbaznJQHnXevv7klQHAWl
	 SVBTq1YOjTJZV/lIGAx0eKFvYwzKAGdbm7PStEgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgESFMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgESFMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:12:37 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B93020758;
        Tue, 19 May 2020 05:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589865156;
        bh=qrHKafA0ZTttPnEqF3hkLOvbCl6Fprw9RuG7qytReC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nlbIrf8Fy8HDlKACQi91AHg9NqzN0RQ0bvP2OUb2TFrW0wClvkadR8udy9FhxT6j0
         QUNapjpdTE6IrfWtYzBdLzBnAHKQj3h7a4JlCowDPcDkGEKeDdsS/iNy8dk528O4qg
         nbm9Y07gMePXo5wP9r4/4P2ShQhKEdTZ2+DDbmOc=
Date:   Mon, 18 May 2020 22:12:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
Message-Id: <20200518221235.1fa32c38e5766113f78e3f0d@linux-foundation.org>
In-Reply-To: <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
        <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 May 2020 23:47:18 +0200 Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:

> We can cleanup code a little by call detach_page_private here.
> 
> ...
>
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -804,10 +804,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
>  	if (rc != MIGRATEPAGE_SUCCESS)
>  		goto unlock_buffers;
>  
> -	ClearPagePrivate(page);
> -	set_page_private(newpage, page_private(page));
> -	set_page_private(page, 0);
> -	put_page(page);
> +	set_page_private(newpage, detach_page_private(page));
>  	get_page(newpage);
>  
>  	bh = head;

mm/migrate.c: In function '__buffer_migrate_page':
./include/linux/mm_types.h:243:52: warning: assignment makes integer from pointer without a cast [-Wint-conversion]
 #define set_page_private(page, v) ((page)->private = (v))
                                                    ^
mm/migrate.c:800:2: note: in expansion of macro 'set_page_private'
  set_page_private(newpage, detach_page_private(page));
  ^~~~~~~~~~~~~~~~

The fact that set_page_private(detach_page_private()) generates a type
mismatch warning seems deeply wrong, surely.

Please let's get the types sorted out - either unsigned long or void *,
not half-one and half-the other.  Whatever needs the least typecasting
at callsites, I suggest.

And can we please implement set_page_private() and page_private() with
inlined C code?  There is no need for these to be macros.

