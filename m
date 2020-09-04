Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DB8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAE62067C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRIf1HBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgIDCTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbgIDCTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:19:08 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEADAC061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 19:19:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b12so4586758edz.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 19:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrAdzv24TvKINI+TSt9YrTxl/N6E+xS4y6ll+3lQsBM=;
        b=MRIf1HBgmWXfY1BikF2IYGavdlt4nQmFrVJ6Mi+ad+vUFt0vx2nR0LP2LhUjG+MOoy
         y/BaY2dLXwr0smwGz3krb1Tp8HTvrZBPaxjjJswpXWPxv6eY9MBUdVuGde7aYtuDJ4fl
         vM4WtJ4alvKrxThlhkLGNlCGI2rDb91JN/ZjFLZ/CRmly547F0A2OlB7yDF546n0qcGv
         32QV9KC3cBX+N7U5ISIfjFklMV66lljsGD2vDQSqAPwrTrxnegtZENKpP7AlOhf8OuAe
         bEWWikidflcbq6YaJCTNtFrd7PAjhQh5W4X+VczD8GPAuWc4xbg7ba7h8uc9XO9w0sRy
         Mwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrAdzv24TvKINI+TSt9YrTxl/N6E+xS4y6ll+3lQsBM=;
        b=jUf0ClM26EknSDg3HqZwhYo1mwU25nbumA7o3o28oW3hVpY78BtmIbbJTvfRxrLai1
         PaQcsOMHnszF8nBigZUHTDQsY4EZr1oBvfgbKAAN6b4PXswiw7XpRUyF2e18gZhbhjo+
         tQbglNFvOA7MqODes8fFx85wPHFTtkx6MzJmr/JwOu1+WxamccUgTRPJXDLCaez59iJ9
         5FCAIOv/Paj3QhM/LXV+HqLPz1SVyBQGb31/iiqfp2CfRG95o/ur1RPkTnF7kcDlIRRn
         DNRyStKPtE6kgVEPwVloobODFeaq1Hf6AvMmI+vX7ssgnsjZZaGQwKWwXEsQjJGQiaov
         SRGQ==
X-Gm-Message-State: AOAM531ejbyH+Qy1B6KAtQyVrAjMitAkVmxTjMeufIuEEbrLKm6dB/R8
        3SpD6HxEds+9XAF0oHexGR9Te4g2Qk9rfuLIpJth3w==
X-Google-Smtp-Source: ABdhPJxs5wovzcetJu5uDT3AQi1FzFLV1CCc/+8EIHAU6I/Z4nPfDoYG4OvY59GtSoCuXmq4fFtncIcI2zqBYqdeokE=
X-Received: by 2002:a50:d809:: with SMTP id o9mr6138860edj.12.1599185946357;
 Thu, 03 Sep 2020 19:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200902125935.20646-1-graf@amazon.com> <20200902125935.20646-6-graf@amazon.com>
In-Reply-To: <20200902125935.20646-6-graf@amazon.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Thu, 3 Sep 2020 19:18:55 -0700
Message-ID: <CAAAPnDH2D6fANhZzy3fAL2XKO4ROrvbOoqPme2Ww6q5XcVJfog@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] KVM: x86: VMX: Prevent MSR passthrough when MSR
 access is denied
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

> +/*
> + * List of MSRs that can be directly passed to the guest.
> + * In addition to these x2apic and PT MSRs are handled specially.
> + */
> +static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSGHROUGH_MSRS] = {

MAX_POSSIBLE_PASSGHROUGH_MSRS should be MAX_POSSIBLE_PASSTHROUGH_MSRS

> +       MSR_IA32_SPEC_CTRL,
> +       MSR_IA32_PRED_CMD,
> +       MSR_IA32_TSC,
> +       MSR_FS_BASE,
> +       MSR_GS_BASE,
> +       MSR_KERNEL_GS_BASE,
> +       MSR_IA32_SYSENTER_CS,
> +       MSR_IA32_SYSENTER_ESP,
> +       MSR_IA32_SYSENTER_EIP,
> +       MSR_CORE_C1_RES,
> +       MSR_CORE_C3_RESIDENCY,
> +       MSR_CORE_C6_RESIDENCY,
> +       MSR_CORE_C7_RESIDENCY,
> +};

Is there any reason not to construct this list on the fly?  That could
help prevent the list from becoming stale over time if this is missed
when calls to vmx_disable_intercept_for_msr() are added.

> +
>  /*
>   * These 2 parameters are used to config the controls for Pause-Loop Exiting:
>   * ple_gap:    upper bound on the amount of time between two successive
> @@ -622,6 +642,41 @@ static inline bool report_flexpriority(void)
>         return flexpriority_enabled;
>  }

One thing that seems to be missing is removing MSRs from the
permission bitmap or resetting the permission bitmap to its original
state before adding changes on top of it.  This would be needed on
subsequent calls to kvm_vm_ioctl_set_msr_filter().  When that happens
the original changes made by KVM_REQ_MSR_FILTER_CHANGED need to be
backed out before applying the new set.
