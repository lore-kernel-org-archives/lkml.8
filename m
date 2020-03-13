Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DC8C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D062073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cJoJ3AzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCMOLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:11:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55351 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgCMOLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:11:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id 6so10113201wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTkIuFS+sGaAC8JwXfK5lVK6SYN5Se9MVMEv67XiNyk=;
        b=cJoJ3AzHZmwtZp40v4ICGMZ3Ajp7ofahUeU14HAvuKUqTyvuR8LSLilmLXPz1OKLj0
         eGkjod9Y94A1RJyiwamaaS3MsFttxA2C5yKvxv/GHnNNd84hqPWBF5lGG6mi172kLsRX
         xoPMyIR23wjH7d8/b/SAg23nr+J01v60kuwgQd8mh/eyLss8kCh2b3CNdjrM/G6lCunt
         MsVHqXH1/vRzLjef2+Ob3ISr52uNkYnouj/37RlpMpE63sX5BErPRieM3hXbQy3pnr5d
         ODhCOQfovpDUjXFEa77tR1D9LMpW5jAlBnQrBMI6vbsqV984k1QMVfCt1JVW5wsU1R/D
         wKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTkIuFS+sGaAC8JwXfK5lVK6SYN5Se9MVMEv67XiNyk=;
        b=qQnlYis6cQ1rcJd9b3/V06OJC1lE07y4ee6TelzwIbtxvg59eYb/Kos0Qq4s7YLgtx
         rmcKRSWUBFpEuTRPyAdrvpeTTP3wDUYzOCwdrTxiFXTndL1lso8atAmjVsSvFgphxU9H
         LL7I/XIEFOgcgX2YQFnlsM68zlRFdQUmxD+ZLRtHuusbr2hRL8aP7BnW059uwPiFi4qL
         UoH0TPgSLJ/l6ZEaZOGGLhAcweR67pT25oK033vmzUtCEfuyT/uCeofN7FmBCr04qPeO
         IvlFsSlpo9y307sJCRgNk50hj12APjFMjSDsbi0AMA3jnCqfVJ0uSSEzZLo2gFt6MftB
         0A0Q==
X-Gm-Message-State: ANhLgQ3cYjqnaTGLX4du3oYEyDvNBiaWD0omrOzfOk1HKRzEB9ABLkSs
        j1oiiPDRP1TI0P8snjgJP9SS8XFNIlQOUHV3Ecs7mQ==
X-Google-Smtp-Source: ADFU+vubSgPtN/iCfASN0cO8puw9z3lOn8G/GuxIIUBghEfV9l49vr7BkkAFDcpEp8y0kg+5TTraf7jD1ht6FcmWgnc=
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr10437048wma.29.1584108658739;
 Fri, 13 Mar 2020 07:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000938a57059f7cafe4@google.com> <20200307235437.GW15444@sol.localdomain>
 <20200308032434.GX15444@sol.localdomain> <CAG_fn=X8UkYx5=3ARUtW3+asc+3tEdeBg=1NKS9VzChSCp33Yg@mail.gmail.com>
 <20200309181154.GB1073@sol.localdomain>
In-Reply-To: <20200309181154.GB1073@sol.localdomain>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 13 Mar 2020 15:10:45 +0100
Message-ID: <CAG_fn=U=ti=YB553DCC-_gmbiHR6=xBG4HQbyc54R3sdGCY=LA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in snapshot_compat_ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+af962bf9e7e27bccd025@syzkaller.appspotmail.com>,
        len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 7:11 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Mar 09, 2020 at 12:53:28PM +0100, 'Alexander Potapenko' via syzkaller-bugs wrote:
> > > > Looks like a KMSAN false positive?  As far as I can tell, the memory is being
> > > > initialized by put_user() called under set_fs(KERNEL_DS).
> >
> > Why? put_user() doesn't write to kernel memory, instead it copies a
> > value to the userspace.
> > That's why KMSAN performs kmsan_check_memory() on it.
> > It would actually be better if KMSAN printed an kernel-infoleak warning instead.
>
> When under set_fs(KERNEL_DS), the userspace access functions like put_user() and
> copy_to_user() can write to kernel memory.  It's discouraged and people have
> been trying to get rid of uses of set_fs(), but a lot still remain, since
> sometimes it's useful to allow code to operate on both user and kernel memory.
> A common example is kernel_read().

Ah, you're right. We can simply check that the target address is in
the userspace before actually reporting the error.
