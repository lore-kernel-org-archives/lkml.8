Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4313FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8F42076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="HVgbAxD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgHTUgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgHTUgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:36:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6946C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:36:50 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mw10so1490403pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ukRwrb1HMectcRQKGGrRlatN7M/qikRtvuRWmz5DhYk=;
        b=HVgbAxD1GIdHmU8TYACBwkx14GqPqpUzwmbU8VpJwROPFFJ5+cVIfIvyIXFEHRKeud
         WCdP+ej8vuDV7AIu97djlIZe8XksjOOXu1FgcinITSFHT+R/TUqVPJCP2NvINDwEoGHb
         PebGzt6kCFsVb2Kf2Ny10xzfCGE0CirDZ77nxG28V3T+Wh8TMl7WKbAqmA6Z6i5PYK4j
         0wdU2/MITrujY7QthxnX++qN+TYfYyr57bSpl+W5e36sfdyO34JQGq8g5hpnpzdEkZtV
         xWriu6tjEn4zpI1HJrO5PIiNktNtLr+J+T8SX+UUla1VAQunQwq8H2b6EnUf3xK/Zd95
         4hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ukRwrb1HMectcRQKGGrRlatN7M/qikRtvuRWmz5DhYk=;
        b=kzFGF5sA3KfvQ5yczeqWeCaudbfqaGj7Ag7oo+5VKdrqYMhLnEnYUsl8x2+Woc2jUV
         f5WlvGh7Rn/+mcS8AnoVi7Ued5syvR4nvQVOi6fBe3q1wwo9BnXmP10UeRAMKVPY8PBu
         5cPV5mv5DVDbe48uSG3mi1bmuwJz2xwG4ICSXG33l8tKL2rM/6DTDkz/ZTsZfovTBFuN
         VCNnvjh3CPIcSLcMcf9+jyHaXfGKzoI3cwcvPVPyz/DJV10BRG9wfliZRm+/vuEBdoEG
         tLqJU7rIMGKh3Sa0ijXHzDkfrXi6SZVjSuNyCFTl1SPS1PkrisB791p6NzAlb/EfmtjX
         v0lQ==
X-Gm-Message-State: AOAM530fJETcKdrLueKz3bDhKYL8KL6Kt6w5pLfgRmp00QxVFLflndtR
        eoMin2jPx0rlpcKHRRk8KxzPEw==
X-Google-Smtp-Source: ABdhPJxLKvfqKuv7kCRdih87jjtWmpEM/T82ek30OpmSbCBmlFantEqUFX7mzG/LyJ/aL4I49tpnBw==
X-Received: by 2002:a17:90a:ab96:: with SMTP id n22mr62959pjq.52.1597955809986;
        Thu, 20 Aug 2020 13:36:49 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:99e7:a8e2:5c3d:8c52? ([2601:646:c200:1ef2:99e7:a8e2:5c3d:8c52])
        by smtp.gmail.com with ESMTPSA id d80sm4068734pfd.22.2020.08.20.13.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 13:36:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: FSGSBASE causing panic on 5.9-rc1
Date:   Thu, 20 Aug 2020 13:36:46 -0700
Message-Id: <5756198D-C8BD-4290-BFCA-04424EB230A6@amacapital.net>
References: <f6694ee6-d672-1cf9-deaf-4d600bc4e9eb@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
In-Reply-To: <f6694ee6-d672-1cf9-deaf-4d600bc4e9eb@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 20, 2020, at 1:15 PM, Tom Lendacky <thomas.lendacky@amd.com> wrote:=

>=20
> =EF=BB=BFOn 8/20/20 3:07 PM, Dave Hansen wrote:
>> On 8/20/20 12:05 PM, Tom Lendacky wrote:
>>>> I added a quick hack to save TSC_AUX to a new variable in the SVM
>>>> struct and then restore it right after VMEXIT (just after where GS is
>>>> restored in svm_vcpu_enter_exit()) and my guest is no longer crashing.
>>>=20
>>> Sorry, I mean my host is no longer crashing.
>> Just to make sure I've got this:
>> 1. Older CPUs didn't have X86_FEATURE_RDPID
>> 2. FSGSBASE patches started using RDPID in the NMI entry path when
>>    supported *AND* FSGSBASE was enabled
>> 3. There was a latent SVM bug which did not restore the RDPID data
>>    before NMIs were reenabled after VMEXIT
>> 4. If an NMI comes in the window between VMEXIT and the
>>    wrmsr(TSC_AUX)... boom
>=20
> Right, which means that the setting of TSC_AUX to the guest value needs to=
 be moved, too.
>=20

Depending on how much of a perf hit this is, we could also skip using RDPID i=
n the paranoid path on SVM-capable CPUs.=
