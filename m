Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCF5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB3B214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="G0JGgN2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgAaU55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:57:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36208 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAaU54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:57:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so4109979pgc.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 12:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=axXyWq+/1ENk7nWGOr0BDelZPbmUAfFhUOKXYN/D26I=;
        b=G0JGgN2vuQgLYNTNbcGJW2bbCdiQWVlU/lEC62HHj9aIpCdNfKqDNPA7DsP7Yl1sW2
         6Dg3DhrOj/9YzOAC/Rn2/4LTXZMbueyw81Mt6hqb4MXpj+eo1BrB5oFy7YU3iEmvNkOn
         yiE2HYPpTVF2/UhXplea49PE+hFdcbFnrd6YvtzfsqA08h/htYGvh7qk9EjC6BCqY8P0
         n5vfTtk59ria8j04K3e+rZFu+aH4F4u4xXwBR9j+ftAa99TmOIhl+1GUpndmNAyUmiaI
         o6EfsIIH2+c2fUKh0fQdpY2ou65nRxaPxmIct9WaITwluSztBoqrADf7Lf5P73zm8ntt
         ydjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=axXyWq+/1ENk7nWGOr0BDelZPbmUAfFhUOKXYN/D26I=;
        b=ZshWspHS4Al1m7x2mZH6ZOtsdqJFU50J075EusX88dogooK9G+QKITa9ehQgGn5J0f
         rd42C7J96xAib8FdASEIB4SRIA26MpheejACekqVCCQ+EvO6+LhnBJD2Vsj2fFddkCjE
         YfNB7NbEfJnAdkIVijvb2sfpPyYxxogQTJBINCExoeh4Q5UW6zy9BTNJxDfri4UwfUQJ
         Fxlr/Bdd78eyO9sxP4m+7i7F50EFLlphdlSM4nT3fwCSsbX8h2ck+eDZlfFQzZuVyZiH
         kjqN0tqyh16UGiWb55W3rqoBql9tEIjlXUYQYLDGyxkVhOj/mefunv/t4VHhfGxY1rd8
         p1bQ==
X-Gm-Message-State: APjAAAW+KsN8oiPduX7dHpQVkyjvm1C0V6RwR9xAEgIbuATe6Ji7hrdJ
        ll5qM6BSEKjPfjFBjt8tud2Zmg==
X-Google-Smtp-Source: APXvYqymQmzrxcl6ZY9/7pXTcbIxf0wn5OwbTW1qGSMIgJZOpPb0A3yJKDDjtXd+A1frFQz+qU319w==
X-Received: by 2002:a63:4b49:: with SMTP id k9mr12264866pgl.269.1580504275824;
        Fri, 31 Jan 2020 12:57:55 -0800 (PST)
Received: from ?IPv6:2600:1010:b010:9631:69c2:3ecc:ab84:f45c? ([2600:1010:b010:9631:69c2:3ecc:ab84:f45c])
        by smtp.gmail.com with ESMTPSA id i68sm11455978pfe.173.2020.01.31.12.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 12:57:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] KVM: VMX: Extend VMX's #AC handding
Date:   Fri, 31 Jan 2020 12:57:51 -0800
Message-Id: <5CD544A4-291A-47A1-80D1-F77FE0444925@amacapital.net>
References: <20200131201743.GE18946@linux.intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20200131201743.GE18946@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Jan 31, 2020, at 12:18 PM, Sean Christopherson <sean.j.christopherson@i=
ntel.com> wrote:
>=20
> =EF=BB=BFOn Sat, Feb 01, 2020 at 01:47:10AM +0800, Xiaoyao Li wrote:
>>> On 1/31/2020 11:37 PM, Andy Lutomirski wrote:
>>>=20
>>>> On Jan 30, 2020, at 11:22 PM, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>>>=20
>>>> On 1/31/2020 1:16 AM, Andy Lutomirski wrote:
>=20
> ...
>=20
>>>>> Can we get a credible description of how this would work? I suggest: I=
ntel
>>>>> adds and documents a new CPUID bit or core capability bit that means
>>>>> =E2=80=9Csplit lock detection is forced on=E2=80=9D.  If this bit is s=
et, the MSR bit
>>>>> controlling split lock detection is still writable, but split lock
>>>>> detection is on regardless of the value.  Operating systems are expect=
ed
>>>>> to set the bit to 1 to indicate to a hypervisor, if present, that they=

>>>>> understand that split lock detection is on.  This would be an SDM-only=

>>>>> change, but it would also be a commitment to certain behavior for futu=
re
>>>>> CPUs that don=E2=80=99t implement split locks.
>>>>=20
>>>> It sounds a PV solution for virtualization that it doesn't need to be
>>>> defined in Intel-SDM but in KVM document.
>>>>=20
>>>> As you suggested, we can define new bit in KVM_CPUID_FEATURES (0x400000=
01)
>>>> as KVM_FEATURE_SLD_FORCED and reuse MSR_TEST_CTL or use a new virtualiz=
ed
>>>> MSR for guest to tell hypervisor it understand split lock detection is
>>>> forced on.
>>>=20
>>> Of course KVM can do this. But this missed the point. Intel added a new C=
PU
>>> feature, complete with an enumeration mechanism, that cannot be correctl=
y
>>> used if a hypervisor is present.
>>=20
>> Why it cannot be correctly used if a hypervisor is present? Because it ne=
eds
>> to disable split lock detection when running a vcpu for guest as this pat=
ch
>> wants to do?
>=20
> Because SMT.  Unless vCPUs are pinned 1:1 with pCPUs, and the guest is
> given an accurate topology, disabling/enabling split-lock #AC may (or may
> not) also disable/enable split-lock #AC on a random vCPU in the guest.
>=20
>>> As it stands, without specific hypervisor and guest support of a non-Int=
el
>>> interface, it is *impossible* to give architecturally correct behavior t=
o a
>>> guest. If KVM implements your suggestion, *Windows* guests will still
>>> malfunction on Linux.
>>=20
>> Actually, KVM don't need to implement my suggestion. It can just virtuali=
ze
>> and expose this feature (MSR_IA32_CORE_CAPABILITIES and MSR_TEST_CTRL) to=

>> guest, (but it may have some requirement that HT is disabled and host is
>> sld_off) then guest can use it architecturally.
>=20
> This is essentially what I proposed a while back.  KVM would allow enablin=
g
> split-lock #AC in the guest if and only if SMT is disabled or the enable b=
it
> is per-thread, *or* the host is in "warn" mode (can live with split-lock #=
AC
> being randomly disabled/enabled) and userspace has communicated to KVM tha=
t
> it is pinning vCPUs.

How about covering the actual sensible case: host is set to fatal?  In this m=
ode, the guest gets split lock detection whether it wants it or not. How do w=
e communicate this to the guest?=
