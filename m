Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DE8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA35206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTQTy1Hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgEOQxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:53:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48662 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726023AbgEOQxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589561610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gN8Ffkm75Z04j5uijHXbjpI4CgfRAT5o0xWHEAmKzV4=;
        b=LTQTy1Hp92ZH/93lZOVcssDrHZur8fZalYvnHhDcQOHRx/xRm5nkVWzhpZw7UQ7ecHssr5
        ZCX5icXjuIUkCjslivb93FcD3ED4yvjemZ7/hfuvxk+5HDYmz5yWDwL5stWTkDQERkN0Hu
        HBd3E+kv2gkUBSQ3zbHG6qdDS0cw1TI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-cSjPPTozMs-pT9w2NnPfzw-1; Fri, 15 May 2020 12:53:28 -0400
X-MC-Unique: cSjPPTozMs-pT9w2NnPfzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DF4819200C0;
        Fri, 15 May 2020 16:53:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8977F5D9C9;
        Fri, 15 May 2020 16:53:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <954ef5ce2e47472f8b41300bf59209c5@garmin.com>
References: <954ef5ce2e47472f8b41300bf59209c5@garmin.com> <20200515152321.9280-1-nate.karstens@garmin.com> <20200515160342.GE23230@ZenIV.linux.org.uk>
To:     "Karstens, Nate" <Nate.Karstens@garmin.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Eric Dumazet" <edumazet@google.com>,
        David Laight <David.Laight@aculab.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Changli Gao <xiaosuo@gmail.com>
Subject: Re: [PATCH v2] Implement close-on-fork
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <197933.1589561600.1@warthog.procyon.org.uk>
Date:   Fri, 15 May 2020 17:53:20 +0100
Message-ID: <197934.1589561600@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Karstens, Nate <Nate.Karstens@garmin.com> wrote:

> > already has a portable solution
> 
> What is the solution?

sys_spawn(const char *path, const char **argv, const char **envv,
	  unsigned long clone_flags, unsigned int nfds, int *fds);

maybe?

David

