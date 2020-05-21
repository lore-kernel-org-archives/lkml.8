Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42134C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF192072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8/fgY66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgEUMvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 08:51:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54549 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728222AbgEUMvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 08:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590065464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8r9b3WKmFH8x00N7WEjSsV4mj5QT0SricNOgzeLgeo=;
        b=e8/fgY66vaz+DkaPoKJXi5L5cskbw1K0JVRmOIVZJv8ISLqZIUavn/BMQWnZnsXha4grqf
        xzrG2AKqISWDJrOOLC4TZjAn+dAP9/MTvHXj0kSDcWYLd5FaibZJSvqBPDt47MPt9FtDCi
        votedtwRHNDINzbmtB+MHPvOIwb1UEU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-oAYeEwGaPfydolTcZ2H3Yg-1; Thu, 21 May 2020 08:51:00 -0400
X-MC-Unique: oAYeEwGaPfydolTcZ2H3Yg-1
Received: by mail-ej1-f71.google.com with SMTP id u9so2828368ejz.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 05:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=I8r9b3WKmFH8x00N7WEjSsV4mj5QT0SricNOgzeLgeo=;
        b=hfMk/pCspcnS+MbmFPL4rNsR9SbSGevqtyO5vHMAO/Jdp2nyCBU2UMirBZUViCgolq
         JX3I35j9anwFytpnZtOyk6RREhkMxCbiFj0zfCarz+ISQzJqLSX7fuCwe2l0yaz002HG
         hrU89fVCA2og6lMS/dn1OumBhWM9U7Vr/xv371NO6PA+7XtRu2ykOyJol/NG2pW1zgBQ
         Wfcr13O/WNS3dv65t3gTbostjxPXP5kArOLrh8PDBRRr0tnaSd3UYyoiI4Qq9IkZmUTk
         JbmjegEkJILOJJC4Dl8Le+42YgKGXs9fMsWx8ZXiqIbytkiHEV3kUcKbFLxPjP7f/IUb
         S5ug==
X-Gm-Message-State: AOAM532d/OJz62ZMQvqzxV7IOcH6GCrHTZWLrAPfxJJzG2v66tfg+bL4
        +JRU9dj+KJgASB7XmpHlz9rSVOpGirY4eB7IME2wMWwrMXM6fhEp0AfT9Rix6DxpRK7k9tziQ/J
        BqMO0OGJaNqfewNATI1BExKaY
X-Received: by 2002:a50:9a86:: with SMTP id p6mr7633390edb.153.1590065459326;
        Thu, 21 May 2020 05:50:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXrIhCP1DTKfr0JnNOc4ivRO8cZw1JfFcEy/90FjXovtXUz6eXY3PV1UDasKGJ7973lC0o3g==
X-Received: by 2002:a50:9a86:: with SMTP id p6mr7633376edb.153.1590065459007;
        Thu, 21 May 2020 05:50:59 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c15sm4736175ejx.62.2020.05.21.05.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 05:50:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     wei.huang2@amd.com, cavery@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 03/22] KVM: SVM: immediately inject INTR vmexit
In-Reply-To: <20200424172416.243870-4-pbonzini@redhat.com>
References: <20200424172416.243870-1-pbonzini@redhat.com> <20200424172416.243870-4-pbonzini@redhat.com>
Date:   Thu, 21 May 2020 14:50:57 +0200
Message-ID: <87blmhsb7y.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> We can immediately leave SVM guest mode in svm_check_nested_events
> now that we have the nested_run_pending mechanism.  This makes
> things easier because we can run the rest of inject_pending_event
> with GIF=0, and KVM will naturally end up requesting the next
> interrupt window.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm/nested.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index e69e60ac1370..266fde240493 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -778,13 +778,13 @@ int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
>  
>  static void nested_svm_intr(struct vcpu_svm *svm)
>  {
> +	trace_kvm_nested_intr_vmexit(svm->vmcb->save.rip);
> +
>  	svm->vmcb->control.exit_code   = SVM_EXIT_INTR;
>  	svm->vmcb->control.exit_info_1 = 0;
>  	svm->vmcb->control.exit_info_2 = 0;
>  
> -	/* nested_svm_vmexit this gets called afterwards from handle_exit */
> -	svm->nested.exit_required = true;
> -	trace_kvm_nested_intr_vmexit(svm->vmcb->save.rip);
> +	nested_svm_vmexit(svm);
>  }
>  
>  static bool nested_exit_on_intr(struct vcpu_svm *svm)

Sorry for reporting this late but I just found out that this commit
breaks Hyper-V 2016 on KVM on SVM completely (always hangs on boot). I
haven't investigated it yet (well, this is Windows, you know...) but
what's usually different about Hyper-V is that unlike KVM/Linux it has
handlers for some hardware interrupts in the guest and not in the
hypervisor.

-- 
Vitaly

