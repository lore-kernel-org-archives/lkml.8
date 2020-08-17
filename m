Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E0FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF8920658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uof3R/kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgHQIr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:47:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39799 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728072AbgHQIru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597654067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t355WPxa6uPtXL7lonYCwvII2S9kGVc9Ngbl+va3Q60=;
        b=Uof3R/krOg1yAzNoKrFKek7aV/LVfVKB9lE90p7sPmJIXXNP1uub4hTpmJdBBlhHML6MBB
        WX+W13fwbNWLAsc0SSBEp8lglBLp86M4flKfcca5VwOebrCAHEq5gbp6Imab1eOS7iTKK/
        wPDnfKtU0XrRVAZvMKbMLlFNT5lyeL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-jE_OXeiPPe2LKymmUwTwdQ-1; Mon, 17 Aug 2020 04:47:43 -0400
X-MC-Unique: jE_OXeiPPe2LKymmUwTwdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A951D81F010;
        Mon, 17 Aug 2020 08:47:41 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7048D5D9D2;
        Mon, 17 Aug 2020 08:47:38 +0000 (UTC)
Date:   Mon, 17 Aug 2020 10:47:35 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Keqian Zhu <zhukeqian1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steven Price <steven.price@arm.com>, wanghaibin.wang@huawei.com
Subject: Re: [PATCH 1/3] KVM: arm64: Some fixes of PV-time interface document
Message-ID: <20200817084735.xyfdtgcsuxzwgzyr@kamzik.brq.redhat.com>
References: <20200817033729.10848-1-zhukeqian1@huawei.com>
 <20200817033729.10848-2-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817033729.10848-2-zhukeqian1@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:37:27AM +0800, Keqian Zhu wrote:
> Rename PV_FEATURES tp PV_TIME_FEATURES
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  Documentation/virt/kvm/arm/pvtime.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/arm/pvtime.rst b/Documentation/virt/kvm/arm/pvtime.rst
> index 687b60d..94bffe2 100644
> --- a/Documentation/virt/kvm/arm/pvtime.rst
> +++ b/Documentation/virt/kvm/arm/pvtime.rst
> @@ -3,7 +3,7 @@
>  Paravirtualized time support for arm64
>  ======================================
>  
> -Arm specification DEN0057/A defines a standard for paravirtualised time
> +Arm specification DEN0057/A defines a standard for paravirtualized time
>  support for AArch64 guests:
>  
>  https://developer.arm.com/docs/den0057/a
> @@ -19,8 +19,8 @@ Two new SMCCC compatible hypercalls are defined:
>  
>  These are only available in the SMC64/HVC64 calling convention as
>  paravirtualized time is not available to 32 bit Arm guests. The existence of
> -the PV_FEATURES hypercall should be probed using the SMCCC 1.1 ARCH_FEATURES
> -mechanism before calling it.
> +the PV_TIME_FEATURES hypercall should be probed using the SMCCC 1.1
> +ARCH_FEATURES mechanism before calling it.
>  
>  PV_TIME_FEATURES
>      ============= ========    ==========
> -- 
> 1.8.3.1
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

