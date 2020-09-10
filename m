Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C33C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D0920BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdZt4HqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgIJKMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgIJKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:12:16 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB63C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:12:16 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u6so6419565iow.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAOOYGuu+LBP43pJURwuK9m9UhVSnYk2CjB4xFHEO1k=;
        b=AdZt4HqZkJ1u6cV0KrTiUOCW93sC4VM7SkzLn8O/c8i6K3G1RSj6pbD2WQ2hwelrZb
         pR68+F9lCZLia4Sh84JH3k4pHlZIKsil8M/J1kMZFu3V6riQJPr5DNIgYDfghSOTZVHB
         qT4Kc38MMI0IIjiRepFGCQtjjyG1+C/TZqOnCqKG4JoJzaWnUqrXRROH/xeFzfZ1nTy6
         7E/rM/GRZgjg+lFY2eIE0dDGBsQORR/Hst0FvBh9Q7q36tV44e4p2rZsw07WageOzBW1
         OhhPi8eOk0QfhVuD6swDwZazQ6xbB/ItaJVvYoFw0K8ZIjlXX5i88cWWM7oz6A1XXmlz
         jGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAOOYGuu+LBP43pJURwuK9m9UhVSnYk2CjB4xFHEO1k=;
        b=r5irpiAEnWObl4ANcXF2Q6qz/HFoz1DdIXNLVdsAXr1I0KKDqdgi6Vhl7Wu5MLCPpg
         KBL5H+bnbN49qao3YyXv5R0z6LX+027oQ8R1qdRKbRQi48g14+dJaZTfIjPCK3K2fZlG
         N4dRoZkqqg3OrpFHLP01so7OSCCkSbYX+krM6ul5HauYgIGXdtv92o9EYPkodQdlpbyO
         wdAJGiTwAcHEZug5GD7zMik1VxT8eNaeq3jsSUejJyTAtzDvxZTehPE6/TOTKOjmMPHE
         Bey//8+ATRt32ZoyJfKIxeAv1+eAPvsI2k/9Yy4ms262e9OWMrh+liPK02jgHJzcUn/a
         +how==
X-Gm-Message-State: AOAM530NCH5pXMrvt9bIr5mw2wCzr9/OWqGKqjfU9DAcXQGSMSPD+Pgb
        R97l2rxAq+3jsqiSRyyrhiVyGBfx7kPZnHQXeUkMavnZujc=
X-Google-Smtp-Source: ABdhPJw4eVxG53MILA9qMjdrpiQu83v1dhdL+ezOBxvoQPQxXwSjyO3zbFaiL/vM0c8W0q9OZ9f42h7QbkqlG4stXRQ=
X-Received: by 2002:a05:6602:2245:: with SMTP id o5mr7042095ioo.105.1599732735527;
 Thu, 10 Sep 2020 03:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWx66qLc-NiwKS_Zu=BP8JDTzfeUO7A2vDd01kXNmiNiA@mail.gmail.com>
 <20200817062355.2884-1-jiangshanlai@gmail.com> <879c4480-9629-9a9c-ce93-f72118f068db@linux.alibaba.com>
In-Reply-To: <879c4480-9629-9a9c-ce93-f72118f068db@linux.alibaba.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 10 Sep 2020 18:12:04 +0800
Message-ID: <CAJhGHyBO4E2WJ-8u28B_r_hq9Jj+78dgekxGsVLgxsXN1j6BGQ@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] x86/entry: simply stack switching when exception
 on userspace
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There are definitely good cleanups in here, but I think it would be
> nice rebased to whatever lands in 5.8-rc1 settles.

Hello, tglx, Andy:

Could you have a review on the patches please?

They are based on 5.9-rc1 and sent when 5.9-rc1 was just settled,
and hoped to get their way into 5.10-rc1.

The first two patches can still be applied to today's tip/master,
(Sep 10 2020). The third can't, and conflicts with a commit just
added 3 days ago(#VC related). But the third removes a short snip
of code only, and is easy to be reviewed or even easy to be
applied manually. I will rebase all of them after they or the first
two are reviewed.

I'm sorry that I have to ask you to review again, because the
patches change the code you've recently changed.

Thanks
Lai
