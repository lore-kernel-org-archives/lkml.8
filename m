Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F225CC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C608E2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R37Hayki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBEPWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:22:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31767 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726416AbgBEPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580916172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vKHNNfcl+r6URdhvtsRg9I1PCC+GPUyhu2TKclBNVok=;
        b=R37HaykiseAX+83N6o7BC5LaHGImjvlRcVfLQ/pyY/xdAwYRnXpzjreL1ILs4dU3r8qejt
        FahZ9onjttYwR5zNod0rY6D2UkfON3FoFPDVhDB3WEAl9gzadZHenkfQRt48hBaeMn5LEo
        NWnROMBUstWKqqN2Pid0SO9ofOxDvBU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-MOESuXHiOKSvltQ4RDR_YA-1; Wed, 05 Feb 2020 10:22:51 -0500
X-MC-Unique: MOESuXHiOKSvltQ4RDR_YA-1
Received: by mail-wr1-f71.google.com with SMTP id u18so1332282wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vKHNNfcl+r6URdhvtsRg9I1PCC+GPUyhu2TKclBNVok=;
        b=uYnls6CAg/KuYRbPmevduaiOSOi+Qbq4azouF4sqihS77j9bZpKv99I+rwTB/TwuVH
         WLoMZglmoDQCCgbhBzS0vaJCcItEHHv9sObMPGx32I7fQItJ5KuCHy80MzKipVtqFNum
         MRcbMELoGvMM1IYN5fML71aMm+fbEj8dBZFZQpv2m2AHPZMksLvKx5Apr5qcMcJAksgU
         gB2jnvwPbWj3ZJOJMWo6NI+n/AFQFjocRQs0LdMBf5iqLt7N08ZNCZHKGrgztXmwoNey
         Ykvv/9jXiLJd9hdZRhR2DSDPMtPrb9PR0CJ5z7IrB9DkQRyRMMdU8DdJEvCQ3rpnamNx
         8Xqg==
X-Gm-Message-State: APjAAAUQ7iqjsm1itBAaK62h0t4O/n3ie7xMv/Th1s2pMmSmm28sYCDR
        Pnczff0j2kbBhQuBGXLXAA/VfzzMpmWOYrQN6QCmgkTDeF26hebSzi2XBrBTnAvQ0SiG16dxE3Z
        kXJQBjsWBv/rVJzxfq/Bsddl8
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr6184618wma.5.1580916169774;
        Wed, 05 Feb 2020 07:22:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1P6wGbDoWJ9U0FwfPyYZ8Yoaq4xJQ1R49Y2GfyL0piQVH3Iy3Xv1yALh03UKBJFamJjwwVQ==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr6184584wma.5.1580916169331;
        Wed, 05 Feb 2020 07:22:49 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i204sm8952711wma.44.2020.02.05.07.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:22:48 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/26] KVM: x86: Add a kvm_x86_ops hook to query virtualized MSR support
In-Reply-To: <20200205145923.GC4877@linux.intel.com>
References: <20200129234640.8147-1-sean.j.christopherson@intel.com> <20200129234640.8147-5-sean.j.christopherson@intel.com> <87eev9ksqy.fsf@vitty.brq.redhat.com> <20200205145923.GC4877@linux.intel.com>
Date:   Wed, 05 Feb 2020 16:22:48 +0100
Message-ID: <8736bpkqif.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Wed, Feb 05, 2020 at 03:34:29PM +0100, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> 
>> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Stooooooop!  Everything from this point on is obsoleted by kvm_cpu_caps!
>

Oops, this was only a week old series! Patches are rottening fast
nowadays!

-- 
Vitaly

