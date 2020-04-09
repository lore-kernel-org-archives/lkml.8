Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A54C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C39320771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586448961;
	bh=6LS46W2TzoLE1O4k8wnCyqNIbJcGM/Dx+HEnC+5kpAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZXL+ILEATPjbSOTwmaPM+tB9EAaDlwzQD/MOcRSzrhQrvRxuqY0uLzgV+I1dexkAp
	 mEx9NskjLtIU1qOKeozq66Kk5HGKEpMcIuG06d9vtA2t1ZY4BrXBqROya4zZpUiwat
	 /TeMO5LBo+KDgkfnUI4GSXMVvj5jdL8lxN1ESDkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgDIQP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:15:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41111 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgDIQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:15:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id z23so59836lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RbDQfT4mgxhb/9iMDJEsy+2/VqmlYknMsSAco0t5hrY=;
        b=dS3fIwTXf8LEsRZ6uN/uEIscofMTWcfi0maH/SslITya1R3AO2hUXiUHiDBwawvRg5
         YP0GaiPojkCP1gqt+xZ/eATYoxB0p8j+zS7m97MnphuQF3+VtOM/8/B7V7FycK9iyd05
         VSmcGDyJGyo9mJ7JYP+4IzLj1DsToi46/S49I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RbDQfT4mgxhb/9iMDJEsy+2/VqmlYknMsSAco0t5hrY=;
        b=jaHuqYwc3lHSNHxOO+VEiqdx6WuM1hgNuwKIkuTh1P+kv2LykDAUJWObSYkSDr4/Gc
         mB5JtMngxng/pEeP1KZoW5JNyqQ5nxkfsw5qanl+QSD4zFn2ISeD7r6xcZ+X/c2xgcI/
         QQtH5AZlpZVLFWSp9eglnpSsa5bNd6jDGGRkzmzljDUQPKIwrwT1jrkq1VOgTYxgsRAJ
         fw9luACjuh+3836vZCtUkFs+2RcaMVjgN37zCP++YVIqZ9q1HnM+zhmMSrk55scxAViW
         +pvI9vTIQoAKGomANOM1Lh6jW10RlOFsqDNselVzD4gaFtUedOlQ8LhDnZCRSIRVl+bL
         hUIg==
X-Gm-Message-State: AGi0PuZHHQkOlRMJAfuS8rkCtcSQWa2G7BPH28w1QnNF5yK4e8q6WlPQ
        1Xvpli6bcJSw8s+fE1E1qJubSPYHFTU=
X-Google-Smtp-Source: APiQypLl52k8XfZ6vpxmrbHgfV5wcyb+r0LzIwdjbXFQ2oFfXJRcTlzJ3klZsce7e30ikHJDaW+Fdw==
X-Received: by 2002:ac2:43b1:: with SMTP id t17mr31152lfl.9.1586448955824;
        Thu, 09 Apr 2020 09:15:55 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u7sm10039884lfu.3.2020.04.09.09.15.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 09:15:54 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id n17so240912lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 09:15:54 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr319121ljj.265.1586448953804;
 Thu, 09 Apr 2020 09:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org> <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org> <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org>
In-Reply-To: <87y2r4so3i.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 09:15:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
Message-ID: <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
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

On Thu, Apr 9, 2020 at 8:01 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> When a thread going about it's ordinary business receives the SIGKILL
> from de_thread the thread changes course and finds it's way to do_exit.
> In do_exit the thread calls ptrace_event(PTRACE_EVENT_EXIT, ...) and
> blocks waiting for the tracer to let it continue.

Hah.

That code isn't _supposed_ to block.

may_ptrace_stop() is supposed to stop the blocking exactly so that it
doesn't deadlock.

I wonder why that doesn't work..

[ Goes and look ]

Oh. I see.

That ptrace_may_stop() only ever considered core-dumping, not execve().

But if _that_ is the reason for the deadlock, then it's trivially fixed.

Famous last words..

             Linus
