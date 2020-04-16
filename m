Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF47C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A74121927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qj8hoC1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394332AbgDPOcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436806AbgDPOMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:12:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E0DC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:12:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d77so4752373wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Aq3yCWYFY7wHOrarhjqlc9bx2dHHg6e1wr/Ld66Bgk=;
        b=qj8hoC1SDgxFYAOGk71xzeMxtQHSHIwu8PjiwZmBwGsSYm8IihfCJCrxSJQXtgl/X5
         c+vj6s/DYv24YDqAcfxP0rDCEsTpYk4GBQPzggmvav5urfiGyH1ZRJGVr7ex09wkDSg9
         UkAqo5nXwdI70dkW1gu71uyo+FBwMZgwCr+VDW/vG8iaXlKniFv853cJ2Ij1oYbQv24B
         iywACOyCQlFVLtOUXLo0UZnJ070gUMqihP5hdPy/x198yIny7nL2RQuqmfhp0yFtwfoT
         1gdOARsCdOIIa13ccLMoiyMMGWvR2W6vc02+JH3e/jjWGKUKYJbro6D36gYa7n5glZ/e
         0zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Aq3yCWYFY7wHOrarhjqlc9bx2dHHg6e1wr/Ld66Bgk=;
        b=K1FtiYWk024M/RuR7G56v/jIY3gjBt7PvI7KfoP0Aa3g+5q6zUKazqMP2utGEJCWRM
         VFXspwq0TV56bBEfyR85NEoC/yCBQtUks3VOI628LjzqqrsoT5K3CxKzcbFOCpEdEMDp
         /sMlpmKSDDq2atEfLP3gSSYWG84sp4r2ZFYt2KnvUF4TOpUMYpD+3pvH0iF9bxIuL+7k
         Fep1iNi6s59AlMJrkSiUFJ88P/iVoB0ntZ7r/lIVvMP/rrnAfWN74gVUjCrdLFluc2pO
         zUXmYjL6KRNOQwYBM1pI5friWAzhLH/aoyyk5BCOnvvJn17/CvkWoldR+Z9U7DAQDg9E
         4hzQ==
X-Gm-Message-State: AGi0PuZ5LKApTPjovQhnATAbT83BF05k7jfDuAeFTRK1pQPRyIb/2nXM
        BMRDRWfb9NLQ+rpMvW+7qHnxZjioOQ+Uo9xObgI=
X-Google-Smtp-Source: APiQypIdWsKrNQFF3dbcu9dwh9adYCneRxwMvuzjpcjrEw5XcBXEAlvWpyxBcdkIEMdK28QlkmPrguTfgw0bFBIiK48=
X-Received: by 2002:a1c:7f91:: with SMTP id a139mr4858422wmd.164.1587046327780;
 Thu, 16 Apr 2020 07:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200416104707.20219-1-david@redhat.com> <20200416104707.20219-2-david@redhat.com>
In-Reply-To: <20200416104707.20219-2-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 16 Apr 2020 16:11:56 +0200
Message-ID: <CAM9Jb+iBAHr+UjxZBUGugQ_+9Z0a6CPAp8gXWorE57_rOQ9xqA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] mm/memory_hotplug: no need to init new pgdat with node_start_pfn
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A hotadded node/pgdat will span no pages at all, until memory is moved to
> the zone/node via move_pfn_range_to_zone() -> resize_pgdat_range - e.g.,
> when onlining memory blocks. We don't have to initialize the
> node_start_pfn to the memory we are adding.
>
> Note: we'll also end up with pgdat->node_start_pfn == 0 when offlined the
> last memory block belonging to a node (via remove_pfn_range_from_zone()->
> update_pgdat_span()).
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 47cf6036eb31..9b15ce465be2 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -866,10 +866,9 @@ static void reset_node_present_pages(pg_data_t *pgdat)
>  }
>
>  /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
> -static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
> +static pg_data_t __ref *hotadd_new_pgdat(int nid)
>  {
>         struct pglist_data *pgdat;
> -       unsigned long start_pfn = PFN_DOWN(start);
>
>         pgdat = NODE_DATA(nid);
>         if (!pgdat) {
> @@ -899,9 +898,8 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
>         }
>
>         /* we can use NODE_DATA(nid) from here */
> -
>         pgdat->node_id = nid;
> -       pgdat->node_start_pfn = start_pfn;
> +       pgdat->node_start_pfn = 0;
>
>         /* init node's zones as empty zones, we don't have any present pages.*/
>         free_area_init_core_hotplug(nid);
> @@ -936,7 +934,6 @@ static void rollback_node_hotadd(int nid)
>  /**
>   * try_online_node - online a node if offlined
>   * @nid: the node ID
> - * @start: start addr of the node
>   * @set_node_online: Whether we want to online the node
>   * called by cpu_up() to online a node without onlined memory.
>   *
> @@ -945,7 +942,7 @@ static void rollback_node_hotadd(int nid)
>   * 0 -> the node is already online
>   * -ENOMEM -> the node could not be allocated
>   */
> -static int __try_online_node(int nid, u64 start, bool set_node_online)
> +static int __try_online_node(int nid, bool set_node_online)
>  {
>         pg_data_t *pgdat;
>         int ret = 1;
> @@ -953,7 +950,7 @@ static int __try_online_node(int nid, u64 start, bool set_node_online)
>         if (node_online(nid))
>                 return 0;
>
> -       pgdat = hotadd_new_pgdat(nid, start);
> +       pgdat = hotadd_new_pgdat(nid);
>         if (!pgdat) {
>                 pr_err("Cannot online node %d due to NULL pgdat\n", nid);
>                 ret = -ENOMEM;
> @@ -977,7 +974,7 @@ int try_online_node(int nid)
>         int ret;
>
>         mem_hotplug_begin();
> -       ret =  __try_online_node(nid, 0, true);
> +       ret =  __try_online_node(nid, true);
>         mem_hotplug_done();
>         return ret;
>  }
> @@ -1031,7 +1028,7 @@ int __ref add_memory_resource(int nid, struct resource *res)
>          */
>         memblock_add_node(start, size, nid);
>
> -       ret = __try_online_node(nid, start, false);
> +       ret = __try_online_node(nid, false);
>         if (ret < 0)
>                 goto error;
>         new_node = ret;
> --

Looks right thing to me. Will wait for others to comment.

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.25.1
>
