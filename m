Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7522AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCD220663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbGsG/PU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgG2JWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:22:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21067 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728161AbgG2JWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596014570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cleKEEqa/Yi8QZ9Y9pY/hJ9mwP+xc/IFgNkiTAzi7w4=;
        b=fbGsG/PU1VJ2Shj4AEx5/bAZTcQPDWI1dKiEstm4Sc67BTZSztoP7wGK6WA4Lbqs+kP5dF
        s28gsnoio2fVo6CVg35k2mFBhFpCtauWVFJyDC8nO9S6KbJKD3+BfXkt+eKz/PHuC+fHnk
        9SjEX7cDUXamHV+DyqBlOaApWO3mylM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-GORSUEwZPNqI1IUsqlHALw-1; Wed, 29 Jul 2020 05:22:47 -0400
X-MC-Unique: GORSUEwZPNqI1IUsqlHALw-1
Received: by mail-ej1-f72.google.com with SMTP id r14so3422964eji.16
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cleKEEqa/Yi8QZ9Y9pY/hJ9mwP+xc/IFgNkiTAzi7w4=;
        b=gPHYo3l+wSvm/LS0SkEUafvJdebDko16xDifNTDAKWzG+d9AQfkGIfRLfm/EqEA+Pk
         /tlMHsUW3guIiZ2Fk3vc8I77JbNed4ltkbJXSiIbgJUNUANwaww17CFOr4ZaoDatvBz6
         EOFPWFVsSvQNYVyDmjefTAm3ID79Vb5YVIi3yTjXVuwhrm++qV6aa91AGI88VAqF0+kr
         mMFAJX4bu89Ng6gnpZ7crxc97naYguJXRD/DByW0le4l/eJv3NHSSpN0XM5u/KxDySCd
         m3xi7axnXnizA/+ra/o9RN4YMPYAyLUZBSil/kJXrQwpJ4Gl0sdiuWDyNVm36xjIVll9
         ianA==
X-Gm-Message-State: AOAM532v7i1Cy/q9WENNfabqZzH1sb84mVaEN3sa6H23g9d+wTqQ0MGU
        hR3ljw1hIVB/uvA3Rhdlz/bDjLdMx5IFeVWpV7NnPesSK1Da8+w+zv4edBOI+7oBAQ3JuanNN17
        EyC5U0DFSgceceM7Y/b8EPB4Q
X-Received: by 2002:aa7:c885:: with SMTP id p5mr31451501eds.100.1596014566900;
        Wed, 29 Jul 2020 02:22:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCfeK5XNoFAzUDf6eYvR8YIVLMGH++FnVZqU3fYGpDuVRQRBQL15uPpm5p2erVWzHIwOY8Cg==
X-Received: by 2002:aa7:c885:: with SMTP id p5mr31451482eds.100.1596014566725;
        Wed, 29 Jul 2020 02:22:46 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c15sm1343755edm.47.2020.07.29.02.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 02:22:46 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Alexander Graf <graf@amazon.com>, Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH] KVM: x86: Deflect unknown MSR accesses to user space
In-Reply-To: <173948e8-4c7a-6dc4-de17-99151bc56d91@amazon.com>
References: <20200728004446.932-1-graf@amazon.com> <87d04gm4ws.fsf@vitty.brq.redhat.com> <a1f30fc8-09f5-fe2f-39e2-136b881ed15a@amazon.com> <CALMp9eQ3OxhQZYiHPiebX=KyvjWQgxQEO-owjSoxgPKsOMRvjw@mail.gmail.com> <87y2n2log7.fsf@vitty.brq.redhat.com> <173948e8-4c7a-6dc4-de17-99151bc56d91@amazon.com>
Date:   Wed, 29 Jul 2020 11:22:45 +0200
Message-ID: <87pn8ellp6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Graf <graf@amazon.com> writes:

> On 29.07.20 10:23, Vitaly Kuznetsov wrote:
>> 
>> 
>> 
>> Jim Mattson <jmattson@google.com> writes:
>> 
>>> On Tue, Jul 28, 2020 at 5:41 AM Alexander Graf <graf@amazon.com> wrote:
>>>>
>> 
>> ...
>> 
>>>> While it does feel a bit overengineered, it would solve the problem that
>>>> we're turning in-KVM handled MSRs into an ABI.
>>>
>>> It seems unlikely that userspace is going to know what to do with a
>>> large number of MSRs. I suspect that a small enumerated list will
>>> suffice.
>> 
>> The list can also be 'wildcarded', i.e.
>> {
>>   u32 index;
>>   u32 mask;
>>   ...
>> }
>> 
>> to make it really short.
>
> I like the idea of wildcards, but I can't quite wrap my head around how 
> we would implement ignore_msrs in user space with them?
>

For that I think we can still deflect all unknown MSR accesses to
userspace (when the CAP is enabled of course ) but MSRs which are on the
list will *have to be deflected*, i.e. KVM can't handle them internally
without consulting with userspace.

We can make it tunable through a parameter for CAP enablement if needed.

-- 
Vitaly

