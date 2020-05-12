Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B74C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22D0205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIzrqbuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbgELXSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:18:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38885 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELXSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589325514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SB1ltR+AradzYbYjso1Rce1uKrAs+DdcyR7ihkqOZBY=;
        b=XIzrqbuWASxW6r0yh9N5G8Qea/7XrvYce3DtT2RJeySEgwv/r4RSJPZ04Va5Wf4WAsnrm1
        qXCEwCnLw9jyq2sQzS++kx3aF7jErjL6Ihd/B2AzeiqJhV8SQGNFf3IaNMJn3KV7+YtF0i
        uUULdVSuM6PRoZsjFgiKcZGhS9SQDcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-rDzyLe2PNruNFeShQa81qw-1; Tue, 12 May 2020 19:18:32 -0400
X-MC-Unique: rDzyLe2PNruNFeShQa81qw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AA3F107ACCD;
        Tue, 12 May 2020 23:18:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67B105D9DD;
        Tue, 12 May 2020 23:18:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200512195712.690f02bb@canb.auug.org.au>
References: <20200512195712.690f02bb@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: linux-next: build failure after merge of the fsinfo tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2959204.1589325509.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 13 May 2020 00:18:29 +0100
Message-ID: <2959205.1589325509@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> /usr/lib/gcc-cross/x86_64-linux-gnu/9/../../../../x86_64-linux-gnu/bin/l=
d: cannot find /usr/lib/x86_64-linux-gnu/libm-2.30.a
> /usr/lib/gcc-cross/x86_64-linux-gnu/9/../../../../x86_64-linux-gnu/bin/l=
d: cannot find /usr/lib/x86_64-linux-gnu/libmvec.a

I'll remove my use of the pow() function to calculate the timestamp
granularities and just print the raw mantissa and exponent.  That way I do=
n't
need -lm at all.

David

