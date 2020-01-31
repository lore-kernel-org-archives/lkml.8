Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364BAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0410E20707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="JL60+CIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgAaPht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:37:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35313 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbgAaPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:37:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so3667728pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 07:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=kHjsKJfHfDKPgNIRtNqjKL6x3lCw1fBq/qdw1Ihh9Ok=;
        b=JL60+CIWVx2ZNBGRRDE/869xFhvDH4kuPxiZc+n/C5B8X1DzHcVR7DMv69tKRLHy42
         opphi9Iqpkod84W59893Tuy0ycC/F3w6iw8ctJPu0tlkJezZD864ycpVmq94qhNsL8pF
         2+UZ1mWaBun9XKzaVIqRbod13ejEN0w2BYgCV1SIdL/fTtl4zri9yCGbBUoFapotOnt3
         rzUYXXx6HRp8eOZ8rapa9WeJje+vPZNGVSf/MUgdMSLu0aAl5BGQ+IEFqWsG20DiNsU3
         icSNHlu4OGqqKwZu09Xxp9n1W3gFO8Ud/aWFfaRYRB4ciutw5iyTMtm7bvP5haO7kobC
         ID6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=kHjsKJfHfDKPgNIRtNqjKL6x3lCw1fBq/qdw1Ihh9Ok=;
        b=bCwY5Ylp/HOl+5YaR9ZsiMkeqQKzo90OR50ERaJcJI66ZZC66yJJP7AwmduqPLUyHG
         zzDHqligEO0Q1MPEpP+2PHq4+f0HVmzxCFgofueZdol3Mo2LmKmLxNnSRQNJHx9XY8Fp
         aBW8EFMSuqW/tB65u1JcapoMyeGBR1GoYcgDeBTq7EwvxsXwE/fyBS3bLwNCoiaS+r9T
         4egBw9uagELVoevmV4FhCUEeDjEsOiVRo4Z4bTGG6e+GmP3paytOzPPmv/W3TN8vesyA
         4fHAn5s4+hviKc81fzK0XmcYckLCseOr2cM0EY7kA3OfE8GTN9Mz7suYKTri387o/RQ5
         rTug==
X-Gm-Message-State: APjAAAVBmdeBix7lfjtPgLe1ye/SD7slBoChZMJw+EjOKENLLM09JPVW
        8uCAFW5dUNMCGkaPhQfD0gf0asd9KFw=
X-Google-Smtp-Source: APXvYqxv/3oJRyhAzrDBpcMBXA/ZW0v6Se321xd0RXvqzLHIfSp3Kz9O7RrwN83lxaeX63wjmLHIzw==
X-Received: by 2002:a63:6602:: with SMTP id a2mr10310624pgc.403.1580485067168;
        Fri, 31 Jan 2020 07:37:47 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:513e:e8d2:8044:fa7a? ([2601:646:c200:1ef2:513e:e8d2:8044:fa7a])
        by smtp.gmail.com with ESMTPSA id a16sm10470140pgb.5.2020.01.31.07.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 07:37:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] KVM: VMX: Extend VMX's #AC handding
Date:   Fri, 31 Jan 2020 07:37:43 -0800
Message-Id: <5D1CAD6E-7D40-48C6-8D21-203BDC3D0B63@amacapital.net>
References: <3499ee3f-e734-50fd-1b50-f6923d1f4f76@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <3499ee3f-e734-50fd-1b50-f6923d1f4f76@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 30, 2020, at 11:22 PM, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>=20
> =EF=BB=BFOn 1/31/2020 1:16 AM, Andy Lutomirski wrote:
>>>> On Jan 30, 2020, at 8:30 AM, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>>=20
>>> =EF=BB=BFOn 1/30/2020 11:18 PM, Andy Lutomirski wrote:
>>>>>> On Jan 30, 2020, at 4:24 AM, Xiaoyao Li <xiaoyao.li@intel.com> wrote:=

>>>>>=20
>>>>> =EF=BB=BFThere are two types of #AC can be generated in Intel CPUs:
>>>>> 1. legacy alignment check #AC;
>>>>> 2. split lock #AC;
>>>>>=20
>>>>> Legacy alignment check #AC can be injected to guest if guest has enabl=
ed
>>>>> alignemnet check.
>>>>>=20
>>>>> When host enables split lock detection, i.e., split_lock_detect!=3Doff=
,
>>>>> guest will receive an unexpected #AC when there is a split_lock happen=
s in
>>>>> guest since KVM doesn't virtualize this feature to guest.
>>>>>=20
>>>>> Since the old guests lack split_lock #AC handler and may have split lo=
ck
>>>>> buges. To make guest survive from split lock, applying the similar pol=
icy
>>>>> as host's split lock detect configuration:
>>>>> - host split lock detect is sld_warn:
>>>>>   warning the split lock happened in guest, and disabling split lock
>>>>>   detect around VM-enter;
>>>>> - host split lock detect is sld_fatal:
>>>>>   forwarding #AC to userspace. (Usually userspace dump the #AC
>>>>>   exception and kill the guest).
>>>> A correct userspace implementation should, with a modern guest kernel, f=
orward the exception. Otherwise you=E2=80=99re introducing a DoS into the gu=
est if the guest kernel is fine but guest userspace is buggy.
>>>=20
>>> To prevent DoS in guest, the better solution is virtualizing and adverti=
sing this feature to guest, so guest can explicitly enable it by setting spl=
it_lock_detect=3Dfatal, if it's a latest linux guest.
>>>=20
>>> However, it's another topic, I'll send out the patches later.
>>>=20
>> Can we get a credible description of how this would work? I suggest:
>> Intel adds and documents a new CPUID bit or core capability bit that mean=
s =E2=80=9Csplit lock detection is forced on=E2=80=9D.  If this bit is set, t=
he MSR bit controlling split lock detection is still writable, but split loc=
k detection is on regardless of the value.  Operating systems are expected t=
o set the bit to 1 to indicate to a hypervisor, if present, that they unders=
tand that split lock detection is on.
>> This would be an SDM-only change, but it would also be a commitment to ce=
rtain behavior for future CPUs that don=E2=80=99t implement split locks.
>=20
> It sounds a PV solution for virtualization that it doesn't need to be defi=
ned in Intel-SDM but in KVM document.
>=20
> As you suggested, we can define new bit in KVM_CPUID_FEATURES (0x40000001)=
 as KVM_FEATURE_SLD_FORCED and reuse MSR_TEST_CTL or use a new virtualized M=
SR for guest to tell hypervisor it understand split lock detection is forced=
 on.

Of course KVM can do this. But this missed the point. Intel added a new CPU f=
eature, complete with an enumeration mechanism, that cannot be correctly use=
d if a hypervisor is present. As it stands, without specific hypervisor and g=
uest support of a non-Intel interface, it is *impossible* to give architectu=
rally correct behavior to a guest. If KVM implements your suggestion, *Windo=
ws* guests will still malfunction on Linux.

This is Intel=E2=80=99s mess. Intel should have some responsibility for clea=
ning it up. If Intel puts something like my suggestion into the SDM, all the=
 OSes and hypervisors will implement it the *same* way and will be compatibl=
e. Sure, old OSes will still be broken, but at least new guests will work co=
rrectly. Without something like this, even new guests are busted.

>=20
>> Can one of you Intel folks ask the architecture team about this?
>=20
