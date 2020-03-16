Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E972C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0552051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAFK1uuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbgCPQ2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:28:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45073 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731884AbgCPQ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:28:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id t2so11972198wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INtESC7LaymD+ZrokYwY/ad7JOusvguI8SpcCtk9QTU=;
        b=DAFK1uuq7wY2sQ4B4diRYu5SUY2n7ytN7R9Mk7WUdWye4u+2F4oqiqO2t77Gqal7lD
         rHIyv3mvFyw6z/fisE684rYZwXHusE/t3LfKUr4QiX30XBA+H9XIjfWGmYjfgeTuk6FS
         Z+KmzL4f0Iqy/4jLiIFE0MAem8SlNwXn/YZocogI+qR4xJ0fEdVJtTgmfLnF5RZnZAf0
         kRCdSG7IK+fRUhwfrc18iIYDCehwKV9dlG9x2xXEktlJwIN9KqvOrCsdBiHXa/r4onre
         +Z1TM9LlU6sYI8X7pPtxcOfBG2PwoTJ08P2OeDxGVQx0BBy0ASNzvj5PajCYZQkiTAUh
         JrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INtESC7LaymD+ZrokYwY/ad7JOusvguI8SpcCtk9QTU=;
        b=Ar+KA6oCEZCBAc7aTnTAV+UHy2lo8HOAUlYhrBK36IF4Xle9AFNHRB06S2lkJW17t0
         hzgMXz9bH80QtSWlxCG15h1ddpISO0OXHciEdDk9Wx6lJgITzMhLGGRG41MCRLIUkItB
         5ZgKGyqHu7uV1TB0XzuO8oY8x56fwG8OHJWDI3XOMX3W9jn/mQ3F6RozmR8L5hMRyld1
         UkNotCqkuo3eU10bBrlp6CzYhFmtJlT6igXrUUkkydEhrBAPJeQ/N1Xg4EJqWXIU7O+l
         kutg8GGfZGiULJq6YAEnPg1IEvqcbkeLBRXDli+5VkOnvna0QfaQlPr+EpOaRRNds3Zb
         iZxw==
X-Gm-Message-State: ANhLgQ1QW4pRfMsRSxeiflQburW0b91zUOjsbjT4ROUZaHnJYX3lGNnS
        0BsSrwn8Y/7I+Z/0ld8q3HcIX2nCHp/LF1xvDKg=
X-Google-Smtp-Source: ADFU+vvEySzO9mn2X5PpSIqCEpCLL7mvrxB9ayexrjw+ipuMsCaIURnQnGgitbzQLyZbmOH0n1ynwhzvbtQXKOgvsrY=
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr134402wrw.289.1584376112780;
 Mon, 16 Mar 2020 09:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200316102150.16487-1-bhe@redhat.com> <20200316102150.16487-2-bhe@redhat.com>
 <20200316125625.GH3486@MiWiFi-R3L-srv>
In-Reply-To: <20200316125625.GH3486@MiWiFi-R3L-srv>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 16 Mar 2020 17:28:21 +0100
Message-ID: <CAM9Jb+hHpeHL5OQfJ4FLT6FnWboegG0f-d7o7FEoD21APnQX3Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm/sparse.c: allocate memmap preferring the given node
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, willy@infradead.org,
        richard.weiyang@gmail.com, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When allocating memmap for hot added memory with the classic sparse, the
> specified 'nid' is ignored in populate_section_memmap().
>
> While in allocating memmap for the classic sparse during boot, the node
> given by 'nid' is preferred. And VMEMMAP prefers the node of 'nid' in
> both boot stage and memory hot adding. So seems no reason to not respect
> the node of 'nid' for the classic sparse when hot adding memory.
>
> Use kvmalloc_node instead to use the passed in 'nid'.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/sparse.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 3fa407d7f70a..31dcdfb55c72 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -719,8 +719,8 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  struct page * __meminit populate_section_memmap(unsigned long pfn,
>                 unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
> -       return kvmalloc(array_size(sizeof(struct page),
> -                                  PAGES_PER_SECTION), GFP_KERNEL);
> +       return kvmalloc_node(array_size(sizeof(struct page),
> +                                       PAGES_PER_SECTION), GFP_KERNEL, nid);
>  }
>
>  static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
> --

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.17.2
>
>
