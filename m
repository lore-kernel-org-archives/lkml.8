Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2042C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09D224649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9spCSDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgCIVgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:36:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49804 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726118AbgCIVgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583789761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WFaOjYkjQp10BON4OY2n2qebvVotlGef2Ci4vePe9f4=;
        b=a9spCSDDWckYHlvqAPVhxQkauRrmtrK8zZ4t1ci8oJLchQSN6EMgX0sgruUO3siWPmKAWS
        oxZ29L9WnfPgvYl/1XihBXlqPhhdemTe194rVqNjCD2vbDbMJ1XyPDGlUmsd9bcO0i0tW1
        0OPcNCVKqgdXYpBmyFNlEhjvKtGe7no=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153--EHBqs8-Ne-oBdffLFWUug-1; Mon, 09 Mar 2020 17:35:57 -0400
X-MC-Unique: -EHBqs8-Ne-oBdffLFWUug-1
Received: by mail-qk1-f200.google.com with SMTP id j10so5106252qkm.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 14:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WFaOjYkjQp10BON4OY2n2qebvVotlGef2Ci4vePe9f4=;
        b=eKntYvHGP3as8dKNYyAoVRAexPdertX0nVGX5FVKY1vZALH4VlIacSolrzEhCE6FRw
         4+eayfrBKvzVP9R0wYy9fR/KuEPVAd7lKiqTM19KxCd7ysVT1S/FjgKYYXjYuVCu0zHq
         bJj2RKcT5Yeh4/MOj0MUyA/4lmuI8smrHjSFIAe3Bcvyeh0Nn+fAV2Pa2nazP7koPa8I
         4CNPVmuypdZwhRjmRQyiZKOa/+5YYVAsj7+Nnsqfqt0sQD5gviqrCM5hZ+7dFdBL/yox
         9DrRWNI93VoGbWBXO+M0jvdBcG0YtCaFs72djQd4KlDdZs9UcCSMnr8d2NPJVIMIDGtO
         5BaA==
X-Gm-Message-State: ANhLgQ1OVDQjGPZGyMY11OZoMHiKtDLYvOeyH7R8n9+6lsq1c1U3Aix+
        kHIR2VsLgYVOJYL9ZLxRF9Od3f6aKy65yT/wwE7EHRRsQ45G7KQVkCTILCatNabKkPB8KOy83tG
        FwAMzt9Ts5kwnWdOYK/eyN+n1
X-Received: by 2002:a37:c0d:: with SMTP id 13mr16494671qkm.417.1583789757350;
        Mon, 09 Mar 2020 14:35:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt2s8s1SwnonzNqXw6lvns7taZsI3hjZ0REGgGXiGjlFYAQRwpCOm/iuvRE0WA6v1Btrj8wLg==
X-Received: by 2002:a37:c0d:: with SMTP id 13mr16494649qkm.417.1583789757022;
        Mon, 09 Mar 2020 14:35:57 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 68sm5985561qkh.75.2020.03.09.14.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:35:56 -0700 (PDT)
Date:   Mon, 9 Mar 2020 17:35:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
Subject: Re: [PATCH v5 05/14] KVM: X86: Implement ring-based dirty memory
 tracking
Message-ID: <20200309213554.GF4206@xz-x1>
References: <20200304174947.69595-6-peterx@redhat.com>
 <202003061911.MfG74mgX%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202003061911.MfG74mgX%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 07:32:20PM +0800, kbuild test robot wrote:
> Hi Peter,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/auto-latest]
> [also build test ERROR on linus/master v5.6-rc4]
> [cannot apply to kvm/linux-next linux/master vhost/linux-next next-20200305]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Peter-Xu/KVM-Dirty-ring-interface/20200305-053531
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 6f2bc932d8ff72b1a0a5c66f3dad04ccba576a8b
> config: s390-alldefconfig (attached as .config)
> compiler: s390-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=s390 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/s390/../../virt/kvm/kvm_main.o: In function `kvm_reset_dirty_gfn':
> >> kvm_main.c:(.text+0x6a60): undefined reference to `kvm_arch_mmu_enable_log_dirty_pt_masked'

It turns out that when I wanted to fix the build error previously, I
did the compilation test (using a ppc64 host) without using the
correct config file, so KVM is not enabled at all...

I'll fix it (again) this time by moving kvm_reset_dirty_gfn() into
kvm_dirty_ring.c (and some other macro touch-ups).  I'll probably also
move KVM_DIRTY_LOG_PAGE_OFFSET==0 definition to uapi/linux/kvm.h.

Thanks,

-- 
Peter Xu

