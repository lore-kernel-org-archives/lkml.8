Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C793CC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932F02467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPshY4hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgBTTJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:09:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42112 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgBTTJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:09:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so2368603pfz.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 11:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mrly7V6dbK4/Jt5t8XEVPETkT0pUle6CTcq6TpnuQrY=;
        b=IPshY4hqjse+pKEEI64mtIXT+GcH+gZXttEziLebKETysKzKNKeAPeRll/PfP0L1q5
         VHLc8LuPG2ziNY3dpzCbSu0Mvapau8iesqn57d/DmS7TZdJDpQ4aphyPPQRTVymRpX05
         RSSXHv+ebRQjR2RYJj3o31NgT/c3wHdWNSl9xIz6He6BJ1KqiTN3aRXoJIrPALBNVoHW
         gI0Fe9aQN/fYLqMfZCvZBQB2Yib9ibwofpnPgh6BoaZgRmydkzCP/12/riN0+rStJcRa
         Od75X1LGzRlKkntFeyqgwqM0SYY6d9vstDEpcDPM32/Ht1FMfBPRwJjQxrnKYBx3Wgjk
         Amtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mrly7V6dbK4/Jt5t8XEVPETkT0pUle6CTcq6TpnuQrY=;
        b=GapRZv4sJCdkEZg/rNYMPe6xHB3Adh+2qcNpnlAaE9RDSAaOaDnz5ukrMWQhVRti+r
         ah4UhIx1az1fgU00d5yGW1pPX+QxiTieRIwlIESRmTiAE8y6j0zVDHW+kAOTJkn31++1
         KYR2Nw6jR5feaPCvCNBH64B1cHYmeaGuoMSDa9ttkOHMcObyeWlH3wIoFPEhZoxRJ7VF
         adic5OsMvPuQi20MxeiG/wylUYTat6QjrvTFMRy61Eng6UaN6Dl/GLVKhCrCC8KdcB1z
         jpe5xvy7dycyshPNuQCjCPphtZZxijnV7KsQbiFBcxCsJ5wXhcoqAtKR6i3thmUyql2G
         KgtQ==
X-Gm-Message-State: APjAAAXmp+oPezq2mpIaZ1kM6jKnUoklQUjf89xHNP8bIAZvHVsTfaEH
        bhoUIU/vLH+DAgwXmImipU0bJ27vciiDl1PlwUXOXg==
X-Google-Smtp-Source: APXvYqxr69KVVFfzWbJ6X/F9YdojS+JkN5x2SFv/dBtj5LK8LnsrmagKSNav+CveUBfMNfXfvg65ftXLcjL7r79HBDg=
X-Received: by 2002:a65:6412:: with SMTP id a18mr9118931pgv.10.1582225775613;
 Thu, 20 Feb 2020 11:09:35 -0800 (PST)
MIME-Version: 1.0
References: <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com>
 <158142525822.411.5401976987070210798.tip-bot2@tip-bot2> <20200213221100.odwg5gan3dwcpk6g@treble>
 <87sgjeghal.fsf@nanos.tec.linutronix.de> <20200214175758.s34rdwmwgiq6qwq7@treble>
 <CAKwvOdmJvWpmbP3GyzaZxyiuwooFXA8D7ui05QE7+f8Oaz+rXg@mail.gmail.com> <20200220004434.GA5687@intel.com>
In-Reply-To: <20200220004434.GA5687@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Feb 2020 11:09:24 -0800
Message-ID: <CAKwvOd=p18z8yxfuOBgpOheZOUzmgAfzvVD-5Kuz=VqKCUpOKw@mail.gmail.com>
Subject: Re: [tip: core/objtool] objtool: Fail the kernel build on fatal errors
To:     Philip Li <philip.li@intel.com>
Cc:     Chen Rong <rong.a.chen@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(everyone else to bcc)

