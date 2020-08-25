Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69672C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C8620738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHYSx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:53:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:16450 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgHYSx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:53:26 -0400
IronPort-SDR: +30W4RogLoAFfgJs5u01pbFVs+vbGTlNOPo2T64DRNY9lQHUgE9Eoelhhuynnxs/R5bRhryFdP
 YxPUwcG0ypiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="217729489"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="217729489"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 11:53:23 -0700
IronPort-SDR: 4BHPj+CdBNJj1OcZhZceUOeJli0U4JoHzTZk7WHsBGIRqqnq1oSLDMKa7WRHeL34Q6cIplwAFe
 wgCpOw2SHr9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="328960106"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 11:53:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B3985301C53; Tue, 25 Aug 2020 10:40:43 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:40:43 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Al Grant <al.grant@foss.arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Message-ID: <20200825174043.GQ1509399@tassilo.jf.intel.com>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 10:28:34AM +0100, Al Grant wrote:
> perf_event.h has macros that define the field offsets in the
> data_src bitmask in perf records. The SNOOPX and REMOTE offsets
> were both 37. These are distinct fields, and the bitfield layout
> in perf_mem_data_src confirms that SNOOPX should be at offset 38.

Looks good.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

Probably should have a Fixes: header

-Andi
