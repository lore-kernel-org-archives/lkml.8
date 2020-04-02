Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00E2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A602F2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU7KK9hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbgDBXbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:31:40 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33663 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390172AbgDBXbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:31:40 -0400
Received: by mail-il1-f194.google.com with SMTP id k29so5476839ilg.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmXWSnZFrGmmooR0jk9MQKfEVRvqr4Bhu0RmJo6EKnI=;
        b=RU7KK9hhnWQJ37k68Oi3oIEBbXk/64ZO2mh73lxhk7GTlRqey4MxSgxLfvF3eU4HqV
         +t+7bc0tVqKgfh06b3PP78MbdPAsUHqAtLBknJWTZ8RvMmDjpI/v1Vch4E7CJCZPyA63
         L3XUGRqhzy0Hx4URAzBCSIn/0sV4q/oM/C7hExlaNjLGXTCVc4dG1qceJvhiqFEm/UYC
         NYLs0iA9ZC9+lP+5dWVwBJCQ/Y2Ee9kCnAxXWVue+h1ynLNzgC6POAuoC2qo1VMHX72D
         X7r73yxULfTxkMLLEsjFzcU1jpbimQTZtMyilSANjjyIRHnfCL03W5cABR2zVVWi8suK
         Bnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmXWSnZFrGmmooR0jk9MQKfEVRvqr4Bhu0RmJo6EKnI=;
        b=R+zrzOA6OdWL8wlng7/x6tG5hGKiSsE9YO6XjMQWoKLB8/yi5TXsivTfAAPDRT6Vmw
         DEjcaS2adN0rjgcdOpbrWwQxIq9b2qX8ECWEhvvPoOkc9W8TVegeBvMgd4nAEXkwfIQF
         DLitXCza9FAskyJwSBcjJVe43n1HPEWUU5fBYRFl2A32qC0r0b3V8qWHMuBI8fOuOYMP
         u2GCVSDHKmxWihkXUx4N9/02P52wqyUeiPt8xAe3t4nqUZ4foRYsiPYc293p70C5lIaJ
         9SDK+N0LoZP9sKGjK7nkHL9IsLG4CgtBtJq/vbJH6zbGkHaZQpX1CZYMT0lncUJwPJvp
         ZdYA==
X-Gm-Message-State: AGi0PubXIosoemfP6CaZVm4NqdK5chuRryXeeW/4wcmxjwVpEPs9FP9V
        kJGYEr4lwlaMahAtm0lcKIQouHoqCLLLi8axxEg=
X-Google-Smtp-Source: APiQypK+zEl2CUhXKeN1pMFtLbx4xPC9hxcsM3MweNUup1O/ZINcmABvKJgjGr2DS3uy3r8m7Wbjhq7W2uEpl1447J8=
X-Received: by 2002:a92:39cc:: with SMTP id h73mr5683281ilf.298.1585870299305;
 Thu, 02 Apr 2020 16:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200402195156.626430-1-leonardo@linux.ibm.com>
 <CAOSf1CEihBDDRny5S_7TA5Cqbdgsh6zN=kdq83OSgaLbRphtrg@mail.gmail.com> <6b4a4a0d4f7af723d0a5a12f4267717a507ce3f0.camel@linux.ibm.com>
In-Reply-To: <6b4a4a0d4f7af723d0a5a12f4267717a507ce3f0.camel@linux.ibm.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 3 Apr 2020 10:31:28 +1100
Message-ID: <CAOSf1CHSCMsQgJTcMPiRUFDxBF=WVpTRk7-bzyg6iit8bmm7rg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] powerpc/kernel: Enables memory hot-remove after
 reboot on pseries guests
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 10:07 AM Leonardo Bras <leonardo@linux.ibm.com> wrote:
>
> Hello Oliver, thank you for the feedback.
> Comments inline:
>
> On Fri, 2020-04-03 at 09:46 +1100, Oliver O'Halloran wrote:
> >
> > I don't really understand why the flag is needed at all. According to
> > PAPR any memory provided by dynamic reconfiguration can be hot-removed
> > so why aren't we treating all DR memory as hot removable? The only
> > memory guaranteed to be there 100% of the time is what's in the
> > /memory@0 node since that's supposed to cover the real mode area.
>
> All LMBs are listed in DR memory, even the base memory.
>
> The v1 of the patch would work this way, as qemu would configure it's
> DR memory with (DRC_INVALID | RESERVED) flags and the hot-added memory
> with (ASSIGNED) flag. Looking for assigned flag would be enough.
>
> But as of today, PowerVM doesn't seem to work that way.
> When you boot a PowerVM virtual machine with Linux, all memory is added
> with the same flags (ASSIGNED).
>
> To create a solution that doesn't break PowerVM, this new flag was made
> necessary.

I'm still not convinced it's necessary. Why not check memory@0 and use
the size as a clip level? Any memory above that level gets marked as
hotpluggable and anything below doesn't. Seems to me that would work
on all current platforms, so what am I missing here?

>
> Best regards,
> Leonardo Bras
