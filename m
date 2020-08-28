Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06217C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FBA2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYbDgKBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgH1SYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1SX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 14:23:56 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A319DC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 11:23:56 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id k63so512966oob.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iXkGuZDPH4c7YYMkQMRwiYMRp5lf9MC5NLMKzhRWWI=;
        b=dYbDgKBbk0VjD6Y/A7wPhWL9z+uEz/dNKUmyetpjnIGuq277TcZgnKD/U2KIUTyLEQ
         FUzpxvVBvO8f/VDWiixr0WMaqSsIKHUL8oMIje1HEtU0/eTy3Cx3aZ1JyufdJUql1l0O
         rKqyYCs9I7gyhfJx309EBd9rXd274mgypn0ovu0XZjDgs+OqpCgo4mYxLz9X9MmaXB6j
         cHUFuOFhKM0DUI165h9NviZX9SiCnkE83onyl/oFaC+eHobxPGWMH7tXqChHwDffmb1P
         mxrF+mejSYCg/PSky2/fN1T18S5XzusIOBna49BqaBLgkGRKed9Hvi3zfIn+vQI4GFvj
         N9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iXkGuZDPH4c7YYMkQMRwiYMRp5lf9MC5NLMKzhRWWI=;
        b=qg6E4U8lAfjqVUV4dbIcGF90/upO8AZvD7DJSChLZLWIpM/LFPjSZ76RC1k+AQNRwm
         sBFs4eFg+DIBu1ikwmGY71HOs13c9nrHz1K/BYdAxeXnBqlLSKkMFpAnptOyTzerZ3NA
         OkL1efRBwfPgL0c84GCvQMsnhpBJTdPaMnla1zGFuAlR5TIYFRkht1idb1+h5T5Mnkev
         T9O+VaikO2Bf+7B+YOX6M9NO46FLQTbjrM8OkwPUFzL3HxTAJZaHqc5hqPqgHwEAxgtX
         rAcHBqCZJ/5rjde2OlA+SYExVXIMKCTd0qlyTrv9Fnc70mr+DSiCgurvqLdnRUg+4uJk
         fDCQ==
X-Gm-Message-State: AOAM533BCaTYdKXWmmTaKZ/QV4yYcIZxJhQmcu3vOvdHOYuJMdrRbuif
        IVzM6FbYbfuO83HWn+M39qzxS3/b1aOcNS/8MbwrYg==
X-Google-Smtp-Source: ABdhPJySAuOpV6dilUu/GNbZMtR+q2kM1vv4eGjjRdnlsLx632hTsZax7LCdUkUWwJqPAFjX2AzrVEdSEI0IuaThf9s=
X-Received: by 2002:a4a:3015:: with SMTP id q21mr2381852oof.55.1598639035545;
 Fri, 28 Aug 2020 11:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200828085622.8365-1-chenyi.qiang@intel.com> <20200828085622.8365-3-chenyi.qiang@intel.com>
In-Reply-To: <20200828085622.8365-3-chenyi.qiang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 28 Aug 2020 11:23:43 -0700
Message-ID: <CALMp9eTDTeKQrCnYsSsMPF3-0N=GW7QPOQY8xg4oiCcmv8hgYA@mail.gmail.com>
Subject: Re: [PATCH 2/5] KVM: nVMX: Verify the VMX controls MSRs with the
 global capability when setting VMX MSRs
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
> When setting the nested VMX MSRs, verify it with the values in
> vmcs_config.nested_vmx_msrs, which reflects the global capability of
> VMX controls MSRs.
>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>

You seem to have entirely missed the point of this code, which is to
prevent userspace from adding features that have previously been
removed for this vCPU (e.g as a side-effect of KVM_SET_CPUID).
