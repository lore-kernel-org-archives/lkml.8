Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AEEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D10206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCQYTqfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgEOImW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:42:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36221 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727845AbgEOImU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589532139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DMIdxGLOvqxhE935UlZMgBbWMPbbsSeb1jl5FoZ23yY=;
        b=JCQYTqfzcU1hWgsn+ZljoFYUtsUv1C+9rqlFd2BrZw66pdHQvEQIw33G7OSNENr02Uzwzn
        PcK1X3s0ZhM7A0C/m+dTx9czY9KKY5CIEOmEKBiQQbLZroDIehWlUSXq25YPnt6YoDCWn5
        OCI0EEMG/7DAGrxtyJcrndIV2NTtl44=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-_RwkeNgQNous23GFEzPH5g-1; Fri, 15 May 2020 04:42:15 -0400
X-MC-Unique: _RwkeNgQNous23GFEzPH5g-1
Received: by mail-wm1-f72.google.com with SMTP id m11so658669wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DMIdxGLOvqxhE935UlZMgBbWMPbbsSeb1jl5FoZ23yY=;
        b=E/y0ebvbL46VrFmfPC/bSKV3Xo44j7ZbxkZ33+A97lN9NM0GlPrVTBOn5f84qIhfhQ
         xHd84mWNuPIyVVY85PlKRep8RdoMSzswVgSxcW7EBi5iSQtR2KKEZc4FW2a9zvf20LNQ
         4b9Wh8h9SkaMyeIVuZV1ZA2iTpf/5EuhEzlMn/pFvDbQY04ZRs0xsFHfyHHRVL8QYO4E
         riQeNFfuoJYeOSTMuThW+cHd6sS+cy/z4LxvLNB+uVcmEcNJNHuHRs3gC4Z7vWC2letp
         CIMHnh44otbYOhr2HDD0nvQW+rDnyn3IIA7p/KL6Tv7s0GfgPtslrDrmOBWoLknyv1B3
         02yw==
X-Gm-Message-State: AOAM530O30GKlvJcB9YAjytjgp6wHeC/MWDOA3QVNyeH7ZsPvw1dAiig
        3CYh6tVpv79JNQjgAOEVx1tUlHhYWHpqVd3CyfXEBbvxFaGMZTq05Dgl4Kv8IgQOFFhV0o4IUO9
        yBvRzKmCQRLOSc15I2zAtqp7m
X-Received: by 2002:a7b:c201:: with SMTP id x1mr2761110wmi.14.1589532133993;
        Fri, 15 May 2020 01:42:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXwzFjPs3XiKuV9op5EMMlZoD4iPCHlEyVN7VtC9ByMmgj8DVBwmpAcO/Ol8/xLi0LrCKwhQ==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr2761095wmi.14.1589532133778;
        Fri, 15 May 2020 01:42:13 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t22sm2441900wmj.37.2020.05.15.01.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:42:13 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org
Subject: Re: [PATCH RFC 0/5] KVM: x86: KVM_MEM_ALLONES memory
In-Reply-To: <20200514233208.GI15847@linux.intel.com>
References: <20200514180540.52407-1-vkuznets@redhat.com> <20200514220516.GC449815@xz-x1> <20200514225623.GF15847@linux.intel.com> <20200514232250.GA479802@xz-x1> <20200514233208.GI15847@linux.intel.com>
Date:   Fri, 15 May 2020 10:42:12 +0200
Message-ID: <87d075wpwb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Thu, May 14, 2020 at 07:22:50PM -0400, Peter Xu wrote:
>> On Thu, May 14, 2020 at 03:56:24PM -0700, Sean Christopherson wrote:
>> > On Thu, May 14, 2020 at 06:05:16PM -0400, Peter Xu wrote:
>> > > E.g., shm_open() with a handle and fill one 0xff page, then remap it to
>> > > anywhere needed in QEMU?
>> > 
>> > Mapping that 4k page over and over is going to get expensive, e.g. each
>> > duplicate will need a VMA and a memslot, plus any PTE overhead.  If the
>> > total sum of the holes is >2mb it'll even overflow the mumber of allowed
>> > memslots.
>> 
>> What's the PTE overhead you mentioned?  We need to fill PTEs one by one on
>> fault even if the page is allocated in the kernel, am I right?
>
> It won't require host PTEs for every page if it's a kernel page.  I doubt
> PTEs are a significant overhead, especially compared to memslots, but it's
> still worth considering.
>
> My thought was to skimp on both host PTEs _and_ KVM SPTEs by always sending
> the PCI hole accesses down the slow MMIO path[*].
>
> [*] https://lkml.kernel.org/r/20200514194624.GB15847@linux.intel.com
>

If we drop 'aggressive' patch from this patchset we can probably get
away with KVM_MEM_READONLY and userspace VMAs but this will only help us
to save some memory, it won't speed things up.

>> 4K is only an example - we can also use more pages as the template.  However I
>> guess the kvm memslot count could be a limit..  Could I ask what's the normal
>> size of this 0xff region, and its distribution?

Julia/Michael, could you please provide some 'normal' configuration for
a Q35 machine and its PCIe config space?

-- 
Vitaly

