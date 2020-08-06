Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B201C43459
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766E6221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgHFHI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 03:08:59 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:33352 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgHFHIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 03:08:13 -0400
Received: by mail-il1-f199.google.com with SMTP id m9so882957ili.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 00:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7dfgtw1iR3AjrQXBtDJPZWn65f38aLiV7OcURuGXSL4=;
        b=Cz/VWKnztuoexs+gbIUCe3DA8Vv4yMAGXqQzIA3C9Bsd69m3V/XxD8ghIrSUxmVpCQ
         ToNgC5NoNm0+F0lhIdjWOkyQpBL15lLUqoB8BWvcjODjBp7MDGN2sHuf12JZHrCBjRKe
         3Z1KDMToFVUGqe5YAIinbpA4HPkxtphBDX8+8sM9G0b3/pPwGMxGoREPaFSrE7mPLbzi
         DoeWPBY46nluCdzCLTqzn6BBh7qUKEEa1/+HlbkQDdwehpSUVNyA1LVqhmx1sQxiE0K7
         3XqMi1cL8fsf33kzIvcnR7Q04Y2U+/vUprZWxm2ZON6sDEZwU8LrUtzcVfiVd9pNUkR5
         cEsQ==
X-Gm-Message-State: AOAM53337FjQ/vSsOBGl/z6WjIFjVr55YeKV3g0/k5dufP98GV62KdrN
        aKzCbVsz2m+aPPcdYeWKBrwfRy52O/TOYgCkuu4n0OwSfiWB
X-Google-Smtp-Source: ABdhPJy/NNkYLn1yvZCHE7rpwLkZOK8dRMoNBFkSPy7ou01r8UDVgYzQVGCO3tkNx8KwQ2h8PC7FmQF05vWr1AcJaPz7b8SR4Sxg
MIME-Version: 1.0
X-Received: by 2002:a92:c844:: with SMTP id b4mr8694995ilq.297.1596697205171;
 Thu, 06 Aug 2020 00:00:05 -0700 (PDT)
Date:   Thu, 06 Aug 2020 00:00:05 -0700
In-Reply-To: <00000000000053e07805a9b61e09@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba6a2d05ac300953@google.com>
Subject: Re: KASAN: use-after-free Read in __cfg8NUM_wpan_dev_from_attrs (2)
From:   syzbot <syzbot+14e0e4960091ffae7cf7@syzkaller.appspotmail.com>
To:     alex.aring@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, stefan@datenfreihafen.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit bf64ff4c2aac65d680dc639a511c781cf6b6ec08
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat Jun 27 07:12:24 2020 +0000

    genetlink: get rid of family->attrbuf

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12069494900000
start commit:   e44f65fd xen-netfront: remove redundant assignment to vari..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=829871134ca5e230
dashboard link: https://syzkaller.appspot.com/bug?extid=14e0e4960091ffae7cf7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11818aa7100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f997d3100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: genetlink: get rid of family->attrbuf

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
