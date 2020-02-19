Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D80CC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A2424654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDnf7BUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgBSOtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:49:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36578 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726528AbgBSOtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582123762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5kMJd4Vm/NTJPAhvw+A4EDbAcc3bG6Z85s7OwrvdR0Q=;
        b=BDnf7BUUK8405Uv8hRrK40IXSzY6wVapZDnlEIwRiMb9zYXAYoErdGCrzbtnae63UGTotO
        IXi4aBzRA3WWDPTCEqhiP6EpBMYlfh1qvzDp3+QbP5X+Rq+iBlqed8uPLYbCabCmKL69CZ
        kFbjV9YKjAcxTClpyMWQf1aIdParf10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-TPDQVUSyPDaqWe31b9AJ6g-1; Wed, 19 Feb 2020 09:49:17 -0500
X-MC-Unique: TPDQVUSyPDaqWe31b9AJ6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A7A48010CA;
        Wed, 19 Feb 2020 14:49:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 426845DA60;
        Wed, 19 Feb 2020 14:49:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <158212287007.224365.12141342648661839361.stgit@warthog.procyon.org.uk>
References: <158212287007.224365.12141342648661839361.stgit@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: syscalls: Add create_automount() and remove_automount()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <225656.1582123754.1@warthog.procyon.org.uk>
Date:   Wed, 19 Feb 2020 14:49:14 +0000
Message-ID: <225657.1582123754@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies - I forgot to enable all the cc's.  Will resend.

David

