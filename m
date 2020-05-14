Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE135C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15E420709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgmWWKpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgENWF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:05:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22979 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbgENWF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589493926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WbD5g5bGH+nPMmGQ14q3KYBCwhmBSOIy/E7pqLF8qco=;
        b=HgmWWKpP7fjRMrxT2DGzUivS9oD8pwkg5U4SezAOD9nbWE06CIFBuxs4WxLvhsueKkSAy/
        dbxI84PLlLlho7UmJPXPASonF8xC88GeZZsfOpUg3vrhH60fiCLD+B491h6r+37SNu9XWw
        rvCpliYZ8Duciu3lTimvQ/vJzO3vTIc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-8fWapEi4NNaax3ACmlmWDg-1; Thu, 14 May 2020 18:05:24 -0400
X-MC-Unique: 8fWapEi4NNaax3ACmlmWDg-1
Received: by mail-qt1-f199.google.com with SMTP id k54so49419qtb.18
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WbD5g5bGH+nPMmGQ14q3KYBCwhmBSOIy/E7pqLF8qco=;
        b=tV/yo9yt0K0AJHfIP4sqJnq8k4Vvr1R7X6PkYrQJXaHfeyKKuP0XXc12v5VtZ3kLv2
         vugNBP6Mwig/rJNRMBRJQJQVloAGBrwA8Up4QyInjWx/zjyFXT0Gzl7CZd/I1Cs/wYnZ
         JBX3mNh4LmBoe9nEFm29edVmzVEpJDzNmAPXohYe5tinZKLGzoGuhxL1OSwpiyh0mB01
         zVsKGGJMLIPQnzEIuIkFZoiJNvlDxRCnJfc6v9hcK+VgJyS9aKLJAEsKOIUXpCjm+Jrx
         Kqo+C5R5MUt5xRulu/Enx+yC/Tz6OB30unkwXUWZOSlBZJ7be6Vs73Pq+ZDd61qfBzmL
         M0Rw==
X-Gm-Message-State: AOAM531pJamxv5eUJj+KfpBnjnKX5ASTQvzZZZc77Y2eQaiW0kczUEc+
        kMppqx5bmGKDVk2YolHGULzM3CTAeLvXAVSBensbC0FHm0uLoek23nZS4MuRM1OTXFXTqRVeUey
        vpZljT/BihRZ4d+6dncav/r7A
X-Received: by 2002:a37:a687:: with SMTP id p129mr551132qke.45.1589493924468;
        Thu, 14 May 2020 15:05:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwh13mhxrDmHNJ8hptY5k7/JfPCSEmEv15VKAaaUnkUI+iGTOJzFoJ4FomI5IJPGc2XiaiEog==
X-Received: by 2002:a37:a687:: with SMTP id p129mr551104qke.45.1589493924227;
        Thu, 14 May 2020 15:05:24 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y28sm373922qtc.62.2020.05.14.15.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 15:05:23 -0700 (PDT)
Date:   Thu, 14 May 2020 18:05:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org
Subject: Re: [PATCH RFC 0/5] KVM: x86: KVM_MEM_ALLONES memory
Message-ID: <20200514220516.GC449815@xz-x1>
References: <20200514180540.52407-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200514180540.52407-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 08:05:35PM +0200, Vitaly Kuznetsov wrote:
> The idea of the patchset was suggested by Michael S. Tsirkin.
> 
> PCIe config space can (depending on the configuration) be quite big but
> usually is sparsely populated. Guest may scan it by accessing individual
> device's page which, when device is missing, is supposed to have 'pci
> holes' semantics: reads return '0xff' and writes get discarded. Currently,
> userspace has to allocate real memory for these holes and fill them with
> '0xff'. Moreover, different VMs usually require different memory.
> 
> The idea behind the feature introduced by this patch is: let's have a
> single read-only page filled with '0xff' in KVM and map it to all such
> PCI holes in all VMs. This will free userspace of obligation to allocate
> real memory and also allow us to speed up access to these holes as we
> can aggressively map the whole slot upon first fault.
> 
> RFC. I've only tested the feature with the selftest (PATCH5) on Intel/AMD
> with and wiuthout EPT/NPT. I haven't tested memslot modifications yet.
> 
> Patches are against kvm/next.

Hi, Vitaly,

Could this be done in userspace with existing techniques?

E.g., shm_open() with a handle and fill one 0xff page, then remap it to
anywhere needed in QEMU?

Thanks,

-- 
Peter Xu

