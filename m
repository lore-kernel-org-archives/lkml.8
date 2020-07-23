Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB1EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477E620714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGWWY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:24:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:11488 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgGWWY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:24:59 -0400
IronPort-SDR: 5ariW4NiwzVootpvbt0O5q9uXqwG9dZDPBPhZWuf9pegA+YOfXdik3sv9Clyyzk5ZLPmUL+98z
 K5J9+xyQ2EHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="138129196"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="138129196"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 15:24:58 -0700
IronPort-SDR: zKgzapZCB5UJHSsy3nQZ6GSkGWrz0yYAHTsx6unny21M0x0GoIjIFkljULw2pjM59tiBuLli9p
 swij7RTimQgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="302465808"
Received: from abdelh1x-mobl.amr.corp.intel.com (HELO localhost) ([10.249.38.107])
  by orsmga002.jf.intel.com with ESMTP; 23 Jul 2020 15:24:56 -0700
Date:   Fri, 24 Jul 2020 01:24:55 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH v4 3/7] vmalloc: Add text_alloc() and text_free()
Message-ID: <20200723222455.GB12405@linux.intel.com>
References: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
 <20200717030422.679972-4-jarkko.sakkinen@linux.intel.com>
 <20200717175245.54758e3954abd1bcccfe5500@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717175245.54758e3954abd1bcccfe5500@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 05:52:45PM +0900, Masami Hiramatsu wrote:
> On Fri, 17 Jul 2020 06:04:17 +0300
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > Introduce functions for allocating memory for dynamic trampolines, such
> > as kprobes. An arch can promote the availability of these functions with
> > CONFIG_ARCH_HAS_TEXT_ALLOC. Provide default/fallback implementation
> > wrapping module_alloc() and module_memfree().
> 
> Doesn't it depend on CONFIG_MODULE?

The idea would be that arch specifically promotes that it has text
allocator that is not dependent on module subsystem.

E.g. like the patch set does for x86.

/Jarkko
