Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68271C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3701A2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585793182;
	bh=ImpUlUDrUArJuKgAgSF5lgzP27rAZ/C6ZUCwuYSkZ+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pNoRq6VkTz5AMcMzJfZNQG01kmPQ3LI8UhSAsQmYrY8fjQJVKN+hhOfnwsxHHRfM/
	 R1PRDOIVfOCYyVdsC2eHD0IDCNrt3rSZwlS4EeQtNyRA/mRcC5E5RImzkVEfggoAbk
	 oxEXq4nHNDTDvh67zx2O0pe6UmL+gVWq9HDtUkl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbgDBCGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:06:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37778 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgDBCGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:06:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so1415925lfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 19:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQMUHcx5ZJebHuFeNsiV5oTqPrmJdOW/j745+2PrxT0=;
        b=FEz92/cjgu/KjeUfKUAamLHbiMYZP/JE8iQyr8PNIMC5adYQCca21soCJysmTW8le/
         u+EmuDxNfwEIB6iFxacesqUbrDJuUXTQH1CifqeNvpd7zFcILB7eKw8/Qk1LJLcobXrc
         6HoPfDxgcA61kzOR0e4ZTAsOnzIaIrzLDUVEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQMUHcx5ZJebHuFeNsiV5oTqPrmJdOW/j745+2PrxT0=;
        b=My6juSl5ojOnkDKd3zJwLaDD4M9I+JVvx5vUirIBFH0Pq9GyUgL45dUSW7JMTzx2tI
         yWY81fd/EtApYEcfhKNJ/Q38NMLCN4c6l+zqnrWTQLxfVVeJnG/tqOyRQLcStrXpdKxK
         ckxbIA6N/dKL3PD5x0MnBiy4wEwSuIYZBTWqz4gCY8F6tz//gp5UfaZCzz+iU64Q9k6m
         XAOKpCiyIILDC2KcuTSedIlnm9BJbIxOtFvUi9wDZ1frTwzkB8rkxyvLbKXSgRGUj23Q
         eAXwb4ghSMr70yWkHCiUO02xshorEB+fTHM1FRbVQ8pKl7XPG8AW7ZgFiir+CJ+xEJ2e
         61Vg==
X-Gm-Message-State: AGi0PuaXpDingRa6mOLvCSZ9brkfw6XLH+vJoYak0LXmZaz+UcLL2q0C
        6mZ+6Z/vL/7cJSXfDvp71pu7+WBF6T0=
X-Google-Smtp-Source: APiQypJy7+sAoidIBF7Fft65uWwrJjp6ViDvh4e9Tk73w0O9t4Sv6znulmNeaRr0gGN7znBZmCp0wg==
X-Received: by 2002:a19:7e02:: with SMTP id z2mr633926lfc.112.1585793176945;
        Wed, 01 Apr 2020 19:06:16 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v22sm2191126ljc.79.2020.04.01.19.06.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 19:06:16 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id z23so1402586lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 19:06:15 -0700 (PDT)
X-Received: by 2002:a19:7f96:: with SMTP id a144mr643180lfd.31.1585793175190;
 Wed, 01 Apr 2020 19:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200324215049.GA3710@pi3.com.pl> <202003291528.730A329@keescook>
 <87zhbvlyq7.fsf_-_@x220.int.ebiederm.org> <CAG48ez3nYr7dj340Rk5-QbzhsFq0JTKPf2MvVJ1-oi1Zug1ftQ@mail.gmail.com>
 <CAHk-=wjz0LEi68oGJSQzZ--3JTFF+dX2yDaXDRKUpYxtBB=Zfw@mail.gmail.com>
 <CAHk-=wgM3qZeChs_1yFt8p8ye1pOaM_cX57BZ_0+qdEPcAiaCQ@mail.gmail.com> <CAG48ez1f82re_V=DzQuRHpy7wOWs1iixrah4GYYxngF1v-moZw@mail.gmail.com>
In-Reply-To: <CAG48ez1f82re_V=DzQuRHpy7wOWs1iixrah4GYYxngF1v-moZw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Apr 2020 19:05:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whks0iE1f=Ka0_vo2PYg774P7FA8Y30YrOdUBGRH-ch9A@mail.gmail.com>
Message-ID: <CAHk-=whks0iE1f=Ka0_vo2PYg774P7FA8Y30YrOdUBGRH-ch9A@mail.gmail.com>
Subject: Re: [PATCH] signal: Extend exec_id to 64bits
To:     Jann Horn <jannh@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Adam Zabrocki <pi3@pi3.com.pl>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 6:36 PM Jann Horn <jannh@google.com> wrote:
>
> Since the read is already protected by the tasklist_lock, an
> alternative might be to let the execve path also take that lock to
> protect the sequence number update,

No.

tasklist_lock is aboue the hottest lock there is in all of the kernel.

We're not doing stupid things for theoretical issues.

Stop this crazy argument.

A comment - sure. 64-bit atomics or very expensive locks? Not a chance.

                   Linus
