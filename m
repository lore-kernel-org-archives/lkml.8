Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C6C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B3A20769
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586453788;
	bh=wHv8k6NIp3Eu0VU6JI00pYehpqbT9i9siGywgQHrCkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xRnQPeiGefot+pX5O5tdlJIsIjM7Fy9Wh3B6FvQyjmAm0HPBGM3SK4DDD1UbP4Gb6
	 9hX+bTl02piZciIoxy/8WuAL3MM9LPkfHwS7PFJJUcb69PkRFUCI/Yc2ExXYa34sUi
	 1I0UZdr9VMBBXVAC8/mwUSJhlsrRCpGMkgQr4O8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDIRg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:36:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36766 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDIRg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:36:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id w145so283602lff.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drFY0cI76YFL+D475SkoScTlV6DBcXax20dn7m+LW8M=;
        b=Njj3turU8V3Xh++Y8IkIN2C4y8WaBrdM2z4B1lfdk+QEuMhjsO+WVk2peac8Pc5M/2
         8xQZfqy/GSdEhX5Q6l3oSJtgUecn84A+WXplS76nOV+kWCzsTudyejT+yCPNS4zLXDuq
         0Gm7DPM6I/TLIao5CwvpmMnXH94Ba9DOy4PfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drFY0cI76YFL+D475SkoScTlV6DBcXax20dn7m+LW8M=;
        b=o9GJo5lwOyYcw4L0jAWWAQ0aXWAseWgPj4+/oiVwOtNTUkfRogkuk8YEVeeFrN7wNE
         bPHFYVVirOvujRRW6QnG10Pj+XYXUwZ8CixgbueLPSUzEAXS13LxSwte11eJFLcovA33
         uYh1WkUdbZjFnA9FgItWjyGA09kbXZT1gglXXmqZpMI4D8gmVgbbtu2PFtJcRj5dnox6
         L9pMe04+SmaglEuE7uV4B1BhcjcNm6ocmNC9IGyP3LQGhGSyke+DCk3JtSA2x1kIMIWB
         D+EhyVXAr2Njff/oSpQcbkrOVDyEc1MCqcXb6E2h0nbTbA7kAELsmnIPCQ2VxBvIjUyZ
         83kg==
X-Gm-Message-State: AGi0PuanEPktYLdE1Y4DFRrx6A5ZwZxBqeL4PoC5+3CYwcsGbGa/6bB0
        oNONxgW7CrxcR67spvSDJii3lHP8+2w=
X-Google-Smtp-Source: APiQypLWK5XwZGPMsiU13tRfUsyX9ViHtO54aVbJCU/l1KIscPR+EW9PT6nI1UhCI4V9sHTSEq4SnQ==
X-Received: by 2002:a19:c3c5:: with SMTP id t188mr225408lff.199.1586453785009;
        Thu, 09 Apr 2020 10:36:25 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id o16sm16405840ljp.53.2020.04.09.10.36.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 10:36:24 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id n17so536022lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:36:23 -0700 (PDT)
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr520029ljp.241.1586453783326;
 Thu, 09 Apr 2020 10:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org> <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org> <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org> <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
 <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com> <87wo6or3pg.fsf@x220.int.ebiederm.org>
In-Reply-To: <87wo6or3pg.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 10:36:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB762bDtiNZJ8KcRSkapOv3VUZbzyCvAt-8tSMWhR1DA@mail.gmail.com>
Message-ID: <CAHk-=wiB762bDtiNZJ8KcRSkapOv3VUZbzyCvAt-8tSMWhR1DA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 10:06 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> a) We must stop in PTRACE_EVENT_EXIT during exec or userspace *breaks*.
>
>    Those are the defined semantics and I believe it is something
>    as common as strace that depends on them.

Don't be silly.

Of course we must stop IF THE TRACER IS ACTUALLY TRACING US.

But that's simply not the case. The deadlock case is where the tracer
is going through an execve, and the tracing thread is being killed.

Claiming that "user space breaks" is garbage. User space cannot care.
In fact, it's broken right now because it deadlocks, but it deadlocks
becvause that code waits for absolutely no good reason.

> b) Even if we added a test for our ptrace parent blocking in a ptrace
>    attach of an ongoing exec, it still wouldn't help.
>
>    That ptrace attach could legitimately come after the thread in
>    question has stopped and notified it's parent it is stopped.

What?

The whole point is that the tracer _is_ the thing going through
execve(), which is why you get the deadlock in the first place.

You make no sense.

If the tracer is somebody else, we wouldn't be deadlocking. We'd just
be tracing.

I really don't understand your arguments against my patch. They seem
entirely nonsensical. Are we speaking past each other some way?

                   Linus
