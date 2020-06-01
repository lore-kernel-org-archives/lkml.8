Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302F3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE08C2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AralpmOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgFAVLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:11:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51217 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727983AbgFAVLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591045898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbRzhG2LzWApjj8c+cePRghjnkrYYRcNMFSCvsXUZ8I=;
        b=AralpmOjEWIyTB9navhbDg72jp4sNdjC6SWkDhw0Hr+ftL0cNIpz35lIEwWTrv2gZTzykQ
        ehojKqW8rNQS7v8Hvb/8ycTv5cnM1pcuUL+5FQA9BL73xzj+s4DvjEpA2olwlWbOSJQcCy
        CB5yxm4k7Ksdribn6y4Gtgxx6icPkKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-w1E6bmOQPuerdajZZdA_Yw-1; Mon, 01 Jun 2020 17:11:31 -0400
X-MC-Unique: w1E6bmOQPuerdajZZdA_Yw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE1D11883603;
        Mon,  1 Jun 2020 21:11:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C9D6D01EB;
        Mon,  1 Jun 2020 21:11:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <3cc663a5-088d-4d26-34cd-c96e362c1eb2@web.de>
References: <3cc663a5-088d-4d26-34cd-c96e362c1eb2@web.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: afs: Improve exception handling in afs_net_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1376358.1591045888.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 01 Jun 2020 22:11:28 +0100
Message-ID: <1376359.1591045888@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Elfring <Markus.Elfring@web.de> wrote:

> I have accidentally taken another look at the implementation of
> the function "afs_net_init".
> I noticed that the statement "net->live =3D false;" was specified three =
times
> for exception handling at the end.
> https://elixir.bootlin.com/linux/v5.7/source/fs/afs/main.c#L127
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
fs/afs/main.c?id=3D9bf9511e3d9f328c03f6f79bfb741c3d18f2f2c0#n127
> =

> Can it be that two of these assignments are redundant then?

Kind of yes, but no.

I want to set "net->live =3D false" as soon as an error occurs because the=
re are
various async mechanisms that check for it and abort their operation if th=
ey
see it, but there are multiple error labels.

So it needs to be cleared before afs_cell_purge() or afs_purge_servers() i=
s
called and it used to be required for something else as well, but that's n=
ow
gone.

In the afs_net_init() function, it now probably only needs to be cleared a=
fter
"error_open_socket:".  I'm a bit leary of removing the clearances in case =
I
add a new dependency on it later.

David

