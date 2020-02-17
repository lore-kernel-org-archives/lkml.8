Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA8AC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7D820718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgBQGJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:09:02 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:38672 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBQGJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:09:02 -0500
Received: by mail-io1-f72.google.com with SMTP id x2so11190880iog.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 22:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KjyO2CoXoWwnkM0ow4J41Qq6MSIdJgEthJmvcyKAp34=;
        b=XtwzvhBnBzLOnikik2Epa6GbfDPR3AYPfXqmwoJNrQF4X4h0/oZ3QiDxdTwaC+u2vg
         2ArCstfNb1eYao41e0l4p35IKs2B7V77T4tWWCw0VmYTvYAR7yZjQlGWv7TotRRGtp8u
         yr2zNipk/0jttWqQVyahVxSugqfxegg4DTZbSPb2VMQz7kEbdgZWxshN34RbTLg1zYlj
         TzONwrr097nLMN3SZ6KPx2RPeftUc/tw6VF3I02mfVQnUpYJMs1jb6+ey72FFPEPpzYB
         Jky+eOimSYgLhB60iRJ8r+PJVDdylDHdN0t7QyehMG81m/IHzYRAlK0mPndCrp8ZmAi1
         qgxA==
X-Gm-Message-State: APjAAAV5bn6DjFH5mQWqG/nzsH2GMfCEIThP7vPDA4ucTpf1ZIN29W3n
        vNt4sNg2FpKlnbfYQpjRDo4EEsUlN197DIA9NScgWTsadRQx
X-Google-Smtp-Source: APXvYqw9e8S7Ik9ZMV2fme+AyYp2vlgWW5jiJuRFAympxlHFz2ZX4EV7M5BWi5Cs3LF+f9da1xKs8iUCxvXKigJf/lEaxfjPT2fk
MIME-Version: 1.0
X-Received: by 2002:a92:5b11:: with SMTP id p17mr13306532ilb.202.1581919741345;
 Sun, 16 Feb 2020 22:09:01 -0800 (PST)
Date:   Sun, 16 Feb 2020 22:09:01 -0800
In-Reply-To: <00000000000014b040059c654481@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f07f8059ebf6465@google.com>
Subject: Re: WARNING in nf_tables_table_destroy
From:   syzbot <syzbot+2a3b1b28cad90c608e20@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit eb014de4fd418de1a277913cba244e47274fe392
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Tue Jan 21 15:48:03 2020 +0000

    netfilter: nf_tables: autoload modules from the abort path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e9cc7ee00000
start commit:   5a9ef194 net: systemport: Fixed queue mapping in internal ..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e89bd00623fe71e
dashboard link: https://syzkaller.appspot.com/bug?extid=2a3b1b28cad90c608e20
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15338966e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1667d8d6e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: nf_tables: autoload modules from the abort path

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
