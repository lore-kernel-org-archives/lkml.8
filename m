Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB57C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9217C2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgE2POA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:14:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48225 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2POA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:14:00 -0400
Received: from [95.90.241.131] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jeghg-0002Po-3T; Fri, 29 May 2020 15:13:48 +0000
Date:   Fri, 29 May 2020 17:13:46 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: clone3: allow creation of time namespace with offset
Message-ID: <20200529151346.lpciwzfscf2tknoe@wittgenstein>
References: <20200317083043.226593-1-areber@redhat.com>
 <CAKgNAkip8nuFHCHEL2NUZXo91+8Q4w1zXKz4aFjj=TwXMuBxcA@mail.gmail.com>
 <20200529151029.GF254677@dcbz.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529151029.GF254677@dcbz.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 05:10:29PM +0200, Adrian Reber wrote:
> On Fri, May 29, 2020 at 02:26:13PM +0200, Michael Kerrisk (man-pages) wrote:
> > Hi Adrian,
> > 
> > If there was a revision to this patch, I missed it. Is there still a
> > plan to bring CLONE_NEWTIME to clone3()?
> 
> Good that you ask. The discussion ended at the point that we do not have
> a way to figure out what a syscall supports from user-space.  I talked a
> bit with Christian about it and he mentioned that there were some ideas
> floating around how to do that. At that point it made more sense to me
> to wait for such a solution to appear before continuing the clone3()
> time namespace work.

We need to have a little talk at ksummit about some aspects of syscall
design. I'm writing something up for this. But we're not in a rush
anyway, I take it.

Christian
