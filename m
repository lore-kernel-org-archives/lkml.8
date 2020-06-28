Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F43C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D102920738
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgF1OLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:11:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56297 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgF1OLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:11:05 -0400
Received: by mail-io1-f69.google.com with SMTP id k10so8941811ioh.22
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 07:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=e3mM+wVWZMbblXjHpKh3rVh40chIjEQjp+JbUdH4Rk8=;
        b=jY+7rqdVYV4hHwt+JjwJ4XjpfZhB15f9tXwOz1aTcQpKfS/eDQAvXxEk0MTBLDZaAz
         7mhYlxQXyqmtDz+ycxu4DGvjPMFhvMc4BLli02ijwCo6WBtE31IAdKUHbDN3jWMtNkqU
         R26bwSN9fvTMOo4PZvAnro6ImsURj0NZVYFsDSAGEaDK9QondRRqQKm87gCPLjv98Zz/
         LNelPpDpjpavBpEphBKDCHCgNOZlqAtCzdPy/U+AO07AfI/7sVJ6Gpm+Qb+34uqXqy8T
         7z99e/Z7wAvWjyxIfZAObIfvRM7iz9mK1l0Ahz4r6q2bubo5sN6DlS0I8owJQQf8pXhk
         fKBQ==
X-Gm-Message-State: AOAM530xUf5AZ9iIWWxRxGtBVDXSucPOay05ZKw/NvYlyk+/+CRecl5G
        Xe0V/NgZFqIbQwjQdek756hQrbUbAFFsiSLLgCUnXhx/M6tC
X-Google-Smtp-Source: ABdhPJz5MwNDHEotHDtTCu6kgkRqMjtTHZ3HOcTj8A4ZUaTiR/zkq5ulZ5jdY9rlNC6HnAnYr5pTa3pe9jMG8+5SS3I+fOL0zhJz
MIME-Version: 1.0
X-Received: by 2002:a05:6638:236:: with SMTP id f22mr13173946jaq.18.1593353465153;
 Sun, 28 Jun 2020 07:11:05 -0700 (PDT)
Date:   Sun, 28 Jun 2020 07:11:05 -0700
In-Reply-To: <CAM_iQpUHiSsfkT8tzwAg7CKYXQQ4ZsROxKZbHKv0LxwrPeM=Jw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ad07105a9258303@google.com>
Subject: Re: possible deadlock in dev_mc_unsync
From:   syzbot <syzbot+08e3d39f3eb8643216be@syzkaller.appspotmail.com>
To:     ap420073@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+08e3d39f3eb8643216be@syzkaller.appspotmail.com

Tested on:

commit:         152c6a4d genetlink: get rid of family->attrbuf
git tree:       https://github.com/congwang/linux.git net
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf3aec367b9ab569
dashboard link: https://syzkaller.appspot.com/bug?extid=08e3d39f3eb8643216be
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
