Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7290C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 02:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81922072B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 02:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585967338;
	bh=uUSrbSAH4OOQ3rY+uxp1FSZdOUv1X+/CDggo62jQrMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sOIesBKpxXhZxatRaR0AgD3ftGpX8dICL5oMDqRu0wzQLpsCnkUww0AqPMWU+w4Wg
	 +HHJCsCqtw6yB5aseAw4t7SWNuj0BJxUtB7EQgKRqNCDQxDJKdPaISy+HJB3aV85+3
	 UJdIlfAkBhb/JJsgMNbuDDSQ9l28g/06Y7YwU37s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgDDC25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 22:28:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43370 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgDDC25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 22:28:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id g27so8870883ljn.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 19:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5JPds8Go2/Zyqr12LZJe1/lrfTLjYhMTcJDleRBAvA=;
        b=REZrOCPy/mT0VVEtrKzx46IbOSanxNR3X9Xmr/iPO703QcYf4mAgIps+y7XHoovfiS
         qp6IEQ4t1Bh5Og7OMlYlgWe1cVR42kH8nqfboAonmjvgPG6ec3nppHREVrlgbVbDiIIK
         wuIQQ2ZWGGSCJsGVR4bSjdjqLIrAWHEfSEusk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5JPds8Go2/Zyqr12LZJe1/lrfTLjYhMTcJDleRBAvA=;
        b=XWf8THEnNceMts1ygiigXt5ibrWHAmc6xnyQvSL3IzyQTvc4BMYEBkWg66k7p6TT2f
         ELpU9Ui9LQbQ/xIf/st9SRBPlEZAD3psyLPvHfAeVDsZpTEo3DBA9oqClgAvyY0fETqj
         IoX5oyVJIRcQNxH+d940QDUMZj6UIGFNUvO50ieu2UxxAKx2mO9wM78XHjJvtK08KI1X
         GPLDSxq3AbqudiIXS2BQtsyvj0fKNUe9zzgBy14kP1Bp5TCHJ5afJaOKXYVD8lnOtp/8
         ePYrl5pMjYuGBJSklxxrPrIJ3cYfXe+gSfj3B/j4OkCxmknljPCvUZ7yUWCL/VwOQUC0
         FHUA==
X-Gm-Message-State: AGi0Pua7XoThjPD+nMRcsLkjnejoMSwjCt/mqjbsSjs5gT2K7t6t65Z+
        tT7fe5OQCXMfREY7T2+/AQxU1A8Cd04=
X-Google-Smtp-Source: APiQypLrwdewUOuDsZEeMLCGpuHZJlHrwWr1kTS7y6o0h8Kk2NUmgwfz1MrePfGjdz0Xrf4Mz9An+w==
X-Received: by 2002:a05:651c:22e:: with SMTP id z14mr6242513ljn.64.1585967334189;
        Fri, 03 Apr 2020 19:28:54 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id t23sm6957272lfq.4.2020.04.03.19.28.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 19:28:53 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id r17so3826817lff.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 19:28:52 -0700 (PDT)
X-Received: by 2002:a19:6144:: with SMTP id m4mr6905908lfk.192.1585967332348;
 Fri, 03 Apr 2020 19:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com> <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
 <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com> <86aa9fc6-6ac9-a0c2-3e1d-a602ef16d873@redhat.com>
 <CAHk-=wgOykL7cM34NraiNGsjJC5Uq6H0ybYHWhdXDSn-wzVXDQ@mail.gmail.com> <5c04cc6d-ec44-b840-071d-248ac81a0f91@redhat.com>
In-Reply-To: <5c04cc6d-ec44-b840-071d-248ac81a0f91@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 19:28:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkE=qT6CSUJHfXNsyhW+=j4SVgxh2jEc8nWY_n3SFZ=w@mail.gmail.com>
Message-ID: <CAHk-=wgkE=qT6CSUJHfXNsyhW+=j4SVgxh2jEc8nWY_n3SFZ=w@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Waiman Long <longman@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 7:02 PM Waiman Long <longman@redhat.com> wrote:
>
> So in term of priority, my current thinking is
>
>     upgrading unfair reader > unfair reader > reader/writer
>
> A higher priority locker will block other lockers from acquiring the lock.

An alternative option might be to have readers normally be 100% normal
(ie with fairness wrt writers), and not really introduce any special
"unfair reader" lock.

Instead, all the unfairness would come into play only when the special
case - execve() - does it's special "lock for reading with intent to
upgrade".

But when it enters that kind of "intent to upgrade" lock state, it
would not only block all subsequent writers, it would also guarantee
that all other readers can continue to go).

So then the new rwsem operations would be

 - read_with_write_intent_lock_interruptible()

   This is the beginning of "execve()", and waits for all writers to
exit, and puts the lock into "all readers can go" mode.

   You could think of it as a "I'm queuing myself for a write lock,
but I'm allowing readers to go ahead" state.

 - read_lock_to_write_upgrade()

   This is the "now this turns into a regular write lock". It needs to
wait for all other readers to exit, of course.

 - read_with_write_intent_unlock()

   This is the "I'm unqueuing myself, I aborted and will not become a
write lock after all" operation.

NOTE! In this model, there may be multiple threads that do that
initial queuing thing. We only guarantee that only one of them will
get to the actual write lock stage, and the others will abort before
that happens.

If that is a more natural state machine, then that should work fine
too. And it has some advantages, in that it keeps the readers normally
fair, and only turns them unfair when we get to that special
read-for-write stage.

But whatever it most natural for the rwsem code. Entirely up to you.

               Linus
