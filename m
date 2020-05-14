Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D05C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F1C206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/UPlbre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgENMLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:11:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39801 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgENMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589458311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6HsKmtuLIrN+BReIkTLQX/WoJqVnv94Uy7kQRFgxEXw=;
        b=U/UPlbreN7AUN77cGfjWCNxpZz1w6WQpHxIt0Cz99Uxud7Bq92Eiaz4mbpNU/nrQacFtsq
        1NsA3jhbxu7hAY2XeuhzDuV1PSUX+wclL8EiqHc0Fa6h3Z/tc8R7MWRsLde0uRbb1yyBWh
        m1NDGD6I7ESZdalF+3eGCEthl0s5XHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-8AngqwwnMbuyX_GGfxMWrA-1; Thu, 14 May 2020 08:11:49 -0400
X-MC-Unique: 8AngqwwnMbuyX_GGfxMWrA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EA4395A5E;
        Thu, 14 May 2020 12:11:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAC765C1BE;
        Thu, 14 May 2020 12:11:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHmME9osYhwzFEyGUELqSSNexgK56NJrOrWTi3vnyDft8tv-hw@mail.gmail.com>
References: <CAHmME9osYhwzFEyGUELqSSNexgK56NJrOrWTi3vnyDft8tv-hw@mail.gmail.com> <20200514143055.1f71ba68@canb.auug.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the keys tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3672487.1589458306.1@warthog.procyon.org.uk>
Date:   Thu, 14 May 2020 13:11:46 +0100
Message-ID: <3672488.1589458306@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> Your touch might be helpful here. CRYPTO_LIB_CHACHA20POLY1305 is a
> tristate and depends on as well as selects other things that are
> tristates.
> 
> Meanwhile BIG_KEYS is a bool, which needs to select
> CRYPTO_LIB_CHACHA20POLY1305. However, it gets antsy if the the symbol
> its selecting has =m items in its hierarchy.
> 
> Any suggestions? The ideal thing to happen would be that the select of
> CRYPTO_LIB_CHACHA20POLY1305 in BIG_KEYS causes all of the descendants
> to become =y too.

I think that select is broken in its behaviour - it doesn't propagate the
selection enforcement up the tree.  You could try changing it to a depends on
or you could put in a select for every dependency.  I'm not sure there are any
other options - unless we turn big_key into a module and institute autoloading
of keytypes on demand.

David

