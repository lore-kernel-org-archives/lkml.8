Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8044BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59812207D4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE2IAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:00:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35365 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE2IAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:00:14 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jeZvx-0003yc-KM; Fri, 29 May 2020 08:00:05 +0000
Date:   Fri, 29 May 2020 10:00:04 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Robert Sesek <rsesek@google.com>, Chris Palmer <palmer@google.com>,
        Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 1/2] seccomp: notify user trap about unused filter
Message-ID: <20200529080004.6lb6w4oi3nvatzdf@wittgenstein>
References: <20200528151412.265444-1-christian.brauner@ubuntu.com>
 <202005281404.276641223F@keescook>
 <CAG48ez0k23qM2QEi42VTjCbnoY9_nfTH09B_Qr2zu+m3KWWUiQ@mail.gmail.com>
 <20200529075137.gkwclirogbe3ae2a@wittgenstein>
 <202005290055.D6E777A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005290055.D6E777A@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 12:56:50AM -0700, Kees Cook wrote:
> On Fri, May 29, 2020 at 09:51:37AM +0200, Christian Brauner wrote:
> > Aside from this being not an issue now, can we please not dump seccomp
> > filter contents in proc. That sounds terrible and what's the rationale,
> > libseccomp already let's you dump filter contents while loading and you
> > could ptrace it. But maybe I'm missing a giant need for this...
> 
> The use-case comes from Android wanting to audit seccomp filters at
> runtime. I think this is stalled until there is a good answer to "what
> are you going to audit for, and how, given raw BPF?"

Doing this in proc seems very suboptimal why isn't this simply an
extension to the seccomp syscall (passing in a struct with the target's
pid or pidfd for example) to identify the target? But yeah, if there's
no real audit strategy all of that seems weird.

Christian
