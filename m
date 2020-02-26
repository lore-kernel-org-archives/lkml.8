Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC56C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C1C24656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582712114;
	bh=8G3COdP14D9n92YRf3mFEELtywZgXkiuQFtraYf7e84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u+dyt67nrMp1TT3bCb59TIVu7HaMv1twkWQ2ReUjwFdSs619sSaZy+tUcQ0nw7c2U
	 nz0dMq7zihhtqW3DVGQoIFBtwz7/fyWJXgK07EGhdVtXIZDgkx0fMn1HtpChQQNTIQ
	 EFBoFyoKZekV7I+7s1z+187adkphCtzsmHMOwrQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBZKPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:15:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgBZKPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:15:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5890420838;
        Wed, 26 Feb 2020 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582712112;
        bh=8G3COdP14D9n92YRf3mFEELtywZgXkiuQFtraYf7e84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbDOsgVihqU8SaREq8lEBFaj8iA71rJOb1rxMQyBgLibxWbwW+m/UnSTObrCnYjQn
         EYwwDLlEfFFLnjrnms13nwfreSn8vYZvxL4VZ7khrG6kp61ijBPCxbje97jbzG6uXU
         ie2SWrjJtlKBS8c7nLwLXAQhwzNxByYudgSPSx40=
Date:   Wed, 26 Feb 2020 11:14:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        akpm@linux-foundation.org, naveen.n.rao@linux.ibm.com,
        ardb@kernel.org, Luigi Rizzo <rizzo@iet.unipi.it>,
        Paolo Abeni <pabeni@redhat.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH 0/2] quickstats, kernel sample collector
Message-ID: <20200226101449.GF127655@kroah.com>
References: <20200226023027.218365-1-lrizzo@google.com>
 <20200226081048.GC22801@kroah.com>
 <CAMOZA0+4Qg+bDQ1xGQ0jL=dvXK80LuxOa7tEd-=iBwat2M9pfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMOZA0+4Qg+bDQ1xGQ0jL=dvXK80LuxOa7tEd-=iBwat2M9pfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:52:25AM -0800, Luigi Rizzo wrote:
> On Wed, Feb 26, 2020 at 12:10 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Feb 25, 2020 at 06:30:25PM -0800, Luigi Rizzo wrote:
> > > This patchset introduces a small library to collect per-cpu samples and
> > > accumulate distributions to be exported through debugfs.
> >
> > Shouldn't this be part of the tracing infrastructure instead of being
> > "stand-alone"?
> 
> That's an option. My reasoning for making it standalone was that
> there are no dependencies in the (trivial) collection/aggregation part,
> so that code might conveniently replace/extend existing snippets of
> code that collect distributions in ad-hoc and perhaps suboptimal ways.

But that's what perf and tracing already does today, right?  You need to
integrate into the existing subsystems of the kernel and not duplicate
things, creating new user/kernel apis whenever possible.

thanks,

greg k-h
