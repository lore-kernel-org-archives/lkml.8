Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EBFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F582086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgHFQ7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgHFQkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:40:40 -0400
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com [IPv6:2607:f8b0:4864:20::1048])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ECEC0086BF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 08:40:09 -0700 (PDT)
Received: by mail-pj1-x1048.google.com with SMTP id s4so7928629pjq.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 08:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=656dnNAuUUnD/k18gLmyRR/+raciy1Oyj/NPSnNG5xk=;
        b=Qb9x6kSybloGsaxZ5zVWPFw7GBTOWjDT7Onj6xNESz+uV3WQz0HuI+a9I/HP4YbIzk
         FwL8gNu2aGWqnMbYtPk1jHNAM6sS2MJF7B7efXCNcrDQ4UqJfR0AY8jXMCbsnqJKP36r
         wj8tjRolORRljI8XJKVHzKZSxTBGDFz7AkNFQdh+WrEtUB/FuMJ0k3/9YFl65FV1NT4F
         WIb17Fj9F6fF0rdr1qjcSYF95ofzVhCdzxLPtQCcnZUiaWo48/8ikLZqwtLu6HpuZc35
         ZvHh57AjelK01KPedxVMLdFUSNOk2UvcGzm+1plbBto3u6mSkdYMAAFc2ShdbixM6C2W
         StqQ==
X-Gm-Message-State: AOAM530b5VT2n4Pqk5pjdKZMkhS85woEqBwfbejTuDT+bVdQA7NWf3O8
        bEoyXc8yBKvEau+HL7gXiqZfYnpfqv2B6jWjNkoC8yqhYpWQ
X-Google-Smtp-Source: ABdhPJwcAiTy/wffzoJCdETIFtbVqx/gf0LyEU7YnrR+t22WgktHp0EA2zFRLzq4BhmxgcgX5gUlZD0bRSKQNpJblmn7VpzbFmVA
MIME-Version: 1.0
X-Received: by 2002:a92:9106:: with SMTP id t6mr10728891ild.105.1596712744169;
 Thu, 06 Aug 2020 04:19:04 -0700 (PDT)
Date:   Thu, 06 Aug 2020 04:19:04 -0700
In-Reply-To: <0000000000006925ea05a69d5bfb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ecb92805ac33a761@google.com>
Subject: Re: WARNING in binder_transaction_buffer_release (2)
From:   syzbot <syzbot+e113a0b970b7b3f394ba@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        maco@android.com, syzkaller-bugs@googlegroups.com,
        tkjos@android.com, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 4b836a1426cb0f1ef2a6e211d7e553221594f8fc
Author: Jann Horn <jannh@google.com>
Date:   Mon Jul 27 12:04:24 2020 +0000

    binder: Prevent context manager from incrementing ref 0

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c84dec900000
start commit:   9cb1fd0e Linux 5.7-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=cca7550d53ffa599
dashboard link: https://syzkaller.appspot.com/bug?extid=e113a0b970b7b3f394ba
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1230353c100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fd535e100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: binder: Prevent context manager from incrementing ref 0

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
