Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA22FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53252467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/PmImm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgAVKK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:10:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43985 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726204AbgAVKK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579687857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G3sIdSKUAznoVtH5H8r0191KUIId3ChkMxDztaPw080=;
        b=X/PmImm7U67yU5yyRd08R/DPnGwbAQKvR/Vwlf6/kgpBAgLcOPM5+4zF5ynWG/nov1EO/x
        ZEerAMJpTwrcggX8RRHO99WQXnvtVDxkBmUsIl7tlcO1PaPegKpaYfcaiEeIhmU+H6+2MV
        Vi4V39+KL/oNT6NRdGaLxSkmYTJb5Yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-hJH0JR9HN8K3BNnAEmjjDQ-1; Wed, 22 Jan 2020 05:10:54 -0500
X-MC-Unique: hJH0JR9HN8K3BNnAEmjjDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B43A9107ACC4;
        Wed, 22 Jan 2020 10:10:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 784018121A;
        Wed, 22 Jan 2020 10:10:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200122081340.2bhx5jfezl55b3qb@kili.mountain>
References: <20200122081340.2bhx5jfezl55b3qb@kili.mountain> <000000000000da7a79059caf2656@google.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+b904ba7c947a37b4b291@syzkaller.appspotmail.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in __proc_create (2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3397878.1579687850.1@warthog.procyon.org.uk>
Date:   Wed, 22 Jan 2020 10:10:50 +0000
Message-ID: <3397879.1579687850@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> We should probably ban '/' characters from the cell name in
> afs_alloc_cell().

And non-printable chars too.

David

