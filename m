Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BA7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9CE206F7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 00:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="u6mHIj8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgFKAPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgFKAPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 20:15:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FF4C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 17:15:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so4280867wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 17:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iHao7Jxny3P3ePcrYrjLcQVBYuxeL3mVp0j7FnnS+Bs=;
        b=u6mHIj8tc2pymYIfKG6eytsU9EfJO732bDOW9rllhAVzlVaqRnIRhUt0y3hseFrwqM
         9AyGgd00NsFD/f3FzcRAOOKUtzSSub0+NcNNSWHaaij7CjsqTyJbYxp4AIWfSRydnYH1
         rpBZvYzR9JZUMZTs1ft6t6WLmQOjhkdOTiirmrlC7rxMH2yqWw9jqZehJeWM9wFmxtbj
         RCA2wiDBTGVT32Iljf7ZVQxHy6q0sfHkJRD6BJCSyDFJ9xjAX5Rak30fJF9sRIjGuLku
         lCBR5c0DLQe4fFwsYVQkoXjpF9K1WNz6MHCMGKNd87G1RRsE5WdCRjRjZlm48SgR+i25
         U/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iHao7Jxny3P3ePcrYrjLcQVBYuxeL3mVp0j7FnnS+Bs=;
        b=dH1ibdDhLcCFZx0H8/qK7pKmP7afGaluBW7vHMWL0x/8bi+zYlYl7J0yBt49TTEIKH
         PEnlts+3n1CVP52aU+cdv/kzHt4U76gA8mFCzab4FKsdQ5yGQesVhaHU3Bkils7QAaqQ
         Eu0+vyN+u3J1RgIjey7nAN/Z0KTLShx1TZmtNOPAoLMaOTPQNReYW2n248K433ZV8JnI
         f0OKb1Lrc1TDy+Z0/8VKfSIT4vgDnrO6Mxk/Dh6Op6KqzIKCO+BJ/FauJv/UOnKeaB4d
         4okGjSkZDDuCv+XgQRfXZqv8YIqQxsKNbVSXvuBqELnKVzB8nmNNaU7VGQa3+BBcIhUH
         eLfg==
X-Gm-Message-State: AOAM5304ew+JWrIfdbTkw1o+mVy44o/9BG6WfybcVExvaV+tdQGVuVnV
        0JDAqAHPaq6Q4v+lOVQostaqHLL8YcfcIGGKt8yYRnQK
X-Google-Smtp-Source: ABdhPJwRaWLeVWNM2DvqJ//Cf/KehU3zODlojPxnnwOKZY6Zk0yCwIImK323tyUo5T97sq9d3VBafA/o5jGqBvSFAng=
X-Received: by 2002:adf:82f8:: with SMTP id 111mr6301223wrc.257.1591834546119;
 Wed, 10 Jun 2020 17:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200610181254.2142-1-dpreed@deepplum.com> <3F5CEF02-0561-4E28-851B-8E993F76DC9B@amacapital.net>
 <20200611000032.GI18790@linux.intel.com>
In-Reply-To: <20200611000032.GI18790@linux.intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 10 Jun 2020 17:15:34 -0700
Message-ID: <CALCETrWxBW-f_YcRyO8jH-LNnot-4GjEFAFoqzY87M04EZTBzA@mail.gmail.com>
Subject: Re: [PATCH] Fix undefined operation VMXOFF during reboot and crash
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "David P. Reed" <dpreed@deepplum.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 5:00 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Wed, Jun 10, 2020 at 02:59:19PM -0700, Andy Lutomirski wrote:
> >
> >
> > > On Jun 10, 2020, at 11:21 AM, David P. Reed <dpreed@deepplum.com> wro=
te:
> > >
> > > =EF=BB=BFIf a panic/reboot occurs when CR4 has VMX enabled, a VMXOFF =
is
> > > done on all CPUS, to allow the INIT IPI to function, since
> > > INIT is suppressed when CPUs are in VMX root operation.
> > > However, VMXOFF causes an undefined operation fault if the CPU is not
> > > in VMX operation, that is, VMXON has not been executed, or VMXOFF
> > > has been executed, but VMX is enabled.
> >
> > I=E2=80=99m surprised. Wouldn=E2=80=99t this mean that emergency reboot=
s always fail it a VM
> > is running?  I would think someone would have noticed before.
>
> The call to cpu_vmxoff() is conditioned on CR4.VMXE=3D=3D1, which KVM tog=
gles in
> tandem with VMXON and VMXOFF.  Out of tree hypervisors presumably do the
> same.  That's obviously not atomic though, e.g. VMXOFF will #UD if the
> vmxoff_nmi() NMI arrives between CR4.VMXE=3D1 and VMXON, or between VMXOF=
F
> and CR4.VMXE=3D0.

It would be nice for the commit message to say "this happens when
nmxoff_nmi() races with KVM's VMXON/VMXOFF toggling".  Or the commit
message should say something else if the bug happens for a different
reason.

The race with KVM should be quite unusual, since it involves rebooting
concurrently with loading or unloading KVM.
