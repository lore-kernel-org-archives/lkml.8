Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12E5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D52C214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azEWFPlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgA1PAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:00:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25951 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726712AbgA1PAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580223622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JC/v0R+n19poVshHaFB2ikrnZeGzcPgJ7gdAXwWxsCA=;
        b=azEWFPlVR0TJB7UsQJ83sYRnenvVydFJ8EKaB/mh5Q9BT3VFCK/NH1cW8Ii+WQtgW6tyiW
        7mitqXt6f7PBl5lirzw7iPd2TbL512P8LFYolAmh0BBhzPUVU9VMPBNKc4/HaUXzDWqomO
        rj8SS8a0eVXItK2Bf6dRHeTocP0tQ9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Ezdjjf2gPp-tKiDpGIq6Jg-1; Tue, 28 Jan 2020 10:00:17 -0500
X-MC-Unique: Ezdjjf2gPp-tKiDpGIq6Jg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9524513F5;
        Tue, 28 Jan 2020 15:00:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-70.rdu2.redhat.com [10.10.121.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D56015DA7E;
        Tue, 28 Jan 2020 15:00:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200128072740.21272-1-frextrite@gmail.com>
References: <20200128072740.21272-1-frextrite@gmail.com>
To:     Amol Grover <frextrite@gmail.com>
Cc:     dhowells@redhat.com, Shakeel Butt <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] cred: Use RCU primitives to access RCU pointers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2176479.1580223610.1@warthog.procyon.org.uk>
Date:   Tue, 28 Jan 2020 15:00:10 +0000
Message-ID: <2176480.1580223610@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amol Grover <frextrite@gmail.com> wrote:

> task_struct.cred and task_struct.real_cred are annotated by __rcu,
> hence use rcu_access_pointer to access them.
> 
> Fixes the following sparse errors:
> kernel/cred.c:144:9: error: incompatible types in comparison expression
> (different address spaces):
> kernel/cred.c:144:9:    struct cred *
> kernel/cred.c:144:9:    struct cred const [noderef] <asn:4> *
> kernel/cred.c:145:9: error: incompatible types in comparison expression
> (different address spaces):
> kernel/cred.c:145:9:    struct cred *
> kernel/cred.c:145:9:    struct cred const [noderef] <asn:4> *
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Reviewed-by: David Howells <dhowells@redhat.com>

