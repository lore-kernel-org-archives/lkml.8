Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B74C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511FA207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUq1JRoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgHTWvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgHTWvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:51:12 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4355C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:51:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i26so2948115edv.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePlmLgzCtlWiuxoxVh29CyOsClISbIT4agaEsQKgw3M=;
        b=uUq1JRoVwV5dgmD1bEihR7hgqEJ37LwyXI62GhBQPPv0GhdesNRF0WZD+CdVrsIFnz
         QenIAW7xB7I0Y2C1yX+hi4veAg2gp5dRfXjDATES9etO2s61gHxkiu2/Uuh3+eMcCgc/
         a0mFSoouAPESgYaK2pqCo49pzjTSNDIh0tq/vUum0RljEoinVbLcPxiRYXMqy//qcFY7
         0iEPz4Z9IOuOE5IipecBEgKd3FdIxrWUGuhhDikbpfd08frdNdgbsGWVpGB0E09Ac3a/
         tre4r8etg5mDkFpzLsCZ7ZmSIrSov3qHivGX6LnjaHrech5YOF4qr7qBgQ2PH5ri+C+s
         LKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePlmLgzCtlWiuxoxVh29CyOsClISbIT4agaEsQKgw3M=;
        b=ggEVQJCx4OZDVkwLlpTeo0J8uRdx3gxDmSGfqBK9HNqAlomcA7yrPXyccKfs35wDI0
         IE9bmKlsbPqPiR5dfLBMnsxnwsBZdoTQtZlKNgbklHs6bsO53x3qXI6kBQWMhseAuJqc
         qYIwm15neCw4SIzWKEGnogauq0a9MTN6z4q5M+QgQqEupNC++pAkYYIwoR93SXjyGcMo
         BbRdxUW+W6JKPucLAZgRxPhMYJTE/n3Y8jjkwvEWyDF33WCEtc0trl9+n4Ss8+0K34DB
         usbV3D9J/qaG9+1QuVh8X/8jlD7GyvT4pePTVtiPhDNSOrfgmrJ9A7lbr8TaqSEmh1jr
         4wsA==
X-Gm-Message-State: AOAM530b4/fkwubDkj27TJyh8RoRsZWDCwO8jz1r1f44AF57gg46rqmO
        z9VhYuyPsiXSIpBEhO6DYeRIlL1kwqa0bFuNIdE=
X-Google-Smtp-Source: ABdhPJwM7phxMUBEe035p/BY+gY+gx8VvnycFblnAm+mDThc4JLA6vCyiQGG6wWu0Y01pzoMW1bfEYhNp0K4OW9Z5DY=
X-Received: by 2002:a50:fd8d:: with SMTP id o13mr15089edt.313.1597963870368;
 Thu, 20 Aug 2020 15:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184122.29C415DF@viggo.jf.intel.com> <20200818184136.7FD537AA@viggo.jf.intel.com>
In-Reply-To: <20200818184136.7FD537AA@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Aug 2020 15:50:57 -0700
Message-ID: <CAHbLzkoYDwU7wJWai1QzUA5DsJyQq1enLbWoCf2hRTaLBNCKtQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 8/9] mm/vmscan: never demote for memcg reclaim
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:52 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Global reclaim aims to reduce the amount of memory used on
> a given node or set of nodes.  Migrating pages to another
> node serves this purpose.
>
> memcg reclaim is different.  Its goal is to reduce the
> total memory consumption of the entire memcg, across all
> nodes.  Migration does not assist memcg reclaim because
> it just moves page contents between nodes rather than
> actually reducing memory consumption.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>
>  b/mm/vmscan.c |   33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff -puN mm/vmscan.c~never-demote-for-memcg-reclaim mm/vmscan.c
> --- a/mm/vmscan.c~never-demote-for-memcg-reclaim        2020-08-18 11:36:56.442583170 -0700
> +++ b/mm/vmscan.c       2020-08-18 11:36:56.447583170 -0700
> @@ -296,8 +296,11 @@ static bool writeback_throttling_sane(st
>  #endif
>
>  static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
> -                                         int node_id)
> +                                         int node_id,
> +                                         struct scan_control *sc)
>  {
> +       bool in_cgroup_reclaim = false;
> +
>         /* Always age anon pages when we have swap */
>         if (memcg == NULL) {
>                 if (get_nr_swap_pages() > 0)
> @@ -307,8 +310,18 @@ static inline bool can_reclaim_anon_page
>                         return true;
>         }
>
> -       /* Also age anon pages if we can auto-migrate them */
> -       if (next_demotion_node(node_id) >= 0)
> +       /* Can only be in memcg reclaim in paths with valid 'sc': */

This comment looks not right. The global reclaim also has valid 'sc'
but just with NULL target_mem_cgroup.

> +       if (sc && cgroup_reclaim(sc))
> +               in_cgroup_reclaim = true;
> +
> +       /*
> +        * Also age anon pages if we can auto-migrate them.
> +        *
> +        * Migrating a page does not reduce comsumption of a

s/comsuption/consumption

> +        * memcg so should not be performed when in memcg
> +        * reclaim.
> +        */
> +       if (!in_cgroup_reclaim && (next_demotion_node(node_id) >= 0))
>                 return true;
>
>         /* No way to reclaim anon pages */
> @@ -326,7 +339,7 @@ unsigned long zone_reclaimable_pages(str
>
>         nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
>                 zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
> -       if (can_reclaim_anon_pages(NULL, zone_to_nid(zone)))
> +       if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
>                 nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
>                         zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
>
> @@ -1070,6 +1083,10 @@ bool migrate_demote_page_ok(struct page
>         VM_BUG_ON_PAGE(PageHuge(page), page);
>         VM_BUG_ON_PAGE(PageLRU(page), page);
>
> +       /* It is pointless to do demotion in memcg reclaim */
> +       if (cgroup_reclaim(sc))
> +               return false;
> +
>         if (next_nid == NUMA_NO_NODE)
>                 return false;
>         if (PageTransHuge(page) && !thp_migration_supported())
> @@ -2369,7 +2386,7 @@ static void get_scan_count(struct lruvec
>         enum lru_list lru;
>
>         /* If we have no swap space, do not bother scanning anon pages. */
> -       if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
> +       if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
>                 scan_balance = SCAN_FILE;
>                 goto out;
>         }
> @@ -2653,7 +2670,7 @@ static void shrink_lruvec(struct lruvec
>          * rebalance the anon lru active/inactive ratio.
>          */
>         if (can_reclaim_anon_pages(lruvec_memcg(lruvec),
> -                              lruvec_pgdat(lruvec)->node_id) &&
> +                              lruvec_pgdat(lruvec)->node_id, sc) &&
>             inactive_is_low(lruvec, LRU_INACTIVE_ANON))
>                 shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
>                                    sc, LRU_ACTIVE_ANON);
> @@ -2724,7 +2741,7 @@ static inline bool should_continue_recla
>          */
>         pages_for_compaction = compact_gap(sc->order);
>         inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
> -       if (can_reclaim_anon_pages(NULL, pgdat->node_id))
> +       if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
>                 inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
>
>         return inactive_lru_pages > pages_for_compaction;
> @@ -3485,7 +3502,7 @@ static void age_active_anon(struct pglis
>         struct mem_cgroup *memcg;
>         struct lruvec *lruvec;
>
> -       if (!can_reclaim_anon_pages(NULL, pgdat->node_id))
> +       if (!can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
>                 return;
>
>         lruvec = mem_cgroup_lruvec(NULL, pgdat);
> _
