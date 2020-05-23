Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621F2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 11:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC362071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 11:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbgEWLdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 07:33:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:54011 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387729AbgEWLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 07:33:05 -0400
Received: by mail-io1-f71.google.com with SMTP id d30so9233310ioe.20
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 04:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dZyZqTwiP+xrs8PlvPwtIHnm6mFf5YN6wYhwO+sWOlc=;
        b=NaaajOL3CovPOylH6fMk/3OZrqCvRoFu7zpaydvY9EfoSM7P6Trg2X7PItmosvb+lS
         kn0L3fQcg407Uv9GBr8GhV2A22udNJqrg88kefJlguWQk2hS4AuVBxCQicgPnfPpCdbD
         lbSZBaYOmp8RsPJViT+AJFJJcC8D2sUNiV9XfXDDPGjJp4SwNvicXcJpr1fxT6aEQU32
         tNLwZaYnCYfHpSVewTEjNqPAaj/8tLM8nie3/FkkQ8euHNebYfUsHbZZI5NhCXe+TfSp
         bA5RHi6jejfFSnDJcDjxOe/yretxL4mCRJ6nX9YDSHCKx8Loiw9yy5+AG147Hcg5AcEZ
         lGFw==
X-Gm-Message-State: AOAM532C3cbwFiV6LuZVkmrwEapNV6qQTPCNwEegxhcQCUnDkxqRG2Xw
        9vG95TPkjjor7iK5Kmj4me+eQC+UKb6tsX3DWeU8l8rkutj6
X-Google-Smtp-Source: ABdhPJwfvsc/Vx5jBxjkvQ8bakqR5UQhv+TwIJyfPj49usVz9ZgCxOwmgKW5G8qRIuo1D8KEOKLd5Fp/aQNB00af2lM5ssRrsDM4
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1104:: with SMTP id n4mr11987894jal.91.1590233584794;
 Sat, 23 May 2020 04:33:04 -0700 (PDT)
Date:   Sat, 23 May 2020 04:33:04 -0700
In-Reply-To: <CAOQ4uxh2+fhAdpyu4JB93MGB9wV0ztExc6cWBZnhfLmozk8Fag@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee810805a64f1b6f@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in ovl_check_fb_len
From:   syzbot <syzbot+61958888b1c60361a791@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+61958888b1c60361a791@syzkaller.appspotmail.com

Tested on:

commit:         30981015 ovl: fix out of bounds access warning in ovl_chec..
git tree:       https://github.com/amir73il/linux.git ovl-fixes
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3368ce0cc5f5ace
dashboard link: https://syzkaller.appspot.com/bug?extid=61958888b1c60361a791
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
