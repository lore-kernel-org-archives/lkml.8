Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAB2C35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2832469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOiS86vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgB0Rzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:55:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43569 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbgB0Rzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:55:45 -0500
Received: by mail-io1-f65.google.com with SMTP id n21so383895ioo.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 09:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NylVHJE6upVF29IVdBuSvP++A0hZb65rcSiVqx/spX0=;
        b=eOiS86viM71jTaieN8tpKi/iZHr0ck18Lvx7IOIytjUhy17X68LguUFd/elbTXuZLH
         lM6D06RdoG36UyIH1ELD/OKP4tk2qxDf3avqVhYoVcNgtYw3AgmEXz0Av6gshpEehdP/
         AO0BzoR/+HGd1J+/TYdPwercOcnCP44Om7rOZiJIJovsCbo5eT78DOyShKW9mdw8lSH/
         x/QD7aSj0jOfyn4RMFjxgL48f2ZF00YY4/95eP/WgT9N0lCVpWGsHzbS6fecmWThDueV
         ywuDRWa2kMVvy00eIgULbTOZdthUVPjBNVtNwrwWvMIPB/BmthzIxfXLtVyUOZW9vuou
         3uOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NylVHJE6upVF29IVdBuSvP++A0hZb65rcSiVqx/spX0=;
        b=uKUtVbfZJ4Lmx+fmoIjEKhAp7SPW5dPO7VRk29AO9C5qNUFmLVkqNU9vsWxVl4FXqU
         iJSARnEXF7zduupFSehup1hdt/miRD5gh7qfhG/a0iHkgfZJV/k3ko6/LzNLLXvUTXbb
         t3UVTTZaLnZcPy19+Re2KExri6yAgpoBp65fnH0BxkNQbX3bGgvqj00MGZw+iB4mlnff
         iPXmrFTUba+NpT5ikxzBukGoizB2lAt1lXLhDRJUewfex5BLATj5zMRNi3eg5t4+LE6v
         tPEqftzMUh64WLVkjiWMIAQ+AWcNYrK7BrMN93+QBqe1zhcH4MpOkiOFZl1QXEy3xysu
         09ww==
X-Gm-Message-State: APjAAAU3YF2BYmy46w/hiP3bJYTxZvasjyA1i+17RCy+7g5uLN5dTZ5R
        JHO09ReWwAaIBVdQEt9iCEOXatKvqN9Igf5DrY6xzA==
X-Google-Smtp-Source: APXvYqwFptUgwySCKOI0OSvyxECMDGUM5f6sOv8slHlp/a4KD/nPi+VDoaD1TXchnUg04QgiHVgi/lUA/uQgZeQjMAg=
X-Received: by 2002:a05:6602:2c91:: with SMTP id i17mr443965iow.26.1582826143722;
 Thu, 27 Feb 2020 09:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20200227172306.21426-1-mgamal@redhat.com> <20200227172306.21426-3-mgamal@redhat.com>
In-Reply-To: <20200227172306.21426-3-mgamal@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 27 Feb 2020 09:55:32 -0800
Message-ID: <CALMp9eR7heTGQ6zwYrK5rJ-xs_wKqz49gfcNtaEC7S6J7n2aFQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] KVM: VMX: Add guest physical address check in EPT
 violation and misconfig
To:     Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 9:23 AM Mohammed Gamal <mgamal@redhat.com> wrote:
>
> Check guest physical address against it's maximum physical memory. If
Nit: "its," without an apostrophe.

> the guest's physical address exceeds the maximum (i.e. has reserved bits
> set), inject a guest page fault with PFERR_RSVD_MASK.
>
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 63aaf44edd1f..477d196aa235 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5162,6 +5162,12 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
>         gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
>         trace_kvm_page_fault(gpa, exit_qualification);
>
> +       /* Check if guest gpa doesn't exceed physical memory limits */
> +       if (gpa >= (1ull << cpuid_maxphyaddr(vcpu))) {
> +               kvm_inject_rsvd_bits_pf(vcpu, gpa);

Even if PFERR_RSVD_MASK is set in the page fault error code, shouldn't
we set still conditionally set:
    PFERR_WRITE_MASK - for an attempted write
    PFERR_USER_MASK - for a usermode access
    PFERR_FETCH_MASK - for an instruction fetch

> +               return 1;
> +       }
> +
>         /* Is it a read fault? */
>         error_code = (exit_qualification & EPT_VIOLATION_ACC_READ)
>                      ? PFERR_USER_MASK : 0;
> @@ -5193,6 +5199,13 @@ static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
>          * nGPA here instead of the required GPA.
>          */
>         gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> +
> +       /* Check if guest gpa doesn't exceed physical memory limits */
> +       if (gpa >= (1ull << cpuid_maxphyaddr(vcpu))) {
> +               kvm_inject_rsvd_bits_pf(vcpu, gpa);

And here as well?

> +               return 1;
> +       }
> +
>         if (!is_guest_mode(vcpu) &&
>             !kvm_io_bus_write(vcpu, KVM_FAST_MMIO_BUS, gpa, 0, NULL)) {
>                 trace_kvm_fast_mmio(gpa);
> --
> 2.21.1
>
