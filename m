Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378AAC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F053F20748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586289076;
	bh=X2OQ1g54VhSiq8IbNQprcsUJTj+M2Y+nTIpvCj5JLRk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=b57vl7P3JoU90ax+FqXq5I5MpNwPxB13zpEsh3UB7ySJKTSlvV88VfsxAfIumAi08
	 x8Exgp4V+u+OwR0jLuvZ349tDcfDEQhfHE19+ejUbeW2HG+tV+kAoBu2nECq0K/TXX
	 xVet4TSyWdi7W1mbB0KguFtttUqi5xmCWj2Ejjvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgDGTvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:51:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40054 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgDGTvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:51:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id 142so573332ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 12:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilLyS0vne6BzXe6S6ucqrxkT0PaPMwvFpiaeY+Srkws=;
        b=arMl4qqEfJTIRx8VEWeLINPE4bGVG5CK1wnMXC4ZAyCSKhGf1UktLZtThxRySiWKrc
         C495qi8z/3TQBoHlyqu6z01DeMHzC4dpq9Z8dFrAprXqY+znH6KeRiBrwSgLiv60L8Ad
         ELwFC34feUDfkB6yCd6kZDWPEtJvSFA8QD6d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilLyS0vne6BzXe6S6ucqrxkT0PaPMwvFpiaeY+Srkws=;
        b=LBr4ICyQbhiE4V6A6BB8EmYPnihFyIOdMGoN3oVEwv5vSiCIDF8dzp69F7WZ4M7sgp
         Ss4fykVNKCwtNz61/nlAGUE5RbGZCpX6LBkTVJlsK5T7EfHjYyHA1t3xc77d66/0DH5j
         NUS/EIzLHys/w0uFbzfNaxtVqhmu2HYUJ+Tch5NS7db9J4ZBCsfkn9dEnMQelTP6FgXn
         Lr1tfYfExc0YSzdKglVhPPVYHOFFbzfP4txMtbpNPp/otPAwnlYC094h+RrjYrD9rcVc
         AhuwiAUqH9poYfuP3DNWp10ZHdjOMwXJUyuM/y8V2guHt6eKA6jeNA4m25sqke81i1So
         H4yQ==
X-Gm-Message-State: AGi0PuZsjjTqgp3Enlyg9x8kFen/9lgqId4lQatHdmUc8JNLG39KBAYT
        iJ8AbLiVvLO8qkxeFgGs6n9NoXHhSoA=
X-Google-Smtp-Source: APiQypKJEiI6uNyk9igXxyQ44rJg0YHEUrpfNcqUYLMzdmWqXIB8iqao9XVuQeD6/q4aSovwsaibhA==
X-Received: by 2002:a2e:97d6:: with SMTP id m22mr993379ljj.245.1586289070326;
        Tue, 07 Apr 2020 12:51:10 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id l6sm12222088ljc.80.2020.04.07.12.51.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 12:51:09 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id j17so3337734lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 12:51:08 -0700 (PDT)
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr2416749lfo.152.1586289068320;
 Tue, 07 Apr 2020 12:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org>
In-Reply-To: <87blo45keg.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 12:50:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
Message-ID: <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 3:20 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> But fundamentally the only reason we need this information stable
> before the point of no return is so that we can return a nice error
> code to the process calling exec.  Instead of terminating the
> process with SIGSEGV.

I'd suggest doing it the other way around instead: let the thread that
does the security_setprocattr() die, since execve() is terminating
other threads anyway.

And the easy way to do that is to just make the rule be that anybody
who waits for this thing for write needs to use a killable wait.

So if the execve() got started earlier, and already took the cred lock
(whatever we'll call it) for reading, then zap_other_threads() will
take care of another thread doing setprocattr().

That sounds like a really simple model, no?

                Linus
