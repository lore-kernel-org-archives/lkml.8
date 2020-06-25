Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F14C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796B4206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMNPIkKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390891AbgFYJeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:34:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27195 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390025AbgFYJeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593077660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X3/CoGz/NWenAAMC8TdUU7tz4aPqJHOm/DKPIoXzmHs=;
        b=NMNPIkKGrfpz+NxoQnjW2qQ87jk0VDOpTejnPv/2q0EJC9L7u+/wlwCDMKK1ZNMHkTfJ0R
        66kRWYJ3T1+7uHYmybR+r0BvtokNty4xJES7v/JvV+jao+1BCTIqjBujPnfWpxSt8YLX1Z
        GdtiJPOKRAAQYclvz3e5r3luwdE15vI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-yCJRN7wxMpuX8h_9MHCFng-1; Thu, 25 Jun 2020 05:34:18 -0400
X-MC-Unique: yCJRN7wxMpuX8h_9MHCFng-1
Received: by mail-wr1-f71.google.com with SMTP id p10so6403716wrn.19
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=X3/CoGz/NWenAAMC8TdUU7tz4aPqJHOm/DKPIoXzmHs=;
        b=a/cZSoTR6pMhGbeSsJbAbBZIwJ2u4oG6GtQBNZOjAVR+DVJcYPPbSKq4d3eApd/cBR
         CJyJsHGmDxV4X7o71QZJFspu4z1ZVL0R0WFPmJ/5ugKYQtEjQaizYXvuAiimQwRnDBy8
         H29FqKOIua3FSXSlc8YBr77LQsIhkfgo6TxY5+aD0568d0UpsRhiEqljEH0boCGo/ZdI
         CxajFeQHPHPuUav1a5MCyoRN2Ja9HJHQsFMoyY8gPK3s8X4JOI3p8USZ1iESH5PRtdWx
         TQTQgw/DQHKuUBn8cG0WUaWBLLXMiLyARheCcjZNls8sP2pvSaBLi9Cind8w3fMINRzd
         5WiA==
X-Gm-Message-State: AOAM530qFKFWDO4hN93GQiPKtlNonI74UOxl+YegnONGQ1ZoBdsRMidQ
        w6nTOc9EyeN7cGHGOwLI1CpaSpoM06KUOAXALWpBg0KMcjLvzly1My5jb5SbAWWpzZy+Z/+SKWW
        J8o1AVmgJeAwRsOOtThJkLgyZ
X-Received: by 2002:adf:e648:: with SMTP id b8mr36650751wrn.386.1593077657052;
        Thu, 25 Jun 2020 02:34:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO9rxFO6NydlVlkFTYJOZIr4JNxTX3tcKMvj9G0tZ4+At9YfEzvpMMWp1NSAjw90OcVZBk8g==
X-Received: by 2002:adf:e648:: with SMTP id b8mr36650724wrn.386.1593077656790;
        Thu, 25 Jun 2020 02:34:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c66sm12336747wma.20.2020.06.25.02.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 02:34:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 0/4] KVM: SVM: Code move follow-up
In-Reply-To: <20200625080325.28439-1-joro@8bytes.org>
References: <20200625080325.28439-1-joro@8bytes.org>
Date:   Thu, 25 Jun 2020 11:34:14 +0200
Message-ID: <87r1u3cwvd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Roedel <joro@8bytes.org> writes:

> From: Joerg Roedel <jroedel@suse.de>
>
> Hi,
>
> here is small series to follow-up on the review comments for moving
> the kvm-amd module code to its own sub-directory. The comments were
> only about renaming structs and symbols, so there are no functional
> changes in these patches.
>
> The comments addressed here are all from [1].
>
> Regards,
>
> 	Joerg
>
> [1] https://lore.kernel.org/lkml/87d0917ezq.fsf@vitty.brq.redhat.com/
>

Thank you for the follow-up!

> Joerg Roedel (4):
>   KVM: SVM: Rename struct nested_state to svm_nested_state
>   KVM: SVM: Add vmcb_ prefix to mark_*() functions
>   KVM: SVM: Add svm_ prefix to set/clr/is_intercept()
>   KVM: SVM: Rename svm_nested_virtualize_tpr() to
>     nested_svm_virtualize_tpr()
>
>  arch/x86/kvm/svm/avic.c   |   2 +-
>  arch/x86/kvm/svm/nested.c |   8 +--
>  arch/x86/kvm/svm/sev.c    |   2 +-
>  arch/x86/kvm/svm/svm.c    | 138 +++++++++++++++++++-------------------
>  arch/x86/kvm/svm/svm.h    |  20 +++---
>  5 files changed, 85 insertions(+), 85 deletions(-)

Series:
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

