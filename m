Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1364C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65012076A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588119262;
	bh=ApiAPyhl/EFXtSrNddcCQTYMor9KnWKySFnM/W1KpQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jNp+TNb9V6u9UcUMt2bF2+i4/gXxdHGjTln/06ci60YjzgSLLXxFiXeo16PpbT0C+
	 bJnuz1NrKqSVFzNZI8g0NiXmetzmJiYKrsXCb6BvCuDuiGEkD8BHdBfLhrFGVjITl0
	 9Xbjn6vmOLO7Y6gPcJf77zOdM9JXhpT3p3/kORpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgD2AOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgD2AOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:14:21 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8EB020737;
        Wed, 29 Apr 2020 00:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588119261;
        bh=ApiAPyhl/EFXtSrNddcCQTYMor9KnWKySFnM/W1KpQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gj633SS5ASO3BAGJRPyDnJc9G0cEPDsMsWpEe4wrBEoe0lF42RQ33mz05tbA8WzlV
         TVNb6T/5oHpRpWlmNZTSZQobZEpyVDLzhXEfds63/1kPcTlJVwuuldLO/hqJVzO31x
         ilUnL2ltMmDqxFt19OElVcqOxQrPHtY6S0Knl4HE=
Date:   Tue, 28 Apr 2020 17:14:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Waiman Long <longman@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ipc: use GFP_ATOMIC under spin lock
Message-Id: <20200428171420.045f0acc9e1bf20044c4560e@linux-foundation.org>
In-Reply-To: <20200428111403.GJ29705@bombadil.infradead.org>
References: <20200428034736.27850-1-weiyongjun1@huawei.com>
        <20200428111403.GJ29705@bombadil.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 04:14:03 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Apr 28, 2020 at 03:47:36AM +0000, Wei Yongjun wrote:
> > The function ipc_id_alloc() is called from ipc_addid(), in which
> > a spin lock is held, so we should use GFP_ATOMIC instead.
> > 
> > Fixes: de5738d1c364 ("ipc: convert ipcs_idr to XArray")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> I see why you think that, but it's not true.  Yes, we hold a spinlock, but
> the spinlock is in an object which is not reachable from any other CPU.
> So it's not possible to deadlock.

um, then why are we taking it?

>  This probably confuses all kinds
> of automated checkers,

A big fat code comment would reduce the email traffic?

> and I should probably rewrite the code to not
> acquire the new spinlock until we're already holding the xa_lock.
> 

