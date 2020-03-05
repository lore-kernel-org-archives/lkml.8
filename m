Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2947C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E53520732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583419601;
	bh=L4ZdQdi1rNUQzzkxkwNiIZW1J/GbJ/1wVrt38kYUTeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jifDJgfcWAtkbNz7fdrkBLmXaQTt9ynP5WWJmRQIdnCv6X6IFbatcnGPsDeE1z3Oa
	 yyiXciNqmGyMafFaNeIIQK78B0iBQz/fNCyHToki0/9POp2PwYu9z5YlFj+mGc3UXC
	 NVfq8BoN/WE9iodE5Mw/6jJBYsuwAri4rNM2dbbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCEOqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:46:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgCEOqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:46:40 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C6620848;
        Thu,  5 Mar 2020 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583419599;
        bh=L4ZdQdi1rNUQzzkxkwNiIZW1J/GbJ/1wVrt38kYUTeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rYziTihmuKKRsGCZ9uXv5X4y84UTXGvKx1LymSBvfR+s+Uvr3F0f471EHMCrlJepl
         I2eAGbD2Xy/2cldNDHWRHKNCisuu+so+mbm8kDLUHc8yxNgFmmjpeaN5NyNH1f7CsN
         WWShshldRAHltyjOtguly1F432XWaO9OrZNoW0/A=
Date:   Thu, 5 Mar 2020 23:46:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, rizzo@iet.unipi.it
Subject: Re: [PATCH v4] kretprobe: percpu support
Message-Id: <20200305234636.1abe2047973df1bdabc6e152@kernel.org>
In-Reply-To: <CAMOZA0+OfDFmgvPK6YPpKjuqQbG5LG6mydwL5S2w_UDte1jNWA@mail.gmail.com>
References: <20200221211657.147250-1-lrizzo@google.com>
        <20200305154240.91406117aebe1f72103e5a9b@kernel.org>
        <CAMOZA0+OfDFmgvPK6YPpKjuqQbG5LG6mydwL5S2w_UDte1jNWA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 12:05:42 +0100
Luigi Rizzo <lrizzo@google.com> wrote:

> > > As part of this patch, we factor out the code to allocate instances in
> > > get_pcpu_rp_instance() and get_rp_instance().
> > >
> > > At the moment we only allow one pending kretprobe per CPU. This can be
> > > extended to a small constant number of entries, but finding a free entry
> > > would either bring back the lock, or require scanning an array, which can
> > > be expensive (especially if callers block and migrate).
> >
> > I think if you disables irq while scanning an array (that should be
> > a small array), you don't need to afraid of such racing (maybe we need
> > a pair of memory barriers).
> >
> 
> To be clear, I was not concerned by races (irq disabled solve that, worst
> case we'll miss an entry being freed by another core while we scan). The
> cost I worried about was when we have many busy entries which can possibly
> be out of the local cache of cpu X eg because the thread that grabbed the
> entry moved to another cpu Y and is updating the record there. This can be
> partially mitigated by putting the user block in a different cache line so
> the cache conflict will happen only once on release.

But how much the cost is? Would you have any actual probe point and workload
about your concerning usecases? I think we can use perf to measure actual cost.

I would like to know the actual benefit of this change.
This is important because, in the future, if someone has another idea to
fix your concern, how I can judge it?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
