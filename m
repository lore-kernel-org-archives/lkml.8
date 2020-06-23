Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A30C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1DF20656
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaoN8QA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbgFWPeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:34:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32931 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732738AbgFWPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592926442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s4vipZzC2aXfqHyxgFFKgIRQV3lS7HzdSqHHonX0YJ8=;
        b=ZaoN8QA7wuvFXHStbwhsxIc/NggX33O3FEQoiYRjeGEL57Uu0/djE1vLAeHfKHJi7q4nrM
        tXJ8EtzuOaZtuFEvFKWcPXnSyE20sq2P3/YOyHjnkWegWpgtgLRv3QxywAuSQ6ihH7h6fT
        XbeYox/SlzJMVpTfXSSqZgR50W7bxO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-Fdj0HluaO2Wwf1FVUy9ZjQ-1; Tue, 23 Jun 2020 11:33:58 -0400
X-MC-Unique: Fdj0HluaO2Wwf1FVUy9ZjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D641019057A1;
        Tue, 23 Jun 2020 15:33:56 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B0597CCF9;
        Tue, 23 Jun 2020 15:33:53 +0000 (UTC)
Date:   Tue, 23 Jun 2020 11:33:52 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ignat Korchagin <ignat@cloudflare.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>, agk@redhat.com,
        dm-devel@redhat.com, dm-crypt@saout.de,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH 0/1] dm-crypt excessive overhead
Message-ID: <20200623153352.GA19783@redhat.com>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619165548.GA24779@redhat.com>
 <alpine.LRH.2.02.2006191429060.23991@file01.intranet.prod.int.rdu2.redhat.com>
 <20200620012332.GA25340@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620012332.GA25340@gondor.apana.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19 2020 at  9:23pm -0400,
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Fri, Jun 19, 2020 at 02:39:39PM -0400, Mikulas Patocka wrote:
> >
> > I'm looking at this and I'd like to know why does the crypto API fail in 
> > hard-irq context and why does it work in tasklet context. What's the exact 
> > reason behind this?
> 
> You're not supposed to do any real work in IRQ handlers.  All
> the substantial work should be postponed to softirq context.
> 
> Why do you need to do work in hard IRQ context?

Ignat, think you may have missed Herbert's question?

My understanding is that you're doing work in hard IRQ context (via
tasklet) precisely to avoid overhead of putting to a workqueue?  Did
you try using a workqueue and it didn't work adequately?  If so, do you
have a handle on why that is?  E.g. was it due to increased latency? or
IO completion occurring on different cpus that submitted (are you
leaning heavily on blk-mq's ability to pin IO completion to same cpu as
IO was submitted?)

I'm fishing here but I'd just like to tease out the details for _why_
you need to do work from hard IRQ via tasklet so that I can potentially
defend it if needed.

Thanks,
Mike

