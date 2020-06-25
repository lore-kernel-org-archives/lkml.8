Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE671C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 03:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E0420656
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 03:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389648AbgFYDBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 23:01:16 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:45097 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389589AbgFYDBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 23:01:13 -0400
Received: by mail-il1-f197.google.com with SMTP id c1so3002982ilk.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 20:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wKHziB1HTjinXOROzU9x8QSF9UVTTl5CGULxlu3fS2A=;
        b=mM3awSkdqvHJIkzxysqgAqsaZ3cvofatwHqZqG4TRAXs1D3OfDYvCzGKUFLI9XvB91
         5iFTlj6TkQwNJX5EU/8oX9KN5HX7ljGcPRdq4SFHysHJQ/mqEBBG42/v6FI6LO9kH4Dy
         HZkAEl6LFI8C+6FDThT72rnoqisGYmLxJwX3yG/2o7OnI79E4e6SJl0cKhup2tRJWI13
         SWGQ7dWIJMejCz1jFZRZo7P0yYfz3PoehCStGmTGFN5ncILf434LuGnTj0/PDuX1qyz0
         vwjgq/QE9wMdh+fWJLx8pIcN67oRBsijzfXTARYmT/0sjqE46ZN12tS3nircsbfrX0IE
         saHw==
X-Gm-Message-State: AOAM530EbNezvLaDnTFYWwvV9fpnPwHi3KrvykYwElKrNwA7WRz0qZs1
        Gryksy7ZCcjZWE6um5RDJ+94PhnCmb4PRUqCYgcgMtO0V8IV
X-Google-Smtp-Source: ABdhPJxbs1SAyL/M/fgk3l40cIJl7wJzsJfAm+GKPt/0zA1RuUK6bKXZkytrERisRhBiK2xMcbSQIrQom47jw0jbMN8Qdv/m0rQo
MIME-Version: 1.0
X-Received: by 2002:a92:290b:: with SMTP id l11mr31731641ilg.145.1593054071282;
 Wed, 24 Jun 2020 20:01:11 -0700 (PDT)
Date:   Wed, 24 Jun 2020 20:01:11 -0700
In-Reply-To: <00000000000047770d05a1c70ecb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006e0ff05a8dfce2d@google.com>
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
From:   syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>
To:     a@unstable.cc, axboe@kernel.dk, b.a.t.m.a.n@lists.open-mesh.org,
        bvanassche@acm.org, davem@davemloft.net, dongli.zhang@oracle.com,
        hdanton@sina.com, jianchao.w.wang@oracle.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
blk-mq: Fix a recently introduced regression in
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
