Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB3FC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85092076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgDQNiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:38:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:54342 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730681AbgDQNiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:38:23 -0400
IronPort-SDR: 6YTvH30ztFyGv03UuQNaYQQ86Pb0kT36CaO+W3ZLnYJz4Lc7YMWT4udKhk/A248EJdj9P5Xtnb
 0IGC/qClFtbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 06:38:23 -0700
IronPort-SDR: ZaocNdzF9cpViqTQt4AnaEZJpzC0ECNT1GSOY01JJHgJrC6Mn54MEA60hQ+CdaP1NJcaOHBUcd
 Nz1eCxTe+AJA==
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="272426880"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 06:38:20 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 16F7A20701; Fri, 17 Apr 2020 16:38:18 +0300 (EEST)
Date:   Fri, 17 Apr 2020 16:38:18 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, urezki@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200417133817.GO27762@paasikivi.fi.intel.com>
References: <20200403163253.GU20730@hirez.programming.kicks-ass.net>
 <20200406130155.GB29306@infradead.org>
 <20200417125735.GN27762@paasikivi.fi.intel.com>
 <20200417131424.GR20713@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417131424.GR20713@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 03:14:24PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 17, 2020 at 03:57:35PM +0300, Sakari Ailus wrote:
> > Hi Christoph,
> > 
> > On Mon, Apr 06, 2020 at 06:01:55AM -0700, Christoph Hellwig wrote:
> > > On Fri, Apr 03, 2020 at 06:32:53PM +0200, Peter Zijlstra wrote:
> > > > 
> > > > __get_vm_area() is an exported symbol, make sure the callers stay in
> > > > the expected memory range. When calling this function with memory
> > > > ranges outside of the VMALLOC range *bad* things can happen.
> > > > 
> > > > (I noticed this when I managed to corrupt the kernel text by accident)
> > > 
> > > Maybe it is time to unexport it?  There are only two users:
> > > 
> > >  - staging/media/ipu3 really should be using vmap.  And given that it
> > >    is a staging driver it really doesn't matter anyway if we break it.
> > 
> > It's not very polite to suggest breaking other people's drivers for such a
> > small matter, staging or not. That'd be bound to break kernel compilation
> > for a lot of people, if for nothing else.
> > 
> > Anyway, thanks for cc'ing me. I agree with suggestion and I'll submit a
> > patch to address it.
> 
> Already done, see:
> 
>   https://lkml.kernel.org/r/20200414131348.444715-5-hch@lst.de

Ah, thanks for pointing this out. Please ignore this then.

-- 
Regards,

Sakari Ailus
