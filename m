Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC69C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9E020848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7pex4m2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCFOnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:43:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53539 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727059AbgCFOnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583505830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8zS24+hgqMgXxDrHvOtYHhXkklLLaRqFr5tO/jCmpNA=;
        b=f7pex4m23pX9SXeAIMYxJqUtzt0hOyrTqVyt3Sg1ylHmihMo1UF06SggmlYygU5il6QXCL
        Ie7RGwKXo623KiHMhQJrlc1ikkBiaSUGZujDgnkEDdaYBNISZRyxU8vGAPWC6LRgObusAY
        ockmAtbSxeIa2xNmwKlqbyhU/07uA+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-13YqOVG-N-K2QjmFm0H8jA-1; Fri, 06 Mar 2020 09:43:46 -0500
X-MC-Unique: 13YqOVG-N-K2QjmFm0H8jA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE4DF18AB2C2;
        Fri,  6 Mar 2020 14:43:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F15475D9CD;
        Fri,  6 Mar 2020 14:43:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200306135632.j7kidnqm3edji6cz@wittgenstein>
References: <20200306135632.j7kidnqm3edji6cz@wittgenstein> <3774367.1583430213@warthog.procyon.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dhowells@redhat.com, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        metze@samba.org, cyphar@cyphar.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Mark AT_* path flags as deprecated and add missing RESOLVE_ flags
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4040641.1583505822.1@warthog.procyon.org.uk>
Date:   Fri, 06 Mar 2020 14:43:42 +0000
Message-ID: <4040642.1583505822@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> wrote:

> > +	if (flags & O_NOFOLLOW)
> > +		lookup_flags &= ~LOOKUP_FOLLOW;
> 
> Odd change. But I guess you're doing it for the sake of consistency
> because of how you treat NO_TERMINAL_SYMLINKS below.

Not really.  The default is to follow.  Both remove the LOOKUP_FOLLOW flag and
neither set it.

David

