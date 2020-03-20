Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6984C43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A164B2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCTO2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:28:04 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:40675 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgCTO2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:28:03 -0400
Received: by mail-io1-f72.google.com with SMTP id z207so4731157iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 07:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=V3eZ0Q2sozWnNVeRof3nsCb56+obGL4I8lV01F1qBnw=;
        b=B6oZLKBEyA2/1ip9x7naREYmjAR93aL+VQzxrC1xWQBnxu82drgsHDKSCOEwz2BWW+
         RNzDJfigUplLHS3btBVGpEBOKcPWjXRZbObF//x4cMv5SO+y8HGRax2w+pDqFpjiLTcg
         3zKleSRt7a3kAOnUk+F8csiiUyJDquCGHr+Ke4AG1YKgBdxascJEs7H6H7o7X6WjYXfK
         vteAQxOaJNXgxLpCIR9eVl0J+0N3MI928f3sL9jerRTL+qu3YjPhkDLYcvewgmuMMcu/
         5gccCM4IXOmpdE32ajnN+2wcv7S9xRp9p+ANTViAu3yNlUfCSprKDNiDb9JtdMlBXSy+
         q7Kw==
X-Gm-Message-State: ANhLgQ1qDsNUNbJEYy419B37f/dK5nkPv7iAFbrA1/FVKVGMFiaaBN9T
        zdEEK/EWvoqnmJwQKb9n4ObRf6f1AxBMaCQUeEfMsRduLuFH
X-Google-Smtp-Source: ADFU+vs8Llim/P/NcDrRl0rA9xDffc9w+ks14520WpdyQ2KMPPDXKIdigsLz5Hd/lFxeKcOVJou3SzJdzLJ5COhOBHpYl/hSWQAs
MIME-Version: 1.0
X-Received: by 2002:a92:2911:: with SMTP id l17mr8982118ilg.166.1584714482967;
 Fri, 20 Mar 2020 07:28:02 -0700 (PDT)
Date:   Fri, 20 Mar 2020 07:28:02 -0700
In-Reply-To: <CADG63jAwaYMP+Q3WNqpOnf39_XZ3z5ZZu-ST-f5q2XM+kHgcgg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3ee8f05a14a17f4@google.com>
Subject: Re: WARNING: refcount bug in sctp_wfree
From:   syzbot <syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com>
To:     anenbupt@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        marcelo.leitner@gmail.com, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com

Tested on:

commit:         a8a7ac16 sctp: fix refcount bug in sctp_wfree
git tree:       https://github.com/hqj/hqjagain_test.git sctp_wfree_refcount_bug
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5295e161cd85b82
dashboard link: https://syzkaller.appspot.com/bug?extid=cea71eec5d6de256d54d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
