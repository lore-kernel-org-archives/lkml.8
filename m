Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B49EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327BD20692
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="upbS40tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgDIPDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:03:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33919 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgDIPDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:03:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id l14so5115007pgb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=vti+QulpjK02SSgR5ooO7HQioSPVHwldN19SASyEiDY=;
        b=upbS40tfJGsurJN7/mZHHFDliZikCZoIqFpXUGM/QaX+XuaD80GaYleZ8Q5F5rFQw/
         hg5GsRuF/YZFNrKs46ev2JPQE6CZ6zwFE9+U9flddA1uwIqdhpgRZlt7k4l+/d3zM1vs
         jEZbhwHPLDu1rPZtLSIutcjRdcxN4ipu7eH1+ygqELUoA9SQUoAxXJussghke9nuhlf+
         piDd35eola4QOziF01AiaD6EWaY1HmgpYaL4eYp5vA5XrJpU2vEVXm/WdKCpWa799jiv
         XCM/P3yqtmVbZOT6W7+Epwo8ep7ZlXlfg7Ry7R4zR7JXskDfrJQ78E5psLgnhQkACxPo
         O+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=vti+QulpjK02SSgR5ooO7HQioSPVHwldN19SASyEiDY=;
        b=NJ80noFNjbkx0pJg5szVALOUa7vDXi89DGls094tHkQwOag83O1K0IkoDoar4bhM5e
         VY2YA+VbErC3bly6np2ZJso0l3GvZy/YqPmTQQWHBg3VIYMdPkRXeNmZbc7O+0PPV5Ip
         pOrEaNEN456U3ELLO3SjmhBEzaohLexdNmEyBusYmzLsFwWK17nEwXfBmGf2iQFCuLOG
         BsjJWDI6onsMmytK8ZuhxAXs30TktbmcKWrDe+GiDk2Mhajtc+CRe9SDYktZA/0LAHcF
         oxTyI3nL3OcArec+iIcGIMfJpM7vkhdwkL3/n4kOUnId1btcYGYg248uEzz4EInt+t0Y
         GbOA==
X-Gm-Message-State: AGi0PuaHoi448QzrbyVwK2BYtUII/r4nKvwp4fuPf97TWyUUfYKR0UIG
        YtWEvRqIR6+lUmdejtt0hFM8dg==
X-Google-Smtp-Source: APiQypLj56yP6feP8J+oTUBnBLkI9ELSEhd5pzgk/Fpw9mVbT1NODELR0bH6iBDE7Bhy+q0sfUedoQ==
X-Received: by 2002:aa7:969b:: with SMTP id f27mr2820pfk.116.1586444593655;
        Thu, 09 Apr 2020 08:03:13 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:d3f:18b:ffcb:12f6? ([2601:646:c200:1ef2:d3f:18b:ffcb:12f6])
        by smtp.gmail.com with ESMTPSA id y193sm18125956pgd.87.2020.04.09.08.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 08:03:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
Date:   Thu, 9 Apr 2020 08:03:09 -0700
Message-Id: <4EB5D96F-F322-45BB-9169-6BF932D413D4@amacapital.net>
References: <c09dd91f-c280-85a6-c2a2-d44a0d378bbc@redhat.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
In-Reply-To: <c09dd91f-c280-85a6-c2a2-d44a0d378bbc@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 9, 2020, at 7:32 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> =EF=BB=BFOn 09/04/20 16:13, Andrew Cooper wrote:
>>> On 09/04/2020 13:47, Paolo Bonzini wrote:
>>> On 09/04/20 06:50, Andy Lutomirski wrote:
>>>> The small
>>>> (or maybe small) one is that any fancy protocol where the guest
>>>> returns from an exception by doing, logically:
>>>>=20
>>>> Hey I'm done;  /* MOV somewhere, hypercall, MOV to CR4, whatever */
>>>> IRET;
>>>>=20
>>>> is fundamentally racy.  After we say we're done and before IRET, we
>>>> can be recursively reentered.  Hi, NMI!
>>> That's possible in theory.  In practice there would be only two levels
>>> of nesting, one for the original page being loaded and one for the tail
>>> of the #VE handler.  The nested #VE would see IF=3D0, resolve the EPT
>>> violation synchronously and both handlers would finish.  For the tail
>>> page to be swapped out again, leading to more nesting, the host's LRU
>>> must be seriously messed up.
>>>=20
>>> With IST it would be much messier, and I haven't quite understood why
>>> you believe the #VE handler should have an IST.
>>=20
>> Any interrupt/exception which can possibly occur between a SYSCALL and
>> re-establishing a kernel stack (several instructions), must be IST to
>> avoid taking said exception on a user stack and being a trivial
>> privilege escalation.
>=20
> Doh, of course.  I always confuse SYSCALL and SYSENTER.
>=20
>> Therefore, it doesn't really matter if KVM's paravirt use of #VE does
>> respect the interrupt flag.  It is not sensible to build a paravirt
>> interface using #VE who's safety depends on never turning on
>> hardware-induced #VE's.
>=20
> No, I think we wouldn't use a paravirt #VE at this point, we would use
> the real thing if available.
>=20
> It would still be possible to switch from the IST to the main kernel
> stack before writing 0 to the reentrancy word.
>=20
>=20

Almost but not quite. We do this for NMI-from-usermode, and it=E2=80=99s ugl=
y. But we can=E2=80=99t do this for NMI-from-kernel or #VE-from-kernel becau=
se there might not be a kernel stack.  Trying to hack around this won=E2=80=99=
t be pretty.

Frankly, I think that we shouldn=E2=80=99t even try to report memory failure=
 to the guest if it happens with interrupts off. Just kill the guest cleanly=
 and keep it simple. Or inject an intentionally unrecoverable IST exception.=

