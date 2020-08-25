Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F39C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3939F2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHYP5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:57:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:42814 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHYP5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:57:49 -0400
IronPort-SDR: nmCdGcPNwigStIZTdKCMeo9l9w5NWdPLG9KvRhxNIcL316aRZvaf2tXQ7SajahVjF9p1lIrmr6
 TPqKz8iQqz4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="143916176"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="143916176"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 08:57:49 -0700
IronPort-SDR: CZ0OUMq/2Wps2vSIlSVLi1OAPFFDR3A73gnlpCzVQL8MOjU3oeXEX4QBMMvjFT51zj9SqNQuAj
 rvcTPoBWiQhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="328905060"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 08:57:49 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id CA454301C53; Tue, 25 Aug 2020 08:47:21 -0700 (PDT)
Date:   Tue, 25 Aug 2020 08:47:21 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, jolsa@redhat.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Message-ID: <20200825154721.GP1509399@tassilo.jf.intel.com>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825074041.378520-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:
> This patch adds new structure called 'json_event' inside jevents.h
> file to improve the callback prototype inside jevent files.
> Initially, whenever user want to add new field, they need to update
> in all function callback which make it more and more complex with
> increased number of parmeters.
> With this change, we just need to add it in new structure 'json_event'.

Looks good to me. Thanks.

I wouldn't consolidate with event_struct, these are logically
different layers.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
