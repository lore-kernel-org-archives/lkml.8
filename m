Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA34C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A9320728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z31HpKpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgEOPPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:15:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24860 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726521AbgEOPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589555737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JreAY7MKMl9fHBBX1SskPW+QiLkeoSeDm7rQFvd/Pn4=;
        b=Z31HpKpp0EkTVy9Gxtmsb1dKqsSx1AbNr7bb0YVfY2/d2YA2FlZ6Cbt8kDBIEnOu+ASqBr
        Gxg2WsXrMHERA1ZrDBXadeEKPOuraKe3YnFytU4jxH/HMx3BRGd44ymMYVMDUzPw0ao/Jl
        fv2CxhR6skzsqHQnqT07ToLYcZhHavE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-szRU-cO-O-uHE_tEFGhqcw-1; Fri, 15 May 2020 11:15:35 -0400
X-MC-Unique: szRU-cO-O-uHE_tEFGhqcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 619438005AD;
        Fri, 15 May 2020 15:15:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE21960C84;
        Fri, 15 May 2020 15:15:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200514062622.GA8564@lst.de>
References: <20200514062622.GA8564@lst.de> <20200513062649.2100053-22-hch@lst.de> <20200513062649.2100053-1-hch@lst.de> <3123898.1589375861@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
        target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        drbd-dev@lists.linbit.com, linux-cifs@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org,
        cluster-devel@redhat.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        linux-kernel@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 21/33] ipv4: add ip_sock_set_mtu_discover
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <128699.1589555724.1@warthog.procyon.org.uk>
Date:   Fri, 15 May 2020 16:15:24 +0100
Message-ID: <128700.1589555724@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> > > +		ip_sock_set_mtu_discover(conn->params.local->socket->sk,
> > > +				IP_PMTUDISC_DONT);
> > 
> > Um... The socket in question could be an AF_INET6 socket, not an AF_INET4
> > socket - I presume it will work in that case.  If so:
> 
> Yes, the implementation of that sockopt, including the inet_sock
> structure where these options are set is shared between ipv4 and ipv6.

Great!  Could you note that either in the patch description or in the
kerneldoc attached to the function?

Thanks,
David

