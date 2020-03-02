Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074B9C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2E622B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9dw+qDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgCBMyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:54:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22303 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727497AbgCBMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583153660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uio7FC4gUy07vPE5jHOFetkzB5/dTbCYvaj0gXJ70aY=;
        b=P9dw+qDG+2T1QJI7RFuRADkwOePGozLSoG0yibaJbmyzY0RMIroY9lZBG6sdtXbyyjQD+W
        5/7SzTx6VVYSlcKINzZTVixHCVqeshWO/1/945ozG87nWUaTubPFe0zyI1CrBHEtKFRE6T
        qjeMqQbZ01t1aE4TzPMkgQPM6JlUfuE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-S9qqkdAhNGiQhjOYOjqf_g-1; Mon, 02 Mar 2020 07:54:18 -0500
X-MC-Unique: S9qqkdAhNGiQhjOYOjqf_g-1
Received: by mail-wm1-f69.google.com with SMTP id c18so1222477wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 04:54:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uio7FC4gUy07vPE5jHOFetkzB5/dTbCYvaj0gXJ70aY=;
        b=i7inCuUQfN4iQ+vFjID3JP5oZG/0Jll0Q2/Bdz2hLnHfQRsudVp2PKUD9uOuFA1kYS
         Uh8cPod/+TcDpOKLx5RrHBNacAOH1rId3etUUMmgi7z4gP1/yaOFjFQhsqJ+sBXJwGME
         DX/XiyFbuFX11j7TPomZQcSeAVB60zI6hLa6/i3ON/m90/H7FJxbItUgtg+syFBOMQl5
         ltZqXqtSzGniY6wmrKG62cDVUKLQtPXpkkkRxEiXZTPm4iVh5QEPIhXYKy/y+92FudDm
         ki9WMGs5x6Y69rHCbH0lQJYd2+9ksUPx51AcLPBsyrDwkjpwCgY9UGIatH5W+9ApHcdg
         qpZw==
X-Gm-Message-State: ANhLgQ3SRbAwEA4+kLjA5NOh745yaEQE4d7SiudI5Dp/fycvIJ08I401
        pI3HGDSnO73GU7nooewDMrb/EKFqxNrZ5b0/AgzfXeq6fusxgPocM14mwCWfRh//0vf63bNbT2K
        /7bktV7GwIPES34TX35EqAD5D
X-Received: by 2002:a05:600c:351:: with SMTP id u17mr6272755wmd.22.1583153657283;
        Mon, 02 Mar 2020 04:54:17 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu04jKN+g6wcSyVSSwVKb7MS+iuJ47n+yTcTQbU+MMAorQDO+ZNDo97ikUeXVPR3pW0sjgjCA==
X-Received: by 2002:a05:600c:351:: with SMTP id u17mr6272735wmd.22.1583153657057;
        Mon, 02 Mar 2020 04:54:17 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id l17sm7282334wmi.10.2020.03.02.04.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 04:54:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Haiwei Li <lihaiwei.kernel@gmail.com>
Cc:     hpa@zytor.com, bp@alien8.de,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "joro\@8bytes.org" <joro@8bytes.org>, jmattson@google.com,
        wanpengli@tencent.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] KVM: SVM: Fix svm the vmexit error_code of WRMSR
In-Reply-To: <CAB5KdOZwZUvgmHX5C53SBU0WttEF4wBFpgqiGahD2OkojQJZ-Q@mail.gmail.com>
References: <CAB5KdOZwZUvgmHX5C53SBU0WttEF4wBFpgqiGahD2OkojQJZ-Q@mail.gmail.com>
Date:   Mon, 02 Mar 2020 13:54:15 +0100
Message-ID: <87o8tehq88.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haiwei Li <lihaiwei.kernel@gmail.com> writes:

>  From 1f755f75dfd73ad7cabb0e0f43e9993dd9f69120 Mon Sep 17 00:00:00 2001
> From: Haiwei Li <lihaiwei@tencent.com>
> Date: Mon, 2 Mar 2020 19:19:59 +0800
> Subject: [PATCH] KVM: SVM: Fix svm the vmexit error_code of WRMSR
>
> In svm, exit_code of write_msr is not EXIT_REASON_MSR_WRITE which
> belongs to vmx.

EXIT_REASON_MSR_WRITE is '32', in SVM this corresponds to
SVM_EXIT_READ_DR0. There were issues I guess. Or did you only detect
that the fastpath is not working?

>
> According to amd manual, SVM_EXIT_MSR(7ch) is the exit_code of VMEXIT_MSR
> due to RDMSR or WRMSR access to protected MSR. Additionally, the processor
> indicates in the VMCB's EXITINFO1 whether a RDMSR(EXITINFO1=0) or
> WRMSR(EXITINFO1=1) was intercepted.
>
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>

Fixes: 1e9e2622a149 ("KVM: VMX: FIXED+PHYSICAL mode single target IPI fastpath")

> ---
>   arch/x86/kvm/svm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index fd3fc9f..ef71755 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -6296,7 +6296,8 @@ static void svm_handle_exit_irqoff(struct kvm_vcpu
> *vcpu,
>          enum exit_fastpath_completion *exit_fastpath)
>   {
>          if (!is_guest_mode(vcpu) &&
> -               to_svm(vcpu)->vmcb->control.exit_code ==
> EXIT_REASON_MSR_WRITE)

There is an extra newline here (in case it's not just me).

> +               (to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_MSR) &&
> +               (to_svm(vcpu)->vmcb->control.exit_info_1 & 1))

Could we add defines for '1' and '0', like
SVM_EXITINFO_MSR_WRITE/SVM_EXITINFO_MSR_READ maybe?

>                  *exit_fastpath = handle_fastpath_set_msr_irqoff(vcpu);
>   }
>
> --
> 1.8.3.1
>

-- 
Vitaly

