Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D324FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA2820719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj3dQDFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCZAU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:20:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44275 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgCZAU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 20:20:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id v134so3929737oie.11;
        Wed, 25 Mar 2020 17:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cXCQWGOzZbHlQrF+J0jHCYgxM5tUf5xEiJJPZMX3IWk=;
        b=bj3dQDFG1NQldxJ6xsrP/T9Pg7GlPHLtSnn3ao2+6CopJsP/L+2LgouWqf/ZJfqSHH
         Y1HTnrdJAddU6DjXM8SxLDiD0vcXWOAV9hmN1e3nTtcjXCECBvIIuXex3CQ8vcZrO2Xb
         nrLntxJQgXPmLbrTqUImP0/aaNik9ahRowBlqa/eVDPeXFil6gz/j7u0y9d8+fD03Mk1
         tKQ15TpIRr0yM+wyYi1ClkZEa8XXCtbVTNhRHM6vrK2N+JFuvoWwU9f7KmxnVS65LnjM
         ntvwXZrCFPkAH5yn8stjgrhR6KndHfOMxKYGVUP+ShD8bcTPDli7DLPYsV6iYM9oBu99
         l5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXCQWGOzZbHlQrF+J0jHCYgxM5tUf5xEiJJPZMX3IWk=;
        b=flD4PslWu/+0KxIYmVnG+cb1GJ+eQRWzLQbTLW5Y2RyVbGWTJ9VLRnY+pQC+FL4Evk
         JIeEsbZYgxBg7ts0pV4ZzFeDSy7McSVKMDHSQrwDSe+KH1Z4ywImlPySYfxPoKSPOKSU
         yS0EmBhLuEm+kZAn6pZZh7/Pp9rVdhWAgbxHmhb5eIfqLVSXhRYltq66tLAlKIlAlXyx
         YzgOwBsirO0kfjKln3sz0JHuBiYMbK5RYDUaKse2uv1pnqiFhOuDH/MXv7WwbjZ8gm08
         nccMkFWKyMXnDsyhWY0n2zCF4nQOmVjpSg+D7hLKBeCNKo2tGZRE0g4o68Yl2Yr4mfjZ
         zOmA==
X-Gm-Message-State: ANhLgQ1JWKCrshX3HcuvZFNZSbkmwaBO2G+kLMCmHJlaoy5SoV185/bC
        7sk08Lze57Hba/jUxpvGb2L7kogyNsnSmKyt+0A=
X-Google-Smtp-Source: ADFU+vt1GcySl1g/SC/21eloPefOnHfQC4QzBvP4QNMs95v9AA9pUnQ90a2CWHra9vyGxtWpF8UvZ6UkArexMw64UIA=
X-Received: by 2002:a54:4094:: with SMTP id i20mr107839oii.141.1585182053512;
 Wed, 25 Mar 2020 17:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <1585031530-19823-1-git-send-email-wanpengli@tencent.com> <708f1914-be5e-91a0-2fdf-8d34b78ca7da@redhat.com>
In-Reply-To: <708f1914-be5e-91a0-2fdf-8d34b78ca7da@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 26 Mar 2020 08:20:42 +0800
Message-ID: <CANRm+CwGT4oU_CcpRcDhS992htXdP4rcO6QqkA1CyryUJbE6Ug@mail.gmail.com>
Subject: Re: [PATCH] KVM: LAPIC: Also cancel preemption timer when disarm
 LAPIC timer
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 at 23:55, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 24/03/20 07:32, Wanpeng Li wrote:
> >                       hrtimer_cancel(&apic->lapic_timer.timer);
> > +                     preempt_disable();
> > +                     if (apic->lapic_timer.hv_timer_in_use)
> > +                             cancel_hv_timer(apic);
> > +                     preempt_enable();
> >                       kvm_lapic_set_reg(apic, APIC_TMICT, 0);
> >                       apic->lapic_timer.period = 0;
> >                       apic->lapic_timer.tscdeadline = 0;
>
> There are a few other occurrences of hrtimer_cancel, and all of them
> probably have a similar issue.  What about adding a cancel_apic_timer

Other places are a little different, here we just disarm the timer,
other places we will restart the timer just after the disarm except
the vCPU reset (fixed in commit 95c065400a1 (KVM: VMX: Stop the
preemption timer during vCPU reset)), the restart will override
vmx->hv_deadline_tsc. What do you think? I can do it if introduce
cancel_apic_timer() is still better.

    Wanpeng
