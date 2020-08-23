Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D22C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5D420724
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598224352;
	bh=ZpmvbCroy3pMVb4rJfiM8NWKqfQUkRdiaTTX3ZVVzAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sRfv9P+lei+5SYm93zUNmdsZmcAPx/Z78nh1BWRvqIsLhQQqRB4DJ+xXTts7RPvN1
	 3U4Bntx5imiTcnpP6SN+7HRzTJVD6GbJBCI/wy40tVMHtPqEiY7bZKJGU5npgf4Aw2
	 spdg1nsLylZWSyj80H+m4HBK0QWZSSEGFNJ/SVCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHWXMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 19:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHWXMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 19:12:31 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 776EB2075B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598224350;
        bh=ZpmvbCroy3pMVb4rJfiM8NWKqfQUkRdiaTTX3ZVVzAg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0CDe7+Bzr86jlTuYjVCOF4lX3mQs0gMVkW5f2y8OPRCyAwVhyaXG0JUOYSICP/cLa
         vLZ4FTxirMsLe6OPkC1Ig6EszC5mMopR7pzXEgto5ojPm+RNNKn0tPL4oQW92zv49J
         Z0J033Z9Oxzv+F7sIELWbAqbNfZMaLZ8DBiKR4fs=
Received: by mail-wm1-f47.google.com with SMTP id s20so1614952wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 16:12:30 -0700 (PDT)
X-Gm-Message-State: AOAM532cmqeWuZq2IyXW8luqOr8nlUsLOeYkM+LNGI5vy+F1Q8Hg9hGO
        q3PdRSmsM1K9kAJreRXitfeGRyehjHYUr0OWvr5AYA==
X-Google-Smtp-Source: ABdhPJy35I/Gzkbp0WW1BdvJj2QIdO/WOhE+U51NFmdPuZTyXxMg4gQXZgvkGBrP54gm4r5C8kMZaeLo147x6/P8a9s=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr2988577wmc.138.1598224349132;
 Sun, 23 Aug 2020 16:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <159817113401.5783.14776307451257171431.tglx@nanos>
 <159817113762.5783.6214320432160748743.tglx@nanos> <CAHk-=wiQQRS1f0qMwVVWKd6YHJ9K3bUK4BR2zoeGeCWRpTM3aw@mail.gmail.com>
 <CALCETrUSE6cTgaa9LWK=JgKhJt4vgGz42uPJEkk6XZWA9dOkvg@mail.gmail.com> <CAHk-=whjkMOgAP_fHL_+p5Gw6fwDm3tOa6_DTuVTJkaTJVTr+A@mail.gmail.com>
In-Reply-To: <CAHk-=whjkMOgAP_fHL_+p5Gw6fwDm3tOa6_DTuVTJkaTJVTr+A@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 23 Aug 2020 16:12:17 -0700
X-Gmail-Original-Message-ID: <CALCETrWZ9chgr68N7KSahJ9=vU4uqgqGZ1w_e2RH982XNEJv_Q@mail.gmail.com>
Message-ID: <CALCETrWZ9chgr68N7KSahJ9=vU4uqgqGZ1w_e2RH982XNEJv_Q@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v5.9-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 3:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Aug 23, 2020 at 3:27 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Every interrupt is going to load the CS and SS descriptor cache lines.
>
> Yeah, but this isn't even sharing the same GDT cache line. Those two
> are at least in the same cacheline, and hey, that is forced upon us by
> the architecture, so we don't have any choice.
>
> But I guess this lsl thing only triggers on the paranoid entry, so
> it's just NMI, DB and MCE.. Or?

Indeed.  And also all the new virt garbage that keeps popping up.

--Andy
