Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F44C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3ED207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vh12em2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHROzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHROzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:55:40 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B30C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:55:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j9so17820068ilc.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTTAJhh4NfjRHYn5UI6mlznlBlZYFizrT8lslR+Z18E=;
        b=vh12em2jvehxMcRPxHt0I2lWNAsDN3sZSBXx4kJbYF0NfJXsSIE1NVVqTy/+6tKJMF
         7RB2EYuxpr1PxGbqVNEez8GM8mwOByVxPSd//nQ8WoZoNLKX0s5deJPv5469v9sIjtgq
         G0W0pU17InFXwODo47EKbwVzWeJy2mXrQ/8xTyTe+JvYDKk8PXR2c5IAQ+oylPbs7q/n
         aUrX1f/Djm6IdJRF89V2qMW0DmEw/cvdPN5ZMpGWLCunkU8Ioc7AEfKYsqPZaqI/AliI
         IltgHRorX6o2IcZX+N/J20iW5PEzuToOZ+bIIE//rL/pr+FsDUj65rt8QANZIIsJDrpM
         X69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTTAJhh4NfjRHYn5UI6mlznlBlZYFizrT8lslR+Z18E=;
        b=LOg4AXhc77t50P5YMYSwR6BijBkTbejonHyK39ALNYi3qd4rpD3+EIyZcWsNWc12LU
         6lPdje7r9nRXtOvE9tAt+X7VhFbSZau1AoE5szfNTF2cIW97Qe93YZOmDKa5k0HNqqlz
         tEf8SnV29HKun9AbIacsz6DFZuJ7GDxSRgV/yHaLt4361a2KBa4a+HzLulp0o/wVTpEG
         ac+2OZ/nHS4ZAv6BC6XkMtg3AZ1NUffl07rgcSA2epNe2wOlXGusBGrOvIQR6KA7aCRk
         hyQUQFQP9QVUtnwHvS4aRqP1eOvonAW8L6EehT6jhAqYs1rRxuwszTmzlO1QVXyCPXxc
         Mc7A==
X-Gm-Message-State: AOAM530dCzl6KmFHAGVfnDpLdczpkZBz/0HAIjcKQNbO8BdHwUAGJvP3
        /Xe5yXhgZckzF9MYt879K57ur3k9tbd8sKreWRI=
X-Google-Smtp-Source: ABdhPJyugOzq1mpedIjjSmTESPhs9cSE7mixc1n80W/RK28kNpOwE78cHLlZbvm3vZliI5m8Ws6AWgiGDZyM2eNZf40=
X-Received: by 2002:a92:d646:: with SMTP id x6mr18734591ilp.237.1597762539068;
 Tue, 18 Aug 2020 07:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200818084448.33969-1-richard.weiyang@linux.alibaba.com>
In-Reply-To: <20200818084448.33969-1-richard.weiyang@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 18 Aug 2020 07:55:28 -0700
Message-ID: <CAKgT0UfQ4BGygD-r+uVpMhF2RBAynhZp54H-6EVrEc7PdESNqQ@mail.gmail.com>
Subject: Re: [Patch v2] mm/page_reporting: drop stale list head check in page_reporting_cycle
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 1:45 AM Wei Yang
<richard.weiyang@linux.alibaba.com> wrote:
>
> list_for_each_entry_safe() guarantees that we will never stumble over
> the list head; "&page->lru != list" will always evaluate to true. Let's
> simplify.
>
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_reporting.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 3bbd471cfc81..aaaa3605123d 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -178,7 +178,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>                  * the new head of the free list before we release the
>                  * zone lock.
>                  */
> -               if (&page->lru != list && !list_is_first(&page->lru, list))
> +               if (!list_is_first(&page->lru, list))
>                         list_rotate_to_front(&page->lru, list);
>
>                 /* release lock before waiting on report processing */

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
