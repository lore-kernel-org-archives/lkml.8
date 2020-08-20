Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333D4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5ED32087D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0hmPBb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHTWIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgHTWIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:08:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7925FC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:08:01 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ba10so2876579edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ruw7kMBa/XlI3wkk64WFQOGvJM4hLrxAU+rGRpFnLc=;
        b=n0hmPBb7TPFM/y9CqWwoF9Rx3kgas1/x+N65KFRhYa+FgOE6uNfe3hlHxGisYiJ4w3
         ApirnJ+TqosdnSkY1WNtHPKwviexSui7a9REpUTJYJvEkSJIMcj/9ulXLcx6iEK+TTvy
         lZAcj26SMutkGOQE+/235+IWq15akCyaN6ohrCD4ynxq/EuCeuDCG0Mm7pD0yVjuD3nV
         S2BPSQnLbD8+kW9Xju+9TNOBGjXYETxPnEHTzfFAuzkvwG/cAVTu52jPkkeYNXQXwikG
         Iz6bhs+EdCa4n67q5Tyov+A2qpwDCNH7b5IhJRF9Q51k82wo3HJMp1CNxZ9iJuRKlu9v
         /n/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ruw7kMBa/XlI3wkk64WFQOGvJM4hLrxAU+rGRpFnLc=;
        b=F0BFbndJcP+ivmJUKXLhPndAnMglSkI/PH0XfPzu2nrokzjLc1cMAJRnE1xdh2+M7u
         1mdOTsXDC5aq/FVuxD48Hk/WvOkPIhFO074/6cZ5NSVYkA1rRGFM9Ye08OsNlKSFiEhb
         VU/+SWmLlZb+RHoIxtMPAmInBk/g7C/m580eSojSnZksVZ2zMkaZpAG40QqdQrryRHXg
         2JCuxbKob+ZhpXJSR3gabQC4ydyLC4gAASY7+gDJHEgQ7f6BvKQBqQG6eYZT9E/NpvF6
         zqWHhj9vo9MfCNyVGH/18eGmq1nBCp+wcdlOqTWgos2TzAI/3vrDK2HUr+RQUfkhT+dg
         XTSA==
X-Gm-Message-State: AOAM5301cSDCF3TfHd3PmrdL6K6EPHGfhuw3XqB1tHiBRgMNTXTh9qT8
        Otb9SyI+0rnu9Zdr65Q+45/i2k+hbDP4knpa3V0=
X-Google-Smtp-Source: ABdhPJyRKaumDK18UlMcN2KjDYGyvYmPFJJW9Mo+NdD1tGbrDVECwcbrH7YKhQ97PVA24gmTJMatpWCFDDWjQeLxfsg=
X-Received: by 2002:a50:9dc2:: with SMTP id l2mr18524edk.290.1597961280138;
 Thu, 20 Aug 2020 15:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184122.29C415DF@viggo.jf.intel.com> <20200818184127.C3B49AB6@viggo.jf.intel.com>
In-Reply-To: <20200818184127.C3B49AB6@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Aug 2020 15:07:48 -0700
Message-ID: <CAHbLzkoKg-iPq1WZUJ5G-mzqTgiT2xrpff9NTFfTEmABGdmL0Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/9] mm/migrate: update migration order during on
 hotplug events
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
> Reclaim-based migration is attempting to optimize data placement in
> memory based on the system topology.  If the system changes, so must
> the migration ordering.
>
> The implementation here is pretty simple and entirely unoptimized.  On
> any memory or CPU hotplug events, assume that a node was added or
> removed and recalculate all migration targets.  This ensures that the
> node_demotion[] array is always ready to be used in case the new
> reclaim mode is enabled.
>
> This recalculation is far from optimal, most glaringly that it does
> not even attempt to figure out if nodes are actually coming or going.
> But, given the expected paucity of hotplug events, this should be
> fine.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>
>  b/mm/migrate.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>
> diff -puN mm/migrate.c~enable-numa-demotion mm/migrate.c
> --- a/mm/migrate.c~enable-numa-demotion 2020-08-18 11:36:50.193583185 -0700
> +++ b/mm/migrate.c      2020-08-18 11:36:50.197583185 -0700
> @@ -49,6 +49,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/ptrace.h>
>  #include <linux/oom.h>
> +#include <linux/memory.h>
>
>  #include <asm/tlbflush.h>
>
> @@ -3130,9 +3131,101 @@ again:
>                 goto again;
>  }
>
> +/*
> + * For callers that do not hold get_online_mems() already.
> + */
>  void set_migration_target_nodes(void)
>  {
>         get_online_mems();
>         __set_migration_target_nodes();
>         put_online_mems();
>  }
> +
> +/*
> + * React to hotplug events that might affect the migration targes

s/targes/targets

> + * like events that online or offline NUMA nodes.
> + *
> + * The ordering is also currently dependent on which nodes have
> + * CPUs.  That means we need CPU on/offline notification too.
> + */
> +static int migration_online_cpu(unsigned int cpu)
> +{
> +       set_migration_target_nodes();
> +       return 0;
> +}
> +
> +static int migration_offline_cpu(unsigned int cpu)
> +{
> +       set_migration_target_nodes();
> +       return 0;
> +}
> +
> +/*
> + * This leaves migrate-on-reclaim transiently disabled
> + * between the MEM_GOING_OFFLINE and MEM_OFFLINE events.
> + * This runs reclaim-based micgration is enabled or not.

s/micgration/migration

> + * This ensures that the user can turn reclaim-based
> + * migration at any time without needing to recalcuate

s/recalcuate/recalculate

> + * migration targets.
> + *
> + * These callbacks already hold get_online_mems().  That
> + * is why __set_migration_target_nodes() can be used as
> + * opposed to set_migration_target_nodes().
> + */
> +#if defined(CONFIG_MEMORY_HOTPLUG)
> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> +                                                unsigned long action, void *arg)
> +{
> +       switch (action) {
> +       case MEM_GOING_OFFLINE:
> +               /*
> +                * Make sure there are not transient states where
> +                * an offline node is a migration target.  This
> +                * will leave migration disabled until the offline
> +                * completes and the MEM_OFFLINE case below runs.
> +                */
> +               disable_all_migrate_targets();
> +               break;
> +       case MEM_OFFLINE:
> +       case MEM_ONLINE:
> +               /*
> +                * Recalculate the target nodes once the node
> +                * reaches its final state (online or offline).
> +                */
> +               __set_migration_target_nodes();
> +               break;
> +       case MEM_CANCEL_OFFLINE:
> +               /*
> +                * MEM_GOING_OFFLINE disabled all the migration
> +                * targets.  Reenable them.
> +                */
> +               __set_migration_target_nodes();
> +               break;
> +       case MEM_GOING_ONLINE:
> +       case MEM_CANCEL_ONLINE:
> +               break;
> +       }
> +
> +       return notifier_from_errno(0);
> +}
> +
> +static int __init migrate_on_reclaim_init(void)
> +{
> +       int ret;
> +
> +       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "migrate on reclaim",
> +                               migration_online_cpu,
> +                               migration_offline_cpu);
> +       /*
> +        * In the unlikely case that this fails, the automatic
> +        * migration targets may become suboptimal for nodes
> +        * where N_CPU changes.  With such a small impact in a
> +        * rare case, do not bother trying to do anything special.
> +        */
> +       WARN_ON(ret < 0);
> +
> +       hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> +       return 0;
> +}
> +late_initcall(migrate_on_reclaim_init);
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> _
