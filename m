Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5002EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2557F2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gzyi9/fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFQQrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFQQrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:47:14 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13030C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:47:14 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id c8so3540493iob.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQoOO+VF4SBHpGOMcAz5jGxlKXeUrUgImS0zglw1/Uo=;
        b=Gzyi9/fcMu3VCfePJqRa51D4oz9qb4xhzSSdu0IECQ6t5vsEXW8/sePtO98+w5zDin
         HO3TsJLee5XV60S/wyy+zT0u/NogW8r1HinR6+wGJ30xpcf3ZAFTOfI3JjRa4BkL1IbJ
         o1PmNqUdp0zHqA1+j7nid9rcmzFBPa4l/D44BFQ71M1zmUpsLssvJ7+6ADIOT2XVevOK
         /qVEiBU1MFbXKlOoswkFkN6uJo8+vDMZc3g1a3gV3NgVRT/2WLaRBKFx5zgrkYvBI8ud
         O61JtuaEeNlQR8ijLGtkOHnYDfPwLhLqZIGagzsC383xHJz/dTeuMditEiHJ7ztMgyop
         K9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQoOO+VF4SBHpGOMcAz5jGxlKXeUrUgImS0zglw1/Uo=;
        b=k8AaO6E73GKivkyg1EIiIOaFCBtB4Iep6PN/s9Fg4ms7ylk0AO+mkyg2/mqd8bpCnu
         oTf1RwIFYZJjqHSZRa4INodXNTg1M6/XXXIHCxeIkussPFRDEzHgHqjZtTvAafkcJnF2
         J0gjChlGk4YVVHxd98Qk3aZkenfjVKBnN0Lxh53Q+AEJoiie6sWCyslAgRCZi6P20m16
         IaGQZ6hfrMKTf/NAydmz1TdH/pXNhzbi1PyIGBdfkjrMq4wpeKnrW2y7b5035xdgMwWu
         vNt/9LFf7URec+o3ggT9vV2odRvjDVSjaBgchIPkZt2A0qUbH1pTUcIYlGmbCC5Byg2v
         fSyQ==
X-Gm-Message-State: AOAM5312pSFC2JS/qSUvnPwDxa36dYk8PhLjRQa3uAzLfRKgBoNRqCWh
        aycuNQ4oeM08naNoDCdH8rl+QoMVDYRP8Di8TUxQ1Q==
X-Google-Smtp-Source: ABdhPJyspdBz5XZmNNacGUiyqAhl2DY9cyi9vJ5/SPZuoEnOMWtFiNLuNhrkq1K5MVzA228YLegc1IL58aQE/ReQvAI=
X-Received: by 2002:a05:6638:209:: with SMTP id e9mr180304jaq.48.1592412432984;
 Wed, 17 Jun 2020 09:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200616161427.375651-1-vkuznets@redhat.com> <CALMp9eSWXGQkOOzSrALfZDMj5JHSH=CsK1wKfdj2x2jtV4XJsw@mail.gmail.com>
 <87366vhscx.fsf@vitty.brq.redhat.com> <CALMp9eQ1qe4w5FojzgsUHKpD=zXqen_D6bBg4-vfHa03BdomGA@mail.gmail.com>
 <87wo45hqhy.fsf@vitty.brq.redhat.com>
In-Reply-To: <87wo45hqhy.fsf@vitty.brq.redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 17 Jun 2020 09:47:01 -0700
Message-ID: <CALMp9eQCbKz5aeacvMvBX4kq5Oxy5Tap3dUT4SZ_dnO-zmrPVQ@mail.gmail.com>
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

On Wed, Jun 17, 2020 at 4:38 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:

> Side note: MSR_IA32_PERF_CAPABILITIES can be returned by both
> KVM_GET_MSR_INDEX_LIST and KVM_GET_MSR_FEATURE_INDEX_LIST as we have it
> both as an emulated MSR filtered by kvm_x86_ops.has_emulated_msr() and
> a feature msr filtered by kvm_x86_ops.get_msr_feature(). But the later
> is a whitelist so MSR_IA32_PERF_CAPABILITIES won't appear on AMD and the
> promise "can be passed to the KVM_GET_MSRS" is kept.

So, how is MSR_IA32_PERF_CAPABILITIES different from, say,
MSR_K7_HWCR, which by its very name doesn't sound like it would be
supported on Intel CPUs? Why not just emulate
MSR_IA32_PERF_CAPABILITIES on AMD, just as we emulate MSR_K7_HWCR on
Intel?

My concern is that we don't seem to have a standard here. Each
individual MSR is handled ad hoc, which adds unnecessary complexity.
