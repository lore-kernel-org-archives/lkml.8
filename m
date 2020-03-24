Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01435C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D8D2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZsTTtppK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgCXTZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:25:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33573 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCXTZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:25:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id d17so8969810pgo.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 12:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=b0vJ6NY31m5cGG2hLm9OUyIsW263Iau0X4y6ey2x+mI=;
        b=ZsTTtppK4VSkmrFT7n7mwQA8kbS22nbNIU50ruT2Q/4jux1kNjWkvJe0Nb7eTyxevz
         iWRMJU7fIWqj3lnJHkptL2l25M996rVZdvzC8PFQlP+LdZuozBkCBEsWELqHa+MXgxn+
         JBuIJnCgwxBNtt5vtpTe2V0YrbvXndGXbhpCFNFDmg16jLlFCeBK6nhXtmKk9e6jel4R
         bPVvz3huX9tvTnBKIkOwLpuxuEL/5zi3QTmBX2SKQcxS0osNy/ht/9hfmTkxiXG9bv/p
         J0w721bXRYC/wNe3cJbXbidrJo728mLLVzNz5dS90+VQM9yiW52Dd/AIXeg/9jZoKpHY
         YNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=b0vJ6NY31m5cGG2hLm9OUyIsW263Iau0X4y6ey2x+mI=;
        b=cMtxBwuDRpogis7H9CDO+Y9AAC1k3Gb9GumMupGz59/7Gu7+coxSX3p8Z+L13KJm+y
         FXsxdXodW11wmTaa4U9ZrbygXr3bgc92u1XI8W7fgzxGPTxXKZ3YXvexWjEnnhw6XC1Z
         m56KPgc+i7lM0eGeWVhwTrIbL5okqCxoJ4n7mUG7lpyyZaRYWvsBvyKyHmqf2EeZ3qs1
         ThDyeUxfaBliF4pU5xZa/HlBsEhYCZ896cn6AKo4TGyKXgPxVBq6fL62SO/j4u7EJXvm
         g1C+ofETqtvD7CcZRExkzwTdo+mShA4IjA6gDRwAQP9+Dm32+coiBNaOV80pWHCNQU41
         WH3A==
X-Gm-Message-State: ANhLgQ1C/amFaaJchR4PggOD3vZ+0UbO6gZVBUqrXva8DFU46XCxmRiz
        MC7AfZwgBfSF4roih6TLdlyE3A==
X-Google-Smtp-Source: ADFU+vu1prW9SuVKgUjYf5SYCcIL6Q7+0zUgILCyyFh8Ci/mMupwTkj2SpbTzeJm/oaz/c31iGhkYA==
X-Received: by 2002:a62:868a:: with SMTP id x132mr29193347pfd.208.1585077905694;
        Tue, 24 Mar 2020 12:25:05 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j21sm8247708pff.39.2020.03.24.12.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 12:25:04 -0700 (PDT)
Date:   Tue, 24 Mar 2020 12:25:03 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Baoquan He <bhe@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        hannes@cmpxchg.org, mhocko@kernel.org, vbabka@suse.cz
Subject: Re: [PATCH 4/5] mm/vmstat.c: move the per-node stats to the front
 of /proc/zoneinfo
In-Reply-To: <20200324142229.12028-5-bhe@redhat.com>
Message-ID: <alpine.DEB.2.21.2003241220360.34058@chino.kir.corp.google.com>
References: <20200324142229.12028-1-bhe@redhat.com> <20200324142229.12028-5-bhe@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Baoquan He wrote:

> This moving makes the layout of /proc/zoneinfo more sensible. And there
> are 4 zones at most currently, it doesn't need to scroll down much to get
> to the 1st populated zone, even though the 1st populated zone is MOVABLE
> zone.
> 

Doesn't this introduce risk that it will break existing parsers of 
/proc/zoneinfo in subtle ways?

In some cases /proc/zoneinfo is a tricky file to correctly parse because 
you have to rely on the existing order in which it is printed to determine 
which zone is being described.  We need to print zones even with unmanaged 
pages, for instance, otherwise userspace may be unaware of which zones are 
supported and what order they are in.  That's important to be able to 
construct the proper string to use when writing vm.lowmem_reserve_ratio.

I'd prefer not changing the order of /proc/zoneinfo if it can be avoided 
just because the risk outweighs the reward that we may break some 
initscript parsers.

> Node 2, per-node stats
>       nr_inactive_anon 48
>       nr_active_anon 15454
> ...
>       nr_foll_pin_acquired 0
>       nr_foll_pin_released 0
> Node 2, zone      DMA
>   pages free     0
>         min      0
>         low      0
>         high     0
>         spanned  0
>         present  0
>         managed  0
> Node 2, zone    DMA32
>   pages free     0
>         min      0
>         low      0
>         high     0
>         spanned  0
>         present  0
>         managed  0
> Node 2, zone   Normal
>   pages free     0
>         min      0
>         low      0
>         high     0
>         spanned  0
>         present  0
>         managed  0
> Node 2, zone  Movable
>   pages free     196346
>         min      3540
> ...
>         managed  262144
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmstat.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 6fd1407f4632..4bbf9be786da 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1567,13 +1567,6 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>  {
>  	int i;
>  	seq_printf(m, "Node %d, zone %8s", pgdat->node_id, zone->name);
> -	if (is_zone_first_populated(pgdat, zone)) {
> -		seq_printf(m, "\n  per-node stats");
> -		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> -			seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
> -				   node_page_state(pgdat, i));
> -		}
> -	}
>  	seq_printf(m,
>  		   "\n  pages free     %lu"
>  		   "\n        min      %lu"
> @@ -1648,7 +1641,18 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>   */
>  static int zoneinfo_show(struct seq_file *m, void *arg)
>  {
> +	int i;
>  	pg_data_t *pgdat = (pg_data_t *)arg;
> +
> +	if (node_state(pgdat->node_id, N_MEMORY)) {
> +		seq_printf(m, "Node %d, per-node stats", pgdat->node_id);
> +		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> +			seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
> +				   node_page_state(pgdat, i));
> +		}
> +		seq_putc(m, '\n');
> +	}
> +
>  	walk_zones_in_node(m, pgdat, false, false, zoneinfo_show_print);
>  	return 0;
>  }
> -- 
> 2.17.2
> 
> 
> 
