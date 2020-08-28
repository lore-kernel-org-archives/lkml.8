Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B924C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FFD2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPn2RIwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgH1RoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgH1RoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:44:14 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5879C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 10:44:13 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j7so1351450oij.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ka2toJ4SYrtlIK7dbmXsBvo9OeZt2glE+FJPcFz/zOg=;
        b=DPn2RIwp6mfg1MAUt4+Srg5bxuZEx9fYANzGEqGJQISQOlLQrLguIJHV66Rnh81Kr7
         ZZrhgcDcafPJ9LPgWeWeK0F9/LjLT2yAZ7g0EKpo0rc2iDU718WC1UKs3kqUB0LSZFNl
         p9+C1x/wEwBdKQN2ZWy4G9+H4fvx9PJT+3kXCa0j5GkPg2cHu6wbckVO09UfCTzjq1+x
         TC1KtbUzV7qK4BULbgVwydqRTQ3Z7EwMDqj4ujza52SjWvLnCx3Egyk7+XCAps6SL+cW
         JF04vt5QmT69IYNlPK3wIruGGd5KdqR8eIOpkBc295doloy0Pvd4+e2vUKmDwoBjomqG
         Cl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ka2toJ4SYrtlIK7dbmXsBvo9OeZt2glE+FJPcFz/zOg=;
        b=jj7pj7ARq3cVdno1Zajl4tIn3Ch/uPdmiPVuquLmm111ejRYr/kpPuIr6G96D4da2r
         N8ncjMUGYxr85ekI06iQiMq/Z8LhByXFa6+79ogAwRlJYOjU+THCQv7Vw1AXuGejRxhX
         nXqdPTqfbASaf9SqgeQ4/fVSs7NAUASAqKl1WbMOZpTnZQ9N9EFtAiDOaKa46QgrVo3v
         7Gi/IrCWpY6CSrzXP5ieiOBIzaaQ3UcKPxW6zEQWvgXwUM1FUXTgugAfAYuKtYdhTRt6
         7xK5s8FS+R3zoTgzL8Q5Qa12OgHlGlXvwmfgfYmPnFJ8oQvyNxxNmkCRGGKO9sTqO6wt
         dhTg==
X-Gm-Message-State: AOAM533EdJFMJWqL1xQBj6c2sZfg3b9w/ug3g6lzv/mgbpt/Yinev6jC
        4gSgO3VLSpFRQDZrg7PhJc0zY+X+FMBiqYbMfyn1yQ==
X-Google-Smtp-Source: ABdhPJxtNn8CA5FcxTF8jvHIbj/TkyPMxjPH3XVVcKj9TobvyTQ7+5i4iEqy1KoT4MrD8qO7vzAqYY9rmtVb6NjlbJE=
X-Received: by 2002:aca:4b12:: with SMTP id y18mr125116oia.28.1598636651259;
 Fri, 28 Aug 2020 10:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200828085622.8365-1-chenyi.qiang@intel.com> <20200828085622.8365-2-chenyi.qiang@intel.com>
In-Reply-To: <20200828085622.8365-2-chenyi.qiang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 28 Aug 2020 10:43:59 -0700
Message-ID: <CALMp9eThyqWuduU=JN+w3M3ANeCYN+7=s-gippzyu_GmvgtVGA@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: nVMX: Fix VMX controls MSRs setup when nested
 VMX enabled
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 1:54 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
>
> KVM supports the nested VM_{EXIT, ENTRY}_LOAD_IA32_PERF_GLOBAL_CTRL and
> VM_{ENTRY_LOAD, EXIT_CLEAR}_BNDCFGS, but they doesn't expose during
> the setup of nested VMX controls MSR.
>

Aren't these features added conditionally in
nested_vmx_entry_exit_ctls_update() and
nested_vmx_pmu_entry_exit_ctls_update()?
