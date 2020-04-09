Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90372C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613C32082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586461344;
	bh=6XuC0xOKni4kfMMVbdgp0La+OSTgNbVXZZW+64vDnII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hOBRa9bbxMKc0pUkJ8VSqPYMJfgInoKJvdRt56KeSRtRIenD7DM8fkNcu8Z3Fkqa5
	 yzqr5JfoYUKMmSO3Dr5i2p6FlM3wODhY825I1KuN/ELVzk4bbrt9et0sA3q+Olh/4+
	 ZbPBR0IvMTekH12ZaQhMfmdP97UPcv2/8ZGYfN7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgDITmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:42:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34913 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgDITmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:42:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id k21so1004206ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 12:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAhys4LZKw/fGvqXf+XzDbKQt9prwZrHtJKIODHUk6s=;
        b=IVm9Qr4x8CQxDDXrmryn2CokCeA9fQTy74TPtZ+nvLq2SMgFUb4GeZjE5/UxlR+KQ3
         0TMI/YLAbzibepwVX2Bs/s8h6TJY0tRKtOfNnoXzCY64HGFrE2RpuMB2hx6SjBfZTv68
         LWL2CPxJFCkmr6MgfcI+JaYyoATRThjnuau0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAhys4LZKw/fGvqXf+XzDbKQt9prwZrHtJKIODHUk6s=;
        b=p366cRDE7+MynRl7VX9SiSW4BTIf95K8MSV682U5wLpQNaSG21NCxgyxIJB9S+FEn7
         f1QEatJ3XJZWQ3eIYdPneSSoLfa1mrP2DOKLiagWinCxTRWZMhzEH4baVwjRJWY6bSpe
         csfMbatn+424ye4/Vot73/fZQvKRI2efZ9Q7ivEK8a5lt+C2lOixRSgoVER8Z31ahi3J
         t7ywkSNqQX5ItleWR547KghhNaLUIzZ5IQghfGRuMWNBBYYWQKXyxZSU2Z9ZkbA/vgub
         lY2j0bIw5t55nIAfJ0g1VIUL2eNjwhHwhyb4nbGDy+gZQ72KgOtrB+kcpqMp950Vn9c0
         6XeA==
X-Gm-Message-State: AGi0PuYzJf8t2aDxY2FmutdaFvdZhyXJbk9rlCl2dSJzPpYmiz+2ZtlM
        UyzusJuiNIIyRQnqiULZphqITOpI7dM=
X-Google-Smtp-Source: APiQypJfaIujWhoQMnlwgc+nl9eX42yqKTVFKTyQvYcbu4YvifyVOgd2K2mli8m00+GIlHNeB/0Dwg==
X-Received: by 2002:a2e:9648:: with SMTP id z8mr872500ljh.169.1586461339283;
        Thu, 09 Apr 2020 12:42:19 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id j13sm22035lfb.19.2020.04.09.12.42.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 12:42:17 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id b1so1006376ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 12:42:17 -0700 (PDT)
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr860929ljp.204.1586461337061;
 Thu, 09 Apr 2020 12:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org> <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org> <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org> <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
 <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
 <87wo6or3pg.fsf@x220.int.ebiederm.org> <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
In-Reply-To: <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 12:42:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
Message-ID: <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 11:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I guess I need to look at what that test is actually testing, because
> it wasn't what I thought.

Ahh.

The problem is that zap_other_threads() counts all threads.

But it doesn't bother notifying already dead threads, even if it counts them.

And then it waits for the threads to go away, but didn't do anything
to make that dead thread go away.

And the test case has an already dead thread that is just waiting to
be reaped by the same person who is now waiting for it to go away.

So it just stays around.

Honestly, I'm not entirely sure this is worth worrying about, since
it's all killable anyway and only happens if you do something stupid.

I mean, you can get two threads to wait for each other more easily other ways.

Or maybe we just shouldn't count already dead threads? Yeah, they'd
share that current signal struct, but they're dead and can't do
anything about it, they can only be reaped.

But that would mean that we should also move the signal->notify_count
update to when we mark the EXIT_ZOMBIE or EXIT_DEAD in exit_state.

          Linus
