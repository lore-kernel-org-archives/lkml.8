Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AF3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1B02075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBOgzEkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgG2Jkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:40:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28449 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgG2Jka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596015629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k7LhEO6XCqGVUuc17BRfAuaIUsyKpv0HJUC9DTzz2Oc=;
        b=TBOgzEkJTgQo//lafpsD2+YcX7VTZCWYb3AUeLD+sK5OHWPc+APplrl8iDAH6XtH6Wyr+m
        AhiHk5H5i+Wddoj+I6qCr2loiVc6PJ+Cu7Sywitrm27vK5zGbhA6/V0izvFqw4VViwEx6g
        O/8wORLJ8g/o68NCkp6bowfY6djS3gI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-6zor32TQNzyl7ZA_qOIfbA-1; Wed, 29 Jul 2020 05:40:25 -0400
X-MC-Unique: 6zor32TQNzyl7ZA_qOIfbA-1
Received: by mail-wm1-f69.google.com with SMTP id p23so464422wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k7LhEO6XCqGVUuc17BRfAuaIUsyKpv0HJUC9DTzz2Oc=;
        b=A/CuDIaq3wKgeNmtLHr+SYWS6lz/mYQ/+FDR4sm0RDmjqZCi62XuwLXY0Jl0l0XU0H
         GMzQvCs1OKX+TitFzJJDjuAydLhBNvlL3WlBld6UI0BwFYDZIIIHNeXedJmDbIlPXrQ8
         wINS1j3QWXH9xrIWsQaGSQQW3xoHKFDfiGA8VzY2eOH6HFe+TqAw6tS7gbtXR0XHGZet
         oisl60dB3J2ChznmfgjVYme02QgU226nrz5LNb3+0+nW4KdtGP1wG3JPIrxsmkgXBZQe
         dsmKh4pqJX96osJL0JJj1Ooq3zZ81NoUQwx9YDfl6YNicIdCqAJ0miJmefzfTJsxUwYf
         L9WQ==
X-Gm-Message-State: AOAM532whJrPDr+WrxI7GB/IE5WOw1cJU3Yi8ZSB2ekY4oj7z2LR7Sej
        UbWanPxjTR+qO4Th8L2Jni3JWbcOpVGwR184X+tOCEhFowHX+g4LYh34z2VjTjPcounf6oKwIsY
        bwh/ET2TXIYgjBM5f3UzjIGSZ
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr28254563wre.369.1596015622990;
        Wed, 29 Jul 2020 02:40:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSgh6jDxOdFmcD7rlJpBZFVipNvyIVfH2WgoMjLbmLGCkqivl8DMGS+QOpLJ4wheZJRWE1WQ==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr28254546wre.369.1596015622705;
        Wed, 29 Jul 2020 02:40:22 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id x2sm534205wrg.73.2020.07.29.02.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 02:40:22 -0700 (PDT)
Date:   Wed, 29 Jul 2020 11:40:18 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, decui@microsoft.com, jhansen@vmware.com,
        kuba@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+a61bac2fcc1a7c6623fe@syzkaller.appspotmail.com,
        stefanha@redhat.com, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Subject: Re: general protection fault in vsock_poll
Message-ID: <20200729094018.x6rr2jlzh3ne4pgx@steredhat.lan>
References: <00000000000099052605aafb5923@google.com>
 <00000000000093b5dc05ab90c468@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000093b5dc05ab90c468@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 01:59:05AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 408624af4c89989117bb2c6517bd50b7708a2fcd
> Author: Stefano Garzarella <sgarzare@redhat.com>
> Date:   Tue Dec 10 10:43:06 2019 +0000
> 
>     vsock: use local transport when it is loaded
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e6489b100000
> start commit:   92ed3019 Linux 5.8-rc7
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1416489b100000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1016489b100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=84f076779e989e69
> dashboard link: https://syzkaller.appspot.com/bug?extid=a61bac2fcc1a7c6623fe
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15930b64900000
> 
> Reported-by: syzbot+a61bac2fcc1a7c6623fe@syzkaller.appspotmail.com
> Fixes: 408624af4c89 ("vsock: use local transport when it is loaded")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

I'll take a look.

At first glance it seems strange, because if sk_state is TCP_ESTABLISHED,
the transport shouldn't be NULL, that's why we didn't put the check.

Stefano

