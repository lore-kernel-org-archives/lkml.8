Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DEEC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBDF206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SquMm66G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgIATkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:40:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52530 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726936AbgIATkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598989230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k7XoFpfF3zK9F/hjkpwRp6hPdDVo06E2ZLhjn5fGMkY=;
        b=SquMm66GtVMqAZCMPI4sebTtMTxRrlnbINNeaRmC+aR/JDEwR+3Um79+dqXSVPAo0XRT7v
        a3zfqZxigK4RtkOYfN3TnUtOHWgMlSGrvbIczt7RDUf6pYUYZPMyEdA1UjuuWoNaWR8Lwh
        TpwKAxflBm4OyIgywWCZKQ86ESE6gWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-NBhsF6_WMFSlQ5EdgLgVgQ-1; Tue, 01 Sep 2020 15:40:29 -0400
X-MC-Unique: NBhsF6_WMFSlQ5EdgLgVgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1B7A18B9EB6;
        Tue,  1 Sep 2020 19:40:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-231.rdu2.redhat.com [10.10.113.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A21D05C1C4;
        Tue,  1 Sep 2020 19:40:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200901164827.GQ14765@casper.infradead.org>
References: <20200901164827.GQ14765@casper.infradead.org> <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] mm: Make more use of readahead_control
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <423218.1598989225.1@warthog.procyon.org.uk>
Date:   Tue, 01 Sep 2020 20:40:25 +0100
Message-ID: <423219.1598989225@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > Also there's an apparent minor bug in khugepaged.c that I've included a
> > patch for: page_cache_sync_readahead() looks to be given the wrong size in
> > collapse_file().
> 
> This needs to go in as an independent fix.  But you didn't actually cc Song.

Bah.  I forgot to pass --auto to stgit.  No matter, he saw it anyway.

David

