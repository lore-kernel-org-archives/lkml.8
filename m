Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D6FC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C73B2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3mo8dK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCJOrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:47:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39589 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726898AbgCJOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583851626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/K2o/46tRWBXyxtbLA8WN6DhZTWN58tPFLWETT0m6mA=;
        b=C3mo8dK9VFXrZBtZykkT5QuexLjpALDp7k92869xT8CuIH3cHMNBBygKsgJ5AilmPMYbAX
        8zX8OAQR8OdBXNllrB8lwlrM99P1eoxdmM/8WXl3a7BcOFuT1qNpuyG495YmZxRsS+U4p5
        KfgTVwMmEKlbmpsROjXBaHTbwWHuSHs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-UE7d0h_aNwiCY7n1buk3qA-1; Tue, 10 Mar 2020 10:47:04 -0400
X-MC-Unique: UE7d0h_aNwiCY7n1buk3qA-1
Received: by mail-qk1-f198.google.com with SMTP id d2so9881374qko.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/K2o/46tRWBXyxtbLA8WN6DhZTWN58tPFLWETT0m6mA=;
        b=qdZBV0rCCd831BhHsh0ZOH7O/6aA7/svgn7yXAnMofo1IOjY8v2Rc9jOV/ii3e7UdS
         RKEUNqUQAzrf9v7uKus/1aAkcj0SlVgtNifj2va/8bArfPeecnh+NGs47Z/vMq3f6rU1
         NrHteea9mwGzB5G0JVxaoJk6hL+DgPZV6NB7yGA7N91mAk3iEQaHssCyPlutVfXswvps
         c/A/679OYnVXgBB7lrvfOOMxitzv2s62dVMGPNnvGtUPO2aUi8J45MrW9sCb2lDE14GD
         K8nPU4uIa86ehSeHQMCrcgfYLKquCOSwai4ysv6qM8yHyvFemlY4kPg8kTF4bECEeIUx
         RBEA==
X-Gm-Message-State: ANhLgQ3RdIHaGcB1Tc+5R5wOydvXYgNgaHyQfwnIKN8g8MJvE12//bmJ
        HzNEpignpoO/RDn4onYpVyATBzI6PUJNmOR2Uqlaw5FVncYzAKKiQiQ+xFVPvQr7rags52wLWKC
        /makRibfaWTNMiX357GtLEaBR
X-Received: by 2002:a37:ac0d:: with SMTP id e13mr12961392qkm.322.1583851624188;
        Tue, 10 Mar 2020 07:47:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsO5t96TYULUQ/OWhsrr/bJIx5RPnb2BGkPM43s56kyXIhd56DU7c0qnH9J8f51YYvCI8slrQ==
X-Received: by 2002:a37:ac0d:: with SMTP id e13mr12961366qkm.322.1583851623887;
        Tue, 10 Mar 2020 07:47:03 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id x7sm17997027qkx.110.2020.03.10.07.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:47:03 -0700 (PDT)
Date:   Tue, 10 Mar 2020 10:46:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
Message-ID: <20200310104627-mutt-send-email-mst@kernel.org>
References: <20200304174947.69595-6-peterx@redhat.com>
 <202003061911.MfG74mgX%lkp@intel.com>
 <20200309213554.GF4206@xz-x1>
 <20200310022931-mutt-send-email-mst@kernel.org>
 <20200310140921.GD326977@xz-x1>
 <20200310101039-mutt-send-email-mst@kernel.org>
 <20200310141901.GE326977@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310141901.GE326977@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:19:01AM -0400, Peter Xu wrote:
> On Tue, Mar 10, 2020 at 10:11:30AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 10:09:21AM -0400, Peter Xu wrote:
> > > On Tue, Mar 10, 2020 at 02:31:55AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Mar 09, 2020 at 05:35:54PM -0400, Peter Xu wrote:
> > > > > I'll probably also
> > > > > move KVM_DIRTY_LOG_PAGE_OFFSET==0 definition to uapi/linux/kvm.h.
> > > > 
> > > > 
> > > > IMHO KVM_DIRTY_LOG_PAGE_OFFSET is kind of pointless anyway - 
> > > > we won't be able to move data around just by changing the
> > > > uapi value since userspace isn't
> > > > recompiled when kernel changes ...
> > > 
> > > Yes I think we can even drop this KVM_DIRTY_LOG_PAGE_OFFSET==0
> > > definition.  IMHO it's only a matter of whether we would like to
> > > directly reference this value in the common code (e.g., for kernel
> > > virt/kvm_main.c) or we want quite a few of this instead:
> > > 
> > > #ifdef KVM_DIRTY_LOG_PAGE_OFFSET
> > > ..
> > > #endif
> > 
> > Hmm do other arches define it to a different value?
> > Maybe I'm confused.
> > If they do then it makes sense.
> 
> Yes they can. So far with this series only x86 will define it to
> nonzero (64). But logically other archs can define it to different
> values.


Oh ok then. somehow I thought it's 0 for all arches.
Sorry about the noise, pls ignore this comment.

> 
> We can reference this to existing offsets that we've defined already
> for different archs, like KVM_COALESCED_MMIO_PAGE_OFFSET:
> 
>   - For ppc, it's defined as 1 (arch/powerpc/include/uapi/asm/kvm.h)
>   - For x86, it's defined as 2 (arch/x86/include/uapi/asm/kvm.h)
>   - ...
> 
> Thanks,
> > 
> > > I slightly prefer to not use lots of "#ifdef"s so I chose to make sure
> > > it's defined.  However I've no strong opinion on this either. So I'm
> > > open to change that if anyone insists with some reasons.
> > > 
> > > Thanks,
> > > 
> > > -- 
> > > Peter Xu
> > 
> 
> -- 
> Peter Xu

