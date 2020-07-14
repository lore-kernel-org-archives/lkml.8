Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA19BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C76121897
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViRM9gIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGNIhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgGNIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:37:51 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:37:50 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p205so7893687iod.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXcvlRkL+rP00wIkwxgaUUeJruwfzTk+tSb1yGBtYmE=;
        b=ViRM9gIJdvZpZ70h5V18lNlz42DdiJjWHAySlSiZaRqdSMYDEIF4GVCoogQUsYYx7a
         iV2IamjZVmDh2TSD4SUEvRFICzdIyjXWG5lRN5eS8KaU7C8ip+BZ42O+uf0Vmkl/+yS7
         W9OQ7nD7XLV2HlbUVgjuvhapmfx5XH6Q0zvE9sAXxV8BTl3KpbtWdVVQoJtK/cYz5fAs
         QKGyr3Ca0vWDCoekuo60137XBx592F+GaNtpdff8/z2LTa2GpPPCCgVZlssS/lH1jmxx
         wH6P51vZzZlPtjUZiiT91O1pTIw4oCioFvMMVLrA4faNkByCEvskjvXB7M6Iw27jtBtz
         RWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXcvlRkL+rP00wIkwxgaUUeJruwfzTk+tSb1yGBtYmE=;
        b=WDq5TsEZjPx+zpSVnIJ/joyKQjJmcbrHGfWcZdTMYTB/cnJ4oa/hKo6EWsPwMYL1Gt
         Z4HHfGmWF5D456YUBzptyYdRbu7FXR+XIj8fpu28qVoNuaSWHLtyvHmEeoxxz4NtvwDK
         dxxCVHsP5XxuDyxEVmq1o0lwfbn87XygAjLDcWjm/zUreBISJdRx7POc55BbYuh/HcmJ
         XIPvNWF+LSXSFkmpdoY+PwyId+BmqjyxfAP/GKbKh9pCqCGbGkbvaS0wyw5fmWYm4RpG
         GLRpMxO/JqajbHCDq5pPldFrs3ktLuLNZ+M1SogPRRDsBLiN56tq/gwnxlZ0FGcmnEq1
         9AOw==
X-Gm-Message-State: AOAM530XbDHVIrAtVbqZn5C7M1sc2qNdIQ4sxPxfMJFnzBl9B3PAUQnR
        d+IXGRNpkHL1NlCFPuniLhAJRKczYaOvW4VQDFU=
X-Google-Smtp-Source: ABdhPJyud0vB1fj9qgci4bf8eIrWivIZFePW3mXSe2/bCbwrXhJ7Zw4rj6gqUBgewPK7E+jB9OOQpYAgLtL5OEWsMCE=
X-Received: by 2002:a02:cc24:: with SMTP id o4mr4689471jap.105.1594715870042;
 Tue, 14 Jul 2020 01:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200714073404.84863-1-richard.weiyang@linux.alibaba.com>
In-Reply-To: <20200714073404.84863-1-richard.weiyang@linux.alibaba.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 14 Jul 2020 10:37:38 +0200
Message-ID: <CAM9Jb+gu6vvYOQGTL546-J-gcXrC4N0jqK_rKpP7PwZdPea8ZQ@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: hide nr_nodes in the internal of for_each_node_mask_to_[alloc|free]
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The second parameter of for_each_node_mask_to_[alloc|free] is a loop
> variant, which is not used outside of loop iteration.
>
> Let's hide this.
>
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 57ece74e3aae..9c3d15fb317e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1196,17 +1196,19 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>         return nid;
>  }
>
> -#define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)          \
> -       for (nr_nodes = nodes_weight(*mask);                            \
> -               nr_nodes > 0 &&                                         \
> +#define for_each_node_mask_to_alloc(hs, node, mask)                    \
> +       int __nr_nodes;                                                 \
> +       for (__nr_nodes = nodes_weight(*mask);                          \
> +               __nr_nodes > 0 &&                                       \
>                 ((node = hstate_next_node_to_alloc(hs, mask)) || 1);    \
> -               nr_nodes--)
> +               __nr_nodes--)
>
> -#define for_each_node_mask_to_free(hs, nr_nodes, node, mask)           \
> -       for (nr_nodes = nodes_weight(*mask);                            \
> -               nr_nodes > 0 &&                                         \
> +#define for_each_node_mask_to_free(hs, node, mask)                     \
> +       int __nr_nodes;                                                 \
> +       for (__nr_nodes = nodes_weight(*mask);                          \
> +               __nr_nodes > 0 &&                                       \
>                 ((node = hstate_next_node_to_free(hs, mask)) || 1);     \
> -               nr_nodes--)
> +               __nr_nodes--)
>
>  #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>  static void destroy_compound_gigantic_page(struct page *page,
> @@ -1403,7 +1405,7 @@ static void __free_huge_page(struct page *page)
>          * reservation.  If the page was associated with a subpool, there
>          * would have been a page reserved in the subpool before allocation
>          * via hugepage_subpool_get_pages().  Since we are 'restoring' the
> -        * reservtion, do not call hugepage_subpool_put_pages() as this will
> +        * reservation, do not call hugepage_subpool_put_pages() as this will
>          * remove the reserved page from the subpool.
>          */
>         if (!restore_reserve) {
> @@ -1760,10 +1762,10 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>                                 nodemask_t *node_alloc_noretry)
>  {
>         struct page *page;
> -       int nr_nodes, node;
> +       int node;
>         gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>
> -       for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
> +       for_each_node_mask_to_alloc(h, node, nodes_allowed) {
>                 page = alloc_fresh_huge_page(h, gfp_mask, node, nodes_allowed,
>                                                 node_alloc_noretry);
>                 if (page)
> @@ -1787,10 +1789,10 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>                                                          bool acct_surplus)
>  {
> -       int nr_nodes, node;
> +       int node;
>         int ret = 0;
>
> -       for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
> +       for_each_node_mask_to_free(h, node, nodes_allowed) {
>                 /*
>                  * If we're returning unused surplus pages, only examine
>                  * nodes with surplus pages.
> @@ -2481,9 +2483,9 @@ int alloc_bootmem_huge_page(struct hstate *h)
>  int __alloc_bootmem_huge_page(struct hstate *h)
>  {
>         struct huge_bootmem_page *m;
> -       int nr_nodes, node;
> +       int node;
>
> -       for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
> +       for_each_node_mask_to_alloc(h, node, &node_states[N_MEMORY]) {
>                 void *addr;
>
>                 addr = memblock_alloc_try_nid_raw(
> @@ -2662,17 +2664,17 @@ static inline void try_to_free_low(struct hstate *h, unsigned long count,
>  static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>                                 int delta)
>  {
> -       int nr_nodes, node;
> +       int node;
>
>         VM_BUG_ON(delta != -1 && delta != 1);
>
>         if (delta < 0) {
> -               for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
> +               for_each_node_mask_to_alloc(h, node, nodes_allowed) {
>                         if (h->surplus_huge_pages_node[node])
>                                 goto found;
>                 }
>         } else {
> -               for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
> +               for_each_node_mask_to_free(h, node, nodes_allowed) {
>                         if (h->surplus_huge_pages_node[node] <
>                                         h->nr_huge_pages_node[node])
>                                 goto found;
> --
> 2.20.1 (Apple Git-117)

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

>
>
