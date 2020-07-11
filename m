Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77ADC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6735F2075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK1R8HNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgGKBd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 21:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgGKBd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 21:33:58 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70687C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 18:33:57 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g2so4187498lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDhpDzdneHH53SGh27TE0u/VykRq3m/++IxZ3dfl0aQ=;
        b=PK1R8HNqDEX/7Dvatfv/qKlX9vFChD7Xo4sgDpyaQ3XF/eSdBWMSSv/vUBpfpiz8tJ
         B15BH2tNhPv5wEwEh57g5xMVKnSaqM1Qb3FuB9Bfq4k1vulgeU6DNZgscexJ7EQtfXkf
         YreiZfIPI62bLTTvg0ARhYkHgVLIVI6Res5Y/Vyo4M6Ug6miLzZYE+rf+l6uqTKlLfPf
         EZ54gZV1sbFgaaT0i+qvNUom2lsJAOCTIfNBElpKmbqydHlGmAO/Whl0VmYusHwvyOLT
         +Bf2TQWdtUFiS4AWtj9FKczUt7TRfi6d3ita8Z+52cxFifcRnUkoPZaYVYcZUY5P3+ZF
         HpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDhpDzdneHH53SGh27TE0u/VykRq3m/++IxZ3dfl0aQ=;
        b=DJ2Gr5vV1pqdJ0M/2mCnEZk3mrvWDb7X3tqX9ktvHoQrCdFMLT+EoG926GTQGyNM5O
         HsbvWIHRBO0ny8iEgbaL0GvKQTVMPPDVEWbK2xBuzFMTcRnUQIT9pLPhhHqaR9ROFv2d
         tf23aSvYjnrszIdO9K/HxZ/N4Wj8A25MCYEGUS2v4yE5wKTf/dinwnaJZK+gJ8khPxbe
         sPk+Kr8scWKL2RIDqpNeNxL4CjH0OENVgnJTkD3qDzVEuvKq3STaJCxhrOalcYtZXa6S
         TQ2Eh1JqdnBqW7zvlRYbwC6pU/YvinSkKAJImsJHktZ4Fhg78/KDN8rqd/2JCCp9pDhH
         dNkg==
X-Gm-Message-State: AOAM530+SqhyyTGo/RDNicIkcZVeN9Z3B1JKZ1TyxmNJ2B7Kqk0yxmn2
        XDZ0IivHmfTdmEYFSvwFgM3tbwrrjcyCcUgvez8=
X-Google-Smtp-Source: ABdhPJza/9oDjbm0HkGoz3dNvoXdkhKypeOY8s6rz5sU6P14UexauqnXxvhbPVc2VgDdaeauVx9P/JeqJKPgwskFOlE=
X-Received: by 2002:a19:4285:: with SMTP id p127mr43176998lfa.74.1594431235970;
 Fri, 10 Jul 2020 18:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com>
 <ed837e01-043b-e19b-293c-30d44df6f3a8@linux.intel.com> <CANaguZArdu1Jz3SvogFSXhnqmbdKX5aAORmGMf_uc+J=UQZpJw@mail.gmail.com>
In-Reply-To: <CANaguZArdu1Jz3SvogFSXhnqmbdKX5aAORmGMf_uc+J=UQZpJw@mail.gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Sat, 11 Jul 2020 09:33:44 +0800
Message-ID: <CAERHkrtqB2cMtQZxj0vQ2AkWU+6dFUQwcSpF=Pv9XR+wt=xZ0A@mail.gmail.com>
Subject: Re: [RFC PATCH 14/16] irq: Add support for core-wide protection of
 IRQ and softirq
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 9:36 PM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> Hi Aubrey,
>
> On Fri, Jul 10, 2020 at 8:19 AM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
> >
> > Hi Joel/Vineeth,
> > [...]
> > The problem is gone when we reverted this patch. We are running multiple
> > uperf threads(equal to cpu number) in a cgroup with coresched enabled.
> > This is 100% reproducible on our side.
> >
> > Just wonder if anything already known before we dig into it.
> >
> Thanks for reporting this. We haven't seen any lockups like this
> in our testing yet.

This is replicable on a bare metal machine. We tried to reproduce
on a 8-cpus KVM vm but failed.

> Could you please add more information on how to reproduce this?
> Was it a simple uperf run without any options or was it running any
> specific kind of network test?

I put our scripts at here:
https://github.com/aubreyli/uperf

>
> We shall also try to reproduce this and investigate.

I'll try to see if I can narrow down the test case and grab some logs
next week.

Thanks,
-Aubrey
