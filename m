Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFACC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85846206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8ZHdAig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgDPVeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgDPVeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:34:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB6CC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 14:34:06 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o127so89010iof.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 14:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TPezPECUKOwAGB1jeVzVXF9iCR+5ADFws6BKwwbizc=;
        b=L8ZHdAigb7rztBqPmzv1Wr3oBMfKTeVUJzOlwoAqCki5iP/+Ph2qQ9QmvsqjiI78wr
         b8mcyDA7M5AEGBxKnri7090GioBy7YcYX+/fA7E8SbfvXVQMBoOGei6QFiNFV6pbmGhx
         URtmXYhIyBHa9vnqaQF+WHenD3KJBKa+ltxSijIDFsvwdkylsah1fiJgbM52NL0AiUsn
         91ccjFMOSucVrljfbPpVeflKDDCJ7EeMKO7ZPYpfa+ZkG0iHLbI0Eevud4VnJcGtvv7b
         +eI0hi9/OPbZjUsChCJSiQTCK0g0OPdCoPNbNExx4hSnpad/bK2lAdbQ62l5z/g4qAvb
         P9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TPezPECUKOwAGB1jeVzVXF9iCR+5ADFws6BKwwbizc=;
        b=cD7p87gYrjZdsyUAoljDzI8oH6YWOO38oVDf31YSu5sSjejhrSqUXzMaWxQyheUha8
         6AOd2pjVtJ6T5thDSpKd53MSOeVW1tXDRacFWScN1kSBQDPpH15YyCGgQrG0PdM4g5IG
         xZTPuNu/x3+SSfpDrn7ymQJK2nXF8uq13xtlDiqhroUZ7vRFJO7zXqtG1OS5EQGToEY6
         sV40DU6WioXsdYQGKsgwiSWOROW5iTxyCB5EOTGG1ARAzwfzXGmeSy/8Jxhg8ZBE262I
         URS5pR+wE1lLiB7y14tmTgT4xoN0YTlEto6+8SoP+7sGPQCU8q/AIdYp+7HYTijpTO/o
         gVIw==
X-Gm-Message-State: AGi0Puay/HbPfzteNIDuXzil3/92hHntnbdC/CK+f6gi8iAWj70Zct4J
        M/Gjg6lLEQ+uiNukb4hSt1LW90Olk+WrNKWULVMZug==
X-Google-Smtp-Source: APiQypLrnL64Nsr0s40zEsJnABAfQ/0uJW+UGGpZoZyX9B3baRbF2EyT+Oszief9+BiZgV4RwH5jr0uQTlTp/BL11Ow=
X-Received: by 2002:a5e:a610:: with SMTP id q16mr590633ioi.75.1587072845762;
 Thu, 16 Apr 2020 14:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200415214414.10194-1-sean.j.christopherson@intel.com> <20200415214414.10194-2-sean.j.christopherson@intel.com>
In-Reply-To: <20200415214414.10194-2-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 16 Apr 2020 14:33:54 -0700
Message-ID: <CALMp9eTaLwj7kXgvACFQ_42+F7pnOvaAd02_2o4tG2fX5+JQaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Set @writable to false for non-visible
 accesses by L2
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 2:44 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Explicitly set @writable to false in try_async_pf() if the GFN->PFN
> translation is short-circuited due to the requested GFN not being
> visible to L2.
>
> Leaving @writable ('map_writable' in the callers) uninitialized is ok
> in that it's never actually consumed, but one has to track it all the
> way through set_spte() being short-circuited by set_mmio_spte() to
> understand that the uninitialized variable is benign, and relying on
> @writable being ignored is an unnecessary risk.  Explicitly setting
> @writable also aligns try_async_pf() with __gfn_to_pfn_memslot().
>
> Jim Mattson <jmattson@google.com>
Go ahead and preface the above with Reviewed-by:
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index c6ea6032c222..6d6cb9416179 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4090,6 +4090,7 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
>          */
>         if (is_guest_mode(vcpu) && !kvm_is_visible_gfn(vcpu->kvm, gfn)) {
>                 *pfn = KVM_PFN_NOSLOT;
> +               *writable = false;
>                 return false;
>         }
>
> --
> 2.26.0
>
