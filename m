Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1796CC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C2A20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581374148;
	bh=82MflMcVGrmt5MUVdc81CJL6FsYuXLCsmLVCoby/PDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=szZ7vYYuxRqadrYMcihZlcEGtJRzLFqTN79ar3J2U8MiTb5cusTy6isOdCQyjlp4i
	 5iYRwmbLZPG6YY6A/P1mAWfwKS6xs5Qfx6X0LQpAiQiewAoQPxrqewvqi3Aeb8Ph4c
	 SurvUfT8DsO866W0J9oN7q8kzVjVuGWu9B0seIz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgBJWfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgBJWfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:35:47 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91792082F;
        Mon, 10 Feb 2020 22:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581374147;
        bh=82MflMcVGrmt5MUVdc81CJL6FsYuXLCsmLVCoby/PDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I3IdaBh/8Z59OiKykBh+V8G/EgR798P7TPHUJGrBpd84Ff/TPO0S0VpOStU5xiec9
         HH3/vLtUQ+LRx9b4atJDI6GHwGrBvRSj2OQujL9M/xSOe5L3JIfVPevKOQdrZKBg19
         kjIpnVeFF7ypVxImosOnulkEEgUNmjdA/ludY4Po=
Date:   Mon, 10 Feb 2020 14:35:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com
Subject: Re: [PATCH -next 0/5] rbtree: optimize frequent tree walks
Message-Id: <20200210143546.4491d9715f1c4a0a1de999ca@linux-foundation.org>
In-Reply-To: <20200210155611.lfrddnolsyzktqne@linux-p48b>
References: <20200207180305.11092-1-dave@stgolabs.net>
        <20200209174632.9c7b6ff20567853c05e5ee58@linux-foundation.org>
        <20200210155611.lfrddnolsyzktqne@linux-p48b>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 07:56:11 -0800 Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Sun, 09 Feb 2020, Andrew Morton wrote:
> >Seems that all the caller sites you've converted use a fairly small
> >number of rbnodes, so the additional storage shouldn't be a big
> >problem.  Are there any other sites you're eyeing?  If so, do you expect
> >any of those will use a significant amount of memory for the nodes?
> 
> I also thought about converting the deadline scheduler to use these,
> mainly benefiting pull_dl_task() but didn't get to it and I don't expect
> the extra footprint to be prohibitive.
> 
> >
> >And...  are these patches really worth merging?  Complexity is added,
> >but what end-user benefit can we expect?
> 
> Yes they are worth merging, imo (which of course is biased :)
> 
> I don't think there is too much added complexity overall, particularly
> considering that the user conversions are rather trivial. And even for
> small trees (ie 100 nodes) we still benefit in a measurable way from
> these optimizations.
> 

Measurable for microbenchmarks, I think?  But what benefit will a user
see, running a workload that is cared about?
