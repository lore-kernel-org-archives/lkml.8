Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEABAC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C211624683
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXvpxSzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgBZOOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:14:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23248 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726579AbgBZOOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582726481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZqF/3U/In6tsjc0/5/XzbqWfAQzpkXhXZK9elqtvXHY=;
        b=aXvpxSzEY4KsvWHgGq8Q8/B62unDaOVz7N1iJvNeGyjYjKd3kCYzkoLZr7icMjEhZNELBk
        AnO3PbwBahJv5l+6PLNaxP1uK6a8BGw4rZy0Sn0MGjYSzM4XzGWG0oPqnvTWNpU1Djw53n
        wUddhzbU6jnD+FlZrja0HhI4Z1zfyfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-jEqJbF1kNyKhkeICBUStJA-1; Wed, 26 Feb 2020 09:14:38 -0500
X-MC-Unique: jEqJbF1kNyKhkeICBUStJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3387D8C78AA;
        Wed, 26 Feb 2020 14:14:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C360390CD1;
        Wed, 26 Feb 2020 14:14:31 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 01QEEVDP016665;
        Wed, 26 Feb 2020 09:14:31 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 01QEEVfP016661;
        Wed, 26 Feb 2020 09:14:31 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 26 Feb 2020 09:14:31 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Lukas Straub <lukasstraub2@web.de>
cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dm-devel <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH] dm-integrity: Prevent RMW for full tag area
 writes
In-Reply-To: <20200226092705.61b7dcf4@luklap>
Message-ID: <alpine.LRH.2.02.2002260906280.17883@file01.intranet.prod.int.rdu2.redhat.com>
References: <20200220190445.2222af54@luklap> <alpine.LRH.2.02.2002251127070.1014@file01.intranet.prod.int.rdu2.redhat.com> <20200226092705.61b7dcf4@luklap>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Feb 2020, Lukas Straub wrote:

> > > -		data = dm_bufio_read(ic->bufio, *metadata_block, &b);
> > > -		if (IS_ERR(data))
> > > -			return PTR_ERR(data);
> > > +		/* Don't read tag area from disk if we're going to overwrite it completely */
> > > +		if (op == TAG_WRITE && *metadata_offset == 0 && total_size >= ic->metadata_run) {
> >
> > Hi
> >
> > This is incorrect logic because ic->metadata_run is in the units of
> > 512-byte sectors and total_size is in bytes.
> >
> > If I correct the bug and change it to "if (op == TAG_WRITE &&
> > *metadata_offset == 0 && total_size >= ic->metadata_run << SECTOR_SHIFT)",
> > then the benchmark doesn't show any performance advantage at all.
> 
> Uh oh, looking at it again i have mixed up sectors/bytes elsewhere too.
> Actually, could we rewrite this check like
>  total_size >= (1U << SECTOR_SHIFT << ic->log2_buffer_sectors)?
> this should work, right?
> So we only have to overwrite part of the tag area, as long as it's whole sectors.
> 
> > You would need much bigger bios to take advantage for this - for example,
> > if we have 4k block size and 64k metadata buffer size and 4-byte crc32,
> > there are 65536/4=16384 tags in one metadata buffer and we would need
> > 16384*4096=64MiB bio to completely overwrite the metadata buffer. Such big
> > bios are not realistic.
> 
> What prevents us from using a single sector as the tag area? (Which was 

Single sector writes perform badly on SSDs (and on disks with 4k physical 
sector size). We would need at least 4k.

There's another problem - using smaller metadata blocks will degrade read 
performance, because we would need to issue more requests to read the 
metadata.

> my assumption with this patch) Then we would have (with 512b sectors) 
> 512/4 = 128 tags = 64k bio, which is still below the optimal write size 

4096/4*4096 = 4MiB - it may be possible, but it's still large.

> of raid5/6. I just tried to accomplish this, but there seems to be 
> minimum limit of interleave_sectors.
> 
> Regards,
> Lukas Straub

Mikulas

