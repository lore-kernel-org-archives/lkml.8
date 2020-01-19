Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6254C33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 20:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC86206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 20:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgASUVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 15:21:02 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:53305 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgASUVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 15:21:01 -0500
Received: by mail-io1-f70.google.com with SMTP id m5so18729173iol.20
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 12:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tB8tVCfxWFIVfqWEsKuHgi0liSe9R1RZ+UBErAfoDaU=;
        b=ScT6c2jf9yF+funz9YdZWxpdpYMDPca/Fbtl+eUkXR693EbpsP6uFE3ETHpjN5y9d2
         WfykpmNvLq7dzdtVHayLzFCpy3G9eZEV0I0P3292jwoS6PmTYDuXwmltRsFMPjQCMfaf
         SF/WeggD9PywpdoDpY6YlH2fthxIwGVnlDUyj3u4MKmcB2WJfKMSFna5hqaq/sFDRTLE
         VO3N+pX+XSVFJO1rmBtXZQ+VrkplVYOKZH+4irwPDFqxO0FdCk3OgZz14TC2AElLTk/0
         5N5AieuOAeSs5j5XudkHiTNasNor802ErCcZ+5U0H4c6InV7d8nYy4tLH+ejVM8NLTYI
         3rxg==
X-Gm-Message-State: APjAAAXmW9fatsXTstsi/DNE0AhIGLmLLeHYrqo8kK/mEYij+DijSH5r
        HcuutedQDTvL7EIbx5U58Eqrs1T0yf8+FvkqyoaZlLUzFVWC
X-Google-Smtp-Source: APXvYqyBW0ANY5otx8x2mkJHYLCBShYafFG9L0jcSxJr3/w8Z3m4XgrA+Nba0kwQlcnkDJsAXjzzdqX7oGV/luxPfoRNInuKbPwk
MIME-Version: 1.0
X-Received: by 2002:a6b:b74a:: with SMTP id h71mr15932229iof.212.1579465260652;
 Sun, 19 Jan 2020 12:21:00 -0800 (PST)
Date:   Sun, 19 Jan 2020 12:21:00 -0800
In-Reply-To: <0000000000006d7b1e059c7db653@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbfd34059c83e917@google.com>
Subject: Re: KASAN: use-after-free Read in bitmap_ip_ext_cleanup
From:   syzbot <syzbot+b554d01b6c7870b17da2@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, florent.fourcot@wifirst.fr, fw@strlen.de,
        jeremy@azazel.net, johannes.berg@intel.com, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        nikolay@cumulusnetworks.com, pablo@netfilter.org,
        roopa@cumulusnetworks.com, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 3d26eb8ad1e9b906433903ce05f775cf038e747f
Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date:   Tue Jul 2 12:00:20 2019 +0000

    net: bridge: don't cache ether dest pointer on input

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bb1cc9e00000
start commit:   9aaa2949 Merge branch '1GbE' of git://git.kernel.org/pub/s..
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=147b1cc9e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=107b1cc9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66d8660c57ff3c98
dashboard link: https://syzkaller.appspot.com/bug?extid=b554d01b6c7870b17da2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15db12a5e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15316faee00000

Reported-by: syzbot+b554d01b6c7870b17da2@syzkaller.appspotmail.com
Fixes: 3d26eb8ad1e9 ("net: bridge: don't cache ether dest pointer on input")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
