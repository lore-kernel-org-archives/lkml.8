Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91720C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5C02071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+VeHmUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgIAToU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbgIAToU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598989458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nTHlq3Kl2GCIO7zccVhN6JeQ5RlCQEu/xPuuaep77Qk=;
        b=K+VeHmUMuGySv/GBtZ5hngff1skKlnluIGzkGzbgyLtQf7aBO8rcLqvPPRjSvFMczFB2hC
        EBg45NCQ/gsXuVtQLuGRV54M3PORZjHwnfUnAdRgvlqltQX1ZCL+lSGbeut8Lcal9rioxM
        H5Cf12h4yzLtsaqjQHCeyWrNEHz7lx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-j-YWKZGfMaSROuVIV8aAKg-1; Tue, 01 Sep 2020 15:44:17 -0400
X-MC-Unique: j-YWKZGfMaSROuVIV8aAKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 247FE425D1;
        Tue,  1 Sep 2020 19:44:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-231.rdu2.redhat.com [10.10.113.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25FEC78B29;
        Tue,  1 Sep 2020 19:44:15 +0000 (UTC)
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
Content-ID: <423538.1598989454.1@warthog.procyon.org.uk>
Date:   Tue, 01 Sep 2020 20:44:14 +0100
Message-ID: <423539.1598989454@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > Note that I've been
> > passing the number of pages to read in rac->_nr_pages, and then saving it
> > and changing it certain points, e.g. page_cache_readahead_unbounded().
> 
> I do not like this.  You're essentially mutating the meaning of _nr_pages
> as the ractl moves down the stack, and that's going to lead to bugs.
> I'd keep it as a separate argument.

The meaning isn't specified in linux/pagemap.h.  Can you adjust the comments
on the struct and on readahead_count() to make it more clear what the value
represents?

Thanks,
David

