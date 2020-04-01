Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFC9C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465B520719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek/j4h4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733090AbgDAOjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:39:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39384 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732791AbgDAOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:39:04 -0400
Received: by mail-io1-f66.google.com with SMTP id c16so11473505iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bc9t147F81S9ClX5m+UTR/FQ0DxmDDOUUXqttzbZFk4=;
        b=ek/j4h4cEOxaVs5N/K4Vix6Kj+19pTFOE0OdfE++vZf3wyhSCWwyWNnQkxKY6uy5gz
         aiWG324ajiDbmUXZrJy5q7HFlimLks3AebOUkADIlkr4vCtpwddfmoFyaJh/EcrINSre
         EWzZniblJgWeSbZTVprPSQ1JubFBt9iyQI67nr1hu7d5tXLnTeC4vZ5YOW0cOlNppRgz
         a1+WqWyjq4geFceLxVFucpVrjpR2UR8pvySd3bWEFIqSAaXuH8XFBKI5ZUn2n5Ek/Bxu
         LYceGsbvrqDIDTmvNn/GCt7vg0i8blUdHClnAXiyw+gaEor7M8ohVnC+5X2auiQMizCb
         PIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bc9t147F81S9ClX5m+UTR/FQ0DxmDDOUUXqttzbZFk4=;
        b=NxXZsmHkOXKk6YGwo87fKc2tH9/12d1W/ue20cn6F5o+pzTYzbG9aTWKBkDx9QfaBG
         VLpLMJOjSNF0tCvQvcoj5W0FbiFNsv2C+AzXhYPONh3KntE9k7GZrYtDLYi3IQnldhYr
         wxwyWFPCW/sKQ2nntZtcu3M8cc15Dbe0ZRv5atc9mlC+KXREFkreIIagjmsXiMbc1ALf
         CX4c91JIyQm8CWFi687C554tKfDP1UWp9NB+MhUJf5h3T6LQ4yv5ZlS9an6pg2dmwssL
         Ga5rmDA9qvlcDXr4IOn7XjlCZNqxnWKa685o8GZdgzGkxS90QbfEYsPz5O7kpQ7hMrg5
         Q8WA==
X-Gm-Message-State: ANhLgQ10ErV4GZ/bc+VwdpW1/QxWDarepFA8Akfv7iy1xV8Y5FsdfnGH
        MM0ougQubimc1XB0NmWvYKSWav4srfAR7PejCA==
X-Google-Smtp-Source: ADFU+vuGXZt8wQWVoZ2VWoNJf5+TwdOAKlV7w97TuYjlG5Wv2sb1OQm6NB/CILv6W1uV0ymansc69VCLvsERbMHXiJY=
X-Received: by 2002:a6b:b512:: with SMTP id e18mr20432245iof.168.1585751942391;
 Wed, 01 Apr 2020 07:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200325101431.12341-1-andrew.cooper3@citrix.com>
 <20200331175810.30204-1-andrew.cooper3@citrix.com> <CAMzpN2i6Nf0VDZ82mXyFixN879FC4eZfqe-LzWGkvygcz1gH_Q@mail.gmail.com>
 <c46bcb6d-4256-2d65-9cd9-33e010846de4@citrix.com> <CAMzpN2gdkmYYbQatFk66QMpiuZSfnUQUVtJ30VYF7nsX_+XVgA@mail.gmail.com>
 <bdf7995d-2d50-9bb9-8066-6c4ccfaa5b52@citrix.com> <CAMzpN2g0LS5anGc7CXco4pgBHhGzc8hw+shMOg8WEWGsx+BHpg@mail.gmail.com>
 <b1aa5cdf-b446-17b0-6d31-fa8947f67592@citrix.com>
In-Reply-To: <b1aa5cdf-b446-17b0-6d31-fa8947f67592@citrix.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 1 Apr 2020 10:38:51 -0400
Message-ID: <CAMzpN2h5u3gbRFfew-BSUH_=E509QirQaopiTBrVQc6Oq2AcvA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/smpboot: Remove 486-isms from the modern AP boot path
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        jailhouse-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 8:14 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 01/04/2020 12:39, Brian Gerst wrote:
> > On Wed, Apr 1, 2020 at 5:22 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> >> On 31/03/2020 23:53, Brian Gerst wrote:
> >>> On Tue, Mar 31, 2020 at 6:44 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> >>>> On 31/03/2020 23:23, Brian Gerst wrote:
> >>>>> On Tue, Mar 31, 2020 at 1:59 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> >>>>>> Linux has an implementation of the Universal Start-up Algorithm (MP spec,
> >>>>>> Appendix B.4, Application Processor Startup), which includes unconditionally
> >>>>>> writing to the Bios Data Area and CMOS registers.
> >>>>>>
> >>>>>> The warm reset vector is only necessary in the non-integrated Local APIC case.
> >>>>>> UV and Jailhouse already have an opt-out for this behaviour, but blindly using
> >>>>>> the BDA and CMOS on a UEFI or other reduced hardware system isn't clever.
> >>>>>>
> >>>>>> We could make this conditional on the integrated-ness of the Local APIC, but
> >>>>>> 486-era SMP isn't supported.  Drop the logic completely, tidying up the includ
> >>>>>> list and header files as appropriate.
> >>>>>>

> >>>>> You removed x86_platform.legacy.warm_reset in the original patch, but
> >>>>> that is missing in V2.
> >>>> Second hunk?  Or are you referring to something different?
> >>> Removing the warm_reset field from struct x86_legacy_features.
> >> Ok, but that is still present as the 2nd hunk of the patch.
> > My apologies, Gmail was hiding that section of the patch because it
> > was a reply to the original patch.  For future reference, add the
> > version number to the title when resubmitting a patch (ie. [PATCH
> > v2]).
>
> Erm... is Gmail hiding that too?
>
> Lore thinks it is there:
> https://lore.kernel.org/lkml/CAMzpN2g0LS5anGc7CXco4pgBHhGzc8hw+shMOg8WEWGsx+BHpg@mail.gmail.com/

Ugh, yes.  I thought it was the title that Gmail threaded on, but it
must be the In-Reply-To: header.  Sorry for the confusion.

That said, I think the v1 patch is probably the better way to go (but
adjusting the comments to include early Pentium-era systems without
integrated APICs).  Then the decision to drop support for external
APICs could be a separate patch.

--
Brian Gerst
