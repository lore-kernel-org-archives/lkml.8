Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93264C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615F82082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579286573;
	bh=CR8E6lRLBE6fE2cORjU/dqghNqr4V3/7DeaKyioujBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SsgriOzHBnyD1GQPfTyN+KuyWyHvE2EpNtSYl0GgD7IpFv2xrnnexE3AyqZLLWl1U
	 DodQuB6D4pGb4uIeekXlRqbaSQGHZNAcKrR9z+R8fEvz4mzbMnMhJce8dm5oD9Eb0F
	 Xa0XDu/Axe8JAhsQzU/MU4PIwHyR2+HXsddH+aws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAQSmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgAQSmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:42:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 151A02072B;
        Fri, 17 Jan 2020 18:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579286571;
        bh=CR8E6lRLBE6fE2cORjU/dqghNqr4V3/7DeaKyioujBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wMBkHaU7nTUa9rSxSaYqB1xdjCgYNYdIGQr3eOYpgC0BC164j13Xdd9Oj6Cvw2VbC
         CWbWP2Nq64c3XMw2xZ8ux6EwbKSyBQkXR2s1gx8vwdot3oh5v1tC2T3ZJNHomPGT+J
         2+9ThHvcSsNigUnMp2N+KXtEnea9wVu0ofIrxmI0=
Date:   Fri, 17 Jan 2020 19:42:49 +0100
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
Message-ID: <20200117184249.GB1969121@kroah.com>
References: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
 <20200117133759.5729-3-roman.sudarikov@linux.intel.com>
 <20200117141944.GC1856891@kroah.com>
 <20200117162357.GK302770@tassilo.jf.intel.com>
 <20200117165406.GA1937954@kroah.com>
 <20200117172726.GM302770@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117172726.GM302770@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 09:27:26AM -0800, Andi Kleen wrote:
> > > Could you suggest how such a 1:N mapping should be expressed instead in
> > > sysfs?
> > 
> > I have yet to figure out what it is you all are trying to express here
> > given a lack of Documentation/ABI/ file :)
> 
> I thought the example Roman gave was clear.
> 
> System has multiple dies
> Each die has 4 pmon ports
> Each pmon port per die maps to one PCI bus.
> 
> He mapped it to 
> 
> pmon0-3: list of pci busses indexed by die
> 
> To be honest the approach doesn't seem unreasonable to me. It's similar
> e.g. how we express lists of cpus or nodes in sysfs today.

Again, you are having to parse a single line of output from sysfs that
contains multiple values, one that will just keep getting bigger and
bigger as time goes on until we run out of space.

One value per file for sysfs, it's been the rule since the beginning.
If there are files that violate this, ugh, it slips through, but as the
submitter is asking for my review, I am going to actually follow the
rules here.

greg k-h
