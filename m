Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AB1C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9858C206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuXyyx+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441541AbgDPKRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:17:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28757 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441262AbgDPKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587032125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=duQdUsOOdHGiX8X+SSFFtnhQDtBYHM0gSY3ojiBRAto=;
        b=TuXyyx+ekI/WaMjlYcHQVVMCe/hcxDlB5MqMHB1GdZnCjLdDwvHuYuQgn4Vp2lu1w24MhZ
        cA+6SNtQagk0KFYIjrwFr6CcEm/ntuq5KWO4WktgNPupSWlJut92trUyILxUmckGF8Msi7
        hTsODdreetkUkMOPCbdq8a2vhZVlZmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-lvRNdSpjMxOevcxPakXQlg-1; Thu, 16 Apr 2020 06:15:23 -0400
X-MC-Unique: lvRNdSpjMxOevcxPakXQlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A21218C8C02;
        Thu, 16 Apr 2020 10:15:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7175E5C1D6;
        Thu, 16 Apr 2020 10:15:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5mvj7GF3i8AE6E=+5f_Vigtb3uw=665F2uuBOgGzUhHObQ@mail.gmail.com>
References: <CAH2r5mvj7GF3i8AE6E=+5f_Vigtb3uw=665F2uuBOgGzUhHObQ@mail.gmail.com> <3865908.1586874010@warthog.procyon.org.uk> <e751977dac616d93806d98f4ad3ce144bb1eb244.camel@kernel.org>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, keyrings@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, fweimer@redhat.com
Subject: Re: What's a good default TTL for DNS keys in the kernel
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <127742.1587032119.1@warthog.procyon.org.uk>
Date:   Thu, 16 Apr 2020 11:15:19 +0100
Message-ID: <127743.1587032119@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfrench@gmail.com> wrote:

> > 10 mins sounds like a reasonable default to me.
> 
> I would lean toward slightly longer (20 minutes?) but aren't there
> usually different timeouts for 'static' vs. 'dynamic' DNS records (so
> static records would have longer timeouts)?

Unfortunately, getaddrinfo() doesn't give me that information.

David

