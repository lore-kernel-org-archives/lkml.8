Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DF5C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0EC222D9
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4wqmYsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBGHXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 02:23:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22011 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgBGHXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581060204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/1eHis89MpyLuxYDGM/uGf+wxAz3YIEtRor+3W21dw=;
        b=e4wqmYsumtzlwTfVQG8/2Fw3C8+moVh4IlE71pPekFSKimBLwTNBEvSezHxVDK+R/mNd+1
        3/epPSxW3rZzQHCA0jx9MXIBRhPMABpQr4Rj9o9d+E0jEo5/eWeRdg3L5fKHThUPRysraz
        u+d2c6UIVtr3d3FV2QNtgB2xZMsZp+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-w5vvEUNNNmCIBUUG-UCjJQ-1; Fri, 07 Feb 2020 02:23:16 -0500
X-MC-Unique: w5vvEUNNNmCIBUUG-UCjJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69644DB64;
        Fri,  7 Feb 2020 07:23:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-218.rdu2.redhat.com [10.10.120.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88CF78E9FE;
        Fri,  7 Feb 2020 07:23:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200207031553.18696-1-hdanton@sina.com>
References: <20200207031553.18696-1-hdanton@sina.com> <20200204084005.11320-1-hdanton@sina.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+3f1fd6b8cbf8702d134e@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuba@kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: inconsistent lock state in rxrpc_put_client_conn
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2394695.1581060192.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 07 Feb 2020 07:23:12 +0000
Message-ID: <2394696.1581060192@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've posted a patch for this:

https://lore.kernel.org/netdev/158099746025.2198892.1158535190228552910.st=
git@warthog.procyon.org.uk/

David

