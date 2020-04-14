Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB9DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04032075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7E03Rra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439853AbgDNMFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439808AbgDNMFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:05:35 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED11C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:05:34 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t3so9008346qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ye8Pt9b9xIcYq/Gt9nBPREXSZRlFaEUivxRL23XW6ZI=;
        b=N7E03RrawPL63NujM/vs57LPY3VlQKpiWGG1zavwqsuqb8LNuPN3T88ns898l6ZijV
         ZEWoA7htCk64CpOwuJs9jyegCT3l54H4MWw9GTAWZkRqdWq1GRFo+PeD+Z3K08CWaTXA
         iICk6MVImYfOzrhpXwW9pYoBnuOwFSxVKzPEwypoXsCbZXpgQv1KvFMI1zq9m4lusYG0
         QyPiNzYpsIgjd3fJuOmjH7dXc6zJXzA4L7rVt16CFjIYnPn3qssahmIomZKo9thw2Kn6
         2B0lCFlCbIx9nZ/Sb763n9gCGQ83KSXkuGAmMOBcYpKccSjYsk3b0dnoJS1r3HJh7gkP
         pHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ye8Pt9b9xIcYq/Gt9nBPREXSZRlFaEUivxRL23XW6ZI=;
        b=bZ2wfemVtJMjaQC7wy0BmaQoAUh5rs11vkF+LrVvxNqY/fM1hErcsipeesLeaQfRAQ
         cM7k869+GEYQdgOdfbmA6nHhjVaA3VwbsK5FPwAjpFyKLSPP6NvbS3ibhKx7hY8KRaXs
         yPEO9EWPdEF60tQIsmWF4yUMklwpmM572GwDyfmjmUmm8jvCI4qeUDfp3ZD7TA6KHA5T
         EpkSqv0wW0sz3zHVCbEpfhBqyIDu/ZaHznmsX1b9jIQcmnvkwRC8lr77jnwYr+56iKtm
         OhmOkRxgxwHR6nS3NMkVSoZzECvdWGelOhzFGTGOcT8UXHHEgR7CsZUXVVIbmNm5Mgo5
         sdKg==
X-Gm-Message-State: AGi0Pua14Dm/vQFQftuYm3B6dq9ty9QTcZXbqEx5GSy3vcJPs781aavv
        BLuvFsvhfohlkwCt0k4UHizUvYF5fAoMewq3LS6mng==
X-Google-Smtp-Source: APiQypLY9oDrsLA1N7wxBV5d9f4kHY3bF533lSU3YgONt9q6VMFdfk/Qaf7YZX0PAASz0V54Qg+I6px7ztXqUkuU2r0=
X-Received: by 2002:a37:bc47:: with SMTP id m68mr10260254qkf.8.1586865933482;
 Tue, 14 Apr 2020 05:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+ZE1XhYpTsjP1J1PyUsEHYKvchww71aHb7UnSk5=4xUrw@mail.gmail.com>
 <04E78431-7B62-4FA1-8B1D-51DF7648D9C5@lca.pw>
In-Reply-To: <04E78431-7B62-4FA1-8B1D-51DF7648D9C5@lca.pw>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Apr 2020 14:05:21 +0200
Message-ID: <CACT4Y+YE6N8MUL-hVps6+BxVoQ0Xi_4AS26j8e+tv=_L2vKuYA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Qian Cai <cai@lca.pw>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Rue <dan.rue@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 1:59 PM Qian Cai <cai@lca.pw> wrote:
> > On Apr 14, 2020, at 7:13 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > How do these use-after-free's and locking bugs get past the
> > unit-testing systems (which syzbot is not) and remain unnoticed for so
> > long?...
> > syzbot uses the dumbest VMs (GCE), so everything it triggers during
> > boot should be triggerable pretty much everywhere.
>
> There are many reasons that any early testing would not be able to catch =
ALL the syzbot blockers.
>
> The Kconfigs are different. For example, I don=E2=80=99t have openvswitch=
 enabled, so would miss that ovs rcu-list lockdep warning. Same for that us=
e-after-free in net/bluetooth and a warning in sound subsystem.
>
> But, notifying Linux-next ML is a good start, so at least we could ask Pa=
ul or Steve to pull out the commit which enabling rcu-list debugging by def=
ault with PROVE_RCU.
>
> I learned through that restricted kconfig to some degree of minimal could=
 save a lot of troubles late on especially those options that I have no way=
 to exercise like net/bluetooth and sound currently. It is going to be extr=
a works though because those default options in Linux-next or even defconfi=
gs are not always pleasant and would want to enable something I don=E2=80=
=99t need if not given human intervention.

We only try to enable what we can reach. There is significant reach
for sound and net/bluetooth even without any hardware. So I would
assume generic testing systems like KernelCI, LKFT, CKI should enable
these as well. Hopefully we don't have all of the sound and
net/bluetooth completely untested in linux-next.
