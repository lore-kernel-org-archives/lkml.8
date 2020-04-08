Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864B9C2BB54
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F777206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586304314;
	bh=fRB8R33swTx2eyYH9iWmJjokUFqp36UDQSPo3F/mQiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IzX3B8lGc8VKNuAS+ZeauiGiZafGxsiAQAjjpvi3hSHR5vgfXfCrnm06pJVye37Sr
	 jBvG6THCKW3pBMxEnkITCNmCAI0f7cUQQ0UEcAjTOYau1l/z8Vy3PUcq+ByaECikXK
	 hp9C7RPD8jWMWnc8CjdWDQgUStOXliWJdDBlwhMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDHAFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:05:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32973 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgDHAFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:05:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id h6so3816628lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 17:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIrR6bYca0pm2GJAq9Eb2z2zbLCcWgcw1hONud88tGI=;
        b=RfefjE1TimGEmBWEYxlaE/AiBpOVt1Uk0Drlf3I8ZJb0O4WXKbDzGGUcGLpSnOHEhp
         FCgsojfCWzwQP3E/sr9GD1ZyDEtgqn2gZNFoAiBYjUII4mzIAx6gdwZd3XUkMTt7+tTZ
         zq6O469mwpErQ5rkzqaJDD9339W+4V6tTVcUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIrR6bYca0pm2GJAq9Eb2z2zbLCcWgcw1hONud88tGI=;
        b=iEyjBy8b1b2mOXKiMyZFLEEa8Kb0dyctjQlrwOYknFlppHxCMRs/2/Gf1IMCu9C7/O
         Ws91ed/y77JgjHcKwlyMmOcybooKNUL6jNjvOB/7wPkv1Hn+RwlIYRVZsummAUDN45+D
         OCFQ4QJV/ua1lYz1lcdxy0vStJCMlLe3Ke6R+4cI7jjNBwPytxKT0dqnvJCay51VdVKJ
         9hCFhrFFE1HB4GXHMBMACrF36GR11T+sz6/sW/kA6p+5L/GCtlmQWCEDxdQnG2hEJTpO
         h7t4kR6BT4xI1ckK5LVzKtv1hU8iUFyPK24n3G5V7WWzzJOF4kiDGNjcsYO/Y7TJB2Yo
         7Y6g==
X-Gm-Message-State: AGi0PuZlJg6JUYoBRqFHXygo52FihxI2yeJtpby0GipZkwhby/XM/Va2
        ihTTf8P3WHymSjYBlJgVUJXK5cZxoNs=
X-Google-Smtp-Source: APiQypIC+y1YKQL/0ft9zqcYVHd4MuWdnMAVNACStzh5urGxrEamu3VtkhPnsl/GZiEGMxnlZq+TQg==
X-Received: by 2002:a19:f611:: with SMTP id x17mr2952541lfe.51.1586304309995;
        Tue, 07 Apr 2020 17:05:09 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id w24sm12425464ljh.57.2020.04.07.17.05.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 17:05:09 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id g27so5647714ljn.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 17:05:08 -0700 (PDT)
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr3154247ljp.204.1586304308658;
 Tue, 07 Apr 2020 17:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000018a92305a2ba57e0@google.com> <20200407220837.GB66033@xz-x1>
In-Reply-To: <20200407220837.GB66033@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 17:04:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQJQM=V6CDPrU2FJVEi4zZsr8-w8a0We8tF5K66J_ZOw@mail.gmail.com>
Message-ID: <CAHk-=wjQJQM=V6CDPrU2FJVEi4zZsr8-w8a0We8tF5K66J_ZOw@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in get_pfnblock_flags_mask
To:     Peter Xu <peterx@redhat.com>
Cc:     syzbot <syzbot+18638e81a805a2d96682@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 3:08 PM Peter Xu <peterx@redhat.com> wrote:
>
> Thanks; I think this is a dup of previous one too:

Peter, since the two nasties are both fairly bad, would you mind
sending me your two patches and I'll just apply them directly.

I've seen them fly by, but I think they both happened inside the
threads discussing the problem, and I'd much rather have the final
patch sent to me explicitly (with confirmation that syzbot tested them
- again I _think_ I saw that fly by too, but my mailbox is fairly
chaotic..)

             Linus
