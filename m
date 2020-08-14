Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECD5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E3A20768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBsZZ3xX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHNTMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgHNTMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:12:53 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB3FC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 12:12:52 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b17so11792428ion.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y8bJoyLns3+2CzDuVwgRu8nFtTqWpVsWzB529hgmwg8=;
        b=HBsZZ3xX0AG7YyqAg8eik2gABoE0QUxIKYrzTjRiy6d2dyPM7aMHo5TM/1MXWQwqLa
         hjefxuo+zxQDALnTmCIrX8O+d8w23pynUoq79XXIgiQXngE5Ywc9LP8KKudfb6u8qqPK
         L5zuCUzAMurmMJHSUWkaz8RmvuokNCaKd0k1qZWTLsPDp6l+2zKm+yGGqaAsMklL3WNz
         kx8VpoIohK9AKTtnAvqhrcHzYKLvexBKOR5Mysv37UzhNpFK0XW6V7ikzCbSn8V5zM8T
         YnhSB/COrklaEFFy70C0cq3ORfqDX0mzuPfSr70qwfk0ISFHRIo1TuunxRx/XPUQQNKG
         9rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y8bJoyLns3+2CzDuVwgRu8nFtTqWpVsWzB529hgmwg8=;
        b=lWcP5JKBTnlV8OHAatujFRZU42rEFzpwENXD6+kPv76mz2PzSjsVXQP1yLeRxvLNpz
         jo4xAGGLUEKs8rxSw2jtTY4USqcJ3WenncUsNv1mcrZFTI8HfN1yck/Jq+KlEDvzrUN9
         yVwTE4etNP5tpfqL00ecaAsULH6Y3+GmKcyqdHFNOOC0mDZW37a1cs3sYfFk5fjuhC/I
         oju/oJtO5vA2TVyvhotBNeu+f86Yy6XWTjC/2tshPfc3gnHs1DxEsCBVPA+bv/Dl4nKa
         k6l95dzS8z32vxFBNl6Xyy7h+SltVCPULJNgODnMfVyxG2xB8GhNCJ0nbOZBQ6xJ93nd
         w4cQ==
X-Gm-Message-State: AOAM530MWy+g4Njxj4OEJCyEYNj4nMZREHkd7GtReCblS9DLNQL0OiH/
        Tj3nXIUU2WpgsUXFh/RfKoPlRC2loQgAt8IgYFcaHA==
X-Google-Smtp-Source: ABdhPJyVnz6ffvmFM+GdAa85YUL1o2zubF/8CpstwQEpUzgt318vFJmyWc972ixi9yczFfSTN926aoGGFShA42/rygE=
X-Received: by 2002:a05:6638:2653:: with SMTP id n19mr4033657jat.34.1597432371786;
 Fri, 14 Aug 2020 12:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200814181617.442787-1-edumazet@google.com> <784A8221-8E96-4C81-B218-4BC4960AA34A@amacapital.net>
In-Reply-To: <784A8221-8E96-4C81-B218-4BC4960AA34A@amacapital.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 14 Aug 2020 12:12:40 -0700
Message-ID: <CANn89iLdozfCse24+G65+XKE25MzOQkcN+eMM_n-pkTjVQUJhQ@mail.gmail.com>
Subject: Re: [PATCH] x86/fsgsbase/64: Fix NULL deref in 86_fsgsbase_read_task
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 12:03 PM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>
>
>
> > On Aug 14, 2020, at 11:16 AM, Eric Dumazet <edumazet@google.com> wrote:
> >
> > =EF=BB=BFsyzbot found its way in 86_fsgsbase_read_task() [1]
> >
> > Fix is to make sure ldt pointer is not NULL
>
> Acked-by: Andy Lutomirski <luto@kernel.org>
>
> Maybe add something like this to the changelog:
>
> This can happen if ptrace() or sigreturn() pokes an LDT selector into FS =
or GS for a task with no LDT and something tries to read the base before a =
return to usermode notices the bad selector and fixes it.
>
> I=E2=80=99ll see if I can whip up a test case too.
>

Jann has a repro if needed (and syzbot also had one)
