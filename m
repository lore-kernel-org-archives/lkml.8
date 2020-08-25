Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC860C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42EB20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XprYI4Hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHYVZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726158AbgHYVZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 17:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598390731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jvt61bqhDvrw7d/FiOCmHNvRxtd4yNajkq8FrCplPOM=;
        b=XprYI4HzIm2FcSTTeIk4MlB3ta/C/T//ZRImvFeQTID0/d4oMrn1bx5CxjdRsiAP2N54QQ
        t8U3cstYkJX3E1TszWC+HDwwOcA67vR6j5Sw5wGqtYG6diglDKRvLvCMO/fV0BYBorS1k9
        d/+1LfXxdukmVW+BaF+SAuE8LCVMsT8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-ah6tPfQLOzmj6sM-3pO3Wg-1; Tue, 25 Aug 2020 17:25:29 -0400
X-MC-Unique: ah6tPfQLOzmj6sM-3pO3Wg-1
Received: by mail-qt1-f199.google.com with SMTP id e11so47444qth.21
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 14:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jvt61bqhDvrw7d/FiOCmHNvRxtd4yNajkq8FrCplPOM=;
        b=LrW9OEXuPHtawTJ1ujazTaUQjexUQwXd1bwNri9Aqfo7xeQiowCKDmsYWUHZLl1PpH
         9UBRx/CfFucCLDGDPcQHaLUcJx2Joe4jKBvsr2MG6pnrkGHjukaUjliFfkGRtGNwM6wL
         i8Olad1Fng7NEmuetSE90uEGA5SE0sNYYkfU335WYeRqAb9nbElhmU6AsD6GCnX3MH60
         qLc7ovBCeIupf/8nNMs7eBXu+IJGw9TqhKuav4fySVu49aFR9seKoSG6+pTBp0mOt7ff
         p//kcSPkz5f7/RxtZG2EAH7y8HvPaBtIgxn61JpzKHwPKoAoKuYmRVm/V4IPLvnL2MCv
         AWGQ==
X-Gm-Message-State: AOAM531lVM2xbhL5d+NO07txYa7YTuyJBinm1DwwbLYUTcebEQYMSRKq
        YSlNnRPKURTYDRr2i1kdHzdDwrsgph7mbcZ0307VSlFAqRItVL/JObRqrHFR+VQpVN4CZ6RbSvH
        3MblpyK359DbLddH37ZzYaOON
X-Received: by 2002:ac8:4891:: with SMTP id i17mr10119843qtq.109.1598390729152;
        Tue, 25 Aug 2020 14:25:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw9Y2fG8E7x/3LrI9A6BsgkdM7gRHYBP8FQbC6LUlD17kQrRL2QzruCf3Sfmqr2QzPgTcPVA==
X-Received: by 2002:ac8:4891:: with SMTP id i17mr10119824qtq.109.1598390728848;
        Tue, 25 Aug 2020 14:25:28 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id x124sm89046qkd.72.2020.08.25.14.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 14:25:28 -0700 (PDT)
Date:   Tue, 25 Aug 2020 17:25:26 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] KVM: x86: KVM_MEM_PCI_HOLE memory
Message-ID: <20200825212526.GC8235@xz-x1>
References: <20200807141232.402895-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807141232.402895-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 04:12:29PM +0200, Vitaly Kuznetsov wrote:
> When testing Linux kernel boot with QEMU q35 VM and direct kernel boot
> I observed 8193 accesses to PCI hole memory. When such exit is handled
> in KVM without exiting to userspace, it takes roughly 0.000001 sec.
> Handling the same exit in userspace is six times slower (0.000006 sec) so
> the overal; difference is 0.04 sec. This may be significant for 'microvm'
> ideas.

Sorry to comment so late, but just curious... have you looked at what's those
8000+ accesses to PCI holes and what they're used for?  What I can think of are
some port IO reads (e.g. upon vendor ID field) during BIOS to scan the devices
attached.  Though those should be far less than 8000+, and those should also be
pio rather than mmio.

If this is only an overhead for virt (since baremetal mmios should be fast),
I'm also thinking whether we can make it even better to skip those pci hole
reads.  Because we know we're virt, so it also gives us possibility that we may
provide those information in a better way than reading PCI holes in the guest?

Thanks,

-- 
Peter Xu

