Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CD8C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 17:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC992067C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 17:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="IuUqXEdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBAR4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 12:56:18 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39236 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgBAR4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 12:56:17 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so4467791pjr.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 09:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=GoT2Xza8HTa8YW9t0YeNg2CkziwyhPIP52r/Avd3w9Q=;
        b=IuUqXEdZlIY+2Jd9WBKsI1VPg1zazke3iNT4V1tgpzFxPSZjpOjif5kf+6NI890RST
         7/B1G8DjK9ELIx73WVhf6/Cc3RmtwC4+t5CXl3Vvd7DFgw9PGfU3PO1E2jq+Lg/UrC3x
         IF6Vkr3ng+6Rdjv4tM3mu+b4qN3iWqxJ1TihpeZfjeSbQGsxyf3rYCBPQfhTG9NQ6L4Z
         CINGPXS/f+Y7iI9+0l4GV3YjtFgd2RvC+NJxnzt6S9hNNKpsMyZiVM7p9dYQrYy0N35g
         BzOPz2BgR9j/phRmm5WfeizF2dyEZIXQBckDsBCioIIhXxMM6fuoyS4LThd+OFJannJA
         5iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=GoT2Xza8HTa8YW9t0YeNg2CkziwyhPIP52r/Avd3w9Q=;
        b=fyjzC5/FMrMJ5eSfn61SqiMLNwYQuCvA8bYiDotpdilCSBATEHhxD9ETnHAvN+astP
         Bsf2KZHSK9Rdlm+PFkZNttam3dj118us1SKOnHJTf+GiXIhz9SSQ1onlH8yp6dWv1nrW
         O/t52mjKjryGh15uOzZqE9QSFX8JhvpcC2PJw1VXYltvhGkm823gnLMU5RK/kkZH7LOZ
         YGwyfMOAKuXOER1cKpEyhyZ5V31GPr/6l7MUchkxfXFx/ki+H8I6JeWzvPPdXwNL2+nQ
         gk5IOqOae0o/b8IvAYdlnfxS6K3Ywl0s/1IU1IKVYqtW+GQTMJKaxsUNSgEw9JeFyxmc
         0CjA==
X-Gm-Message-State: APjAAAVoQnWqT4J55mUFP7oDQnQrpVab0kBk6ktOmiCS4zI813xKwMvn
        sWAfDTkOdqG28YtW6DZD4Lo7Ng==
X-Google-Smtp-Source: APXvYqwuVBJe0yuRW97unT6n4U4keypU3fR3mGbvE89pdgIUrkvOFFujmOrb6/HGbZ1oRV6zWiCXpQ==
X-Received: by 2002:a17:90a:8008:: with SMTP id b8mr19588079pjn.37.1580579776661;
        Sat, 01 Feb 2020 09:56:16 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:45d6:e4ad:bc82:ed68? ([2601:646:c200:1ef2:45d6:e4ad:bc82:ed68])
        by smtp.gmail.com with ESMTPSA id q21sm14405957pff.105.2020.02.01.09.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 09:56:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] KVM: VMX: Extend VMX's #AC handding
Date:   Sat, 1 Feb 2020 09:56:11 -0800
Message-Id: <A2622E15-756D-434D-AF64-4F67781C0A74@amacapital.net>
References: <b2e2310d-2228-45c2-8174-048e18a46bb6@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <b2e2310d-2228-45c2-8174-048e18a46bb6@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 1, 2020, at 8:58 AM, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>=20
> =EF=BB=BFOn 2/1/2020 5:33 AM, Andy Lutomirski wrote:
>>>> On Jan 31, 2020, at 1:04 PM, Sean Christopherson <sean.j.christopherson=
@intel.com> wrote:
>>>=20
>>> =EF=BB=BFOn Fri, Jan 31, 2020 at 12:57:51PM -0800, Andy Lutomirski wrote=
:
>>>>=20
>>>>>> On Jan 31, 2020, at 12:18 PM, Sean Christopherson <sean.j.christopher=
son@intel.com> wrote:
>>>>>=20
>>>>> This is essentially what I proposed a while back.  KVM would allow ena=
bling
>>>>> split-lock #AC in the guest if and only if SMT is disabled or the enab=
le bit
>>>>> is per-thread, *or* the host is in "warn" mode (can live with split-lo=
ck #AC
>>>>> being randomly disabled/enabled) and userspace has communicated to KVM=
 that
>>>>> it is pinning vCPUs.
>>>>=20
>>>> How about covering the actual sensible case: host is set to fatal?  In t=
his
>>>> mode, the guest gets split lock detection whether it wants it or not. H=
ow do
>>>> we communicate this to the guest?
>>>=20
>>> KVM doesn't advertise split-lock #AC to the guest and returns -EFAULT to=
 the
>>> userspace VMM if the guest triggers a split-lock #AC.
>>>=20
>>> Effectively the same behavior as any other userspace process, just that K=
VM
>>> explicitly returns -EFAULT instead of the process getting a SIGBUS.
>> Which helps how if the guest is actually SLD-aware?
>> I suppose we could make the argument that, if an SLD-aware guest gets #AC=
 at CPL0, it=E2=80=99s a bug, but it still seems rather nicer to forward the=
 #AC to the guest instead of summarily killing it.
>=20
> If KVM does advertise split-lock detection to the guest, then kvm/host can=
 know whether a guest is SLD-aware by checking guest's MSR_TEST_CTRL.SPLIT_L=
OCK_DETECT bit.
>=20
> - If guest's MSR_TEST_CTRL.SPLIT_LOCK_DETECT is set, it indicates guest is=
 SLD-aware so KVM forwards #AC to guest.
>=20

I disagree. If you advertise split-lock detection with the current core capa=
bility bit, it should *work*.  And it won=E2=80=99t.  The choices you=E2=80=99=
re actually giving the guest are:

a) Guest understands SLD and wants it on.  The guest gets the same behavior a=
s in bare metal.

b) Guest does not understand. Guest gets killed if it screws up as described=
 below.

> - If not set. It may be a old guest or a malicious guest or a guest withou=
t SLD support, and we cannot figure it out. So we have to kill the guest whe=
n host is SLD-fatal, and let guest survive when SLD-WARN for old sane buggy g=
uest.

All true, but the result of running a Linux guest in SLD-warn mode will be b=
roken.

>=20
> In a word, all the above is on the condition that KVM advertise split-lock=
 detection to guest. But this patch doesn't do this. Maybe I should add that=
 part in v2.

I think you should think the details all the way through, and I think you=E2=
=80=99re likely to determine that the Intel architecture team needs to do *s=
omething* to clean up this mess.

There are two independent problems here.  First, SLD *can=E2=80=99t* be virt=
ualized sanely because it=E2=80=99s per-core not per-thread. Second, most us=
ers *won=E2=80=99t want* to virtualize it correctly even if they could: if a=
 guest is allowed to do split locks, it can DoS the system.

So I think there should be an architectural way to tell a guest that SLD is o=
n whether it likes it or not. And the guest, if booted with sld=3Dwarn, can p=
rint a message saying =E2=80=9Chaha, actually SLD is fatal=E2=80=9D and carr=
y on.

>=20
>> ISTM, on an SLD-fatal host with an SLD-aware guest, the host should tell t=
he guest =E2=80=9Chey, you may not do split locks =E2=80=94 SLD is forced on=
=E2=80=9D and the guest should somehow acknowledge it so that it sees the ar=
chitectural behavior instead of something we made up.  Hence my suggestion.
>=20
