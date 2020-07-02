Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5264C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE57B20748
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgGBBUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:20:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:39459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgGBBUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:20:07 -0400
IronPort-SDR: uro9CT9Wri9AumaEJn6/eEvXJsUuZyt2G09UAIaxwAdwRdTPt4/gkc9fBR5RoHdWGKe8+p5xPE
 JtfRaR7b0SaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="164805700"
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; 
   d="scan'208";a="164805700"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 18:20:04 -0700
IronPort-SDR: KIuacI0QVpJAbNqRCLESWM38cXlYvzAIPduUiJXxQQZ1OSkAQzJYjiihINh1UvLfUc+yhZLcjE
 SCGaC6dCVk1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; 
   d="scan'208";a="281785832"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga006.jf.intel.com with ESMTP; 01 Jul 2020 18:20:01 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <yang.shi@linux.alibaba.com>, <rientjes@google.com>,
        <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 5/8] mm/numa: automatically generate node migration order
References: <20200629234503.749E5340@viggo.jf.intel.com>
        <20200629234512.F34EDC44@viggo.jf.intel.com>
        <87ftadotd5.fsf@yhuang-dev.intel.com>
        <3ef8a701-fe8a-cf65-5b72-806b244aae8b@intel.com>
Date:   Thu, 02 Jul 2020 09:20:00 +0800
In-Reply-To: <3ef8a701-fe8a-cf65-5b72-806b244aae8b@intel.com> (Dave Hansen's
        message of "Wed, 1 Jul 2020 11:23:00 -0700")
Message-ID: <878sg2lnlr.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 6/30/20 1:22 AM, Huang, Ying wrote:
>>> +	/*
>>> +	 * To avoid cycles in the migration "graph", ensure
>>> +	 * that migration sources are not future targets by
>>> +	 * setting them in 'used_targets'.
>>> +	 *
>>> +	 * But, do this only once per pass so that multiple
>>> +	 * source nodes can share a target node.
>> establish_migrate_target() calls find_next_best_node(), which will set
>> target_node in used_targets.  So it seems that the nodes_or() below is
>> only necessary to initialize used_targets, and multiple source nodes
>> cannot share one target node in current implementation.
>
> Yes, that is true.  My focus on this implementation was simplicity and
> sanity for common configurations.  I can certainly imagine scenarios
> where this is suboptimal.
>
> I'm totally open to other ways of doing this.

OK.  So when we really need to share one target node for multiple source
nodes, we can add a parameter to find_next_best_node() to specify
whether set target_node in used_targets.

Best Regards,
Huang, Ying
