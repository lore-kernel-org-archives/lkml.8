Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF2C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3939B214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTO7/8tD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgBFNJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:09:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31685 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727325AbgBFNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580994586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZgKjq5f4oMoXVI4WqrUXov10JILu8ei/f35tvvz5Kbg=;
        b=FTO7/8tDOr6uQuCyWV1BMHo8ZKq3n535OaqJJ/MNeU5au9P1DrZLmyPmjERN7YRpCBNO4i
        lwzUvGwbXKOh5Y98Lt9nZqlQAGZJNrbE6G2YfDjBxWaR+xFwgHGZOcj0vhS3Bqp9stXRaH
        fl+Cw8XT8EY27Mem6+BAPue83HrXMJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-qH7P_AwpP2eTBjAnESgrMQ-1; Thu, 06 Feb 2020 08:09:41 -0500
X-MC-Unique: qH7P_AwpP2eTBjAnESgrMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0E51104D419;
        Thu,  6 Feb 2020 13:09:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-218.rdu2.redhat.com [10.10.120.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B996E90536;
        Thu,  6 Feb 2020 13:09:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200204084005.11320-1-hdanton@sina.com>
References: <20200204084005.11320-1-hdanton@sina.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+3f1fd6b8cbf8702d134e@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuba@kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: inconsistent lock state in rxrpc_put_client_conn
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2183051.1580994576.1@warthog.procyon.org.uk>
Date:   Thu, 06 Feb 2020 13:09:36 +0000
Message-ID: <2183052.1580994576@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hillf Danton <hdanton@sina.com> wrote:

> Take lock with irq quiesced.

I think that's overkill.  It only needs _bh annotations, not _irqsave/restore
- but even that is probably not the best way.

The best way is to offload the stuff done by rxrpc_rcu_destroy_call() to a
workqueue if called in softirq mode.  I'm not sure whether rcu callbacks are
done in softirq mode - if they are, then it can just call rxrpc_queue_work().

David

