Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474C7C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3EC214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579280051;
	bh=FY97BvRPdZSU2bIodwF411p0zZgZzBz9rfMfxvBV0Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y9BbENsnsjYMWRyGb+Tq1E8JkxbZrLqzGzXI5nDj78h39GopqU2LznSf8i6bPAk7K
	 0yz4XIYYZ2ZqglQ4luioWpSC0851rlGJLMGr4yhyh5iY3KuUXk6iMit+uhaZ6BePIv
	 5qdFsSy+AONH9ANR3SPNrp1VrXWunCs49e90nob8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAQQyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:54:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgAQQyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:54:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E707E2072B;
        Fri, 17 Jan 2020 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579280048;
        bh=FY97BvRPdZSU2bIodwF411p0zZgZzBz9rfMfxvBV0Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/bI+vGEPuRESvXvSwPWfqllyNprA4S2VpVi05U+yn/41OeA6M8TqCcjjGvANG2T6
         qKcr4mkabYVo+s7BEgvHEJaAM3nXhf4dcUU61v2p7+/vbrThg6BIJKWysCwmLgYxbJ
         BZeZqz5mUOjt05bV5SwjEkcqRFNXcpvA24WMsDrs=
Date:   Fri, 17 Jan 2020 17:54:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     roman.sudarikov@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v4 2/2] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200117165406.GA1937954@kroah.com>
References: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
 <20200117133759.5729-3-roman.sudarikov@linux.intel.com>
 <20200117141944.GC1856891@kroah.com>
 <20200117162357.GK302770@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117162357.GK302770@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 08:23:57AM -0800, Andi Kleen wrote:
> > I thought I was nice and gentle last time and said that this was a
> > really bad idea and you would fix it up.  That didn't happen, so I am
> > being explicit here, THIS IS NOT AN ACCEPTABLE FILE OUTPUT FOR A SYSFS
> > FILE.
> 
> Could you suggest how such a 1:N mapping should be expressed instead in
> sysfs?

I have yet to figure out what it is you all are trying to express here
given a lack of Documentation/ABI/ file :)

But again, sysfs is ONE VALUE PER FILE.  You have a list of items here,
that is bounded only by the number of devices in the system at the
moment.  That number will go up in time, as we all know.  So this is
just not going to work at all as-is.

greg k-h
