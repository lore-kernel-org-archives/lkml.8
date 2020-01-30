Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7E9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA53206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="hBShpIRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgA3RQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:16:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42929 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgA3RQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:16:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id p9so1582598plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 09:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=YMQtJsos2o5a2vGvBs3zHzY0eygzY9U697OHegfTvFc=;
        b=hBShpIRUTwGCaXYoFQeYK9qnnNLEeYM92PmRzUd57ii9Zy3Ta4U2KCs6AGkI+T4e5O
         14FiaV+fceomlbaUlZFgHMPTv7Lj37OYe9QY9WDQyq+YkL0tpA0laR5/a14J+vcQrRU1
         /X1Cub8NBxNTEFy04TtMySnqbXD3jcUlxyySjY66YtN+0Vd5evEoH0/NUpeqWEytLfH8
         AreO5PN1Fp0U0d6twdnzzAgEWMc0c4ps/AnpBBidMBwjVvFQofPKGQR28VyLXYbzI2R+
         cbm7h+cUqqI48iD/V/niVL7N2EXpzjqTez3ze3FexeSRUjAPCJLpBwKo8AR/h7YeMuKq
         Bk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=YMQtJsos2o5a2vGvBs3zHzY0eygzY9U697OHegfTvFc=;
        b=YaCoRxsHPTBJcFCCfAEeW+BwqPSS6hkY3/Rh657bJTOazD7pLhHXtbYLXYBhT0ddrs
         rAoUTxg5pOLiOhG9jNI/0fs52KThvbPddosaq2sBTiEQhAiKONTj4jkNM0vqPnzrR0st
         5hPDZGQYref/TSDCgx64RSALkDpESMUHIW0yR3wpsynTuH95pbpRTeNOV5f4WTvFHqxv
         YAk6J/x4qOYw+g+pBr+9Or6KmlfSDTeqiDSnmoSlcyMJNkc11z5lHPWBQEngKbEAv2kl
         wPjIwo90vd3/qsDf6YCc7BcXvkK6FeMIT0FwG6EortrldUm1GoDhkkexMzX6KNUjEXnR
         bUWw==
X-Gm-Message-State: APjAAAUBBcsDbTv5e04cdn5mHGd08wjhmNd4mN30MUbe+YrK/GyhcPop
        dnPdFLfOtkw2Q3K+oK49vTBxiA==
X-Google-Smtp-Source: APXvYqz/HanZumE0+gOaDZtoRCZJgLmyvi/x1M0d911Rrv0gRMWU2PPbezu3EhVerXEDMCBuRijzIw==
X-Received: by 2002:a17:90a:ead8:: with SMTP id ev24mr6958304pjb.91.1580404616562;
        Thu, 30 Jan 2020 09:16:56 -0800 (PST)
Received: from ?IPv6:2600:1010:b010:9631:69c2:3ecc:ab84:f45c? ([2600:1010:b010:9631:69c2:3ecc:ab84:f45c])
        by smtp.gmail.com with ESMTPSA id d3sm6838195pfn.113.2020.01.30.09.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 09:16:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] KVM: VMX: Extend VMX's #AC handding
Date:   Thu, 30 Jan 2020 09:16:54 -0800
Message-Id: <A2E4B0E3-EDDF-46FD-8CE9-62A2E2E4BF20@amacapital.net>
References: <cf79eeeb-e107-bdff-13a8-c52288d0d123@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <cf79eeeb-e107-bdff-13a8-c52288d0d123@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 30, 2020, at 8:30 AM, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>=20
> =EF=BB=BFOn 1/30/2020 11:18 PM, Andy Lutomirski wrote:
>>>> On Jan 30, 2020, at 4:24 AM, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>>=20
>>> =EF=BB=BFThere are two types of #AC can be generated in Intel CPUs:
>>> 1. legacy alignment check #AC;
>>> 2. split lock #AC;
>>>=20
>>> Legacy alignment check #AC can be injected to guest if guest has enabled=

>>> alignemnet check.
>>>=20
>>> When host enables split lock detection, i.e., split_lock_detect!=3Doff,
>>> guest will receive an unexpected #AC when there is a split_lock happens i=
n
>>> guest since KVM doesn't virtualize this feature to guest.
>>>=20
>>> Since the old guests lack split_lock #AC handler and may have split lock=

>>> buges. To make guest survive from split lock, applying the similar polic=
y
>>> as host's split lock detect configuration:
>>> - host split lock detect is sld_warn:
>>>   warning the split lock happened in guest, and disabling split lock
>>>   detect around VM-enter;
>>> - host split lock detect is sld_fatal:
>>>   forwarding #AC to userspace. (Usually userspace dump the #AC
>>>   exception and kill the guest).
>> A correct userspace implementation should, with a modern guest kernel, fo=
rward the exception. Otherwise you=E2=80=99re introducing a DoS into the gue=
st if the guest kernel is fine but guest userspace is buggy.
>=20
> To prevent DoS in guest, the better solution is virtualizing and advertisi=
ng this feature to guest, so guest can explicitly enable it by setting split=
_lock_detect=3Dfatal, if it's a latest linux guest.
>=20
> However, it's another topic, I'll send out the patches later.
>=20

Can we get a credible description of how this would work? I suggest:

Intel adds and documents a new CPUID bit or core capability bit that means =E2=
=80=9Csplit lock detection is forced on=E2=80=9D.  If this bit is set, the M=
SR bit controlling split lock detection is still writable, but split lock de=
tection is on regardless of the value.  Operating systems are expected to se=
t the bit to 1 to indicate to a hypervisor, if present, that they understand=
 that split lock detection is on.

This would be an SDM-only change, but it would also be a commitment to certa=
in behavior for future CPUs that don=E2=80=99t implement split locks.

Can one of you Intel folks ask the architecture team about this?=
