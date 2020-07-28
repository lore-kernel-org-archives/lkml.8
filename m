Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5EEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F74204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCBXTL4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgG1K4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:56:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38642 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbgG1K4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595933806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zuhNoXt/vboskwHWTvcGm0FKZ53F2LaSY2sM0Z/PlfA=;
        b=jCBXTL4ovNGuAvaSzwjbs818RXfgk2GE4Lffnx38aEao2JELSKl0kDETkf461kCAJDREOM
        Gf1yDq0kU5Or3QIEaKBWstreU/aNRkUw5bLseVrD+I2GLdX1bhFO1hY3mYVNh5sKYmHNpD
        +ty4Z0ZnVIRkbm3FmGKQyFOy8+PSfmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-_v5Sa43JM3GH7Wyhhlu4Zw-1; Tue, 28 Jul 2020 06:56:45 -0400
X-MC-Unique: _v5Sa43JM3GH7Wyhhlu4Zw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CEB7800472;
        Tue, 28 Jul 2020 10:56:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDD641001B2C;
        Tue, 28 Jul 2020 10:56:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200721195132.GJ10769@hirez.programming.kicks-ass.net>
References: <20200721195132.GJ10769@hirez.programming.kicks-ass.net> <202006142054.C00B3E9C9@keescook> <20200612183450.4189588-1-keescook@chromium.org> <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com> <544539.1595328664@warthog.procyon.org.uk> <202007211144.A68C31D@keescook>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dhowells@redhat.com, Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3211865.1595933798.1@warthog.procyon.org.uk>
Date:   Tue, 28 Jul 2020 11:56:38 +0100
Message-ID: <3211866.1595933798@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:

> > Please do not _undo_ the changes; just add the API you need.
> 
> add_return and sub_return are horrible interface for refcount, which is
> the problem.
> 
> If you meant: refcount_dec(), but want the old value for tracing, you
> want a different ordering than if you wanted to do
> refcount_dec_and_test(); dec_return can't know this.
> 
> David, would something like a __refcount_*() API work where there is a
> 3rd argument (int *), which, if !NULL, will be assigned the old value?

That would be fine, though the number needs to be something I can interpret
easily when looking through the traces.  It would also be okay if there was an
interpretation function that I could use in the trace point when setting the
variable.

Say:

	void rxrpc_get_call(struct rxrpc_call *call, enum rxrpc_call_trace op)
	{
		const void *here = __builtin_return_address(0);
		unsigned int n;

		refcount_inc_return(&call->usage, &n);

		trace_rxrpc_call(call->debug_id, op, n, here, NULL);
	}

then:

	TRACE_EVENT(rxrpc_call,
		    TP_PROTO(..., int usage, ...),

		    TP_ARGS(...),

		    TP_STRUCT__entry(
			    ...
			    __field(int, usage)
			    ...
				     ),

		    TP_fast_assign(
			    ...
			    __entry->usage = refcount_interpret(usage);
			    ...
				   ),

		    TP_printk("... u=%d ...",
			      ...
			      __entry->usage,
			      ...)
		    );

so that it looks like the refcount is 'complete' at 0.

David

