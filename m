Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF74C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75F720748
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeKlZYd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgGCA6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 20:58:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24847 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbgGCA6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593737926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5zlrXGxKm/JoU8AA+dwl+T//yIRszGny2ohMnMEEFxY=;
        b=WeKlZYd3kCEHbMpMc5VhRjr8h8onzGDiAOqD4Hqq/YXHT6tTVU81ECDtG20qpsmuhtIjpx
        5EroAiN9SbQ0Cb9QiyuSjALS5LsMtB+3iQ3aXsTzo1ZPzcD7FU13a1kc4pSEHO3vUFjYAX
        wB37xE/LAnCeBvrk2OajsUsW79PtYTI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-djBtNSjPNC-mZWSzJtXbhg-1; Thu, 02 Jul 2020 20:58:42 -0400
X-MC-Unique: djBtNSjPNC-mZWSzJtXbhg-1
Received: by mail-qk1-f197.google.com with SMTP id p126so4470340qkf.15
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 17:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5zlrXGxKm/JoU8AA+dwl+T//yIRszGny2ohMnMEEFxY=;
        b=FaOe2SfbgEXHjPTKy7H3YJTH7OaFIjAi5MwLGrTChaHxEPLdGbrF12z3oXeIZYV9dw
         L2TxEvhSk4lQweHlP5H+Qr3H8sPYSNlhieeZZc0VSiRho7794X1hAw0Av+iAKOA9GB9E
         t2uS8aCoR85OqNrHbLvCEq3/iavDwbM3NFGIXWf2TA5fHJ3U4N2ZV0qYSC8Nh3LPpKEk
         Cr+EMVfev34/4T7pKGvzJjy0NH5Nu0PyNplKze3SepLMIydgGjFuDXCfoPptVxWO6Y/K
         T54KYBmt1ptZ6dzLzKDqWInMfeAwyU6H5DUQfmb1eycaxhx/GR0RZZtey5cKkyWl64Ez
         lIMQ==
X-Gm-Message-State: AOAM533+I1fjS2qDYEEit44zlViHOHa+oOdMUTXMhYjNJHjnyij94kUQ
        poqmky0+oGAsd+yo0q1r7Y+6kkmvUS9SSrTgAyhA0FX636jh4EJKVySNfKx9E9DhRBQz0DXPgnb
        Vrq6aa9BqUiDm3ytW1Az92k0E
X-Received: by 2002:ac8:3438:: with SMTP id u53mr34763423qtb.102.1593737922459;
        Thu, 02 Jul 2020 17:58:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHJ/zoCeCWJlKioO070m7F5IMC5C0GNbb4MH/uExBKdX0suFgKub7q+wMx1ISV5PGpH5FKpQ==
X-Received: by 2002:ac8:3438:: with SMTP id u53mr34763408qtb.102.1593737921981;
        Thu, 02 Jul 2020 17:58:41 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y40sm10502896qtc.29.2020.07.02.17.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 17:58:41 -0700 (PDT)
Date:   Thu, 2 Jul 2020 20:58:40 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: arch/x86/kvm/../../../virt/kvm/kvm_main.c:4326:17: sparse:
 struct kvm_vcpu Documentation Kbuild Makefile crypto include sound usr
 <asn:3> kvm_get_running_vcpus( ... )
Message-ID: <20200703005840.GC6677@xz-x1>
References: <202007021746.jJj16Pl8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007021746.jJj16Pl8%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 05:18:48PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   cd77006e01b3198c75fb7819b3d0ff89709539bb
> commit: 7495e22bb165e7030bae4d9c6e84addb5ea17b29 KVM: Move running VCPU from ARM to common code
> date:   5 months ago
> config: x86_64-randconfig-s031-20200701 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-3-gfa153962-dirty
>         git checkout 7495e22bb165e7030bae4d9c6e84addb5ea17b29
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    arch/x86/kvm/../../../virt/kvm/kvm_main.c:3023:57: sparse: sparse: cast removes address space '<asn:1>' of expression
>    arch/x86/kvm/../../../virt/kvm/kvm_main.c:3023:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct compat_sigset_t const [noderef] [usertype] <asn:1> *compat @@     got void * @@
>    arch/x86/kvm/../../../virt/kvm/kvm_main.c:3023:57: sparse:     expected struct compat_sigset_t const [noderef] [usertype] <asn:1> *compat
>    arch/x86/kvm/../../../virt/kvm/kvm_main.c:3023:57: sparse:     got void *
>    arch/x86/kvm/../../../virt/kvm/kvm_main.c:4326:17: sparse: sparse: symbol 'kvm_get_running_vcpus' redeclared with different type (different address spaces):
> >> arch/x86/kvm/../../../virt/kvm/kvm_main.c:4326:17: sparse:    struct kvm_vcpu *[noderef] <asn:3> *extern [addressable] [toplevel] kvm_get_running_vcpus( ... )
>    include/linux/kvm_host.h:1339:26: sparse: note: previously declared as:
>    include/linux/kvm_host.h:1339:26: sparse:    struct kvm_vcpu [noderef] <asn:3> **extern [addressable] [toplevel] kvm_get_running_vcpus( ... )
> 
> vim +4326 arch/x86/kvm/../../../virt/kvm/kvm_main.c
> 
>   4322	
>   4323	/**
>   4324	 * kvm_get_running_vcpus - get the per-CPU array of currently running vcpus.
>   4325	 */
> > 4326	struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
>   4327	{
>   4328	        return &kvm_running_vcpu;
>   4329	}
>   4330	

Not the first time got confused with this report - this seems to have been
fixed by fcd07f9adc7d ("KVM: let declaration of kvm_get_running_vcpus match
implementation", 2020-02-28) already...

-- 
Peter Xu

