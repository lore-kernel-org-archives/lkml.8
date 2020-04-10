Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECE1C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CF720801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nq1ZWmiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDJT5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:57:16 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42215 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJT5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:57:15 -0400
Received: by mail-qv1-f65.google.com with SMTP id e5so691486qvo.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pS46DIfpY3lCgLGWiwz/LrxVk7ZBGeU+Fv83QXgtneM=;
        b=nq1ZWmiuWSEQ+KIE3v28/I0n8D7ft/MTnPl9hHDCzXRYS4ySeY5iCyuGKWm7XrXEwy
         Sn5GIsHCo+oGNjNPyctS+fovdWZ5njHDgAhqTQQ2tj0zLF/HtII47YK8TqSSxfq0WwB4
         3SMOh8CdjE8s7s5SPEvPWdlYzNzRZES93OKTOSmuYTQGxCwNGxvVtnROvyoZBv0YKida
         Wzo7jar5Qf1F/TDQH8lwX5/W9Wg31j+ywJdbp6vCvu+jeyCmjfmpK8To5k+fnQBzjyYX
         TXIc18k5PMF96XKOd/nOIMEW0YAeCBJMN07XLH4DTa8iY5QAIsldeLeiMlX20uAHF+zK
         mKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pS46DIfpY3lCgLGWiwz/LrxVk7ZBGeU+Fv83QXgtneM=;
        b=ClT7weImMIRaTeGhT12c1lT2IQacqAhanWbWAzwMTfLeca8tmPiGR/k2TlfY/3kP7r
         Ym2Y32Zlwz3tNFcw/vJ9XhjfHTNZMBM7wSg2+gqoitEr0uTwWCv+gajYgbJ55ycuJurL
         OfVFPfzv/lyd2IqC0oM0luEmUhXNF43SblnkzyckEV2ha9so3fKnGs26fcR2WfinGhlF
         H5ybBIHDImKo8qhQneENT2K1GinB9PcqHQX68KpSQyj0tfW/AWQHw0FB2SdGvJIKmviM
         qkXXWj3wEXy+3+SVa0+ykeJt0VwsvBL0mTMoLcb/77yK8whyYMQ0ZnfEyC3CdEkA+qb7
         LiRA==
X-Gm-Message-State: AGi0PualeOP9amHPdEWKCFTZjh74qnGCAxnmlOeTpHcsrfBXv2j309lP
        2AhVKvuLpBorZ6zOfhi+3hEK6HFraT/dIA==
X-Google-Smtp-Source: APiQypI8lAZSlQsy9qjWnpjBDL35RuvUd1Z3Euh3p3MgvqmI82eGjZxIE7ObFJeipLZphFmozZmMoQ==
X-Received: by 2002:a0c:9068:: with SMTP id o95mr6816196qvo.101.1586548634028;
        Fri, 10 Apr 2020 12:57:14 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m1sm2439743qtm.22.2020.04.10.12.57.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 12:57:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: KCSAN + KVM = host reset
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CANpmjNPqQHKUjqAzcFym5G8kHX0mjProOpGu8e4rBmuGRykAUg@mail.gmail.com>
Date:   Fri, 10 Apr 2020 15:57:12 -0400
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C4FED226-E3DE-44AE-BBED-2B56B9F5B12F@lca.pw>
References: <CANpmjNMR4BgfCxL9qXn0sQrJtQJbEPKxJ5_HEa2VXWi6UY4wig@mail.gmail.com>
 <AC8A5393-B817-4868-AA85-B3019A1086F9@lca.pw>
 <CANpmjNPqQHKUjqAzcFym5G8kHX0mjProOpGu8e4rBmuGRykAUg@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 10, 2020, at 7:35 AM, Marco Elver <elver@google.com> wrote:
>=20
> On Fri, 10 Apr 2020 at 13:25, Qian Cai <cai@lca.pw> wrote:
>>=20
>>=20
>>=20
>>> On Apr 10, 2020, at 5:47 AM, Marco Elver <elver@google.com> wrote:
>>>=20
>>> That would contradict what you said about it working if KCSAN is
>>> "off". What kernel are you attempting to use in the VM?
>=20
> Ah, sorry this was a typo,
>  s/working if KCSAN/not working if KCSAN/
>=20
>> Well, I said set KCSAN debugfs to =E2=80=9Coff=E2=80=9D did not help, =
i.e., it will reset the host running kvm.sh. It is the vanilla ubuntu =
18.04 kernel in VM.
>>=20
>> github.com/cailca/linux-mm/blob/master/kvm.sh
>=20
> So, if you say that CONFIG_KCSAN_INTERRUPT_WATCHER=3Dn works, that
> contradicts it not working when KCSAN is "off". Because if KCSAN is
> off, it never sets up any watchpoints, and whether or not
> KCSAN_INTERRUPT_WATCHER is selected or not shouldn't matter. Does that
> make more sense?

Yes, you are right. CONFIG_KCSAN_INTERRUPT_WATCHER=3Dn does not
make it work. It was a mistake when I tested it because there was a =
stale svm.o
leftover from the previous run, and then it will not trigger a rebuild =
(a bug?) when
only modify the Makefile to remove KCSAN_SANITIZE :=3D n. Sorry for the =
misleading
information. I should be checking if svm.o was really recompiled in the =
first place.

Anyway, I=E2=80=99ll send a patch to add __no_kcsan for svm_vcpu_run() =
because I tried
to narrow down more with a kcsan_[disable|enable]_current() pair, but it =
does NOT
work even by enclosing the almost whole function below until Marcro has =
more ideas?

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2be5bbae3a40..e58b2d5a575c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3286,6 +3286,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
        svm->vmcb->save.rsp =3D vcpu->arch.regs[VCPU_REGS_RSP];
        svm->vmcb->save.rip =3D vcpu->arch.regs[VCPU_REGS_RIP];
=20
+       kcsan_disable_current();
        /*
         * A vmexit emulation is required before the vcpu can be =
executed
         * again.
@@ -3410,6 +3411,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
                svm_handle_mce(svm);
=20
        mark_all_clean(svm->vmcb);
+       kcsan_enable_current();
 }
 STACK_FRAME_NON_STANDARD(svm_vcpu_run);
=20

=20



