Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37565C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09ECD206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AQ5KOkV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgESDuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgESDuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:50:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5EFC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:50:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l5so3965341edn.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEQ9qTm1gqgdFjPFW3OQAVDn5qaony6GoNhcdizYj6g=;
        b=AQ5KOkV3NvNX5xxC0VyBzJ78fqzvuA3q+oXuH0H+EoqUa+nF2KrjyYK4dwcsXL9yFO
         LrZybd3jK6WUuRqFJAudihfOSqoHYnWIsWl9JgALjgK0fg/EGLfV5IzWtHIaYjEYOjkE
         7Y1OsQevLv0p3IvRjPDG8Gyq0XmsIhAHONIgzjFSXhlvPPP8BFUt+VWgKhVtGe2Z95tN
         kIm14MwMdnY9F218ByZrNlR/NtSSe7nczGDbY1RBeeH6yf+RFCvDxVpc/hJbcV4k6+KH
         SQSxoFQp19OUUqj2bJX0JrD98enMtTL4uIenElBtWLN3vDRrpMOKTwagooblCZeiff28
         SWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEQ9qTm1gqgdFjPFW3OQAVDn5qaony6GoNhcdizYj6g=;
        b=bOpid0+z9FR403qnsGo/B0YoONMm0O0Dql93R6g9YLcLcyex4pnxD+2ptXkcCjOh8i
         WxogAe4oXjJlKowXzPQLejoJTl4RVOimzCYppsADrdDWnyN7T8PyS7lRKzLES9vvbRU0
         lMOjbDdIm3X+Bjx0KeAUpMLlhldB5tUjaeEFDP0wtbDSuq/8H83nnTfWxgoDMJPXptiz
         QOEz3hZTsKpwUltrAd/4yuXyBvjUgsnO6RCiDnOylVb6aAnMiyK5oXtZN1fbuPhNxl7X
         jRf+PXHot7y9boSlZwyJS0b855FfurERX7cpX9bKf1vFfDHk0/qptjKQJu/tfKCR9mPl
         xQ0w==
X-Gm-Message-State: AOAM530DSWldYgdDqLMg6EHQxoBS0EJxG6eBrG7LT434hnHbl2EbVJT1
        9aZ3HsLKkYvVHGh9B8KjK6S1aK6D2r5KfidA3r/EhQ==
X-Google-Smtp-Source: ABdhPJw4jR6m0fMVDO2FB+R6zYwNqrdt5nWWX9i23iqjClsTlQ7f6HqZi7cwlwRgKDySqKqRLOiocJK3S8cMCJ24Uco=
X-Received: by 2002:a50:ee1a:: with SMTP id g26mr16103774eds.18.1589860216078;
 Mon, 18 May 2020 20:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <D90B73BA-22EC-407E-838F-2BA646C60DE0@lca.pw> <CAM4kBBKkOGOjT5fddQ_vongNx_cXmv0tCQzD9ZtrGgkuPTKfTg@mail.gmail.com>
In-Reply-To: <CAM4kBBKkOGOjT5fddQ_vongNx_cXmv0tCQzD9ZtrGgkuPTKfTg@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Date:   Mon, 18 May 2020 23:50:05 -0400
Message-ID: <CAG=TAF65nmW2m9-5z5xvLmfRAD0LZAxgARJOEAqvzA3GdN-iJA@mail.gmail.com>
Subject: Re: zswap z3fold + memory offline = infinite loop
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 4:28 AM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
>
>
>
> On Wed, May 13, 2020, 2:36 AM Qian Cai <cai@lca.pw> wrote:
>>
>> Put zswap z3fold pages into the memory and then offline those memory would trigger an infinite loop here in
>>
>> __offline_pages() --> do_migrate_range() because there is no error handling,
>>
>>                         if (pfn) {
>>                                 /*
>>                                  * TODO: fatal migration failures should bail
>>                                  * out
>>                                  */
>>                                 do_migrate_range(pfn, end_pfn);
>>
>> There, isolate_movable_page() will always return -EBUSY  because,
>>
>>         if (!mapping->a_ops->isolate_page(page, mode))
>>                 goto out_no_isolated;
>>
>> i.e., z3fold_page_isolate() will always return false because,
>>
>> zhdr->mapped_count == 2
>
>
> So who mapped these pages? The whole zswap operation presumes that objects are mapped for a short while to run some I/O and so, most of the time zhdr->mapped_count would be 0.

I have no clue why those pages have been mapped for so long, but it is
trivial to reproduce using the above reproducer. Also, zbud has no
such issue. Alternatively, if you could send me some debug patches to
narrow it down, I'll be happy to run for you.

>
> Removing that check in ->isolate() is not a big deal, but ->migratepage() shall not allow actual migration anyway if there are mapped objects.

Is that worse than an endless loop here?
