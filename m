Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F12C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3947E206F8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wlbq/DL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389999AbgDBTXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:23:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36051 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388280AbgDBTXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585855390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cxt+LO+/D+LWZGAf62ME434VQmNIvwgAEaDvQHLIBZg=;
        b=Wlbq/DL7uBloOHCNJNjpxjeZzj5cUcjwVqLL8MZe6YxJ63YFkrUZgcZ53zDg16yA+AcGod
        Ak4mlDtTttOqr8oqGzwsQtGEbninpHwS0Va6xrjMMd/6rI6qmgc/rxAgGHf1VMm687UfyC
        RUBooECKffWJ1Csi1FmPS19eg9lI4x4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-zd_6lpFdPjG5Ir4N7ys80Q-1; Thu, 02 Apr 2020 15:23:08 -0400
X-MC-Unique: zd_6lpFdPjG5Ir4N7ys80Q-1
Received: by mail-wr1-f69.google.com with SMTP id w12so1885451wrl.23
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 12:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cxt+LO+/D+LWZGAf62ME434VQmNIvwgAEaDvQHLIBZg=;
        b=ZhqGLMwAGkHDxBIyhy6DunR425AEkW3j/J8YdKwJ4xp/8ErrGQshuDIY6wNrsaOujo
         5vOVp1JaT3lQjR2PPVmoOtKi1+UmtP6qqyRF4wlGI8sa7UXFs5zeiS+hBCqfRwppqctW
         ST74Lvp1ISlp1IH8lgajoGbfBaAZIV+cP8Uo22a+ybkB8ni+QJILp+6SQ3hxUX07ZZjc
         jy54KuX2riGG9JcJIbTPZIKVGauMcki/Ztu4DdFdvGrP6VzipOoIPWHfOrZ6Hc8VuT1S
         sYvOdFQX71U7geYUVvxrZqHDzfNlKN0bjztsBxyc/+SgyR+7Ssojrzk//MX7/1niRqIj
         OYwQ==
X-Gm-Message-State: AGi0PuYhJB5L7yiHnhpWy4Hjg715EbnPsNRgFLGfRBtFgDG5fYOE75DL
        MrprDCMUeNugddxzgUgHcNtWXXOlO99wzMKVn3mGZZEOy63Yn5LK8IQNM3dpN/vdFPcWhPV6eUr
        xuYMcma2BSwixV5QzHeObqjBS
X-Received: by 2002:a1c:9805:: with SMTP id a5mr4801362wme.119.1585855387493;
        Thu, 02 Apr 2020 12:23:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypIhqOMduV95ID1TOu+8/286w64w+I2dfqIZk2Y7Q7JUkbcQkwaQl5dfAOKAwswECuH8pPBbbQ==
X-Received: by 2002:a1c:9805:: with SMTP id a5mr4801347wme.119.1585855387242;
        Thu, 02 Apr 2020 12:23:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1868:42dd:216c:2c09? ([2001:b07:6468:f312:1868:42dd:216c:2c09])
        by smtp.gmail.com with ESMTPSA id v7sm8596686wrs.96.2020.04.02.12.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 12:23:06 -0700 (PDT)
Subject: Re: [PATCH -next] x86/kvm: fix a missing-prototypes "vmread_error"
To:     Qian Cai <cai@lca.pw>
Cc:     sean.j.christopherson@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200402153955.1695-1-cai@lca.pw>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e823923-4b81-8cb5-59f6-4376dc71fce2@redhat.com>
Date:   Thu, 2 Apr 2020 21:23:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402153955.1695-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/20 17:39, Qian Cai wrote:
> The commit 842f4be95899 ("KVM: VMX: Add a trampoline to fix VMREAD error
> handling") removed the declaration of vmread_error() causes a W=1 build
> failure with KVM_WERROR=y. Fix it by adding it back.
> 
> arch/x86/kvm/vmx/vmx.c:359:17: error: no previous prototype for 'vmread_error' [-Werror=missing-prototypes]
>  asmlinkage void vmread_error(unsigned long field, bool fault)
>                  ^~~~~~~~~~~~
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/kvm/vmx/ops.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/vmx/ops.h b/arch/x86/kvm/vmx/ops.h
> index 09b0937d56b1..19717d0a1100 100644
> --- a/arch/x86/kvm/vmx/ops.h
> +++ b/arch/x86/kvm/vmx/ops.h
> @@ -12,6 +12,7 @@
>  
>  #define __ex(x) __kvm_handle_fault_on_reboot(x)
>  
> +asmlinkage void vmread_error(unsigned long field, bool fault);
>  __attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
>  							 bool fault);
>  void vmwrite_error(unsigned long field, unsigned long value);
> 

Merged, thanks.

Paolo

