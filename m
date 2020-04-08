Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3F0C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A6720769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586363710;
	bh=0FUd0nDLgV5A9Q0ni69sjMnr8zeDE1GZpILQuG4nebY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=efrSOwQcsegkEhxlug+DuzKAkhoeaddBPo0HaGUO0MQrpA7M6ygD09smm7V0jTOkU
	 gNY1dLLuJQpv40ec2TgqEYYxf/mJ6TCY9jACn0yhspQh/9d/4igxb6e9dwJ1CKrNWh
	 EoW1VknrLuhZVvbBs1qEfeDI6lE8zsBvcqhMzxus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgDHQfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:35:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44306 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgDHQfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:35:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id z26so4201240ljz.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29SKUXTwJN3v/j3/R0A3kj/FiH8JxJ//hjcnQffrrsk=;
        b=AYcAqx9sJjb46kiIhmKp/bkK+AN68urLGSJcgXbEhs7x4N5gYzXeHWQXKXujsCAYWJ
         kotBA8nGDaWEn8jaVmRDCJHQPeOfYXV/3m5nYTZGULNm5wn9jI3WgMuQTjtS6dyz4lRh
         VQf1mBw/X8G//QKg4X1b2l4JmTpectUDekeXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29SKUXTwJN3v/j3/R0A3kj/FiH8JxJ//hjcnQffrrsk=;
        b=jHPRXEBIPAmcUXAw/mB3fFDgJrL4TEe1A0C+dsyX7Eqy4+pZIRM3N7ilkBEacX0k9o
         rFNkr9SZYhOBqJWx7WnPHwWr7G+xgm/wE471BdG1/734K38SZ5Sv9V7hk7FYydNVXPma
         Xy+UCylrkyfEXWtft+fa6t7snxL/XYpei97ZxjnTEs5eljizYHJIP8Ag0RHbj7Y2obZb
         /fKIwRkdUYbDIXsivqEbxr94ZwA9KualUFnJHyByhglEyVJBMyw9eJ7SszOZOkWjhl4X
         q0Y+9S2zyk2tHfQUiyIpNX4WuLatzkGOIke8by/kH31N0dkWz2MbnId/Ni79pBFa7826
         uz0g==
X-Gm-Message-State: AGi0PubUa+jnKbbTPYq1Me4zjG5REPpw6DPIOwsEe7CO2CTSLABAClpP
        McQZv+/mq/lwa1XTwYnwtt4H76kKt3k=
X-Google-Smtp-Source: APiQypLsU1lvpTo0eBtA8to34mP6LW6RXDzY8pc1V7PWrJWEkzTKrTxIU5AME2pYtF5ck//+hM29DQ==
X-Received: by 2002:a2e:9655:: with SMTP id z21mr427743ljh.122.1586363705686;
        Wed, 08 Apr 2020 09:35:05 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id v21sm17044617lji.81.2020.04.08.09.35.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 09:35:04 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id r17so5636342lff.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:35:03 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr5203163lfk.30.1586363703395;
 Wed, 08 Apr 2020 09:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org> <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org>
In-Reply-To: <87v9maxb5q.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Apr 2020 09:34:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
Message-ID: <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
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

On Wed, Apr 8, 2020 at 8:17 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Yes.  I missed the fact that we could take the lock killable.
> We still unfortunately have the deadlock with ptrace.

That, I feel, is similarly trivial.

Again, anybody who takes the lock for writing should just do so
killably. So you have three cases:

 - ptrace wins the race and gets the lock.

   Fine, the execve will wait until afterwards.

 - ptrace loses the race and is not a thread with execve.

   Fine, the execve() won, and the ptrace will wait until after execve.

 - ptrace loses the race and is a thread with execve.

   Fine, the execve() will kill the thing in dethread() and the ptrace
thread will release the lock and die.

So all three cases are fine, and none of them have any behavioral
differences (as mentioned, the killing is "invisible" to users since
it's fundamentally a race, and you can consider the kill to have
happened before the ptrace started).

> It might be simpler to make whichever lock we are dealing with per
> task_struct instead of per signal_struct.  Then we don't even have to
> think about what de_thread does or if the lock is taken killable.

Well, yes, but I think the dethread behavior of killing threads is
required anyway, so..

> I keep wondering if we could do something similar to vfork.  That is
> allocate an new task_struct and fully set it up for the post exec
> process, and then make it visible under tasklist_lock.  Finally we could
> free the old process.
>
> That would appear as if everything happened atomically from
> the point of view of the rest of the kernel.

I do think that would have been a lovely design originally, and would
avoid a lot of things. So "execve()" would basically look like an exit
and a thread creation with the same pid (without the SIGCHILD to the
parent, obviously)

That would also naturally handle the "flush pending signals" etc issues.

The fact that we created a whole new mm-struct ended up fixing a lot
of problems (even if it was painful to do). This might be similar.

But it's not what we've ever done, and I do suspect you'd run into a
lot of odd small special cases if we were to try to do it now.

So I think it's simpler to just start making the "cred lock waiters
have to be killable" rule. It's not like that's a very complex rule.

              Linus
