Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894A5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F87D20848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nw5ituQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgCCSh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:37:27 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41918 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCCSh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:37:26 -0500
Received: by mail-io1-f65.google.com with SMTP id m25so4718327ioo.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 10:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9WYQEOpVWGproVMAv07ziOTdPLiRIDc+HJ/iWbkJV8=;
        b=nw5ituQz/pxZjKMazbeyIO9kVrzTCthyRCgmJ6Ar5UhswHJ6/p5LDuVy/3Mdr+U7/K
         dmSH9Z115uy9rWM1d2V+eTGy6i/WW5va2/nPuq/+WaOBMMZwnCwk9pegwRJy/s41GdVZ
         gbrjXviV3QRqt7vNyaIoq+OS/YcD7SbY/Hk7uRnTRFlM5B/FpscRPgfstnrFF2kKdZuf
         +vy2yrmyPWKKW0Ej6NwYTqac32h/GmxUhjiHOqy/kI+PILBIZQ4+ojXQeEYYJjn6gGf1
         2pMo+bFxnv9YxHWLZOjfYCEdgZeLVJLFzWp2J0rXkNsVq6uEPlSNZ94AEs7+aOriMJLu
         6Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9WYQEOpVWGproVMAv07ziOTdPLiRIDc+HJ/iWbkJV8=;
        b=HMT5KtoOxHHmIyE1zoUA36L9xhLOKieHihf8UXUU9aL+4S1K9EhpoZqgUVuTYXafQE
         c6QkxRfUoKC70R0+wxbC48889K0VI+uLbwckaWH70cLcylBguQNMt6rDevrC8hsPKAnX
         01piPQtIXdcy4KeuThLihcZ3BOJDSmQDm84gs8TOOy8sf8fs3ttli74ih7ErKiBjPvNl
         5yGPRsG2qz5hNI2nEzWtR2R7gUk8ulI8nrKQcmwuNWowfIyvzDYsK3lI0Pj8K/iRFHay
         PZieF7ORivaV5La+iO5Gbfp0y+iiEpCnnDZwB3YgYfzVW+n9BeI3HbJN6FNt4qpCaTi8
         ubag==
X-Gm-Message-State: ANhLgQ2HJBB8mVlS3mTP6gHIcqywYOW3LifpBLYg65JZQwz1kVPrp89c
        nZ2uWd1dZvl5kW9L2hMjmEO2dTnPh8sumLq+JK+4Mg==
X-Google-Smtp-Source: ADFU+vsbEoLs/s4b8PtMM3X7o6dJ75+m8cmCT11wPJXYP+bN2I4AMLKekRt07jPvqjI6HHPiQWatQKoNCs0R+jPHFxI=
X-Received: by 2002:a6b:e807:: with SMTP id f7mr5197526ioh.26.1583260645891;
 Tue, 03 Mar 2020 10:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20200302235709.27467-1-sean.j.christopherson@intel.com> <20200302235709.27467-65-sean.j.christopherson@intel.com>
In-Reply-To: <20200302235709.27467-65-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 3 Mar 2020 10:37:14 -0800
Message-ID: <CALMp9eRuT=Zi_JoBmmRyMzid7RF3MpYMjXCrOMA9cvqOO06C9w@mail.gmail.com>
Subject: Re: [PATCH v2 64/66] KVM: nSVM: Expose SVM features to L1 iff nested
 is enabled
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 3:57 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Set SVM feature bits in KVM capabilities if and only if nested=true, KVM
> shouldn't advertise features that realistically can't be used.  Use
> kvm_cpu_cap_has(X86_FEATURE_SVM) to indirectly query "nested" in
> svm_set_supported_cpuid() in anticipation of moving CPUID 0x8000000A
> adjustments into common x86 code.

Why not go ahead and report the SVM feature bits regardless of
"nested," and lock SVM off in VM_CR when nested=false? That would be
more like hardware behavior.
