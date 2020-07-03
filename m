Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E697CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE18206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgGCJaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:30:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:61960 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgGCJaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:30:11 -0400
IronPort-SDR: dgShyHnAEW8DJdWyrcGPldNDGlytC122C5vXdQK4npdqcJyOrZ7IgS+xQV9GVAm7ftU5ihWsU1
 C2hkQABmOBnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="231986881"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="231986881"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 02:30:11 -0700
IronPort-SDR: l31gYcmKNMh0jJgY194TtzUizoIW0DpsWBdZeEs9ROHqsohAxscc7OynGyejlLP/6GMDUzY+XA
 s5mLMPhfEedg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="278387141"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga003.jf.intel.com with ESMTP; 03 Jul 2020 02:30:09 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <yang.shi@linux.alibaba.com>, <rientjes@google.com>,
        <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 8/8] mm/numa: new reclaim mode to enable reclaim-based migration
References: <20200629234503.749E5340@viggo.jf.intel.com>
        <20200629234517.A7EC4BD3@viggo.jf.intel.com>
Date:   Fri, 03 Jul 2020 17:30:09 +0800
In-Reply-To: <20200629234517.A7EC4BD3@viggo.jf.intel.com> (Dave Hansen's
        message of "Mon, 29 Jun 2020 16:45:17 -0700")
Message-ID: <87imf5djz2.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:
> +/*
> + * React to hotplug events that might online or offline
> + * NUMA nodes.
> + *
> + * This leaves migrate-on-reclaim transiently disabled
> + * between the MEM_GOING_OFFLINE and MEM_OFFLINE events.
> + * This runs whether RECLAIM_MIGRATE is enabled or not.
> + * That ensures that the user can turn RECLAIM_MIGRATE
> + * without needing to recalcuate migration targets.
> + */
> +#if defined(CONFIG_MEMORY_HOTPLUG)
> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> +						 unsigned long action, void *arg)
> +{
> +	switch (action) {
> +	case MEM_GOING_OFFLINE:
> +		/*
> +		 * Make sure there are not transient states where
> +		 * an offline node is a migration target.  This
> +		 * will leave migration disabled until the offline
> +		 * completes and the MEM_OFFLINE case below runs.
> +		 */
> +		disable_all_migrate_targets();
> +		break;
> +	case MEM_OFFLINE:
> +	case MEM_ONLINE:
> +		/*
> +		 * Recalculate the target nodes once the node
> +		 * reaches its final state (online or offline).
> +		 */
> +		set_migration_target_nodes();
> +		break;
> +	case MEM_CANCEL_OFFLINE:
> +		/*
> +		 * MEM_GOING_OFFLINE disabled all the migration
> +		 * targets.  Reenable them.
> +		 */
> +		set_migration_target_nodes();
> +		break;
> +	case MEM_GOING_ONLINE:
> +	case MEM_CANCEL_ONLINE:
> +		break;

I think we need to call
disable_all_migrate_targets()/set_migration_target_nodes() for CPU
online/offline event too.  Because that will influence node_state(nid,
N_CPU).  Which will influence node demotion relationship.

> +	}
> +
> +	return notifier_from_errno(0);
>  }
> +

Best Regards,
Huang, Ying
