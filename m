Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA97BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7FC2225B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9tbFhBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgFSWEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:04:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43729 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728854AbgFSWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592604272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zE25PztAeYspSZdKFWX6ttU7TX+nk2oGIiHynCDXJVA=;
        b=c9tbFhBla7yqHK+Iee8j/wFuseM71ckc1Whbg2I6fMPzk7Y2xpx5d4lwsD3DMDp9rPsK9P
        qaC1kgvb0D7Wzfe7L+OSI/wJBMa9jT2hKZdTsQhacpggg5bmG0XLGE3JrZnLGsppAlGKsM
        Xt/vbl+UKgFO9kUhyzYnUNcU90iT3kI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-fRbPtyloNCaZ-wjkOgiVgQ-1; Fri, 19 Jun 2020 18:04:28 -0400
X-MC-Unique: fRbPtyloNCaZ-wjkOgiVgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91E7B18585A4;
        Fri, 19 Jun 2020 22:04:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B1BC1002382;
        Fri, 19 Jun 2020 22:04:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <00000000000042f7b405a86969e4@google.com>
References: <00000000000042f7b405a86969e4@google.com>
To:     syzbot <syzbot+0710b20f5412c027fefb@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: bpf test error: KASAN: use-after-free Write in afs_wake_up_async_call
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2213247.1592604265.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 19 Jun 2020 23:04:25 +0100
Message-ID: <2213248.1592604265@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#sys dup: net-next test error: KASAN: use-after-free Write in afs_wake_up_=
async_call

