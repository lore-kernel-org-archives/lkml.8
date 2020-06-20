Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21725C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F0822D05
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YXI2uDsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbgFTBle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731400AbgFTBle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 21:41:34 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D7EC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 18:41:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k11so12197203ejr.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 18:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGEKlCMwGCVdgAUnlLlbikbWphYIp6lmyRBiC34xvQY=;
        b=YXI2uDsxPIP5ikjSuPaoUIF1ub+ItyOscirT0PZX6vg5+S9mPCXhIixyDfmWkUXF2/
         bGtT5MMsoK0KB1oN0FS8bAWiBHLJ1TJxoaObYThsr4ACcF60AupjpzkMEv2DkySF+2jw
         i7DfE/dF8LfVQjnLlxhyGdB5uOX+JY9BocyLkq5YyVyc0ywIsmTqEeVLfBY1j0mX/OSN
         pMRU14+JMtSgP4f8ozG7j4PTKh/+YOWGGfTITRSDNwPDd3PbAaOBVHW8LGNrKljVIAzA
         tBftNKW/7zWcmS70mDCjWpXQjCQPSqayKz3jfPbC301Xf4J4YO+tZJyxuO/dJszlk9m0
         xwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGEKlCMwGCVdgAUnlLlbikbWphYIp6lmyRBiC34xvQY=;
        b=Z4EVoTyrqtKkM9moYpRoU/8bcoq6GN0l0wgxpZ1DRL7ALoQSZTXbcZa3vQaLY4XTxy
         ti3Hzh2oGHeXkhcfQfq7PmRUANX07Sr1iyNx3PFAjGDfP+A4NdmvtoK3SPSq8DQC13nz
         E/0BLJmKDLd3ZvTD2Nc33uNqKlNtRL52pUoJQ/PsRofPpol7eoYDitMuSCSCZjnE/C1T
         4az53KbaoJYIEpQ7lR0OXX+1Gy+2G3TWRfUNuxUwNYpNUH3ap8YmdI9k98LPKgzK6dcA
         0kyeWvvZPtZ+c1wV/ypI6XgBNwCvckthSIA14KpKs8Wxp2hK31IxXJEJqsXKVCm75IfZ
         Gd6Q==
X-Gm-Message-State: AOAM530BacZGVbOwINiULlw1yPOj78qYKofppmERZWu6sr+99GtN8Eta
        9qiZ2ZqV4tALVEq7eUugCznmd7MGDwqKf8DOpzYblw==
X-Google-Smtp-Source: ABdhPJymAe1wIbRyau9RlQ6rtHNZw5DceIsixBfHh6SSvyh/IXmUxdYQl3Gloshx2qUoNe5r4vkQUkPYAmNv0UbeP2s=
X-Received: by 2002:a17:906:fac8:: with SMTP id lu8mr6018617ejb.432.1592617292159;
 Fri, 19 Jun 2020 18:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200619125923.22602-1-david@redhat.com> <20200619125923.22602-3-david@redhat.com>
In-Reply-To: <20200619125923.22602-3-david@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 19 Jun 2020 18:41:21 -0700
Message-ID: <CAPcyv4hgHmnKd-isUbSy5PjohjhhCL03Y00x0NO8=JOvexvUtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: document why shuffle_zone() is relevant
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 6:00 AM David Hildenbrand <david@redhat.com> wrote:
>
> It's not completely obvious why we have to shuffle the complete zone, as
> some sort of shuffling is already performed when onlining pages via
> __free_one_page(), placing MAX_ORDER-1 pages either to the head or the tail
> of the freelist. Let's document why we have to shuffle the complete zone
> when exposing larger, contiguous physical memory areas to the buddy.
>

How about?

Fixes: e900a918b098 ("mm: shuffle initial free memory to improve
memory-side-cache utilization")

...just like Patch1 since that original commit was missing the proper
commentary in the code?


> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9b34e03e730a4..a0d81d404823d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -822,6 +822,14 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>         zone->zone_pgdat->node_present_pages += onlined_pages;
>         pgdat_resize_unlock(zone->zone_pgdat, &flags);
>
> +       /*
> +        * When exposing larger, physically contiguous memory areas to the
> +        * buddy, shuffling in the buddy (when freeing onlined pages, putting
> +        * them either to the head or the tail of the freelist) is only helpful
> +        * for mainining the shuffle, but not for creating the initial shuffle.

s/mainining/maintaining/

> +        * Shuffle the whole zone to make sure the just onlined pages are
> +        * properly distributed across the whole freelist.
> +        */
>         shuffle_zone(zone);
>
>         node_states_set_node(nid, &arg);

Other than the above minor fixups you can add:

Acked-by: Dan Williams <dan.j.williams@intel.com>
