Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEA3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2668320738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590191584;
	bh=HRrdOuGUdvjl0wXxA5ZTMAtvsW5wKqP1K72cTMtDBds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LUsfBN3rg7ffhfpPIBarysJtmP7wSG2W4cjLEkkJZQN46v6RE4GBwJl+n95NSrVPS
	 hHpLDQVHY8Dvz1CpQjLbdiakW9o8ip/GQFXs4g8xO6na+CoCm1id6S37g4esgF4tCW
	 AauqPb36NoYRXAwc/CXXQei2/MlnV91fyrafwBhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgEVXxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 19:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387437AbgEVXxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 19:53:03 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E057B206BE;
        Fri, 22 May 2020 23:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590191582;
        bh=HRrdOuGUdvjl0wXxA5ZTMAtvsW5wKqP1K72cTMtDBds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1AlseEXERTVm6vSNK1ukfK+IKevlLvrv6Ut5WPfcaxPjEQDtTwQU1c78tP25poSPW
         Pkl8eSf9lB28MNNLVVALtVRBzSnpqvBMMBfnOi5Q3QgSu4rEMqixny1o33eD6zyvPb
         ZVWFPXMqETTQHAGv+cqRhqFBFl0fIYa3FdeSmo0I=
Date:   Fri, 22 May 2020 16:53:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Dave Chinner <david@fromorbit.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup
 code
Message-Id: <20200522165301.727977de1d39ac5bfb683ed0@linux-foundation.org>
In-Reply-To: <906f7469-492d-febc-c7ed-b01830ae900d@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
        <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
        <20200521225220.GV2005@dread.disaster.area>
        <906f7469-492d-febc-c7ed-b01830ae900d@cloud.ionos.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 09:18:25 +0200 Guoqing Jiang <guoqing.jiang@cloud.ionos.com> wrote:

> >> -	ClearPagePrivate(page);
> >> -	set_page_private(newpage, page_private(page));
> >> -	set_page_private(page, 0);
> >> -	put_page(page);
> >> +	set_page_private(newpage, detach_page_private(page));
> > attach_page_private(newpage, detach_page_private(page));
> 
> Mattew had suggested it as follows, but not sure if we can reorder of 
> the setup of
> the bh and setting PagePrivate, so I didn't want to break the original 
> syntax.
> 
> @@ -797,11 +797,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
>          if (rc != MIGRATEPAGE_SUCCESS)
>                  goto unlock_buffers;
>   
> -       ClearPagePrivate(page);
> -       set_page_private(newpage, page_private(page));
> -       set_page_private(page, 0);
> -       put_page(page);
> -       get_page(newpage);
> +       attach_page_private(newpage, detach_page_private(page));
>   
>          bh = head;
>          do {
> @@ -810,8 +806,6 @@ static int __buffer_migrate_page(struct address_space *mapping,
>   
>          } while (bh != head);
>   
> -       SetPagePrivate(newpage);
> -
>          if (mode != MIGRATE_SYNC_NO_COPY)

This is OK - coherency between PG_private and the page's buffer
ring is maintained by holding lock_page().

I have (effectively) applied the above change.
