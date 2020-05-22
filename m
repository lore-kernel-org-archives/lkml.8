Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED1CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77805206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgEVNOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:14:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35245 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgEVNOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:14:01 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jc7Uq-00072T-CU; Fri, 22 May 2020 13:13:56 +0000
Date:   Fri, 22 May 2020 15:13:55 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Blecker <matthewb@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Mike Frysinger <vapier@google.com>,
        Christian Brauner <christian@brauner.io>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        vineethrp@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC] sched/headers: Fix sched_setattr userspace
 compilation issues
Message-ID: <20200522131355.f4bdc2f4h2zyqbku@wittgenstein>
References: <20200521155346.168413-1-joel@joelfernandes.org>
 <CAEXW_YTj83gO0STovrOuL9zgDwEYWRJusUZ3ebVw_jOG6yJxTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTj83gO0STovrOuL9zgDwEYWRJusUZ3ebVw_jOG6yJxTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:55:21AM -0400, Joel Fernandes wrote:
> On Thu, May 21, 2020 at 11:53 AM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > On a modern Linux distro, compiling the following program fails:
> >  #include<stdlib.h>
> >  #include<stdint.h>
> >  #include<pthread.h>
> >  #include<linux/sched/types.h>
> >
> >  void main() {
> >          struct sched_attr sa;
> >
> >          return;
> >  }
> >
> > with:
> > /usr/include/linux/sched/types.h:8:8: \
> >                         error: redefinition of ‘struct sched_param’
> >     8 | struct sched_param {
> >       |        ^~~~~~~~~~~
> > In file included from /usr/include/x86_64-linux-gnu/bits/sched.h:74,
> >                  from /usr/include/sched.h:43,
> >                  from /usr/include/pthread.h:23,
> >                  from /tmp/s.c:4:
> > /usr/include/x86_64-linux-gnu/bits/types/struct_sched_param.h:23:8:
> > note: originally defined here
> >    23 | struct sched_param
> >       |        ^~~~~~~~~~~
> >
> > This is also causing a problem on using sched_attr Chrome. The issue is
> > sched_param is already provided by glibc.
> >
> > Guard the kernel's UAPI definition of sched_param with __KERNEL__ so
> > that userspace can compile.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> If it is more preferable, another option is to move sched_param to
> include/linux/sched/types.h

Might it be worth Ccing libc-alpha here? Seems like one of those classic
header conflicts.

Christian
