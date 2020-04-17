Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81492C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DF5221EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgDQM5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:57:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:12923 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbgDQM5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:57:41 -0400
IronPort-SDR: tGdSO4vVEbF0y1nW8gN/P2ipQL2UxgIOCYry3R5Viugxa3tuecHlO8vjRrnif8YfberYklG1/h
 hpvGKb+fWGkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 05:57:40 -0700
IronPort-SDR: EeKEeugl3hBbRh6rXGlGndnxkb9iEZCITynNpkA4RJIr2ivOTWYtNwkF0W6Xr9r3ij5alHXlXP
 RN6zTDTJ+6/w==
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="279582510"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 05:57:38 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id D7FA720701; Fri, 17 Apr 2020 15:57:35 +0300 (EEST)
Date:   Fri, 17 Apr 2020 15:57:35 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, urezki@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200417125735.GN27762@paasikivi.fi.intel.com>
References: <20200403163253.GU20730@hirez.programming.kicks-ass.net>
 <20200406130155.GB29306@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406130155.GB29306@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Apr 06, 2020 at 06:01:55AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 03, 2020 at 06:32:53PM +0200, Peter Zijlstra wrote:
> > 
> > __get_vm_area() is an exported symbol, make sure the callers stay in
> > the expected memory range. When calling this function with memory
> > ranges outside of the VMALLOC range *bad* things can happen.
> > 
> > (I noticed this when I managed to corrupt the kernel text by accident)
> 
> Maybe it is time to unexport it?  There are only two users:
> 
>  - staging/media/ipu3 really should be using vmap.  And given that it
>    is a staging driver it really doesn't matter anyway if we break it.

It's not very polite to suggest breaking other people's drivers for such a
small matter, staging or not. That'd be bound to break kernel compilation
for a lot of people, if for nothing else.

Anyway, thanks for cc'ing me. I agree with suggestion and I'll submit a
patch to address it.

-- 
Regards,

Sakari Ailus
