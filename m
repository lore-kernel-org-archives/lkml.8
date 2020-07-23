Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12164C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E196E2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="QHrs12ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGWGVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:21:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53217 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgGWGVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:21:20 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4BC2KB5s0qz9sSJ; Thu, 23 Jul 2020 16:21:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1595485278; bh=IFTCm6zcqf516abhJ4Sn7meDBWdJj/FMmew567e6yPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHrs12kseRVGEX+ozdM7Bk6vM8hN0rntxzjRAXDLPJB5+D4I5trx8JLVKEGr+HWlW
         Mj63kCsmYQo/uJVxEQyo6xy71+qys9EPiyUnLS0wybJYnvAxhe3k+ZSJ+U2csi6dEv
         m4p3ywW83Fc4+QdjQ8081sBvInO0dflWfc+rdmby+iEWn07BdpvNwnJNhl+BoXRUko
         PGFpiYQvGK+7m6HjKWHrkG4zVYjQaSTJZBb90cqJYr+EdFmgz1kCMJiQLPN4BTwuys
         wW2IRygLknjUHpNpoWgw1D7M2qtPhMQU14/2XHHACcZE0i5VV9A13lZCYY5BQd0UY8
         9ybHPfknMp5Lg==
Date:   Thu, 23 Jul 2020 16:19:04 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     pbonzini@redhat.com, tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com,
        chenhuacai@gmail.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/5] KVM: PPC: clean up redundant kvm_run parameters
 in assembly
Message-ID: <20200723061904.GC213782@thinks.paulus.ozlabs.org>
References: <20200623131418.31473-1-tianjia.zhang@linux.alibaba.com>
 <20200623131418.31473-4-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623131418.31473-4-tianjia.zhang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:14:16PM +0800, Tianjia Zhang wrote:
> In the current kvm version, 'kvm_run' has been included in the 'kvm_vcpu'
> structure. For historical reasons, many kvm-related function parameters
> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
> patch does a unified cleanup of these remaining redundant parameters.

Thanks, patch applied to my kvm-ppc-next branch, with fixes.

Paul.
