Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8BAC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D782084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPnf4qH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgEGQTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:19:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58411 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727845AbgEGQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588868345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WPWPHe3pgTIBihcXGk8hJCaqBjbGv2lpjNArereGrgk=;
        b=fPnf4qH7qFk0fu7Y05MwVO7zfoT0G63u2FOHKHfg77J+A/o0B5VTta6HHaAqGJgKOhSUZd
        GZiCxvneLUCZQJdBs7oBDYkUBfjBC9QJivE6jkb+F6UVmTucHJDUn+M3mabzgkM7WZ61mi
        E5ObdqfgYpGuCHO8lW9rTwQAHBc8Bzg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-_9kMBvvbMsGUNyybba33Ag-1; Thu, 07 May 2020 12:18:57 -0400
X-MC-Unique: _9kMBvvbMsGUNyybba33Ag-1
Received: by mail-qk1-f200.google.com with SMTP id x5so6277794qkn.20
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 09:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WPWPHe3pgTIBihcXGk8hJCaqBjbGv2lpjNArereGrgk=;
        b=ZoQDKirMVqFEZDm+YlE4H+c3zY426W6wmO24DQ/Ey6O/3TGk9OJV2tsrrm0mqhvuND
         Lp/bMSiwyUflZCpU6sl8aYiIcfzv/eU3a3ach2Bg1cCY2q67+73inegdMaqpyXvTdey7
         5Ues98b3U6jf9CtOe6gTMvdSeR64md2IYg83WqX2+Dg6k+oDzX8HKhjQdppQB6EGph5E
         /OCTavqTzMvNuRTu+a2mBITY9jGCfvwBEMXiR+VnZQgwZpDHv3sm+mMmYVOEgGvgsg8N
         cLsqEspakig94AsZegj5tMszjpfP4xcC8wbPLRhvf6LtEGKBPb9uI/R5g1JmrkFCH8Hz
         Z7LQ==
X-Gm-Message-State: AGi0Pub4uTZWPt2fSgqrEtnrBaR5BMBPL75hb+knp7ImeTfhnwkPX3oe
        ZmNsVllX3SNZ4tB7AaqfbR5L/7JYac+WQCbWEet6AW2wMeL3L4weMVm60fTDfx4oJ4tAgBBRj/i
        7TDNONzSymHU+yxe2KgOI1Z9g
X-Received: by 2002:ac8:5057:: with SMTP id h23mr14783766qtm.287.1588868336833;
        Thu, 07 May 2020 09:18:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypKMXRz+2RdT4/NUmlbtskmTYfoso9urd97IW1y5qNWjs9Os8BEJwCtLJ++jqbfn/vjqoo8YLg==
X-Received: by 2002:ac8:5057:: with SMTP id h23mr14783733qtm.287.1588868336490;
        Thu, 07 May 2020 09:18:56 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id i43sm2874675qte.37.2020.05.07.09.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 09:18:55 -0700 (PDT)
Date:   Thu, 7 May 2020 12:18:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 9/9] KVM: VMX: pass correct DR6 for GD userspace exit
Message-ID: <20200507161854.GF228260@xz-x1>
References: <20200507115011.494562-1-pbonzini@redhat.com>
 <20200507115011.494562-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507115011.494562-10-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:50:11AM -0400, Paolo Bonzini wrote:
> When KVM_EXIT_DEBUG is raised for the disabled-breakpoints case (DR7.GD),
> DR6 was incorrectly copied from the value in the VM.  Instead,
> DR6.BD should be set in order to catch this case.
> 
> On AMD this does not need any special code because the processor triggers
> a #DB exception that is intercepted.  However, the testcase would fail
> without the previous patch because both DR6.BS and DR6.BD would be set.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c                        |  2 +-
>  .../testing/selftests/kvm/x86_64/debug_regs.c | 24 ++++++++++++++++++-
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e2b71b0cdfce..e45cf89c5821 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4927,7 +4927,7 @@ static int handle_dr(struct kvm_vcpu *vcpu)
>  		 * guest debugging itself.
>  		 */
>  		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
> -			vcpu->run->debug.arch.dr6 = vcpu->arch.dr6;
> +			vcpu->run->debug.arch.dr6 = DR6_BD | DR6_RTM | DR6_FIXED_1;

After a second thought I'm thinking whether it would be okay to have BS set in
that test case.  I just remembered there's a test case in the kvm-unit-test
that checks explicitly against BS leftover as long as dr6 is not cleared
explicitly by the guest code, while the spec seems to have no explicit
description on this case.

Intead of above, I'm thinking whether we should allow the userspace to also
change dr6 with the KVM_SET_GUEST_DEBUG ioctl when they wanted to (right now
iiuc dr6 from userspace is completely ignored), instead of offering a fake dr6.
Or to make it simple, maybe we can just check BD bit only?

Thanks,

>  			vcpu->run->debug.arch.dr7 = dr7;
>  			vcpu->run->debug.arch.pc = kvm_get_linear_rip(vcpu);
>  			vcpu->run->debug.arch.exception = DB_VECTOR;

-- 
Peter Xu

