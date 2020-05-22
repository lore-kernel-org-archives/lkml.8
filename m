Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8195EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D4C206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cziCdNEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbgEVX0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 19:26:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40846 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731183AbgEVX0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 19:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590190011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ML9m6yqp+0tcU4CPCOGDw0ZTVISsG/4OQXgXgDYzfc=;
        b=cziCdNEH1vdGdGBr+i1zy8xfdBdsqJa0WD59ngmLEf1oKsVJksO/YK8p9Ebkyr+nmsFxXs
        ksD//qgCsoLoG3ru6JILIymGgKHvMyeTTYYIXZOtgwzt87XgQ92TIvafzD3+Z541v8UVkH
        T4iYHZy4ZVs2xvQp8BTcyTGrbmf9Rx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-2zI9wFUpMQGsKtFIr0R05Q-1; Fri, 22 May 2020 19:26:49 -0400
X-MC-Unique: 2zI9wFUpMQGsKtFIr0R05Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D1AF107ACCA;
        Fri, 22 May 2020 23:26:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DE325D788;
        Fri, 22 May 2020 23:26:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200522.155418.406408375053374516.davem@davemloft.net>
References: <20200522.155418.406408375053374516.davem@davemloft.net> <159001690181.18663.663730118645460940.stgit@warthog.procyon.org.uk>
To:     David Miller <davem@davemloft.net>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] rxrpc: Fix retransmission timeout and ACK discard
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <997164.1590190006.1@warthog.procyon.org.uk>
Date:   Sat, 23 May 2020 00:26:46 +0100
Message-ID: <997165.1590190006@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:

> Pulled, thanks David.

Thanks.  I'll rebase my two extra patches I've just sent you a pull request
for when you've updated the branch.

David

