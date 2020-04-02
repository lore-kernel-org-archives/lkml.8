Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E264C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BB02077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585857193;
	bh=6Xn17RJrxBwDV9PO4+7DMeXSMbnkd9AcHEncWBQm1tQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KY6/x1gYrNo74zz1iS1tQ37qmpNtf0rMR1sTtlHx3luGm+YpvnD541t3C0dPSNa00
	 4FVnN1ni4IaMbTDD5U2yvBEa5v6TTwEvVYQtVzW4v/p+bI94DStY4bD92RABtixesc
	 URF3eRYzQ2H4SuzmF0ZmGzoF3tFuAP9BfgpgNaOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbgDBTxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:53:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43005 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgDBTxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:53:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so4534732ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1M4Ag+S0nZJij93THMq7bbkrnw/fgLQVfhHEAPg0zJg=;
        b=C3f5PUXk+JZIZCZcNR0ar1vubzZ5yFkVQ8SIF5yLetsxkbpN4qR9j+r642h2EHOVcp
         Zhp+esPwciqbodVQcDiIbMK1aUHC7IR7Zor/6HqPjnXt4wzG439ETqAuwfeIUqpkEqDx
         f5mlJ9AKWuYcxkphaEsikpSSNS5RgS4z/p36Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1M4Ag+S0nZJij93THMq7bbkrnw/fgLQVfhHEAPg0zJg=;
        b=nc6nLeZU7fjWPZx+NxGHPC7A4BCOgAWFGW3tt2QD58I1DSuDX1hqzmZpwp3rXEr5mp
         dJ/55w5VUr/BoHvThgXLtWohM4XCWqx0zeI8qRuFtjitj6MMw9IIjS8zx8RX+n5JNrLs
         yj3Nu134xT7ma68Fw31SY2a+VS4kaDJME+vm48J1uB0obUr+cDH4i7iXP2bGXSvjI+Ni
         CmZuFKwUxqGskJkYsusKMz9D+JQIOlyWLOXxUG4k3exFYjaCLzUcia0IFCGtFNX2KD8I
         tL1shvlk43s2QOJDNz41adDPZ8+fNUE1cLfFOFvPHssWP/BzEmklnBHTgvBPuJHoqOp/
         dzeA==
X-Gm-Message-State: AGi0PuYQfBd0D8vqFX7/c0UEkhDwhgDik+FtLj1sP8vbAPGbXzA4uGGL
        y4khxdWsy0QYnMt4jH8EfmM/VmobIA0=
X-Google-Smtp-Source: APiQypITI+bTxmZOe2u/VGzYTdo1PlgTowUF70/B4CbxuiUv2JzHk1eAjs5MrBXHqaD5GT0Zv6X7Sg==
X-Received: by 2002:a2e:914b:: with SMTP id q11mr2872557ljg.291.1585857188566;
        Thu, 02 Apr 2020 12:53:08 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y26sm4502490lfl.95.2020.04.02.12.53.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 12:53:07 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id k21so4628160ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 12:53:07 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr2700792ljc.209.1585857186793;
 Thu, 02 Apr 2020 12:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 12:52:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
Message-ID: <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 12:31 PM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>
> This is at least what is my impression how the existing mutexes are used,
> a mutex called "cred_guard_mutex" is a not very good self explaining name,
> in my opinion, it is totally unclear what it does "guard", and why.

Oh, I absolutely agree that cred_guard_mutex is a horrible lock.

It actually _used_ to be a lot more understandable, and the name used
to make more sense in the context it was used.

See commit

  a2a8474c3fff ("exec: do not sleep in TASK_TRACED under ->cred_guard_mutex")

for when it changed from "somewhat understandable" to "really hard to follow".

Don't get me wrong - that commit has a very good reason for it, but it
does make the locking really hard to understand.

It all used to be in one function - do_execve() - and it was holding
the lock over a fairly obvious range, starting at

    bprm->cred = prepare_exec_creds();

and ending at basically "we're done with execve()".

So basically, cred_guard_mutex ends up being the thing that is held
all the way from the "before execve looks at the old creds" to "execve
is done, and has changed the creds".

The reason it's needed is exactly that there are some nasty situations
where execve() itself does things with creds to determine that the new
creds are ok. And it uses the old creds to do that, but it also uses
the task->flags and task->ptrace.

So think of cred_guard_mutex as a lock around not just the creds, but
the combination of creds and the task flags/ptrace.

Anybody who changes the task ptrace setting needs to serialize with
execve(). Or anybody who tests for "dumpable()", for example.

If *all* you care about is just the creds, then you don't need it.
It's really only users that do more checks than just credentials.
"dumpable()" is I think the common one.

And that's why cred_guard_mutex has that big range - it starts when we
read the original creds (because it will use those creds to determine
how the *new* creds will affect dumpability etc), and it ends when it
has updated not only to the new creds, but it has set all those other
flags too.

So I'm not at all against splitting the lock up, and trying to make it
more directed and specific.

My complaints were about how the new lock wasn't much better. It was
still completely incomprehensible, the conditional unlocking was hard
to follow, and it really wasn't obvious that the converted users were
fine.

See?

               Linus
