Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E06C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5918720659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586115392;
	bh=wwwU7AKjQhJuMCN/DMQpCeuXbMLGbJ7GdVZ5T69Ztfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1ych+MGbKoomMfZiVOn6BqJ2wi3g5kxNvgb22n6DfwzViWLTmMzhZHOzDYE/TA0rj
	 rMrpS6/DLV0YhtQkF+GCZwU1QIRLTZBaIO4rJcSwdNWSRVyMHFGxurX9+sQuUvgMJg
	 7eKR7YiALrKdJ4L/4Dlyl20IMpGwQQbtbfrp0wOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgDETgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:36:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40667 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgDETgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:36:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id 19so12350911ljj.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McxNvBKCZ6JPN08OgrptO9lPEWVuANGL5JPQo1cYmzU=;
        b=cWkloafk1u9C1dM2sB8E6IvHCliy8gXmxKWFFWXfSHYohaUGzpNRNlEVHifOqRDSvo
         OosYIkcsU9H/hl2tIwQEUOs+onByylg6uy1RPOA/u2zjbBFMk3dVPXtThJGR/ixUcaqh
         wMTmGospwPYmk9dn16WwABooWdUc/ALk9Sdcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McxNvBKCZ6JPN08OgrptO9lPEWVuANGL5JPQo1cYmzU=;
        b=rrO4Fv1c62EHpDY45WY26msKWV5HDyR1IOeburD6WI6e6t4zU+LS53AOQOmJwtj7j0
         oiI4Hq0+BvLsObcyxZ9ucTCao7+ZRQ39QasBd0q2Xyu3IK+cAFYB/USiOTmB0qkzkN3y
         y3KbXSMoJvKwgF89Noq5FnrXH9CBiMfhtVvqo7B/iCASO+lY2tQB7YrVTiO9k8+PA4Yn
         hd7Xiu5bneQATRjbuTrHPG2N/zIEsnRzp1CmN/0RtNnUrKOm5PXLun5NaerKUm+YhSyE
         pyV+YRFipC6TDr30CczRaGu5zwnZilo8QztlQ/ZXREN5i2SE7Cs/j6LNwAJSaurBnd3D
         6W2Q==
X-Gm-Message-State: AGi0Pua4LE5HOV3LbUVpFuZedX/NfMybcNP9YSxKmLaM/tbNjhmhybtI
        wQDYVXct5fSEs8wM88MlXVcHIkorKp0=
X-Google-Smtp-Source: APiQypJfyAYqRb7K3rw++QRKIqmL9mdhnQdEuqoKwLi8izd2ABEZozLpJssZp3cHM4t+fifipdD2Yg==
X-Received: by 2002:a2e:a554:: with SMTP id e20mr9801566ljn.88.1586115371530;
        Sun, 05 Apr 2020 12:36:11 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id q6sm8945664ljp.21.2020.04.05.12.36.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 12:36:10 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 131so9998218lfh.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 12:36:09 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr7701604lfd.10.1586115369481;
 Sun, 05 Apr 2020 12:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com> <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
 <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com> <86aa9fc6-6ac9-a0c2-3e1d-a602ef16d873@redhat.com>
 <CAHk-=wgOykL7cM34NraiNGsjJC5Uq6H0ybYHWhdXDSn-wzVXDQ@mail.gmail.com>
 <5c04cc6d-ec44-b840-071d-248ac81a0f91@redhat.com> <CAHk-=wgkE=qT6CSUJHfXNsyhW+=j4SVgxh2jEc8nWY_n3SFZ=w@mail.gmail.com>
 <AM6PR03MB517044AE8D005BB0BBB1EC98E4C40@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <AM6PR03MB5170135E51DBF9093346E1DDE4C50@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5170135E51DBF9093346E1DDE4C50@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Apr 2020 12:35:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbxavbe82MTKYn8_qasqw-9kC346Azo0bGy062w0bWGg@mail.gmail.com>
Message-ID: <CAHk-=wgbxavbe82MTKYn8_qasqw-9kC346Azo0bGy062w0bWGg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Waiman Long <longman@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 11:34 PM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>
> What really makes it impossible to write a multi-threaded strace program,
> is that *only* the tread that made PTRACE_ATTACH can do all the other
> PTRACE-APIs, but for a multi-treaded strace, any thread should be able
> to call PTRACE-APIs as long as we are in the same process.

I agree that the ptrace model is broken, and no, you can't do a
threaded ptrace the way things are now.

Some of that is really fundamental to how we do things (ie the ptracer
is the parent), and our data structures really make that be
per-thread.

I'm not sure how easy it would be to fix. Some of it is probably
really painful. For example, right now we know we can't race between
different pthread operations, because only the thread that did
PTRACE_ATTACH is allowed to do most of them.

So it could be very painful indeed to try to fix it so that you can do
threaded tracing. It woudl probably be a good thing to have, but it
might not be worth the pain.

Some daring person could try...

               Linus