On Wed, Feb 19, 2020 at 4:44 PM Philip Li <philip.li@intel.com> wrote:
>
> On Wed, Feb 19, 2020 at 02:43:39PM -0800, Nick Desaulniers wrote:
> > On Fri, Feb 14, 2020 at 9:58 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Fri, Feb 14, 2020 at 01:10:26AM +0100, Thomas Gleixner wrote:
> > > > Josh Poimboeuf <jpoimboe@redhat.com> writes:
> > > > > On Tue, Feb 11, 2020 at 12:47:38PM -0000, tip-bot2 for Josh Poimboeuf wrote:
> > > > >> The following commit has been merged into the core/objtool branch of tip:
> > > > >>
> > > > >> Commit-ID:     644592d328370af4b3e027b7b1ae9f81613782d8
> > > > >> Gitweb:        https://git.kernel.org/tip/644592d328370af4b3e027b7b1ae9f81613782d8
> > > > >> Author:        Josh Poimboeuf <jpoimboe@redhat.com>
> > > > >> AuthorDate:    Mon, 10 Feb 2020 12:32:38 -06:00
> > > > >> Committer:     Borislav Petkov <bp@suse.de>
> > > > >> CommitterDate: Tue, 11 Feb 2020 13:27:03 +01:00
> > > > >>
> > > > >> objtool: Fail the kernel build on fatal errors
> > > > >>
> > > > >> When objtool encounters a fatal error, it usually means the binary is
> > > > >> corrupt or otherwise broken in some way.  Up until now, such errors were
> > > > >> just treated as warnings which didn't fail the kernel build.
> > > > >>
> > > > >> However, objtool is now stable enough that if a fatal error is
> > > > >> discovered, it most likely means something is seriously wrong and it
> > > > >> should fail the kernel build.
> > > > >>
> > > > >> Note that this doesn't apply to "normal" objtool warnings; only fatal
> > > > >> ones.
> > > > >
> > > > > Clang still has some toolchain issues which need to be sorted out, so
> > > > > upgrading the fatal errors is causing their CI to fail.
> > > >
> > > > Good. Last time we made it fail they just fixed their stuff.
> > > >
> > > > > So I think we need to drop this one for now.
> > > >
> > > > Why? It's our decision to define which level of toolchain brokeness is
> > > > tolerable.
> > > >
> > > > > Boris, are you able to just drop it or should I send a revert?
> > > >
> > > > I really want to see a revert which has a proper justification why the
> > > > issues of clang are tolerable along with a clear statement when this
> > > > fatal error will come back. And 'when' means a date, not 'when clang is
> > > > fixed'.
> > >
> > > Fair enough.  The root cause was actually a bug in binutils which gets
> > > triggered by a new clang feature.  So instead of reverting the above
> > > patch, I think I've figured out a way to work around the binutils bug,
> > > while also improving objtool at the same time (win-win).
> > >
> > > The binutils bug will be fixed in binutils 2.35.
> > >
> > > BTW, to be fair, this was less "Clang has issues" and more "Josh is
> > > lazy".  I didn't test the patch with Clang -- I tend to rely on 0-day
> > > bot reports because I don't have the bandwidth to test the
> > > kernel/config/toolchain combinations.  Nick tells me Clang will soon be
> > > integrated with the 0-day bot, which should help prevent this type of
> > > thing in the future.
> >
> > Hi Rong, Philip,
> > Do you have any status updates on turning on the 0day bot emails to
> > the patch authors in production?  It's been quite handy in helping us
> > find issues, for the private mails we've been triaging daily.
> Hi Nick, this is on our schedule in a new 2-3 weeks, sorry not to update
> your in another mail loop earlier.

No worries.

>
> What I plan to do is to cc you for the clang reports when 0-day ci sends
> to kernel patch author. If you notice something may be related to clang (since
> we always integrate newer clang version), you can help filter it out. How
> do you think?

If you would kindly cc our mailing list "clang-built-linux
<clang-built-linux@googlegroups.com>" we'd be happy to continue to
triage and provide suggestions.  That level of indirection better
allows us to deal with subscriptions and change of email addresses
without having to disturb you.

-- 
Thanks,
~Nick Desaulniers
