Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5792AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F242072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPbd36yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391143AbgFXO0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:26:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42622 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388115AbgFXO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593008794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Asd6KB19RKXQe2oHJ11QoHr6ke20Niq5tDtEhqotynY=;
        b=gPbd36yjuw9c9LZ/p6LOywnNIC+HkS31YE7OxATBp1lA4dS4iOZ0etLqEqrz4xTwBbr+46
        w6MA8ib99/Vy1Pbc5qoADMM8yZBHhuOOAWLM9nSENNsipv64KjHatslFXXybQ8Cvn+6zi0
        9hyO3iNeB3/TC6sMsUYOiIBncBdeV+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-bZdIp3mNNWW456JCtacMtA-1; Wed, 24 Jun 2020 10:26:32 -0400
X-MC-Unique: bZdIp3mNNWW456JCtacMtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3766218A8221;
        Wed, 24 Jun 2020 14:26:31 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65B775D9DC;
        Wed, 24 Jun 2020 14:26:29 +0000 (UTC)
Date:   Wed, 24 Jun 2020 10:26:26 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page_alloc: fix documentation error and remove magic
 numbers
Message-ID: <20200624142626.GB1987277@optiplex-lnx>
References: <20200624032712.23263-1-jsavitz@redhat.com>
 <20200624111255.GL21350@casper.infradead.org>
 <20200624140727.GA1987277@optiplex-lnx>
 <20200624140958.GN21350@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624140958.GN21350@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:09:58PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 24, 2020 at 10:07:27AM -0400, Rafael Aquini wrote:
> > On Wed, Jun 24, 2020 at 12:12:55PM +0100, Matthew Wilcox wrote:
> > > On Tue, Jun 23, 2020 at 11:27:12PM -0400, Joel Savitz wrote:
> > > > In addition, this patch replaces the magic number bounds with symbolic
> > > > constants to clarify the logic.
> > > 
> > > Why do people think this kind of thing makes the code easier to read?
> > > It actually makes it harder.  Unless the constants are used in more
> > > than one place, just leave the numbers where they are.
> > > 
> > > > @@ -7852,6 +7852,9 @@ void setup_per_zone_wmarks(void)
> > > >   * 8192MB:	11584k
> > > >   * 16384MB:	16384k
> > > >   */
> > > > +static const int MIN_FREE_KBYTES_LOWER_BOUND = 1 << 7;
> > > > +static const int MIN_FREE_KBYTES_UPPER_BOUND = 1 << 18;
> > > > +
> > 
> > I think these constants would look better if declared as an enum.
> 
> Why does having to look in two different places make the code clearer?
>

It might not make it clearer in this particular case, because it was
easy to take the meaning from the code, but it also doesn't make it
harder to read, so I don't have any strong opinion on this case. 

Joel's approach, however, makes sense if you consider it's generally a 
good practice to get rid of the unnamed magic numbers anti-pattern.

Cheers,
-- Rafael

