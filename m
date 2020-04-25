Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C061C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 22:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA6320706
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 22:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587852644;
	bh=xuqmIzDpOCho8iZFxLKt+Gkxw+5vPYAZTLSjtItPycU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e1l2IVEOMkdFO8q4QM8QWPVaWC/+V7KBwoqCABoFDKq5m3/QhHKL75SZtWMGqMvcI
	 fzk+ROo1LFOORz6vo8/qn5YDD+kQrhOXSpLfWJR7yb1iztkwYSDCGMWsAc0tWoH23j
	 j4om2ebXet54bKaYDBzJfAShBcT+sb3Z6n5WIM6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgDYWKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 18:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgDYWKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 18:10:43 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1FBE21707
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 22:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587852642;
        bh=xuqmIzDpOCho8iZFxLKt+Gkxw+5vPYAZTLSjtItPycU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VQq6Mz7smcr3zNIcC9pKupyHyFvsFY8q4jW93o4Pvp61DKtny6S1PN1CVtESTMt1x
         0YOy/VXa+OfZBvFpSU6eteA54tRtaoUDqUeg9gPjIMkG43XV6c3n6wN2gXYsQk4uLU
         CqnubEshLb3LjDTEOxBI+/8+ibDs0pY1ir/VgnPY=
Received: by mail-wr1-f46.google.com with SMTP id f13so15920628wrm.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 15:10:42 -0700 (PDT)
X-Gm-Message-State: AGi0PuYcua7VEg9rcGXJ/C5ppVCICWLpMtU3chXTDhdzI9NqFGnqk/u2
        A8uBFPi19ZFVzCe948vnStP/brnxlTwvP4BFEBlKPA==
X-Google-Smtp-Source: APiQypJY9gdxtTJ8GRawCUdcR1DxC8wlogE3i2vYIogcFwlTEoBRip4uY50PmovAxmm9X2kGA1bOgOh4cBwbd1QBjkA=
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr18433808wrv.75.1587852641044;
 Sat, 25 Apr 2020 15:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200425191032.GK21900@8bytes.org> <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
 <20200425202316.GL21900@8bytes.org>
In-Reply-To: <20200425202316.GL21900@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 25 Apr 2020 15:10:29 -0700
X-Gmail-Original-Message-ID: <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
Message-ID: <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Mike Stunes <mstunes@vmware.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>,
        Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 1:23 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Sat, Apr 25, 2020 at 12:47:31PM -0700, Andy Lutomirski wrote:
> > I assume the race you mean is:
> >
> > #VC
> > Immediate NMI before IST gets shifted
> > #VC
> >
> > Kaboom.
> >
> > How are you dealing with this?  Ultimately, I think that NMI will need
> > to turn off IST before engaging in any funny business. Let me ponder
> > this a bit.
>
> Right, I dealt with that by unconditionally shifting/unshifting the #VC IST entry
> in do_nmi() (thanks to Davin Kaplan for the idea). It might cause
> one of the IST stacks to be unused during nesting, but that is fine. The
> stack memory for #VC is only allocated when SEV-ES is active (in an
> SEV-ES VM).

Blech.  It probably works, but still, yuck.  It's a bit sad that we
seem to be growing more and more poorly designed happens-anywhere
exception types at an alarming rate.  We seem to have #NM, #MC, #VC,
#HV, and #DB.  This doesn't really scale.

--Andy
