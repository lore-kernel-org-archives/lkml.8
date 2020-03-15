Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF85C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7DE206B1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4Nfempo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgCOOtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 10:49:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24087 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727034AbgCOOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584283771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPTZzaWSHWqaJnlfbIy3YcXZPQowucS73dRcL1UcEWw=;
        b=K4NfempoFHdnk+H3PReQ3go9bduRPEA7vEixwEkEnsbeqprY2aiKC+z19ZLNuyOhP0rPKy
        T0PKsACFoD2ROt7jbWtTNqowA3V8Y7uWZwZRbIAowUYJRF3Q/A4GXbYeIttiOYERdZup3K
        EsDk7pPz/G3P0bVzBcFoTcx4MJOvlEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-zedcxP_9NOyM7-3GxM1zkw-1; Sun, 15 Mar 2020 10:49:26 -0400
X-MC-Unique: zedcxP_9NOyM7-3GxM1zkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3228189D6C0;
        Sun, 15 Mar 2020 14:49:23 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AB1491D92;
        Sun, 15 Mar 2020 14:49:21 +0000 (UTC)
Date:   Sun, 15 Mar 2020 09:49:19 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     syzbot <syzbot+2a3c14db0e17fe4c7409@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org, peterz@infradead.org,
        shile.zhang@linux.alibaba.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: BUG: stack guard page was hit in deref_stack_reg
Message-ID: <20200315144919.y6r5sarg5m4s6wpw@treble>
References: <000000000000f5a6bf05a0ce0a95@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000f5a6bf05a0ce0a95@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 03:28:11AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    34a568a2 net: sgi: ioc3-eth: Remove phy workaround
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=103e69fde00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=598678fc6e800071
> dashboard link: https://syzkaller.appspot.com/bug?extid=2a3c14db0e17fe4c7409
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2a3c14db0e17fe4c7409@syzkaller.appspotmail.com

This is a stack overflow caused by a recursive loop in the networking
code.  This chain repeats until it runs out of stack:

>  bond_compute_features.isra.0+0x521/0xa40 drivers/net/bonding/bond_main.c:1188
>  bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
>  bond_netdev_event+0x6ee/0x930 drivers/net/bonding/bond_main.c:3277
>  notifier_call_chain+0xc0/0x230 kernel/notifier.c:83
>  call_netdevice_notifiers_info net/core/dev.c:1948 [inline]
>  call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1933
>  call_netdevice_notifiers_extack net/core/dev.c:1960 [inline]
>  call_netdevice_notifiers net/core/dev.c:1974 [inline]
>  netdev_features_change net/core/dev.c:1364 [inline]
>  netdev_update_features net/core/dev.c:9082 [inline]
>  netdev_update_features+0xc4/0xd0 net/core/dev.c:9079
>  netdev_sync_lower_features net/core/dev.c:8891 [inline]
>  __netdev_update_features+0x821/0x12f0 net/core/dev.c:9026
>  netdev_change_features+0x61/0xb0 net/core/dev.c:9098
>  bond_compute_features.isra.0+0x521/0xa40 drivers/net/bonding/bond_main.c:1188

-- 
Josh

