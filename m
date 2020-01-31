Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F3AC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB2B22522
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bX5/8f/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgAaRuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:50:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43864 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726969AbgAaRuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580493000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V3SBkZ4i5QlwjrNLSuKkhNiYeBGoDcITcsKQCtUjA6A=;
        b=bX5/8f/OCXeY3rqyA7m7VH0hedTEKfSQjQxS3YmkWPgrQYslqXzo1QLw5Wq7qoZ6c+yCmv
        Ycyo88+TcLxHmiqox1aOk6pWzCfGJcNjSiW4SY+i4nDICkVtK4lZExxHHiwtfr6QoWXtMP
        rv74qQR6M/ctqLzey3Dp22TTHvOCbck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-U-Jyth6VO06hI2fdG66p-A-1; Fri, 31 Jan 2020 12:49:56 -0500
X-MC-Unique: U-Jyth6VO06hI2fdG66p-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4A0D107ACC5;
        Fri, 31 Jan 2020 17:49:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-218.rdu2.redhat.com [10.10.120.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC0A97FB60;
        Fri, 31 Jan 2020 17:49:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
References: <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com> <20200128072740.21272-1-frextrite@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Amol Grover <frextrite@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] cred: Use RCU primitives to access RCU pointers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <267884.1580492989.1@warthog.procyon.org.uk>
Date:   Fri, 31 Jan 2020 17:49:49 +0000
Message-ID: <267885.1580492989@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> > task_struct.cred and task_struct.real_cred are annotated by __rcu,
> 
> task_struct.cred doesn't actually have RCU semantics though, see
> commit d7852fbd0f0423937fa287a598bfde188bb68c22. For task_struct.cred,
> it would probably be more correct to remove the __rcu annotation?

You're right, I think, there shouldn't be any need for __rcu on
task_struct::cred since it shouldn't be accessed on any task except current.

I've a feeling that there was something at the time, proc perhaps, but I don't
remember.

David

