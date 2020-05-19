Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7077DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482C1207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E62FzXGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgESQVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:21:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28415 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728775AbgESQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589905267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfUhnJsBjAnTzzL+sHH9DFgILRNGyHwzu1Q5lwdqFzE=;
        b=E62FzXGPFs9i4ohgkFvwxogTSyTuKy1kR7RIf+TGVsadmdW7gbpyEdyMrRXUx7Wtc6oEmC
        er4cBL1zqBnqILQZV7U92GRWLv1Xv/YJLzMMwQHJV3zN3GcAX4iDOihK6Cn7P5rQpCtDtH
        Wjfuyxn3F3MeDA+0qOrWvLJ62TrhbsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-6U2vJhNAMrG7agpJUzVKqQ-1; Tue, 19 May 2020 12:21:03 -0400
X-MC-Unique: 6U2vJhNAMrG7agpJUzVKqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 791DB18C35A7;
        Tue, 19 May 2020 16:20:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 666355C1BB;
        Tue, 19 May 2020 16:20:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200512181745.11866-1-anders.roxell@linaro.org>
References: <20200512181745.11866-1-anders.roxell@linaro.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     dhowells@redhat.com, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] scripts: fix deprecated always and hostprogs-y
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1514448.1589905253.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 19 May 2020 17:20:53 +0100
Message-ID: <1514449.1589905253@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Roxell <anders.roxell@linaro.org> wrote:

> When I did an allmodconfig build the following warning showed up:
> =

> scripts/Makefile.lib:8: 'always' is deprecated. Please use 'always-y' in=
stead
> scripts/Makefile.lib:12: 'hostprogs-y' and 'hostprogs-m' are deprecated.=
 Please use 'hostprogs' instead
> =

> Rework to use the new 'always-y' and 'hostprogs'.
> =

> Fixes: 631ec151fd96 ("Add sample notification program")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've folded this in, thanks.

David

