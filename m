Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB903C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948F022256
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc0CYvtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgFSWDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:03:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32170 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728242AbgFSWDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592604216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I79nPb0pXt8/3dgBW2qv/EZDlPMjoeNKQYFohhTmzfU=;
        b=Sc0CYvtIywyAA/oFLio0uzNsWSyDyMGyz1ArIv00vUWu2Geb03yELFXi9UHqv9u+bGuBPv
        NKjv0lnEDqJltQZMi4vpu/Nq9SwIlyWs361WNcE6E/0XcXXXgwADgyrkhuQB3ZobwHIq7S
        EW1TEUEEZCC3D44ulxpsiBL6/d56Yoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-t7DfemX0PkK-nE9rgO2Rog-1; Fri, 19 Jun 2020 18:03:32 -0400
X-MC-Unique: t7DfemX0PkK-nE9rgO2Rog-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9853E8015CE;
        Fri, 19 Jun 2020 22:03:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A4CC5C1D0;
        Fri, 19 Jun 2020 22:03:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <00000000000096141f05a845c246@google.com>
References: <00000000000096141f05a845c246@google.com>
To:     syzbot <syzbot+5e590d73a9d01be6b1a1@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, davem@davemloft.net, kuba@kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: net test error: KASAN: use-after-free Write in afs_wake_up_async_call
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2213144.1592604208.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 19 Jun 2020 23:03:28 +0100
Message-ID: <2213145.1592604208@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: net-next test error: KASAN: use-after-free Write in afs_wake_up_=
async_call

