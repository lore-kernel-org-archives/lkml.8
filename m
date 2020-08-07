Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D695C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDBD2075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxAbeI0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgHGQ1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:27:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44096 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725900AbgHGQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596817660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pv6qNlWxgjgBBXp8H46A8UMNxHtp1mGMJlZDBfM4nf4=;
        b=AxAbeI0e5l50ikwSSQEROxsXg9N8/5WF4cFg9bU+0fWyO1HPXpwP8dLMf8IhE99lq4FQ5n
        BtF+/XI6BChf2OfkQV0V3dZNf/nLnOvB7VDOfpptZ9Rx1JdJ6V+YRiWnbI6jAR2Zcuvu8I
        insfSsfe/NR2mqofTwcOP9T3XZrwTKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-tNMRgF-cObOzMwR-mWlVqg-1; Fri, 07 Aug 2020 12:27:38 -0400
X-MC-Unique: tNMRgF-cObOzMwR-mWlVqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E4E5801E6A;
        Fri,  7 Aug 2020 16:27:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-69.rdu2.redhat.com [10.10.113.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62AD5610F3;
        Fri,  7 Aug 2020 16:27:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <a2fe568438aa45e9a63a3a7d9d64a73f@bfs.de>
References: <a2fe568438aa45e9a63a3a7d9d64a73f@bfs.de> <159680892602.29015.6551860260436544999.stgit@warthog.procyon.org.uk>,<159680897140.29015.15318866561972877762.stgit@warthog.procyon.org.uk>
To:     Walter Harms <wharms@bfs.de>
Cc:     dhowells@redhat.com,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AW: [PATCH 5/5] Add manpage for fsconfig(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45106.1596817654.1@warthog.procyon.org.uk>
Date:   Fri, 07 Aug 2020 17:27:34 +0100
Message-ID: <45107.1596817654@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Walter Harms <wharms@bfs.de> wrote:

> maybe it is obvious but i did not see it ..
> starting with what kernel version are these features available ?

See:

	+.SH VERSIONS
	+.BR fsconfig ()
	+was added to Linux in kernel 5.1.

David

