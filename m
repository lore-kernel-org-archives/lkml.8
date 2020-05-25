Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C59C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCADA2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyprC9O5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404179AbgEYP06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:26:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42261 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403999AbgEYP05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590420415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PI4OLD2ZI4py7bxKHPKVelhSZTDGLOrNvjwt+4tOug=;
        b=XyprC9O5gVQcz4ZCE/+f6PAlrKUfMNIWKlZhoR1am4hBOjflSfRha9KCivcbr+xXSLkMd9
        s3ZyZS412dm6ue2t/qb8EbR3xo/bxDDGuwODHgWFotCGzOdz9wSPorGJPtIy8jHyRPz8gY
        sazJXLcsvZwtWX1L/F/nNYLEFEYnz14=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-OR7GCtUBP4u88mm4WyQYqQ-1; Mon, 25 May 2020 11:26:52 -0400
X-MC-Unique: OR7GCtUBP4u88mm4WyQYqQ-1
Received: by mail-qk1-f197.google.com with SMTP id p5so13092899qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2PI4OLD2ZI4py7bxKHPKVelhSZTDGLOrNvjwt+4tOug=;
        b=YxEW5Fi/9dTa1OkMEAeGn4Q4Znjj8EtzhDOwK1OO+zvQSZhEt+WCWfmc+Y+JQd2Uel
         mZqizoyCP/RPbW9FuPDl/cljcaMhzXr5viJvvin6lN3OU+fJtMExoETrxKssiBWIy9p2
         m7aY08H6YwZtfa+AFKoqMJFMMqNqgPsyoOoiq9vsvT469FTsLKbeCjbtrgYq5IEFn25W
         TMqNkmk3qMqt/7fhKDAE48D9z8NWR8dWhsH9L7iHsXMUPhxvBBhd4OO6klKOKxQ3Frj/
         V4nnZyMHWzRt5SDr6iJhj1Q1GaZWqZxR8hoGNqTKcHLyopGxGGDygyLP6W4JWTwDNeov
         zAAQ==
X-Gm-Message-State: AOAM530NJEqZfl/ojP4Y/qnNB9pLsC3FP0t0BHHAq/9c+dXdNGW3oh14
        49W1q36qE0i7XR2qlSJbDDF8HR62uEsm9mMLPmUe52mx/xyHKM3wQQcCEshZeZufQR1TSkLfIF3
        pSk7VO8srj7pf5ZXP/Z+mLYUI
X-Received: by 2002:ac8:4d02:: with SMTP id w2mr28319764qtv.170.1590420411956;
        Mon, 25 May 2020 08:26:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRYTEvDHkzZlN9N8OdVleY8RnsN2Eeh3cPWv0zTSlKo2jQXNjD4uFHPXMimAcfEA1Ah+yfiA==
X-Received: by 2002:ac8:4d02:: with SMTP id w2mr28319735qtv.170.1590420411698;
        Mon, 25 May 2020 08:26:51 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id s74sm15008079qka.54.2020.05.25.08.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:26:51 -0700 (PDT)
Date:   Mon, 25 May 2020 11:26:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kbuild-all@lists.01.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v9 05/14] KVM: X86: Implement ring-based dirty memory
 tracking
Message-ID: <20200525152649.GF1058657@xz-x1>
References: <20200523225659.1027044-6-peterx@redhat.com>
 <202005251058.wRNkniwm%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005251058.wRNkniwm%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 10:48:08AM +0800, kbuild test robot wrote:
> Hi Peter,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on vhost/linux-next]
> [also build test WARNING on linus/master v5.7-rc7]
> [cannot apply to kvm/linux-next tip/auto-latest linux/master next-20200522]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Peter-Xu/KVM-Dirty-ring-interface/20200524-070926
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> config: s390-randconfig-s002-20200524 (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-240-gf0fe1cd9-dirty
>         # save the attached .config to linux build tree
>         make W=1 C=1 ARCH=s390 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> arch/s390/kvm/../../../virt/kvm/kvm_main.c: In function 'kvm_page_in_dirty_ring':
> >> arch/s390/kvm/../../../virt/kvm/kvm_main.c:2932:16: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 2932 |  return (pgoff >= KVM_DIRTY_LOG_PAGE_OFFSET) &&
> |                ^~

Should be a false positive, since when KVM_DIRTY_LOG_PAGE_OFFSET==0 (true for
s390) then the code won't reach here at all due to the previous check [1].

I thought gcc should be able to directly remove the below code when it sees "if
(1) return false;", but it seems not...

I wanted to avoid using "#if" macros because I think it always makes the code
harder to read (especially when nested).  Maybe it's still ok to use one more
time here.

Thanks,

> 
> vim +2932 arch/s390/kvm/../../../virt/kvm/kvm_main.c
> 
>   2926	
>   2927	static bool kvm_page_in_dirty_ring(struct kvm *kvm, unsigned long pgoff)
>   2928	{
>   2929		if (!KVM_DIRTY_LOG_PAGE_OFFSET)
>   2930			return false;

[1]

>   2931	
> > 2932		return (pgoff >= KVM_DIRTY_LOG_PAGE_OFFSET) &&
>   2933		    (pgoff < KVM_DIRTY_LOG_PAGE_OFFSET +
>   2934		     kvm->dirty_ring_size / PAGE_SIZE);
>   2935	}
>   2936	


-- 
Peter Xu

