Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEEFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC2320737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4rYlUDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgGBL7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGBL70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:59:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C71DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:59:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w16so779737qts.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdEoyg5cz5gqKw5XA1ird4Jwpq42Fb0cYp9G68e5U8k=;
        b=A4rYlUDqufFtk3BWPSKmxkjmWJniPMPBX+Azpwopdu0pJnbXDuoB1EGnDXYJyp3FUR
         fiyUMV3zo8XvAQDWX8QIeeKZvfPHlwEMWra+sZJ3lOxF1mdPnpV+W4Ekiacq3xI0qFeI
         LKgJt6jpqVfstXbYSqXstgvIsp35o6za3BtPdCtWUwB0InIMCIoeByhVm9n3S+ZwJiv6
         Qeon25PCtJfOM1SLPwcvWIX1+GD0Dk6GjwrscF+1m+EUrL7y2J4a/8CmYp1YvtI+EiQX
         K1xPMJH6YLihVypYT4LdQDEsQs3l2ivPDSeCbFZ9jGrq1XvQADo91m7nCwqcuvnxvJAb
         fHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdEoyg5cz5gqKw5XA1ird4Jwpq42Fb0cYp9G68e5U8k=;
        b=AQVwYgR5BWjdRk3COz7Da9rHJUH+PT4Qsd3ceuerZemzgON1h7LdDu+ArrPbr08wwF
         iJY/j5YAdqwiB3+xzFSs0omK3f35l9T5sWUjZAKwSEmrk7iNPFs1XwnIs4tk4FD3SJbe
         72Kiez0WyHWwCZbDedXwX8a4mfjh0fJmVy/VGkhbNUfEWCC4q1Z3Z9ftDp4TSCOZbp9p
         LFr7rZ5T6FdINwQ6ryS7fLKrw+SSc6WNnRypRdN36oXdrRMarJju3MPDJHB+MQy9hXTV
         xnjyL7h3OmNjBMWLsdHVIan0TTSCzjIu+9Z/JTBzWs6Sif4puQWtX7T0c9b9RCKYGdfq
         XghQ==
X-Gm-Message-State: AOAM531Z5L0WJveP63qPMn4wPNezOVidrbblY07IKidWtSB8PPNFDIB4
        OxbOCVcSZ9xSNVzsr60CZ1pYux6lXwnkMfq1vd9811eP
X-Google-Smtp-Source: ABdhPJxE5hLn/2Xwu5PYobN8sCXVCTbkkX2J9Tvr2Tg3TcwVzfzulqt0c7NW+md/LMSebK41q+4uZUaZXkMgr2cUG08=
X-Received: by 2002:aed:3201:: with SMTP id y1mr30549256qtd.156.1593691165663;
 Thu, 02 Jul 2020 04:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
In-Reply-To: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Thu, 2 Jul 2020 14:59:07 +0300
Message-ID: <CAOJsxLErUqY=eBEaj0G3iRAY-YuyyLnxOnBLTP6SkCjhq1On2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial objects
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 11:32 AM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
> The node list_lock in count_partial() spend long time iterating
> in case of large amount of partial page lists, which can cause
> thunder herd effect to the list_lock contention, e.g. it cause
> business response-time jitters when accessing "/proc/slabinfo"
> in our production environments.

Would you have any numbers to share to quantify this jitter? I have no
objections to this approach, but I think the original design
deliberately made reading "/proc/slabinfo" more expensive to avoid
atomic operations in the allocation/deallocation paths. It would be
good to understand what is the gain of this approach before we switch
to it. Maybe even run some slab-related benchmark (not sure if there's
something better than hackbench these days) to see if the overhead of
this approach shows up.

> This patch introduces two counters to maintain the actual number
> of partial objects dynamically instead of iterating the partial
> page lists with list_lock held.
>
> New counters of kmem_cache_node are: pfree_objects, ptotal_objects.
> The main operations are under list_lock in slow path, its performance
> impact is minimal.
>
> Co-developed-by: Wen Yang <wenyang@linux.alibaba.com>
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> ---
>  mm/slab.h |  2 ++
>  mm/slub.c | 38 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 7e94700..5935749 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -616,6 +616,8 @@ struct kmem_cache_node {
>  #ifdef CONFIG_SLUB
>         unsigned long nr_partial;
>         struct list_head partial;
> +       atomic_long_t pfree_objects; /* partial free objects */
> +       atomic_long_t ptotal_objects; /* partial total objects */

You could rename these to "nr_partial_free_objs" and
"nr_partial_total_objs" for readability.

- Pekka
