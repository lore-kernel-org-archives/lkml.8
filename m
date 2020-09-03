Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF59DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E5520722
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMdM+ggA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgICTcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgICTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:31:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CD4C061246
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 12:31:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id m22so5416774eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+ShtGQDOEuDeRhwletzDAClmRG1r75b7doI6fMMxgg=;
        b=XMdM+ggAPdh81IpctLm1c/aREm4XCfPl9ormWCc8fRfStKSfr64uBm9xQ8XUYvomtu
         i4lQqPuIECn/07PUDa+BtqgejMhvR+pWgdZzU+J2fLYIJImKvIhv82hWQnfl5kKDij5L
         2FKUWLGKMGFLsfdbimfn83RNfdpecFqdCDirf8uR/iz7oSfdaD0oc2zieNja5E96JV9S
         edDGCZvSh/LNR48161lZ7YpEnXi3sJlDoAbZ0qttdNakSWFpVgYT2DQzYO0KWwU5ZHg5
         58cRpDNj9AwTkBn1XkBtD2orU++NHUITLs4R7tmR0ihtQ+aQxazOSBJhZuVw+HKZvQ4s
         0CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+ShtGQDOEuDeRhwletzDAClmRG1r75b7doI6fMMxgg=;
        b=mBmADoizyr6p9NMj859Wu41Ew61KpBZbpLNvPT9PohkxiK1FR2ajKouywtL6fs+vTz
         7hJ72E6VkJU7n+W/5wSVLiV1MhiBXzZx129wsbaLPJ9rXps1GdCZVJrVzsWPxRnSzsSx
         KEsbG8aQFNvz+IiqOMs4aww+aRiKcWV6qJo+QknUYC9+5i80c6TLxRW4z/bbsecVUbK1
         mTTyg48t9d3PVofCDW/TWO0Yyh/NlTmFIyU6EXTfrGrIg1vTOavGlQ9+t6iUbTzRM5et
         wJgop8ESvOQBqEnly5NHaVSyfPc0c67JBjjogMOMt5mJr6R+IZkMGTGlTZ46bJRDg1CO
         53BQ==
X-Gm-Message-State: AOAM533B+1T+86hiR5IG+SvvJrQjYnq9aP5QLKw2OY0X9IP7YkDZ3QMV
        ppDgg8nfrStZL3jtJbUt+1Q+f0UVdAdLcr/HD5usjg==
X-Google-Smtp-Source: ABdhPJxzqWflIuaQcu6lMxgx6PjjmAOLd/fwM001Majbck6saPXD0zktzAys5GBbr0JCjPQoNibKK9m6QJTcz1kTv8A=
X-Received: by 2002:a17:906:9604:: with SMTP id s4mr3979782ejx.182.1599161514431;
 Thu, 03 Sep 2020 12:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200902125935.20646-1-graf@amazon.com> <20200902125935.20646-8-graf@amazon.com>
In-Reply-To: <20200902125935.20646-8-graf@amazon.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Thu, 3 Sep 2020 12:31:43 -0700
Message-ID: <CAAAPnDGC8ED=aky=vjaQf6=pv9kKXHbB8m-uEsuzhxgSN0oZZw@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] KVM: selftests: Add test for user space MSR handling
To:     Alexander Graf <graf@amazon.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        KarimAllah Raslan <karahmed@amazon.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kvm list <kvm@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void handle_rdmsr(struct kvm_run *run)
> +{
> +       run->msr.data = run->msr.index;
> +       msr_reads++;
> +
> +       if (run->msr.index == MSR_SYSCALL_MASK ||
> +           run->msr.index == MSR_GS_BASE) {
> +               TEST_ASSERT(run->msr.reason != KVM_MSR_EXIT_REASON_FILTER,

TEST_ASSERT(run->msr.reason == KVM_MSR_EXIT_REASON_FILTER,

> +                           "MSR read trap w/o access fault");
> +       }
> +}
> +
> +static void handle_wrmsr(struct kvm_run *run)
> +{
> +       /* ignore */
> +       msr_writes++;
> +
> +       if (run->msr.index == MSR_IA32_POWER_CTL) {
> +               TEST_ASSERT(run->msr.data != 0x1234,

TEST_ASSERT(run->msr.data == 0x1234,

> +                           "MSR data for MSR_IA32_POWER_CTL incorrect");
> +               TEST_ASSERT(run->msr.reason != KVM_MSR_EXIT_REASON_FILTER,

TEST_ASSERT(run->msr.reason == KVM_MSR_EXIT_REASON_FILTER,

> +                           "MSR_IA32_POWER_CTL trap w/o access fault");
> +       }
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       struct kvm_enable_cap cap = {
> +               .cap = KVM_CAP_X86_USER_SPACE_MSR,
> +               .args[0] = 1,

.args[0] = KVM_MSR_EXIT_REASON_FILTER,

> +       };
> +       struct kvm_vm *vm;
> +       struct kvm_run *run;
> +       int rc;
