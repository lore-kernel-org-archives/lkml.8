Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68E8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 19:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1132464E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 19:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eH7a5r35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgFTTgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 15:36:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30386 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728544AbgFTTgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 15:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592681795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g8WdW3pAZTXSYPszUGjpxZHpJb0PKXk+NRFlf8yIkz0=;
        b=eH7a5r35IyZEzKOHPYu2nsMSOv5b5uZUBYsUvKkiqrREQkkjLiOrRjhfYDjeFt3O2+KuGQ
        LeSIch2tlNnNsVvt0naBbFFuaEHajt9UD+foCFt6gF8BsrI9yTur4EKyuOUF2yy5PVMNwP
        UD8eadrKXzu3S75FmBtW9khO29+foTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-a7fo6He5Pi2qzdEZTmsM4Q-1; Sat, 20 Jun 2020 15:36:30 -0400
X-MC-Unique: a7fo6He5Pi2qzdEZTmsM4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74037835B40;
        Sat, 20 Jun 2020 19:36:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A32A05BAD5;
        Sat, 20 Jun 2020 19:36:23 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 05KJaNfQ025067;
        Sat, 20 Jun 2020 15:36:23 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 05KJaMP8025063;
        Sat, 20 Jun 2020 15:36:22 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sat, 20 Jun 2020 15:36:21 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Herbert Xu <herbert@gondor.apana.org.au>
cc:     Ignat Korchagin <ignat@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, dm-crypt@saout.de,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH 0/1] dm-crypt excessive overhead
In-Reply-To: <20200620012332.GA25340@gondor.apana.org.au>
Message-ID: <alpine.LRH.2.02.2006201535280.24999@file01.intranet.prod.int.rdu2.redhat.com>
References: <20200619164132.1648-1-ignat@cloudflare.com> <20200619165548.GA24779@redhat.com> <alpine.LRH.2.02.2006191429060.23991@file01.intranet.prod.int.rdu2.redhat.com> <20200620012332.GA25340@gondor.apana.org.au>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Jun 2020, Herbert Xu wrote:

> On Fri, Jun 19, 2020 at 02:39:39PM -0400, Mikulas Patocka wrote:
> >
> > I'm looking at this and I'd like to know why does the crypto API fail in 
> > hard-irq context and why does it work in tasklet context. What's the exact 
> > reason behind this?
> 
> You're not supposed to do any real work in IRQ handlers.  All
> the substantial work should be postponed to softirq context.

I see.

BTW - should it also warn if it is running in a process context with 
interrupts disabled?

Mikulas

> Why do you need to do work in hard IRQ context?
> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 

