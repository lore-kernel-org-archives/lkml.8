Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81407C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697FB20775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbgF3IWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:22:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:20753 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727919AbgF3IWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:22:50 -0400
IronPort-SDR: nnUluNpXypDeC3y033Z3GNmGgiGr9zmxIThehqZT8VNxmCB+cl+E9yg8EtU4wCqP4tNtjlBy7P
 PU5ItE2xfIlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="207689809"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="207689809"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 01:22:49 -0700
IronPort-SDR: Sm85a8BcaRvXV1JjJmavq1vsPR+FFG9Gm9Heo+bchclIS2GjzV4T9qT/IXAQiGwLGm+xfJeoFV
 CJclhTFeLCcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="321326416"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2020 01:22:47 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <yang.shi@linux.alibaba.com>, <rientjes@google.com>,
        <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 5/8] mm/numa: automatically generate node migration order
References: <20200629234503.749E5340@viggo.jf.intel.com>
        <20200629234512.F34EDC44@viggo.jf.intel.com>
Date:   Tue, 30 Jun 2020 16:22:46 +0800
In-Reply-To: <20200629234512.F34EDC44@viggo.jf.intel.com> (Dave Hansen's
        message of "Mon, 29 Jun 2020 16:45:12 -0700")
Message-ID: <87ftadotd5.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> +/*
> + * Find an automatic demotion target for 'node'.
> + * Failing here is OK.  It might just indicate
> + * being at the end of a chain.
> + */
> +static int establish_migrate_target(int node, nodemask_t *used)
> +{
> +	int migration_target;
> +
> +	/*
> +	 * Can not set a migration target on a
> +	 * node with it already set.
> +	 *
> +	 * No need for READ_ONCE() here since this
> +	 * in the write path for node_demotion[].
> +	 * This should be the only thread writing.
> +	 */
> +	if (node_demotion[node] != NUMA_NO_NODE)
> +		return NUMA_NO_NODE;
> +
> +	migration_target = find_next_best_node(node, used);
> +	if (migration_target == NUMA_NO_NODE)
> +		return NUMA_NO_NODE;
> +
> +	node_demotion[node] = migration_target;
> +
> +	return migration_target;
> +}
> +
> +/*
> + * When memory fills up on a node, memory contents can be
> + * automatically migrated to another node instead of
> + * discarded at reclaim.
> + *
> + * Establish a "migration path" which will start at nodes
> + * with CPUs and will follow the priorities used to build the
> + * page allocator zonelists.
> + *
> + * The difference here is that cycles must be avoided.  If
> + * node0 migrates to node1, then neither node1, nor anything
> + * node1 migrates to can migrate to node0.
> + *
> + * This function can run simultaneously with readers of
> + * node_demotion[].  However, it can not run simultaneously
> + * with itself.  Exclusion is provided by memory hotplug events
> + * being single-threaded.
> + */
> +void set_migration_target_nodes(void)
> +{
> +	nodemask_t next_pass = NODE_MASK_NONE;
> +	nodemask_t this_pass = NODE_MASK_NONE;
> +	nodemask_t used_targets = NODE_MASK_NONE;
> +	int node;
> +
> +	get_online_mems();
> +	/*
> +	 * Avoid any oddities like cycles that could occur
> +	 * from changes in the topology.  This will leave
> +	 * a momentary gap when migration is disabled.
> +	 */
> +	disable_all_migrate_targets();
> +
> +	/*
> +	 * Ensure that the "disable" is visible across the system.
> +	 * Readers will see either a combination of before+disable
> +	 * state or disable+after.  They will never see before and
> +	 * after state together.
> +	 *
> +	 * The before+after state together might have cycles and
> +	 * could cause readers to do things like loop until this
> +	 * function finishes.  This ensures they can only see a
> +	 * single "bad" read and would, for instance, only loop
> +	 * once.
> +	 */
> +	smp_wmb();
> +
> +	/*
> +	 * Allocations go close to CPUs, first.  Assume that
> +	 * the migration path starts at the nodes with CPUs.
> +	 */
> +	next_pass = node_states[N_CPU];
> +again:
> +	this_pass = next_pass;
> +	next_pass = NODE_MASK_NONE;
> +	/*
> +	 * To avoid cycles in the migration "graph", ensure
> +	 * that migration sources are not future targets by
> +	 * setting them in 'used_targets'.
> +	 *
> +	 * But, do this only once per pass so that multiple
> +	 * source nodes can share a target node.

establish_migrate_target() calls find_next_best_node(), which will set
target_node in used_targets.  So it seems that the nodes_or() below is
only necessary to initialize used_targets, and multiple source nodes
cannot share one target node in current implementation.

Best Regards,
Huang, Ying

> +	 */
> +	nodes_or(used_targets, used_targets, this_pass);
> +	for_each_node_mask(node, this_pass) {
> +		int target_node = establish_migrate_target(node, &used_targets);
> +
> +		if (target_node == NUMA_NO_NODE)
> +			continue;
> +
> +		/* Visit targets from this pass in the next pass: */
> +		node_set(target_node, next_pass);
> +	}
> +	/* Is another pass necessary? */
> +	if (!nodes_empty(next_pass))
> +		goto again;
> +
> +	put_online_mems();
> +}
