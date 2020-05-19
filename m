Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AFBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE885207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdoOvzQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgESShu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgESSht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:37:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DFCC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:37:49 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a4so355181lfh.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukq4U4bhaGx/BxEZICOHMgvvHCN7gRfX69OD8Ug5nJ8=;
        b=hdoOvzQyr8p/pfR0tzbZhD8bTdnTt2VJ2wiF59WLjGel9YDl0tBbxVRNmo26mqAl8H
         k3/jRCp08thphnuZ7k8Qjs1/bJstD78aUCPaIwHKLlbTCaSfOW0bU5d1I+toorKpe2VG
         jFSrSspHLMGpRYjpqeQykoRqCQt/pEwLQ9a2NvFfh3zH44bU6EvXIv+MD7+oTHrHU5uN
         +OZ3ZAR7bDB374NxNFM3tPhYEmzMj+sq9FWua3dciQZzrKgoWhYfUrlJVNfi1WjjFiH+
         6og6li06vwaldl8PbxCLo/W0VxGttcxI6MCAjO1pVo2M7YKz3BLW+RCcFpQNY5i/iYpQ
         biQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukq4U4bhaGx/BxEZICOHMgvvHCN7gRfX69OD8Ug5nJ8=;
        b=J7qbSLfwLYFC3xTqz956VEdKdzZIJJK4k4kGHiqFOIFZtOPekcjrAaqetxCAlMk9ei
         86nKAAucTf2OsJXCCqaEVqstHo/U6OPaQheGcM9dlDr0FmN8PZEToZ8KoU7jKCYiKRyq
         oGy80K9FilWJ1UrnAIq810n+Ijp1UozWU010+6gKPxcZ8fZ8UZdUwZC/otBqyBYTqAYn
         8WntBSkE3TAN344mqwxSAtGYy+V/lssQyxEqHukeS9gh8vKfYz6JTIbOIs3/7fximB/F
         JVh4c/xg0ewVLPM0j9SDTMbWuTGyR9TYjtbUBCRSV+XJpdyhtwgSjHd87V3oziV8kykI
         NEJQ==
X-Gm-Message-State: AOAM530R6oZGnZaFXCxurDxzBLO0nkoqh0XrD1nCyCLxbYo3Y4wsim+L
        RWZE6ysN+Rjjzbp0gkWy5fbwwq5eBsvtCV7/sA0k6zLO
X-Google-Smtp-Source: ABdhPJzr9vyjWv7gfSfaxwWVJ2jAs3pdmlMuqe+6/DgxR/ifbfGj5DK9NaIwRduB9SggkajLVrwGSluKTmNHk1R/usQ=
X-Received: by 2002:a19:ed17:: with SMTP id y23mr163055lfy.162.1589913467376;
 Tue, 19 May 2020 11:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200519180743.89974-1-pbonzini@redhat.com>
In-Reply-To: <20200519180743.89974-1-pbonzini@redhat.com>
From:   Oliver Upton <oupton@google.com>
Date:   Tue, 19 May 2020 11:37:36 -0700
Message-ID: <CAOQ_Qsi7EZ6CYOrbCgZLmBFBaBgXWEu=50RrUROg8x5pyTy-SA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: allow KVM_STATE_NESTED_MTF_PENDING in kvm_state flags
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:07 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The migration functionality was left incomplete in commit 5ef8acbdd687
> ("KVM: nVMX: Emulate MTF when performing instruction emulation", 2020-02-23),
> fix it.
>
> Fixes: 5ef8acbdd687 ("KVM: nVMX: Emulate MTF when performing instruction emulation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Oliver Upton <oupton@google.com>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4f55a44951c3..0001b2addc66 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4626,7 +4626,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>
>                 if (kvm_state.flags &
>                     ~(KVM_STATE_NESTED_RUN_PENDING | KVM_STATE_NESTED_GUEST_MODE
> -                     | KVM_STATE_NESTED_EVMCS))
> +                     | KVM_STATE_NESTED_EVMCS | KVM_STATE_NESTED_MTF_PENDING))
>                         break;
>
>                 /* nested_run_pending implies guest_mode.  */
> --
> 2.18.2
>
