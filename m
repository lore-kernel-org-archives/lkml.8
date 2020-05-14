Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83B1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92500206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgENJ5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:57:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33408 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgENJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:57:35 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jZAcJ-0006FD-Eb; Thu, 14 May 2020 09:57:27 +0000
Date:   Thu, 14 May 2020 11:57:26 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ia64: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
Message-ID: <20200514095726.k6k33gzldmjc6ev5@wittgenstein>
References: <20200513204848.1208864-1-christian.brauner@ubuntu.com>
 <3908561D78D1C84285E8C5FCA982C28F7F6266E0@ORSMSX115.amr.corp.intel.com>
 <79e58d9b-5a39-390c-2f0c-0d87b63442b4@physik.fu-berlin.de>
 <20200514074606.vkc35syhdep23rzh@wittgenstein>
 <20200514085801.uolf4amd3bd2aw7m@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200514085801.uolf4amd3bd2aw7m@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:58:01AM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-05-14 09:46:06 [+0200], Christian Brauner wrote:
> > > As for getting a working cross-compiler for ia64 in Debian, this has
> > > been on my TODO list for a while now. Building a cross-compiler for
> > > ia64 is a bit more tricky due to it's dependency on the external
> > > libunwind.
> > 
> > I hit that roadblock as well but yeah, a cross-compiler would be
> > helpful.
> 
> There is
>    https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> and I used the ia64 compiler from there while compile testing patches
> for ia64.

Excellent, I've got it to compile on my system now. Let's see if it
succeeds!
Just a way to boot it afterwards would be great.

Christian
