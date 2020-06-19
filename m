Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C128C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED2720DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0aJNXfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbgFSSjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:39:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731358AbgFSSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592591992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rcl3Tsq20b25qpxfIY8/T/emiAI5DcC+fOswqOgue0s=;
        b=h0aJNXfOZ4rGi+/X4FmM9ej1WVju3jVh1h8Xe2HdX9BoyOB4q9N4wgRNT9BrUDaMs/rjWn
        wyCGjN8PoN7bMFHbhFDeUKLkDiOgRA5i8DaU3X5LnQMSMZd/8a5AiLcyupTdOjuo9i+tv0
        h99brFhPPG6B/oPq1FKOzkAISEsZxbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-zYiwwnGWMAi2INwzf2hTCQ-1; Fri, 19 Jun 2020 14:39:48 -0400
X-MC-Unique: zYiwwnGWMAi2INwzf2hTCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC7FF107ACCA;
        Fri, 19 Jun 2020 18:39:46 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5718619D7B;
        Fri, 19 Jun 2020 18:39:41 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 05JIde6C026822;
        Fri, 19 Jun 2020 14:39:40 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 05JIddo9026818;
        Fri, 19 Jun 2020 14:39:39 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 19 Jun 2020 14:39:39 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Ignat Korchagin <ignat@cloudflare.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
cc:     Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, dm-crypt@saout.de,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH 0/1] dm-crypt excessive overhead
In-Reply-To: <20200619165548.GA24779@redhat.com>
Message-ID: <alpine.LRH.2.02.2006191429060.23991@file01.intranet.prod.int.rdu2.redhat.com>
References: <20200619164132.1648-1-ignat@cloudflare.com> <20200619165548.GA24779@redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Jun 2020, Mike Snitzer wrote:

> On Fri, Jun 19 2020 at 12:41pm -0400,
> Ignat Korchagin <ignat@cloudflare.com> wrote:
> 
> > This is a follow up from the long-forgotten [1], but with some more convincing
> > evidence. Consider the following script:
> > 
> > [1]: https://www.spinics.net/lists/dm-crypt/msg07516.html
> > [2]: https://blog.cloudflare.com/speeding-up-linux-disk-encryption/
> > 
> > Ignat Korchagin (1):
> >   Add DM_CRYPT_FORCE_INLINE flag to dm-crypt target
> > 
> >  drivers/md/dm-crypt.c | 55 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 43 insertions(+), 12 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 
> 
> Hi,
> 
> I saw [2] and have been expecting something from cloudflare ever since.
> Nice to see this submission.
> 
> There is useful context in your 0th patch header.  I'll likely merge
> parts of this patch header with the more terse 1/1 header (reality is
> there only needed to be a single patch submission).
> 
> Will review and stage accordingly if all looks fine to me.  Mikulas,
> please have a look too.
> 
> Thanks,
> Mike

+       if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags)) {
+               if (in_irq()) {
+                       /* Crypto API will fail hard in hard IRQ context */
+                       tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
+                       tasklet_schedule(&io->tasklet);
+               } else
+                       kcryptd_crypt(&io->work);
+       } else {
+               INIT_WORK(&io->work, kcryptd_crypt);
+               queue_work(cc->crypt_queue, &io->work);
+       }

I'm looking at this and I'd like to know why does the crypto API fail in 
hard-irq context and why does it work in tasklet context. What's the exact 
reason behind this?

Mikulas

