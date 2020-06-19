Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED50EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D121E22268
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgFSWNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:13:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:36055 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgFSWND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:13:03 -0400
Received: by mail-io1-f71.google.com with SMTP id d197so7863327iog.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 15:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=bDQBVe7l2yqt3mB06iVMiMUl/d4DebrpwMmTezaCnl8=;
        b=Bp+OKSGIZ5EEW3nVLXIhKHcaqowKFOqubjrVd/EamMG6ZXimYlgkUnYUUikJ9ZRSUU
         b2bxyY1hcq76Y4EWkvoPaa3aUzM8j+Ai6TXnpZY0orMIpky/Q5KvWw1o2Xa4uGGH1arO
         7nYxK3F4pdSMYV40gKcXzoLa1Z4z/KlR0PA9iQt8fXJwqtBtthDfEi43kIFfvrE4nRLU
         5jsDjTdh/vDlSJJQN6HN6meWHNIS4DplR6a6ysggNX7iNeO4OC42UJJpx18W94d03Eox
         TgPTw7Yn1USonkkHZJ/ET0eOq439JIbqlcUhMjQ0SNRtgwmbYLGsr/ZEb/gjgnLTrxyH
         p3pA==
X-Gm-Message-State: AOAM531B05SG//1eTLuR3ZmiSEIBVYpPNpYzHcD5cXwbjS0CpMKkBJ1t
        KsPJhs7iVHI4+Fy1zPbk15yzssVaEGnznCiKy9LtXdCvOuWb
X-Google-Smtp-Source: ABdhPJzjaETVaBpX1f0tHVMK3hsmWaEb1GQ3x0ua3YT2kGO5COxXB6fKHj4VZholdD5EaJS9f8p85/bf/O/linaN08vWq58XmZ7B
MIME-Version: 1.0
X-Received: by 2002:a02:cd89:: with SMTP id l9mr5712504jap.88.1592604782755;
 Fri, 19 Jun 2020 15:13:02 -0700 (PDT)
Date:   Fri, 19 Jun 2020 15:13:02 -0700
In-Reply-To: <2214469.1592604774@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005805de05a87732bf@google.com>
Subject: Re: Re: net-next test error: KASAN: use-after-free Write in afs_wake_up_async_call
From:   syzbot <syzbot+d3eccef36ddbd02713e9@syzkaller.appspotmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     davem@davemloft.net, dhowells@redhat.com, kuba@kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git 559f5964f95ce6096ae0aa858eaee202500ab9ca

This crash does not have a reproducer. I cannot test it.

>
