Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6ECC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9491A2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn1n/gaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404204AbgEYPeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:34:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28248 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404066AbgEYPeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590420842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o1s5zuPCbjv4W1F4qB4hsqDOidZ/dEXbHAB3GqNTJXQ=;
        b=cn1n/gafXPmYZsS9bSw/owpTn7YzMkbPL/3zfUHV2spGJuA5V+001pp5Vm5ezoeT75nmlV
        7dhOQRTOm0NGSSZ0hn0ayuVTxGkrZqaxvk3ePcbKaMTPVpeg8yCDjUyl4XfqLdYtsvMt5F
        a1uQC068kmLvfoT7wQNPCD6ZMaT/unU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-wFibjEmFO7qlTiouhbQSdA-1; Mon, 25 May 2020 11:33:52 -0400
X-MC-Unique: wFibjEmFO7qlTiouhbQSdA-1
Received: by mail-qk1-f199.google.com with SMTP id d187so683276qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o1s5zuPCbjv4W1F4qB4hsqDOidZ/dEXbHAB3GqNTJXQ=;
        b=pL2j7VB1Q1xgOSzEalCAF3s9jbArcAnDpZQHFOTiVUQx+lj8FNZVbPl+SDxs498/fK
         JY9HGplQTQcoeFwcJqPfEqKqz0CaUyDybnqiCIvyD7UIuCw3qzETwUZCNIh/WaYjuvF+
         KvgTKmG6m4hGYwKpYglE/O9DksVMRYzgClvabi+UyhzuVzDd8pLG0xsk3f4YEgqPx7kJ
         Q+GOY8kuIuWOtSSGdV6zlxih1Z8JateOCD3e8Zuxi0KyGszYPGBrvOpMlYZVwcjFeiRa
         jcvWEV27VACl2DEQ7nZCjlOhMCxNNyqZYktIfqDX3wBeRkZdliTtoyuWZSpAPl4UNF0G
         7kSQ==
X-Gm-Message-State: AOAM532slmLV+1gxetY+CgD7FGg8bGI5M3o6vLCLmlIClMpnh+pKSSg/
        8WKfF7hDSRtLpu8adMPMLUbvrvRRofJFZw/qkWHbgu2DzmSQLRCPwET9+6PBG15J/+B9GQQSyAi
        WcooQZlpQUg1mgR1rbg0Z0cb4
X-Received: by 2002:a37:7143:: with SMTP id m64mr26064119qkc.27.1590420831691;
        Mon, 25 May 2020 08:33:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMgbQT9zZHhsACJ6JIUxvphkrjM3Sc4JuKOREGxqwcWEftYz9SdklT7uY+WRjYzsggI7Jw5g==
X-Received: by 2002:a37:7143:: with SMTP id m64mr26064085qkc.27.1590420831299;
        Mon, 25 May 2020 08:33:51 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p11sm3160489qtq.75.2020.05.25.08.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:33:50 -0700 (PDT)
Date:   Mon, 25 May 2020 11:33:47 -0400
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
Message-ID: <20200525153347.GG1058657@xz-x1>
References: <20200523225659.1027044-6-peterx@redhat.com>
 <202005252245.ZeOB8qNJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005252245.ZeOB8qNJ%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 10:54:58PM +0800, kbuild test robot wrote:
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
> config: x86_64-allyesconfig (attached as .config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build):
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> arch/x86/kvm/../../../virt/kvm/dirty_ring.c:33:6: warning: no previous prototype for 'kvm_dirty_ring_full' [-Wmissing-prototypes]
> bool kvm_dirty_ring_full(struct kvm_dirty_ring *ring)
> ^~~~~~~~~~~~~~~~~~~

I'll add a "static" to quiesce this..

> --
> arch/x86/kvm/vmx/vmx.c: In function 'init_rmode_identity_map':
> >> arch/x86/kvm/vmx/vmx.c:3472:12: warning: variable 'identity_map_pfn' set but not used [-Wunused-but-set-variable]
> kvm_pfn_t identity_map_pfn;
> ^~~~~~~~~~~~~~~~

Hmm, this seems to be true but not related to this series afaict...  but sure I
can add another patch to remove it.

> 
> vim +/kvm_dirty_ring_full +33 arch/x86/kvm/../../../virt/kvm/dirty_ring.c
> 
>     32	
>   > 33	bool kvm_dirty_ring_full(struct kvm_dirty_ring *ring)
>     34	{
>     35		return kvm_dirty_ring_used(ring) >= ring->size;
>     36	}
>     37	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Peter Xu

