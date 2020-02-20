Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186DCC11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E118C2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emykKyOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgBTHwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:52:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22186 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726248AbgBTHwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582185130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKHnTXS8JHsJkGLe40P/26aUTaSDknlNIIOYz4XwZEQ=;
        b=emykKyOq8s2GuvmKqKSePF6p5H7+tzAtGsCojaiv3Eg7BAXKu74T0fIYBeHoFBfpKslj/w
        ofuZVxOAT1bgdytU4y0Vkpx4BVHwB6w0mXKYdif/EOVK1T+e3G8ZQMYTlIoxS+piziyr8c
        H426l5S7s76nR2w/6jgeVyHgoo3yDVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-WzSeYNV4P9u2xPZQedKB9Q-1; Thu, 20 Feb 2020 02:52:08 -0500
X-MC-Unique: WzSeYNV4P9u2xPZQedKB9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 510F313E4;
        Thu, 20 Feb 2020 07:52:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A0B7863A5;
        Thu, 20 Feb 2020 07:52:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whOAg2EJycA=x=8RzBy3dnDFsgnyxrjREyNu6-8+eTTHA@mail.gmail.com>
References: <CAHk-=whOAg2EJycA=x=8RzBy3dnDFsgnyxrjREyNu6-8+eTTHA@mail.gmail.com> <158215745745.386537.12978619503606431141.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] afs: Create a mountpoint through symlink() and remove through rmdir()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <426584.1582185125.1@warthog.procyon.org.uk>
Date:   Thu, 20 Feb 2020 07:52:05 +0000
Message-ID: <426585.1582185125@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Your argument that if the prefix is made really long it couldn't be a
> valid symlink at all on AFS is fair, but seems somewhat excessive.

Normally, mountpoint creation and removal would be hidden behind the
appropriate command line tool and not done directly with ln/rmdir.

> The only issue I see with this interface is that you can now create
> these kinds of things by untarring a tar-ball etc.

That would be true with mknod approach too.  Even if tar couldn't do the
second-stage write, it could still create a lot of half-formed mountpoints
by extracting chardevs.

David

