Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9E5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA20123119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfTFo6+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgHFQrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbgHFQpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:45:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD3C002173
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:14:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id jp10so24368870ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUhK6XxdfktnJLvVMPHZp4b3o9WzGcvCUn7lMMPRpRY=;
        b=HfTFo6+NCf3S+9swY/fTtzedig26g/bIhESx5DqzJjD9jwCMYVYCAJ5R4bYYX1iFHL
         VIUbSAxvhkjzG6ciZBhTCBev/lO/UqdxZ9W8Wqx5lgO+UIVj2VM+t7uzUerAjmP0fdfl
         tFxW8XHxFKmfxrZGYEgJ26hAeI4WJA3Y2FngZioz0t/MTTQdN15ghhB/EQPQzWI0fMBF
         qfjzLg/pO1Yl0glZRJalvO2Y6LnvTXgOzhT2/3gQ2a41cxQP+0hYlw8kfm7mrkGKgxMi
         MhBR+SHavb9nXwJbX9BDptI7gXYjP3X4vdy9eXkKFtJW2c+u3a637bDi/9t+H7ZeI3u4
         wCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUhK6XxdfktnJLvVMPHZp4b3o9WzGcvCUn7lMMPRpRY=;
        b=srZooTz/FEGx5ajTwLZAL1/SPi2cpv5immEruTs2Mxz2r1o6QzkIoZN9Ccv5NaDkHo
         YVB4utTuhJwhsmWN5yDUsRasQHgTOnQ7kA3DNVFiJKepKkLwALvq4wluLVQgovoyCSiu
         TFJgfJmWi5G5Dm33F87T0Tw8ka1KtkyLsgjDKJIGSGUfVcxV6KMSACms+HU/UsdRjv5O
         wKa6fbTV3vuQjsIkbMd1l4re+KadOl9C/EAyZ9fZp5FQA3lCqyUpJLvrmUxf3Ted5uay
         wofYZ2T0BxdoEz3G5XZkl5wm0irSW+E0/MY+zTPNIeujvJqzXprli11bh9x9NJnikW6z
         w9mw==
X-Gm-Message-State: AOAM531+dOXj481MA6gR07LgIF+bADOr7tnxF9LttgCVR4WccVgRkKFh
        ae/jxUhlqrEO88lmuyjUxyIxQbSpl1D8NWM+cqjBpLFR
X-Google-Smtp-Source: ABdhPJxJI5PkLwFsxMCbJSijgov8BkA6HTM/g4dOfaBOhR8DivHf4LCdyjvKHRZzQJWu3M/JyvJujWB1lbvsAWeL0eQ=
X-Received: by 2002:a17:906:c406:: with SMTP id u6mr5330651ejz.47.1596730453302;
 Thu, 06 Aug 2020 09:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006925ea05a69d5bfb@google.com> <000000000000ecb92805ac33a761@google.com>
 <CAG48ez0Rdut=HxSyKUCiCVU=zZJPR7YXcOfL3tRBXXwUS0iKxw@mail.gmail.com>
In-Reply-To: <CAG48ez0Rdut=HxSyKUCiCVU=zZJPR7YXcOfL3tRBXXwUS0iKxw@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 6 Aug 2020 09:14:01 -0700
Message-ID: <CAHRSSEyJHcjZj73SjkzavdeDnoAp2pREJxQa58k94hEph8tRwA@mail.gmail.com>
Subject: Re: WARNING in binder_transaction_buffer_release (2)
To:     Jann Horn <jannh@google.com>
Cc:     syzbot <syzbot+e113a0b970b7b3f394ba@syzkaller.appspotmail.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Todd Kjos <tkjos@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 9:09 AM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Aug 6, 2020 at 1:19 PM syzbot
> <syzbot+e113a0b970b7b3f394ba@syzkaller.appspotmail.com> wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 4b836a1426cb0f1ef2a6e211d7e553221594f8fc
> > Author: Jann Horn <jannh@google.com>
> > Date:   Mon Jul 27 12:04:24 2020 +0000
> >
> >     binder: Prevent context manager from incrementing ref 0
> [...]
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e113a0b970b7b3f394ba
> [...]
> > If the result looks correct, please mark the issue as fixed by replying with:
> >
> > #syz fix: binder: Prevent context manager from incrementing ref 0
>
> I think this issue still exists, syzbot probably just hit it in a
> weird way that doesn't work anymore.
>
> This warning:
>
> case BINDER_TYPE_FD: {
>         /*
>          * No need to close the file here since user-space
>          * closes it for for successfully delivered
>          * transactions. For transactions that weren't
>          * delivered, the new fd was never allocated so
>          * there is no need to close and the fput on the
>          * file is done when the transaction is torn
>          * down.
>          */
>         WARN_ON(failed_at &&
>                 proc->tsk == current->group_leader);
> } break;
>
> can be false-positive if the sender and recipient of the transaction
> are associated with the same task_struct. But there isn't really any
> reason why you wouldn't be able to have sender and recipient in the
> same process, as long as the binder_proc is different.
> (binder_transaction() has a weird check that refuses transactions to
> handle 0 based on task_struct equality - which IMO doesn't really make
> sense -, but transactions to other handles can happen just fine even
> if both ends are in the same task_struct.)
>
> Maybe the best fix is just to rip out that WARN_ON()?

Yes, probably so.
