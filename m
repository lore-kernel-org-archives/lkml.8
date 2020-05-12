Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5EAC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C48020731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDMoZgIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgELX0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:26:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22771 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELX0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589325980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nf5ipnL8n4hf1p58tjMDHcZBfdQ1O05mmKF1dowfL7w=;
        b=RDMoZgIHn0IHFbGf5CMWPHIdPRK6TMxVxhhBw2Im92xqy9hSIjzM761IDN9mYVUHxA6N6J
        4nB3L0ISA+ZxMUxAEOooHizNfDMV1Jy69WC2Qy2wDK5VUb4Qc8v/3xEST5ryj6zW+XIUPy
        mOU7najTZcrJterBC8A3APQJaoB75T8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-AdvI7pp6PsSxAQTwcjoQnQ-1; Tue, 12 May 2020 19:26:16 -0400
X-MC-Unique: AdvI7pp6PsSxAQTwcjoQnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18E331841920;
        Tue, 12 May 2020 23:26:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17C987529C;
        Tue, 12 May 2020 23:26:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAK7LNAQ-=A0nDZK0FTzgJ6oJ-VbV33F1rVjvBAWgybSsUXaPVA@mail.gmail.com>
References: <CAK7LNAQ-=A0nDZK0FTzgJ6oJ-VbV33F1rVjvBAWgybSsUXaPVA@mail.gmail.com> <20200512195712.690f02bb@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the fsinfo tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2960968.1589325972.1@warthog.procyon.org.uk>
Date:   Wed, 13 May 2020 00:26:12 +0100
Message-ID: <2960969.1589325972@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> wrote:

> BTW, why is '-static' needed here?

Sorry, that was a leftover.  I've been building it on one version of Fedora
and running it on my test machine - which is a couple of versions behind.  I
really need to do an update.  Anyway, I've removed it and -lm.

David

