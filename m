Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E24C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E262420724
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Cy4c1ZQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgDQNWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730059AbgDQNWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:22:03 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19007C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:22:03 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s30so1879442qth.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hprasaok50MZK/a/feo2e2oclDOFVapOraKUc6PEaaw=;
        b=Cy4c1ZQe4G9SMrIOkfvW/lXRdE7J7My+efjCR36dpGMsNWVjE2WF0RjP/1LyW0EE9V
         jLhFL2HqJbxsByPjW/xGuaB6H6DHwIQD3vnU5KqfqaUl4DpVTu6oCF82+AJTCKoZzA9b
         eu1wuX9DIqmpGHx2mbpbKznE3HXjwCGDmt4dE5QrzkJVZVj2rpXlqnURyx4Nr0o5muN0
         mIMyTNlbP2Ihpcvo93Z54eXzBKQQ6yvBCGjhHBY7fKT7pfp42Ac7OVhgA3rjiG+O6pej
         WQlV44x9fx+V/4JTeeIrXd9P6rcUuL27qT16PaaKso5mO9s0mK+noBJW2bCVEvN/41Tm
         e73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hprasaok50MZK/a/feo2e2oclDOFVapOraKUc6PEaaw=;
        b=WQiv38mbfnMupg0L0TRY5AYwRaUt9zeJBZ60LLCQ2dqovX+MqRyqBKMResIWr/tGcs
         ce8eBIUGv/90TNU53TYGsaTcHsUvB8Za24HwAUe8JnqMZ7MwcqBITKtVpEOrdhWTfklG
         eAiTSkp13IKeO9iJ+5vSJN9LHSQJyDggInbFOXA3wABeJlEfRnk45g+6WA0p4n3vYbzV
         KKjgSF7UG1jKwB/vb2cFcBb/L1QfkGdZ9RG4ISZ6BEDhbWC3/1vPe8d3AT4aJUnNRWyT
         jTqBiAAav35eAt+mihlEKssBfBZdvWiPB3NUuiG8XKjLoi5gAxYRZ+opoo67lxf6KEbX
         tCLQ==
X-Gm-Message-State: AGi0PuYcWdeFDPqnouii/aOpRKb4DkfN9KTCF/LzR2y7A/GkPVs7uHjA
        UT3e+LEcCxW8I/mNAea3kZay3mna01U7uw==
X-Google-Smtp-Source: APiQypLINBcGF72yF2OOfhsB7LCEXiY/71TAZiQ84OPjbI8O9xMYQgnMX9Pqn8PJ85t59l4ixc587Q==
X-Received: by 2002:ac8:46d8:: with SMTP id h24mr2932189qto.352.1587129722173;
        Fri, 17 Apr 2020 06:22:02 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v76sm17479205qka.32.2020.04.17.06.22.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 06:22:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH -next] kvm/svm: disable KCSAN for svm_vcpu_run()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <f02ca9b9-f0a6-dfb5-1ca0-32a12d4f56fb@redhat.com>
Date:   Fri, 17 Apr 2020 09:21:59 -0400
Cc:     Elver Marco <elver@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kasan-dev <kasan-dev@googlegroups.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F15D565-D34D-41F5-B1C5-B9A04626EE97@lca.pw>
References: <20200415153709.1559-1-cai@lca.pw>
 <f02ca9b9-f0a6-dfb5-1ca0-32a12d4f56fb@redhat.com>
To:     "paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 15, 2020, at 11:57 AM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> On 15/04/20 17:37, Qian Cai wrote:
>> For some reasons, running a simple qemu-kvm command with KCSAN will
>> reset AMD hosts. It turns out svm_vcpu_run() could not be =
instrumented.
>> Disable it for now.
>>=20
>> # /usr/libexec/qemu-kvm -name ubuntu-18.04-server-cloudimg -cpu host
>> 	-smp 2 -m 2G -hda ubuntu-18.04-server-cloudimg.qcow2
>>=20
>> =3D=3D=3D console output =3D=3D=3D
>> Kernel 5.6.0-next-20200408+ on an x86_64
>>=20
>> hp-dl385g10-05 login:
>>=20
>> <...host reset...>
>>=20
>> HPE ProLiant System BIOS A40 v1.20 (03/09/2018)
>> (C) Copyright 1982-2018 Hewlett Packard Enterprise Development LP
>> Early system initialization, please wait...
>>=20
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> arch/x86/kvm/svm/svm.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 2be5bbae3a40..1fdb300e9337 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -3278,7 +3278,7 @@ static void svm_cancel_injection(struct =
kvm_vcpu *vcpu)
>>=20
>> bool __svm_vcpu_run(unsigned long vmcb_pa, unsigned long *regs);
>>=20
>> -static void svm_vcpu_run(struct kvm_vcpu *vcpu)
>> +static __no_kcsan void svm_vcpu_run(struct kvm_vcpu *vcpu)
>> {
>> 	struct vcpu_svm *svm =3D to_svm(vcpu);
>>=20
>>=20
>=20
> I suppose you tested the patch to move cli/sti into the .S file.  =
Anyway:
>=20
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paul, can you pick this up along with other KCSAN fixes?

