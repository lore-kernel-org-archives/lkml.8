Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ACBC43333
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B511220409
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N4LnSddq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgCRUyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:54:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44057 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgCRUyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:54:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id y24so2298142qtv.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hy5qm/HoUUr4+Nf3BF/DCL1M5z8PuuCJBXzeH7Xw+kY=;
        b=N4LnSddqyjrj35FEVCaWDHim03KW+ZMlw6qB2LGHay3tvrKmDKnOjhDE1BDP5LjjQ3
         FY6hM5XnjpfTcrJgfZwC9eNgRb2L0XbMHVXs32uIu9T7ragvkTHGOyNnU7Yf2eRdCJE4
         3I34Il+w8b2WlNqaNKTgy+Yz/V7aplf9yBmx8lUj/sa0pndkwQVgTed31zYlC/Jrht0t
         p52hIjkurSF/WCqgML1XoV0ubBQi5ua4ZdQ67Bb9l8CNm72Iph64ACpCtzJjzKqgCxTy
         XqZ9eOArX3AGMRBIKcOZIUimcnYMhYUpq4pe8Jxyj1zVeUKecaMY9CRKdllFXWrv3P6B
         ygcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hy5qm/HoUUr4+Nf3BF/DCL1M5z8PuuCJBXzeH7Xw+kY=;
        b=eUIdqXMd8c3do/q2CgUF33b2AjilWW+EahDaWA8NnyiHlnoxcFRUV+PEm//Z9jEo27
         Nu6I0RT3oXLwpeoHE5IqzBVREvA/5nJcoq9oJzWAiJHcD1GQoPhPecuxFY80z8nwE5/1
         Cl3CKBfzduxW25W+jZs7p17sgCcynnn2IDytwMPebeEUjkWmzpy6nwWW5R5/g3Gvczii
         5LbvSN5kfhp3Jn7twBVj8cCxS+Fzb4tpn38Ak0rfdpW1t+EV1ynsWX3/PrFZM7Zqevc6
         QQseA+7hRsEWFcMZ216cWuN6oZIBDUQIoSoekyGDLP7EefGzOQbE24ZI06PzgQ0UDNtG
         6wmg==
X-Gm-Message-State: ANhLgQ26eCTwi+aX5AMohAEj0v9mnRE3KEJFpZoq3kVO4aHORMfDYLh2
        +FgnoQffXYWmIHpFWt7emrRB4Zy2cWQBSMTPt/Y7qw==
X-Google-Smtp-Source: ADFU+vtmmSWS+aIMzUy5/s+2hhcAShSPdK7KLUDMp6FBmd1LA5Z7u8QejSBWyleiEI9eBwNGxK3e7ELqI7QZGMIbzUo=
X-Received: by 2002:aed:36a5:: with SMTP id f34mr6299431qtb.57.1584564859557;
 Wed, 18 Mar 2020 13:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ae2ab305a123f146@google.com>
In-Reply-To: <000000000000ae2ab305a123f146@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Mar 2020 21:54:07 +0100
Message-ID: <CACT4Y+a_d=5TNZth0dPov0B7tB5T9bAzWXBj1HjhXdn-=0KOOg@mail.gmail.com>
Subject: Re: linux-next build error (8)
To:     syzbot <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 5:57 PM syzbot
<syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    47780d78 Add linux-next specific files for 20200318
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14228745e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b68b7b89ad96c62a
> dashboard link: https://syzkaller.appspot.com/bug?extid=792dec47d693ccdc05a0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com
>
> kernel/rcu/tasks.h:1070:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?

+rcu maintainers

> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
