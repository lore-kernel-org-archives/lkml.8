Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD7AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8460D2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXllCjjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgFARIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:08:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22986 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726555AbgFARIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591031328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aBfVnLq9ec7IA3u5TWoDLJTmL8ZGnJcANeLd1J0lvVs=;
        b=fXllCjjyGOoKGXMmNcw5d6/jV63+k2V4TrguxfUbTbdhacsJ3d/0F9DBt0fsXCN1Up6iUJ
        WNK/Dh0AchB6xCtwI/xT6sSIkp8/RLH7aaiQlNCLZ+EyV76+HQa/xpob2EAsajxjaK5QUs
        LWSBNDAHyYi5vqDS/c/y8/DhDLOmLxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-i0lRwKS8OGmsfJbPywpuyA-1; Mon, 01 Jun 2020 13:08:46 -0400
X-MC-Unique: i0lRwKS8OGmsfJbPywpuyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6856C107ACCD;
        Mon,  1 Jun 2020 17:08:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C954E7F0A4;
        Mon,  1 Jun 2020 17:08:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <779b327f-b0fa-e21f-cbf6-5cadeca58581@web.de>
References: <779b327f-b0fa-e21f-cbf6-5cadeca58581@web.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dhowells@redhat.com, Zhihao Cheng <chengzhihao1@huawei.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yi Zhang <yi.zhang@huawei.com>
Subject: Re: [PATCH v2] afs: Fix memory leak in afs_put_sysnames()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1346216.1591031323.1@warthog.procyon.org.uk>
Date:   Mon, 01 Jun 2020 18:08:43 +0100
Message-ID: <1346217.1591031323@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Elfring <Markus.Elfring@web.de> wrote:

> > sysnames should be freed after refcnt being decreased to zero in
> > afs_put_sysnames().
> 
> How do you think about a wording variant like the following?
> 
>    Release the sysnames object after its reference counter was decreased
>    to zero.

I would say "reference count" not "reference counter" personally.  I would
also say "afs_sysnames" rather than "sysnames".  Perhaps something like:

	Fix afs_put_sysnames() to actually free the specified afs_sysnames
	object after its reference count has been decreased to zero and its
	contents have been released.

> Will it matter to mention the size of the data structure "afs_sysnames"?

Why is it necessary to do so?

David

