Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BBCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E843520786
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1c6FPq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgFPQY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgFPQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:24:55 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F808C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:24:55 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id o5so22552628iow.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHU5NIj28mFBazu9jdqEVaKFMbdsjaboVO1Xjcptaqs=;
        b=Y1c6FPq275I90ZY+g0ftWg5KQkd1D+8GqwaUSjZUJoK0rstULwyRaN4x6eKhEmbJjf
         QPQe+soc9cGuoZCFIWUcuUjIKN0A6zZtGWoGt1IQBgjs6lqQVlD7uNzNgKkp7lsEMKoa
         PSkh4qlK00BTuN2ZPq3YCVyjo3tbhyKXLxc3R/UFheQFEEi1h3HD7MsA936xUCEyWU9G
         IZumGTqJ3lTToH6U4GoJv1Jh52/aet6V2cDzMIUdT3CgQvkp0fLLJNFNUjB61qpgY/oK
         Mfh5aUcbVRoZFWIndjuzoW2pK08ag7n6l7x/fICh+ZZV2ApZujcMyD0QG7IHCGnzZfdT
         MESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHU5NIj28mFBazu9jdqEVaKFMbdsjaboVO1Xjcptaqs=;
        b=idcAZmwjV1+x7Ije/7N1U7dd4u06DjtJuXAJdf255qV8tk1nP4D4QbeYaBMLfdw0VH
         GDTN7taKNnO7W+kqUvF7/gz3eK/crfdBorgHwzvzRHzVJJZajglS7LKzcSt+LzgdT3Pi
         MUFqYpCHPlcTvAqK63w7K2T8+DyW7fpMfOaTn3UzOLAXz4ftB6k0DExgwoE5L7zT7QcT
         wZhYqATxF7ReCp+Pw+tXAqZztgV4j8XKiNPzDK3jjaAeq3o7gD4uSrYZOEboLo8moTbO
         lxzFBMzreT5d2LEc9J2QRwImjXTskkrEz5jfVG4PqQarkCjDPwzcfoplV4K7OtIPBzV7
         wJBA==
X-Gm-Message-State: AOAM530J9vkuUjbhBLyWaVR2s7FHZA9f62lgVs4E3/KPgUL5CxVH6SIF
        XSxUIo2SoUs6eE9COZmDx17OoxewTS6FnLDEXxArbQ==
X-Google-Smtp-Source: ABdhPJz6daLARwINz1z8LOJd4TBWGCiIuoS7XuQTJSE+8zWd6pJytz4lbvrsJEBrFmTx9/LKJmuob4k32nzTsdscrnQ=
X-Received: by 2002:a02:3406:: with SMTP id x6mr26671587jae.24.1592324694558;
 Tue, 16 Jun 2020 09:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200616161427.375651-1-vkuznets@redhat.com>
In-Reply-To: <20200616161427.375651-1-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 16 Jun 2020 09:24:42 -0700
Message-ID: <CALMp9eSWXGQkOOzSrALfZDMj5JHSH=CsK1wKfdj2x2jtV4XJsw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: drop MSR_IA32_PERF_CAPABILITIES from emulated MSRs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 9:14 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> state_test/smm_test selftests are failing on AMD with:
> "Unexpected result from KVM_GET_MSRS, r: 51 (failed MSR was 0x345)"
>
> MSR_IA32_PERF_CAPABILITIES is an emulated MSR indeed but only on Intel,
> make svm_has_emulated_msr() skip it so it is not returned by
> KVM_GET_MSR_INDEX_LIST.

Do we need to support this MSR under SVM for cross-vendor migration?
Or, have we given up on that?
