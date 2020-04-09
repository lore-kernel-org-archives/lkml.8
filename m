Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EF9C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB3320730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586465814;
	bh=FBMWmb9p9rL4CgCUxYg6eSlSd2wCSC/e4pjROnOE71I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0cJVBStdbjZ2vzugwRgF/l7dzF+jCrOaOSytHeyOacKncyx2rAyBuX86DOUE34u12
	 5b0bNpyjeRodYqazaE0xqNiX0lqQBWxPfBYUYHi98g0Eo8w0mWzGuoxMHl4WTFaT7p
	 +0wXkYarpEgTwdr6JYIG26DmnjMecKp+QzSZMRBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgDIU4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:56:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37969 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDIU4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:56:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id l11so725015lfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 13:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iXvIdYpMMdaZcrY8CYi0zKhJsLjYjxYUyiUwCPLGBw=;
        b=SKppsqnUWK53xq5DHVmd18JZLjvCv8Z986IJdsmvF/UoFOuqJlDFIhVw04DPuQIU1Z
         LAH0kLb4IbF7ynM8iL0uL3mwEpmOpBgWVbpSeh44ffmyIV/SINa/6aI5owY6Ivok45MC
         UvfMNCV3QoEUyaqfrTp9VXbm3NAlq3mnJMhv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iXvIdYpMMdaZcrY8CYi0zKhJsLjYjxYUyiUwCPLGBw=;
        b=EKfePRJM5UKfeFfg+BeUElppq/GcdXeubG8j0rxNR570+fAmEuvWfCxCyITrFxPTpl
         UYavFedDghbu/dlt/tXcvaOP2FAMofdptL9ZirMv3ghJG24kB0mwZemFg0nlRBnyivNn
         N4lyV659xJYnryGEFcRIzDirBQifnFVNrNNo3EL2LHjr4lP1bPjCvae1AMXgiiUbrql6
         +t7comExluDTJK5F/z19arZ9ChBn+2+9xXLEhrjd2z6udAc681uv1Mg8m1y4dBYozQkU
         3/raLPN5/Xq8B4UCOKSnWn2yqKTDXCB6bZgZb53hdEtYWED5uerYRZm+FmBS9wmFEg6c
         iPvA==
X-Gm-Message-State: AGi0Pub0qvyEE5evRNlWK5aP693e8miITz5P4U/PCGUR70Lyi0hUJDMy
        5ibozpdVBvzexY3IfqWKRQGjCD+KZp0=
X-Google-Smtp-Source: APiQypI4UfpBooAYOOPRdJPKFhD/t59ThG0zkVfyj9AW8oqAlodivJenliWc9UJMoW/TrzvPo5sIKw==
X-Received: by 2002:ac2:5c07:: with SMTP id r7mr689668lfp.160.1586465811046;
        Thu, 09 Apr 2020 13:56:51 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id p28sm282577ljn.24.2020.04.09.13.56.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 13:56:48 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id r7so1141420ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 13:56:48 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr934145ljc.209.1586465808087;
 Thu, 09 Apr 2020 13:56:48 -0700 (PDT)
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
 <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
 <87wo6or3pg.fsf@x220.int.ebiederm.org> <CAHk-=wiB762bDtiNZJ8KcRSkapOv3VUZbzyCvAt-8tSMWhR1DA@mail.gmail.com>
 <871rowpfe5.fsf@x220.int.ebiederm.org>
In-Reply-To: <871rowpfe5.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 13:56:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDm68i2sT3xNm-JdwmqAYzeQHTDZzEzm-NLfo_i38YBg@mail.gmail.com>
Message-ID: <CAHk-=wiDm68i2sT3xNm-JdwmqAYzeQHTDZzEzm-NLfo_i38YBg@mail.gmail.com>
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

On Thu, Apr 9, 2020 at 1:37 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Since they are all waiting for each other that loop is a deadlock.

No.

That's just a user bug. It's not a deadlock for the kernel.

The fact that you guys kept calling it a deadlock was what confused me
and made me think you were talking about something much more
fundamental (like the same thread trying to take the lock recursively
- *THAT* is a deadlock).

There are lots of easier ways to make people wait for each other. This
is a trivial one:

  #include <unistd.h>

  int main(void)
  {
        int fd[2];
        char buffer[1];

        pipe(fd);
        fork();
        read(fd[0], buffer, sizeof(buffer));
        write(fd[1], buffer, sizeof(buffer));
  }

where you have two readers that both wait for each other to write.

As far as the kernel is concerned, it's not a deadlock. It's just a
user space bug.

The exact same thing is true here. The user space was buggy, and set
it up so that both sides of two processes were just waiting for the
other side to do something that they never did.

And exactly like the reads, it's not a kernel bug.

Now, I do agree that from a QoI standpoint, it's annoying when
ptrace() just stops like that, particularly when you want to use
ptrace for debugging. So I'm not dismissing trying to improve on
interfaces, but I think you've confused things by calling this a
deadlock and thinking that it's a kernel bug.

The kernel never tries to figure out "Oh, stupid users are waiting for
each other". Sure, file locking has the special circular locking
detection, but that's literally a special case. The normal semantics
are that you give users rope. If users make a noose of the rope and
then trip on it, that's _their_ problem, not the kernels.

            Linus
