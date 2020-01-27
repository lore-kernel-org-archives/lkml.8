Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38882C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0212220720
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HffzNcJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgA0OPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:15:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44661 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726635AbgA0OPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580134553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WkvSDwSG0ICKN8SDTNhYC6T7ULaT30MIRmlQvVlNa1E=;
        b=HffzNcJMQsGnwsxoyygWOlCkFdmvFyDK4Tz8yifPXMDoG6I5g6EWN1VjI1q6e3PT/sfXdw
        lOFP4m0fVfOpwPcS0Q+X/moLbClUIgrDpwBoiFXK3R7oY6Pq/cB8eI0Y9QLIuO96iklnC6
        IStRmjUkuld9CuCXriO2zIJVhDoqoEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-1HtWR7f9OcG0lI5gn1Q0Dg-1; Mon, 27 Jan 2020 09:15:49 -0500
X-MC-Unique: 1HtWR7f9OcG0lI5gn1Q0Dg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70682107ACC7;
        Mon, 27 Jan 2020 14:15:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-99.rdu2.redhat.com [10.10.120.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8062149AF;
        Mon, 27 Jan 2020 14:15:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000f349be059bcd827a@google.com>
References: <000000000000f349be059bcd827a@google.com>
To:     syzbot <syzbot+016c7186c1d55575bab8@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in __xlate_proc_name (2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1465947.1580134546.1@warthog.procyon.org.uk>
Date:   Mon, 27 Jan 2020 14:15:46 +0000
Message-ID: <1465948.1580134546@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: WARNING in __proc_create (2)

