Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F554C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D678206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PwH8YjZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgGXRYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:24:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:52945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgGXRYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595611445;
        bh=CKyR8EMqxeOXVY/iOMNddyLu0IDddolO4j2t8BjxTkY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PwH8YjZtZl0FG2VXzt0NRxkf+yHG8ZnJjsMFJCDcy5drJtOK7YzmvviUy9Xn4/Pcm
         8ggOSOCFIGbBxdeO1yAbqZn5gaO2/LSnjWgtkFsoFqpL0jF8UXpE/lssCVtoRQZKxK
         yB0agzD+BrpSYEokV1+zZnRwQ1iG48XY0JeQicAI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmlXA-1khkQd24RS-00jpgg; Fri, 24
 Jul 2020 19:24:05 +0200
Date:   Fri, 24 Jul 2020 19:24:03 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/2] kernel/trace: Remove function callback casts
Message-ID: <20200724172403.GC3123@ubuntu>
References: <20200719155033.24201-1-oscar.carter@gmx.com>
 <20200719155033.24201-3-oscar.carter@gmx.com>
 <20200721140545.445f0258@oasis.local.home>
 <20200724161921.GA3123@ubuntu>
 <20200724123528.36ea9c9e@oasis.local.home>
 <20200724171418.GB3123@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724171418.GB3123@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:f286teVwMCObcAo1c+vNRctWHP3RuMXVbuBShTSuZg/kMkr9sgf
 g/pnMennfIcHSP/WROtDP9H8l+xTgIFdWyxKHjkmZZvCOxWoi6ZimtXAhPf/zD6IF/oAO3L
 fyBvqTR0VXVtNDH6ZXvqbq052+qrDnmzEnTryU6nEuQV21jpn8uRB9RYUb2/DAQ/z2gleAu
 fMG0/Ba93qgZ4tYsit/zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3l9mO4VbPNw=:K+2uWVyPPAP91pFroHuFd8
 yjNMolsXRIXRWhIXSkKHuSVAwI7pZ7ZUHJMuslnlJCluECZWYeCjujLJsWOgjIMuRVdxQ2o+0
 Qhk0yDqDbLK4dvciHEDYJ13up+TJbl9iW30utK4lrlMIYQr+TLpWTWssL/pYR4t/xApbazcjl
 rxtJU/N2Yjs12g8Oo9TDqKAvuvRRD3LW/qQ72LDS8Eeh60locDghuSArF2yRBjqh9UD+XpQ8i
 UbFzyS8DU1VS1NEg70zGblCCyaaNEafaiudfHdLQq4HD0ollm0G3ICQEXuEPslVofKJtUq4DJ
 i3BdRv7UiXN53kG4keuuV2cdOmtyozJf+ogz4qGJVm8iuhuWB48vdkf1MfnyEisEd77vWOpXK
 tojR6Upc/VG1sABsZf7TAWP35d84cKh690MvMnVL2IGN6m2PJ83WlTAJoXIWFJtT0ACsVSnfy
 J6u7pFV4O9xF4Lmdc6v6F31fC0GUohn9U2v6zTqqCIbyreSFvYCo4S9gP5biUg1zBZVx44qrl
 bY20xnZHE0vLSgAKvSVaLSoYtLXdaf1WHeQCaVYgeLPOYX2DbQS45CMIOW8QsdLsr9by+bAyS
 gLKMADoWB5M7dnK+M8voh587j7GSX19HM3MqiwiizPA1hsD+/+SPjvJ2de3FcL1E9KHbx+agT
 +purwlTS75/uVsi/rtNvdYlCzFpHSSabQcV0K9mhox62Tkz2VVJR8c63a1kXclRfg82TB1bxq
 q8H4+BP9+d+67mw2Zn2IncefoLerrLAWplvVxGgCKzl7221lnSnh7nh4wX/GjCkCpyxx0NlKA
 sMbiNhstB+xPHtDqRMhTF6XNRtixWKdd9vh7BJ0TDn/JmokXyAxLl1uueZYPhnn6mS02tpjmi
 w359qiq/JWW4Fofm7zmxXTyVo8Dppu0gRD21TUzGNgNgLx1yM/Z86z4mHSV1gLy4JGqwSrQ2c
 CG5A++yerWl+vl2vxWk8U/0UoDaZjUWi9zQIv3bmu7d0vMCogkkWT8wSUyWfo0grqZa6TTVTT
 qZlYs8QqxVw3Z4Vfpq7pPIw1NUuLr8kbFborNejS+6AHH7JUbFqXVz1hT9rrd2MlhGei9Fp0m
 HbZd9ZMpkaRMEr/JjGfvQXqI0ofdh9ajeZu+PnQSQUNKDaBQj8JwfLsJPmR3oFw6mLQxXm1Lz
 UI9p4IZj08M//DGhAqGJ7hQkRD1Zrsj5gC/xucK/ngLxuchrcupiZFXopHRChC81ZLj/hQuLR
 zcseIaZkrvYdIp5S/IlfJao+McrfL7NqcKW7Tnw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Fri, Jul 24, 2020 at 07:14:18PM +0200, Oscar Carter wrote:
> On Fri, Jul 24, 2020 at 12:35:28PM -0400, Steven Rostedt wrote:
> > On Fri, 24 Jul 2020 18:19:21 +0200
> > Oscar Carter <oscar.carter@gmx.com> wrote:
> >
> > > > The linker trick is far less intrusive, and I believe less error p=
rone.
> > >
> > > If we use the linker trick, the warning -Wcast-function-type dissape=
ars,
> > > but in a way that makes impossible to the compiler to get the necess=
ary
> > > info about function prototypes to insert the commented check. As far=
 I
> > > know, this linker trick (redirection of a function) is hidden for th=
e
> > > CFI build.
> > >
> > > So, in my opinion, the linker trick is not suitable if we want to pr=
otect
> > > the function pointers of the ftrace subsystem against an attack that
> > > modifiy the normal flow of the kernel.
> >
> > The linker trick should only affect architectures that don't implement
> > the needed features. I can make it so the linker trick is only applied
> > to those archs, and other archs that want more protection only need to
> > add these features to their architectures.
> >
> > It's much less intrusive than this patch.
>
> Sorry, but I don't understand your proposal. What features an arch need =
to
> add if want the CFI protection?

Typo correction.

Sorry, but I don't understand your proposal. What features does an arch ne=
ed
to add if want the CFI protection?

>
> >
> > -- Steve
>
Thanks,
Oscar Carter
