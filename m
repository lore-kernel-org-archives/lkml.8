Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E234C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA19207D8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhzFKg9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbgEXTSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:18:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33172 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387794AbgEXTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590347931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/hcaiO8OAmzEEvBE9PTP1sm7IVt4F5J/5yjE5N6/7jM=;
        b=bhzFKg9fh0jhhMsprnC7e6GQAyie0usRpfy+Fyx0XYkJGcAwiIt1800aYEjO8dS6KShtZN
        U2Ek4Fb8vaC5J9OOZ0jAMzKjegOjs+lMAJ5c2nDrTLxUAW1YDNHEHIiqY7G1JfANQuBUyR
        gR+4e6jNu+txJxHvcmxVZQn/5dF3ikg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-isZjvzsPOcyw65ZX4ispRg-1; Sun, 24 May 2020 15:18:49 -0400
X-MC-Unique: isZjvzsPOcyw65ZX4ispRg-1
Received: by mail-oo1-f70.google.com with SMTP id z24so8594316ook.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hcaiO8OAmzEEvBE9PTP1sm7IVt4F5J/5yjE5N6/7jM=;
        b=CJDWaTWlvRqoJA17hVecDeC2zWl1Zk0Vi3zgXE4h57QKC+thTfmv47yy28YRlY8YRB
         L7xnpX/DEegBNqT40Z3k1gC8fjP7tHnoCSC/XJIA01tNVrDIAVatwO7Cs09Yy0GQj8+x
         w+g+wGlwLFJ5I6BjW5XMT5pKO+jWVUtptCd+Uno6+X9AqDj+hcHFzBDRdDGLS7+1vVV4
         /iulXOmUCkPwAPfGNNrB96HonusaqvLWT5mLfLGNndgbVhs6JZNXQtuYItH1bKJTH5dd
         qgL8xw4Z/dep176vzOUpruyUBYJT5lrv80TR7uSyRgL5fdYiQLZmWjndO5enQjUfxvuu
         IkKA==
X-Gm-Message-State: AOAM531gNPFH59y1/pdD/HeTMch8Cu4f1QomXACMNNrsuZ17m0WByKQn
        TqJdr4WD6qVz+R8gAQ33or2sOp3TJnHOILAkEWKTeJgkJ8jvZaL7DiJp5zjQMK/w0NqAh4O4Fh4
        YPXE/XWFh/4n/hz8JAskXlWYzRkiT6xJtQlzBebWO
X-Received: by 2002:aca:230e:: with SMTP id e14mr8127885oie.127.1590347928490;
        Sun, 24 May 2020 12:18:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR67E8xiElSW8GFSVtkRz6H4YIOv3dOHo5+hRuKxFSktBuh65WLcJCA92/FZ3AbOMoVZnTpxopYyCyDrOGnzQ=
X-Received: by 2002:aca:230e:: with SMTP id e14mr8127873oie.127.1590347928244;
 Sun, 24 May 2020 12:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp> <d65ee15211aa69a815bdc7cc4fc9e7c2e1bcba43.camel@perches.com>
In-Reply-To: <d65ee15211aa69a815bdc7cc4fc9e7c2e1bcba43.camel@perches.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sun, 24 May 2020 21:18:38 +0200
Message-ID: <CAFqZXNthJE0a3KkgZFXYSFArwRs0H_20KjT6KfAkiMo6WTp1rw@mail.gmail.com>
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into printk(KERN_DEBUG)
To:     Joe Perches <joe@perches.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 7:38 PM Joe Perches <joe@perches.com> wrote:
> On Sun, 2020-05-24 at 23:50 +0900, Tetsuo Handa wrote:
> > syzbot found a NULL pointer dereference bug inside mptcp_recvmsg() due to
> > ssock == NULL, but this bug manifested inside selinux_socket_recvmsg()
> > because pr_debug() was no-op [1].
> >
> >   pr_debug("fallback-read subflow=%p",
> >            mptcp_subflow_ctx(ssock->sk));
> >   copied = sock_recvmsg(ssock, msg, flags);
>
> > Since console loglevel used by syzkaller will not print KERN_DEBUG
> > messages to consoles, always evaluating pr_devel()/pr_debug() messages
> > will not cause too much console output. Thus, let's allow fuzzers to
> > always evaluate pr_devel()/pr_debug() messages.
>
> While I think this is rather unnecessary,
> what about dev_dbg/netdev_dbg/netif_dbg et al ?

I'm also not sure if this is really worth it... It would help localize
the bug in this specific case, but there is nothing systematic about
it. Are there that many debug print statements that dereference
pointers that are later passed to functions, but not dereferenced
otherwise? Maybe yes, but it seems to be quite an optimistic
assumption... I don't consider it such a big problem that a bug in
function X only manifests itself deeper in the callchain. There will
always be such bugs, no matter how many moles you whack.

That said, I'm not strongly opposed to the change either, I just
wanted to state my opinion in case my reply to the syzbot report [1]
gave the impression that I considered the "misattribution" as
something that needs to be fixed :)

[1] https://lore.kernel.org/selinux/CAFqZXNvf+oJs9u4H97u7=jTL2Wo_Hkf4nZdZJLD7tNC_J0KDRg@mail.gmail.com/

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

