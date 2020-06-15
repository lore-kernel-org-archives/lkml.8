Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67E3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03732078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zw0j7ZxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgFONrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:47:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59011 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728326AbgFONrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592228819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=weheyMNu1Wo9nH5YiVxVjdHICGi6lkG7Hb/LLVN60N8=;
        b=Zw0j7ZxWNF5lSzy/gI1kz1S3IJ/u/tbSx0SFBt7vS4p7LVgA8nx8W84udzj5l2uvmYNTMm
        eRQdy03rUrUjfWe64M34CFwMxpMcjieqshHzUIcZ0/cjbcdx9lR0KmAjkn7+Q7QR1uCpH1
        t2j76xX+k7y2PYn8rDW2TuagxWVQdMA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-hek48vVTNTK0XxJq1sFTWg-1; Mon, 15 Jun 2020 09:46:56 -0400
X-MC-Unique: hek48vVTNTK0XxJq1sFTWg-1
Received: by mail-wm1-f72.google.com with SMTP id 11so4955126wmj.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=weheyMNu1Wo9nH5YiVxVjdHICGi6lkG7Hb/LLVN60N8=;
        b=NciSR44f/MKNeu9u9gIlyiHda54AlTLIcIAhd62tLbwp9f29ZnR9MnBlO8CWFe33hO
         fOJCs92GIzN0v9wcXwfx8bQmzAfrGTtjHRZmAjOuaO/q6bv1+HON0o0MpXW1Kf92QJJC
         V32OEtwsFSltarfT0lJTSHVqeOEXq65+wh7i+O/GxhOTq5S06NJqjTSRMojQtNCm5y5K
         2/sI3g3/1MK1bpZ0qlxQkCcHS12aFAhi1FcRG4Y4+WZyHafNYttn01uyUr3HUPvZpaf3
         82R79QL8qRUJ/nTpJUXCIdNSAHAW/swhK4m413njCqFn81KyF2rfsL2P5AGyXvH/qyP8
         shfQ==
X-Gm-Message-State: AOAM531eyJiJXp7CrWEr6bXGjKG96w5x8BSy4/TumAMSh58JVx0czU+v
        GcdXuUcZ5W1JTcVqGACKfelZiXW3GjiHqsBC0d2gyKYYgg4o7u1A6BzoDEASfnps4tPLeOoN1+1
        VSezMBSxoBhduFg+ehCpAyZBm
X-Received: by 2002:a5d:4488:: with SMTP id j8mr28281428wrq.242.1592228815044;
        Mon, 15 Jun 2020 06:46:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz08cj7iJ9yvZ/uENIDqMPzdJxASRATbeR9Y8pLU9H+iaXbLfMqZsJsrO1NZQZnvvXuWuEUAw==
X-Received: by 2002:a5d:4488:: with SMTP id j8mr28281411wrq.242.1592228814812;
        Mon, 15 Jun 2020 06:46:54 -0700 (PDT)
Received: from [192.168.178.58] ([151.48.99.33])
        by smtp.gmail.com with ESMTPSA id w3sm24300473wmg.44.2020.06.15.06.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 06:46:54 -0700 (PDT)
Subject: Re: [PATCH 3/3] KVM:SVM: Enable INVPCID feature on AMD
To:     Jim Mattson <jmattson@google.com>, Babu Moger <babu.moger@amd.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>, Joerg Roedel <joro@8bytes.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>
References: <159191202523.31436.11959784252237488867.stgit@bmoger-ubuntu>
 <159191213022.31436.11150808867377936241.stgit@bmoger-ubuntu>
 <CALMp9eSC-wwP50gtprpakKjPYeZ5LdDSFS6i__csVCJwUKmqjA@mail.gmail.com>
 <d0b09992-eb87-651a-3b97-0787e07cc46d@amd.com>
 <CALMp9eRZQXgJvt3MGreq47ApM5ObTU7YFQV_GcY5N+jozGK1Uw@mail.gmail.com>
 <d0c38022-2d82-aacc-4829-02c557edddc0@amd.com>
 <CALMp9eSn36W=YK5XtaVATJis-J--udGK4ZOESDhYyT0zJ4YZ9A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f5a7fca-02b3-4cd9-159c-59fcda3debd0@redhat.com>
Date:   Mon, 15 Jun 2020 15:46:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eSn36W=YK5XtaVATJis-J--udGK4ZOESDhYyT0zJ4YZ9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/20 02:04, Jim Mattson wrote:
>> I think I have misunderstood this part. I was not inteding to change the
>> #GP behaviour. I will remove this part. My intension of these series is to
>> handle invpcid in shadow page mode. I have verified that part. Hope I did
>> not miss anything else.
> You don't really have to intercept INVPCID when tdp is in use, right?
> There are certainly plenty of operations for which kvm does not
> properly raise #UD when they aren't enumerated in the guest CPUID.
> 

Indeed; for RDRAND and RDSEED it makes sense to do so because the
instructions may introduce undesirable nondeterminism (or block all the
packages in your core as they have been doing for a few weeks).
Therefore on Intel we trap them and raise #UD; on AMD this is not
possible because RDRAND has no intercept.

In general however we do not try to hard to raise #UD and that is
usually not even possible.

Paolo

