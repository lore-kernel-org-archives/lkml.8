Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B4AC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 22:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B01420719
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 22:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4GBeTT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgGZWKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 18:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGZWKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 18:10:00 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72594C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 15:10:00 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id l13so254969qvt.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 15:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=i3uC59zrTYqrU7WK2MYwBH2tqz/HMoZey93tc8rjRr4=;
        b=r4GBeTT3czQZ0SGW+2ZGZiDXe9vbLdpYoiIWJ8k8Eoyl8ct25CwlsOu7qKfbM1iPTM
         BRHUKBbHejZfRqojOTgbFQQbCYwq9SnIxU4cnvcBYCNr8JHqnEs+dgh+r+FAuOGEPLsU
         PPrJV0mGyo+UZnW3UC+qNUaczQGkxvH5fYzNmwNdCV6FKp1k6tScFwjuaokAtZxxiuag
         RDS8+Vn99zm+BT7vs0NPsoNn8ba9/7qgJVl3kFqlMR6R0B+vW9VrR7TxIakTcpbOk76d
         r4x/l+19n3M3/4yeFccrPXXl3GF+fZBosnNZSehIAcUROVNKRKronFd3e6iW4xiW6Ew3
         DBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=i3uC59zrTYqrU7WK2MYwBH2tqz/HMoZey93tc8rjRr4=;
        b=UjmMx3psk6eweUb9Q0CVmjM5/VIXVhkn1Ag4Z8a60g+PQ8PrQv8qkeuP/Keo67I9/5
         4P07KueTJs6kr5znvq4uo1w1ItGMIJ2FzzRIQYNYJ+4l7KPiGsVsH8wCutFP5dBsBr+/
         XoCcG0YYzcH7D3/H9nuJVJwZ2AbbHFq1cs0ggKUR9AStChIcVa9gFFbSB0gYJlNuYG/j
         XOUSCraeQmkj3uEZq7mgYWNlVOlRDM7ZBiQ8yu7TlYvXmr4bn10MyX/RBpHBAWq5gk7/
         NKmTNwXU6nZzgP+7KGG5eMJ5m/pMP/RFj740mkqT6JFiXcgkZWXhoQeNQetfR+hG2dTu
         sBCA==
X-Gm-Message-State: AOAM530Z0/B5v1ydfpD8WIhoB94KQSRugllaiCSA7DP2+74KB2VIMiO7
        kXRRDq7U/OU3FWy6pbPSHRBvug==
X-Google-Smtp-Source: ABdhPJzYmQeObi9pYiaTdzrWgeSkB4PjQ9wbXVysW/OJOKebzfOfApfWmxTKy0rUEWgNxhtrIoE2aw==
X-Received: by 2002:a05:6214:b88:: with SMTP id fe8mr19676729qvb.244.1595801399318;
        Sun, 26 Jul 2020 15:09:59 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k5sm15419169qke.18.2020.07.26.15.09.57
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 26 Jul 2020 15:09:58 -0700 (PDT)
Date:   Sun, 26 Jul 2020 15:09:44 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
In-Reply-To: <CAHk-=wg+7Wk7BLmLiDkoNDBvMfoooDVEaLimDY+10Jr9jLKLZg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2007261454110.7444@eggly.anvils>
References: <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com> <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com> <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com> <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com> <20200724152424.GC17209@redhat.com>
 <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com> <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com> <20200725101445.GB3870@redhat.com> <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <alpine.LSU.2.11.2007251343370.3804@eggly.anvils> <alpine.LSU.2.11.2007252100230.5376@eggly.anvils> <alpine.LSU.2.11.2007261246530.6812@eggly.anvils> <CAHk-=wg+7Wk7BLmLiDkoNDBvMfoooDVEaLimDY+10Jr9jLKLZg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020, Linus Torvalds wrote:
> On Sun, Jul 26, 2020 at 1:30 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > I've deduced nothing useful from the logs, will have to leave that
> > to others here with more experience of them.  But my assumption now
> > is that you have successfully removed one bottleneck, so the tests
> > get somewhat further and now stick in the next bottleneck, whatever
> > that may be.  Which shows up as "failure", where the unlock_page()
> > wake_up_page_bit() bottleneck had allowed the tests to proceed in
> > a more serially sedate way.
> 
> Well, that's the very optimistic reading.
> 
> As the optimistic and happy person I am (hah!) I'm going to agree with
> you, and plan on just merging that patch early in the next merge
> window. It may fix a real bug in the current trere, but it's much too
> late to apply right now, particularly with your somewhat ambiguous
> results.

Absolutely: it should be good to see it in v5.9,
but much too late for a patch like this in v5.8.

> 
> Oleg's theoretical race has probably never been seen, and while the
> watchdog triggering is clearly a real bug, it's also extreme enough
> not to really be a strong argument for merging this out-of-window..
> 
> > The xhci handle_cmd_completion list_del bugs (on an older version
> > of the driver): weird, nothing to do with page wakeups, I'll just
> > have to assume that it's some driver bug exposed by the greater
> > stress allowed down, and let driver people investigate (if it
> > still manifests) when we take in your improvements.
> 
> Do you have the bug-report, just to google against anybody else
> reporting something simialr>

Okay, just on that basis, with some reluctance an edited extract:
certainly not asking you or anyone on the list to investigate further.

[35196.140502] kernel BUG at lib/list_debug.c:53!
[35196.141448] RIP: 0010:__list_del_entry_valid+0x8e/0xb0
[35196.141534] Call Trace:
[35196.141538]  <IRQ>
[35196.141557]  [<ffffffffc01bc8b4>] handle_cmd_completion+0x7d4/0x14f0 [xhci_hcd]
[35196.141578]  [<ffffffffc01bda22>] xhci_irq+0x242/0x1ea0 [xhci_hcd]
[35196.141608]  [<ffffffffc01bf691>] xhci_msi_irq+0x11/0x20 [xhci_hcd]
[35196.141622]  [<ffffffffb9ff27f8>] __handle_irq_event_percpu+0x48/0x2c0
[35196.141636]  [<ffffffffb9ff2aa2>] handle_irq_event_percpu+0x32/0x80
[35196.141651]  [<ffffffffb9ff2b3a>] handle_irq_event+0x4a/0x80
[35196.141680]  [<ffffffffb9ff6b08>] handle_edge_irq+0xd8/0x1b0
[35196.141697]  [<ffffffffb9ec22ab>] handle_irq+0x2b/0x50
[35196.141712]  [<ffffffffbaa02766>] do_IRQ+0xb6/0x1c0
[35196.141725]  [<ffffffffbaa00990>] common_interrupt+0x90/0x90
[35196.141732]  </IRQ>
> 
> > One nice thing from the comparison runs without your patches:
> > watchdog panic did crash one of those with exactly the unlock_page()
> > wake_up_page_bit() softlockup symptom we've been fighting, that did
> > not appear with your patches.  So although the sample size is much
> > too small to justify a conclusion, it does tend towards confirming
> > your changes.
> 
> You win some, you lose some. But yes, I'll take that as a tentative
> success and that the approach is valid.

Great, yes, tentative success: and we have three months in which to
change our minds if any real trouble surfaces; and I wouldn't call
anything I've seen (since that very first version) *real* trouble.

> 
> Thanks,
> 
>                Linus
