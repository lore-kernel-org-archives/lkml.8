Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1571246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NC1u/Aoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgB1JgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:36:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46635 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726631AbgB1JgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582882574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xGQ30kUvc7fIP0RyINOYfwYjQETpcqZNSK+cVjV0fQQ=;
        b=NC1u/AoaRwfKzkEGtvQ+Q/3URcJfhhSFpgKANRQKmLu3sNhvqaMrYH6VMNBvLjiELnwO4N
        C3gV1GFRQataJIHbZBWUQuagvzhWYf0C80HVRTEhnYtXqRb5lnVWyCsoIaJqt1SQQX2vei
        Zm2hw1T/rvB9n4A0uo7vZDSJqH1sVzY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-Kr67Z03PPb26glRiqH13XA-1; Fri, 28 Feb 2020 04:36:12 -0500
X-MC-Unique: Kr67Z03PPb26glRiqH13XA-1
Received: by mail-wm1-f71.google.com with SMTP id p4so132607wmp.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 01:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xGQ30kUvc7fIP0RyINOYfwYjQETpcqZNSK+cVjV0fQQ=;
        b=WqStI4TsD5ECT8/fqlMa2/JY2Q4bVxj3liOvoynAbZt5HIi63YY3xnSSnbyihkVSo9
         TlY8+Re3wKTa30j8Cf6OnFuPms7bV++T443xXyZUuvRdoJB+NUWsTyfWnTEVTkqmLjcE
         kJ17Ghl25e+tUGtRYslnR2Gm4HjM1U9tprklGS/b51p0fHHAOcQpCUMPQquJNy9+egN+
         UYb3V9GH2csgau1LYzXuWNhUq2MfrRsFe+sFAhvOoOUKMSUBylFtGnNzq5KODQoqm3s/
         SH/TvjGFH7FOyEk7eSLWJzplzjDRbAJvvCD4Y5DjDJEOB1ZTzB9JkI7IHXOexlQH+MBH
         JjEg==
X-Gm-Message-State: APjAAAXDtg4S44TX8SCEnH2nduBj94TJwwTHHFVSBznhaFeGG7V9tGn2
        M80lm6QUhXlT6FHteHyJV5V7SHhrH99mh+8ZNYYqGLJHhpqRSFHnPNNPz35ExZRwuMhxKo600E/
        gsQBBApi3K5ThAAumVJq8pPJl
X-Received: by 2002:a05:600c:3d1:: with SMTP id z17mr4119297wmd.90.1582882571464;
        Fri, 28 Feb 2020 01:36:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMpaEMR5F3/oHm6BUQh6V6cohnmDW6MF7pyQrno3k4L7OwqhL0nlcd2ky/TZgElcMLgwXadw==
X-Received: by 2002:a05:600c:3d1:: with SMTP id z17mr4119276wmd.90.1582882571220;
        Fri, 28 Feb 2020 01:36:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f? ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
        by smtp.gmail.com with ESMTPSA id u23sm1371280wmu.14.2020.02.28.01.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 01:36:10 -0800 (PST)
Subject: Re: [PATCH] KVM: nVMX: allow compiling with W=1
To:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <263441.1582858192@turing-police>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <96d8eb48-2961-8b85-9687-6bbc27e443a9@redhat.com>
Date:   Fri, 28 Feb 2020 10:36:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <263441.1582858192@turing-police>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/20 03:49, Valdis Klētnieks wrote:
> Compile error with CONFIG_KVM_INTEL=y and W=1:
> 
>   CC      arch/x86/kvm/vmx/vmx.o
> arch/x86/kvm/vmx/vmx.c:68:32: error: 'vmx_cpu_id' defined but not used [-Werror=unused-const-variable=]
>    68 | static const struct x86_cpu_id vmx_cpu_id[] = {
>       |                                ^~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> When building with =y, the MODULE_DEVICE_TABLE macro doesn't generate a
> reference to the structure (or any code at all).  This makes W=1 compiles
> unhappy.
> 
> Wrap both in a #ifdef to avoid the issue.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 40a1467d1655..5c2fc2177b0d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -65,11 +65,13 @@
>  MODULE_AUTHOR("Qumranet");
>  MODULE_LICENSE("GPL");
>  
> +#ifdef MODULE
>  static const struct x86_cpu_id vmx_cpu_id[] = {
>  	X86_FEATURE_MATCH(X86_FEATURE_VMX),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, vmx_cpu_id);
> +#endif
>  
>  bool __read_mostly enable_vpid = 1;
>  module_param_named(vpid, enable_vpid, bool, 0444);
> 

Queued, and doing the same for AMD.

Paolo

