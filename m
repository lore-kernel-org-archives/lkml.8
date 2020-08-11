Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA48C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055B4205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vek8bieF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgHKJzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:55:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53407 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728377AbgHKJzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597139721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ARUSqSkquuJlHefVM/we7tLn6Y34P6IHwTWPXDZ/fcc=;
        b=Vek8bieFTN0kMDtYi4Z5vUYw7J5+Xy7EVZao0lxF32Uluzd4YGMkiONY8w//WwRgHeqyWg
        VefF/0InmbkuVXIQtyYqB4Wqpnb7mh6IGrUlQOX9qcjyfESd4E+i2ZmEcHnQ9T9vjbyeGd
        4Km3ZC70iOU8BOiK4d8ArgXPDhFpeZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-QD2RIGNDOhCl7Iw_ou2VIg-1; Tue, 11 Aug 2020 05:55:19 -0400
X-MC-Unique: QD2RIGNDOhCl7Iw_ou2VIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BB4857;
        Tue, 11 Aug 2020 09:55:18 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-182.ams2.redhat.com [10.36.113.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04F3F5D9FC;
        Tue, 11 Aug 2020 09:55:05 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     davem@davemloft.net
Cc:     Jorgen Hansen <jhansen@vmware.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH net 0/2] vsock: fix null pointer dereference and cleanup in
 vsock_poll()
Date:   Tue, 11 Aug 2020 11:55:02 +0200
Message-Id: <20200811095504.25051-1-sgarzare@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch fixes a potential null pointer dereference in vsock_poll()
reported by syzbot.
The second patch is a simple cleanup in the same block code. I put this later,
to make it easier to backport the first patch in the stable branches.

Thanks,
Stefano

Stefano Garzarella (2):
  vsock: fix potential null pointer dereference in vsock_poll()
  vsock: small cleanup in vsock_poll()

 net/vmw_vsock/af_vsock.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

-- 
2.26.2

