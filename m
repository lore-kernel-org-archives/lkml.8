Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D875C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEB32077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgAPKtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 05:49:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:41717 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgAPKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:49:02 -0500
Received: by mail-il1-f200.google.com with SMTP id k9so15591596ili.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 02:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vXf7A0NOmOYnzFvw+i/lGTeJq016329/QakV55aUcG0=;
        b=eNTZxIfiYzKDu0LbWdmrlXVZ7lLDkcxk5FZlhB4R9ZE7CCncJ5cq5gjjScSDWJMJW7
         6twUHcOKsQvQ6sBxslr5VpEb72v3TU9RB6p4CQJj/tpYgr3hX31Owd0IbyRN1jyMGi6q
         xu0vkWymETTWX0IM/2d5luKWAmTIsy5npm06OBFcpSriqLkF2NDwO+QUZ2731GHiZiRb
         hFWHLCShfUIpp4BlCWvtayUBPFzlhTjOHoTFQ4N1fe4ZoVGE6a8bW3YWFwboYiz7yI/8
         Y7Byhng8EFD0Rxk1Rq7Apsj9Rev/Q+c7t39zD9EbPnJAM53wPL5jOKNSKgKewAGpT0nT
         D5mQ==
X-Gm-Message-State: APjAAAWRpGMs6t/pmGSTVefMdWciw9faz6POEcALrIuMhj+8Ya9hEKCe
        Yg8mcGcOaVH4sd1RwMDmRlhSOaMDzO7TklkwLtibdl1LaEta
X-Google-Smtp-Source: APXvYqxopJ/jpk1yIg/I62PmVhs8FXVnSYmF1TfUZ9VNvmnmuoElsGzQesNp8GprKQ9VNUmhiQEqsoJLXz2GyBosz3vGAuYabDoY
MIME-Version: 1.0
X-Received: by 2002:a92:3cd4:: with SMTP id j81mr3015923ilf.77.1579171741688;
 Thu, 16 Jan 2020 02:49:01 -0800 (PST)
Date:   Thu, 16 Jan 2020 02:49:01 -0800
In-Reply-To: <000000000000b9fc96059c36db9e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3ea0f059c3f9203@google.com>
Subject: Re: WARNING in nft_request_module
From:   syzbot <syzbot+0e63ae76d117ae1c3a01@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@blackhole.kfki.hu, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 452238e8d5ffd8b77f92387519513839d4ca7379
Author: Florian Westphal <fw@strlen.de>
Date:   Wed Jul 11 11:45:10 2018 +0000

     netfilter: nf_tables: add and use helper for module autoload

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bb83e1e00000
start commit:   51d69817 Merge tag 'platform-drivers-x86-v5.5-3' of git://..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=147b83e1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=107b83e1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=0e63ae76d117ae1c3a01
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b14421e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138473fee00000

Reported-by: syzbot+0e63ae76d117ae1c3a01@syzkaller.appspotmail.com
Fixes: 452238e8d5ff ("netfilter: nf_tables: add and use helper for module  
autoload")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
