Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4222CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B03A20709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgENIhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:37:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59457 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgENIhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:37:45 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jZ9N6-0000Ln-N0; Thu, 14 May 2020 08:37:40 +0000
Date:   Thu, 14 May 2020 10:37:39 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ia64: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
Message-ID: <20200514083739.m2idxcxof4jyreck@wittgenstein>
References: <20200513204848.1208864-1-christian.brauner@ubuntu.com>
 <3908561D78D1C84285E8C5FCA982C28F7F6266E0@ORSMSX115.amr.corp.intel.com>
 <79e58d9b-5a39-390c-2f0c-0d87b63442b4@physik.fu-berlin.de>
 <20200514074606.vkc35syhdep23rzh@wittgenstein>
 <6b298416-1e64-eee7-0bb4-3b1f7f67adc6@physik.fu-berlin.de>
 <20200514075808.krdtypxpag4tfa74@wittgenstein>
 <917c9b03-cfd0-4bcf-d6a6-6aef7489b27b@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <917c9b03-cfd0-4bcf-d6a6-6aef7489b27b@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:24:25AM +0200, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 5/14/20 9:58 AM, Christian Brauner wrote:
> >> The machine also serves as a Debian buildd which is why it's a bit more
> >> busy than other servers.
> > 
> > Oh? Does it also produce Debian images for ia64 similar to what is done
> > for sparc64?
> 
> Yes, it's actually the same person who does this - me ;).

Well thank you very much. Thanks to this I was able to test my sparc
patches in qemu. :)

> 
> These images should work just fine:
> 
> > https://cdimage.debian.org/cdimage/ports/2020-04-19/

Oh I didn't find these images when searching for them. They would be
super helpful but there's no qemu for ia64 anymore that's useable. I had
tried building qemu from an old source based on a gsoc project for an
ia64 port but that turned out to be more involved than writing ia64
assembly itself. :)

> 
> The latest snapshot is currently broken due to a regression in initramfs-tools.
> 
> >>>> As for getting a working cross-compiler for ia64 in Debian, this has
> >>>> been on my TODO list for a while now. Building a cross-compiler for
> >>>> ia64 is a bit more tricky due to it's dependency on the external
> >>>> libunwind.
> >>>
> >>> I hit that roadblock as well but yeah, a cross-compiler would be
> >>> helpful.
> >>
> >> It's not difficult, it's just a bit of annoying package work including
> >> some trial and error testing.
> >>
> >> Once the cross-compiler is in Debian, it will be available in Ubuntu as well.
> > 
> > Would that based on a recent gcc? I vaguely remember a post somwhere
> > that gcc 10 or 11 was planning to drop support for ia64?
> 
> Yes, that would be the latest gcc. There are no plans at the moment to
> drop ia64 from gcc as the backend is already ported to MODE_CC.
> 
> m68k was on the brink of being removed, but I started a Bountysource campaign
> to convert it from cc0 to MODE_CC and it was eventually saved ;).
> 
> > https://www.bountysource.com/issues/80706251-m68k-convert-the-backend-to-mode_cc-so-it-can-be-kept-in-future-releases

Oh that's pretty neat. Thanks!
Christian
