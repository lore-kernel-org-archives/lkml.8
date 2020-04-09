Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF2DC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DF6206F7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586457412;
	bh=HZ7E/aOqk4BoMCRfoqkcG3OlsmAeiq1kWXwqpUBpYP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Me3XQBTQYaMTSQTrxhTRi7HLQlhDDJp82nQog5vZ7Jd9B1oGe41geKSjgrPGM9i3P
	 tmoUlQfe5ik51eR4ESntlsYI5jfI8xi5Gyrc77sTwMld5JRzRGtCxyuXKtN2YzN66d
	 V+NUK+b217yIUEJ8kn4CiKur1eKVhjeP1Qqlw0Jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDISgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:36:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34853 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgDISgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:36:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id r17so431767lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/+se2UHgrfLQE0M/DBpN86UleQ7BkRzq/fVSWTmR4I=;
        b=Uk3vkLLnOL8XH6hpPhWCArhvSElp5DkPZZzfl19oy8vdkPSomq+LC2ORDEWY3tg5f7
         JWg1VC2w6K5RpT0TCfi+IeafFwg0poVjQ3qfy8Bf3l075rFYIX4vvPbLh/8hObqy/sPc
         s9QtrG5hqTX3HzcVkUn7y1E6VqDG3uEfihU2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/+se2UHgrfLQE0M/DBpN86UleQ7BkRzq/fVSWTmR4I=;
        b=OhZixVk6+Q979KwVy7aq9hLF+NOOQM8x08rhqfIpeZYHRQ1kcpff6QS7O0/unoMO9Z
         rIgiMxSL5k8i/vOUO2U62Xnd6D5Uqoprmkk4ekhhl5ny6kZHFfzNfLfVbYvNxUhWs1/l
         LvFVNzoCKD9HbuGOmMfMHX4seOSEEC+TK8GiEijxv307VnQKopJ+bUf8VnQjUxGI1Vgy
         etgHuHi/KPMwGbM2QB/h0EOEwK7zm7b9hsR3HSYCQWP2ITuGMykR1yN6v+1MHqv60Ts9
         3PYr2AkXVt1+C7Xg7Jbvo01XzhEwTBHIj5aJ1ReZQDgcqTZFCdRavKUFpyM3D1IeVJew
         bjfw==
X-Gm-Message-State: AGi0PuZcqpjq8/uMmSlTfMfQnMHAoDcazUN383hzjiIxrUpbUqDsV9Ds
        nX/ckoDT7xRGZ550pqcdczZpScj1Mto=
X-Google-Smtp-Source: APiQypKMQfZhmsvDNsVHW69OQ9GMHA5oULTEGffIP0ICMUKEV6A6tXmd87DH+Hvw6U7PVWonmeS0Ug==
X-Received: by 2002:ac2:4d10:: with SMTP id r16mr387094lfi.180.1586457408104;
        Thu, 09 Apr 2020 11:36:48 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id j22sm18335872lfg.96.2020.04.09.11.36.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 11:36:46 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id t17so720395ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 11:36:45 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr652422ljc.209.1586457405165;
 Thu, 09 Apr 2020 11:36:45 -0700 (PDT)
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
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com> <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 11:36:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
Message-ID: <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
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

On Thu, Apr 9, 2020 at 10:46 AM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>
> Test case 1/2 is working 2/2 is failing, deadlocking,
> I think even the time-out handler does not kill the dead-lock
> if I remember correctly.

Ok, I get

  [==========] Running 2 tests from 1 test cases.
  [ RUN      ] global.vmaccess
  [       OK ] global.vmaccess
  [ RUN      ] global.attach
  global.attach: Test terminated by timeout
  [     FAIL ] global.attach
  [==========] 1 / 2 tests passed.
  [  FAILED  ]

but reading that test it's not doing what I thought it was doing.

I thought it was doing the ptrace from within a thread. But it's doing
a proper fork() and doing the attach from the parent, just doing the
TRACEME from a thread that exits.

I guess I need to look at what that test is actually testing, because
it wasn't what I thought.

               Linus
