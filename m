Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE70DC33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD4520721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DutMquvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgBCKXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:23:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44507 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgBCKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580725429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ir31YPKw00IaR4oAq3edSrrdUHl7ICLQw2SC3HVAAC4=;
        b=DutMquvdbcFzWxbaeJqrEYw23CO0QRlhTP2n+eUPy56BVuKWhHgVmJBaCb0cj3g9XI95E6
        /ReMVQBYYS9e8oiDeHf2+D1ygVh6e0XDhNq1/XxMmMzX+wU34i+HLFh+90uE6NiRTxjWbP
        cCj2XeuRWqpJG7OdZSwdGvE4mnkJAws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-nK8sREX3OCKJMwcjJ7ImLg-1; Mon, 03 Feb 2020 05:23:47 -0500
X-MC-Unique: nK8sREX3OCKJMwcjJ7ImLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 780EB18A6EC2;
        Mon,  3 Feb 2020 10:23:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-218.rdu2.redhat.com [10.10.120.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 702A91FD3B;
        Mon,  3 Feb 2020 10:23:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200202122735.157d8b44@cakuba.hsd1.ca.comcast.net>
References: <20200202122735.157d8b44@cakuba.hsd1.ca.comcast.net> <158047735578.133127.17728061182258449164.stgit@warthog.procyon.org.uk> <158047737679.133127.13567286503234295.stgit@warthog.procyon.org.uk>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/4] rxrpc: Fix missing active use pinning of rxrpc_local object
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <734243.1580725424.1@warthog.procyon.org.uk>
Date:   Mon, 03 Feb 2020 10:23:44 +0000
Message-ID: <734244.1580725424@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> wrote:

> > +	BUG_ON(!conn->params.local);
> > +	BUG_ON(!conn->params.local->socket);
> 
> Is this really, really not possible to convert those into a WARN_ON()
> and return?

I can take those out - I actually put them in to help figure out which pointer
had become NULL - but turning them into a WARN_ON() and return doesn't
actually help that much since, without this patch, there was nothing to stop
the relevant pointer getting cleared between this point and the next access,
so there's a chance you'd end up with the same oops anyway.

David

