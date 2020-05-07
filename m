Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186A0C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002AB2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgEGHMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:12:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40474 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgEGHMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:12:24 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jWah6-0000SK-DG; Thu, 07 May 2020 07:11:44 +0000
Date:   Thu, 7 May 2020 09:11:43 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jan Stancek <jstancek@redhat.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Christian Kellner <christian@kellner.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Ingo Molnar <mingo@kernel.org>, Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH] clone: only use lower 32 flag bits
Message-ID: <20200507071143.b4xp6jeqvsglzjmx@wittgenstein>
References: <20200505174446.204918-1-christian.brauner@ubuntu.com>
 <aa9e029703e184a56bcab9f0992cfff316136d16.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa9e029703e184a56bcab9f0992cfff316136d16.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:06:10PM -0700, Joe Perches wrote:
> On Tue, 2020-05-05 at 19:44 +0200, Christian Brauner wrote:
> > Jan reported an issue where an interaction between sign-extending clone's
> > flag argument on ppc64le and the new CLONE_INTO_CGROUP feature causes
> > clone() to consistently fail with EBADF.
> []
> > Let's fix this by always capping the upper 32 bits for the legacy clone()
> > syscall. This ensures that we can't reach clone3() only features by
> > accident via legacy clone as with the sign extension case and also that
> > legacy clone() works exactly like before, i.e. ignoring any unknown flags.
> > This solution risks no regressions and is also pretty clean.
> > 
> > I've chosen u32 and not unsigned int to visually indicate that we're
> > capping this to 32 bits.
> 
> Perhaps use the lower_32_bits macro?

Oh neat, I wasn't aware of this helper since there are no users under
kernel/*

Christian
