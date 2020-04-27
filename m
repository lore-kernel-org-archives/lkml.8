Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BD0C83003
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16642072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgD0Xon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726329AbgD0Xon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:44:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A67C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 16:44:42 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jTDQE-0004J5-Fg; Tue, 28 Apr 2020 01:44:22 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E009B100FC0; Tue, 28 Apr 2020 01:44:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 5/7] x86/mmu: Allocate/free PASID
In-Reply-To: <20200427221825.GF242333@romley-ivt3.sc.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com> <1585596788-193989-6-git-send-email-fenghua.yu@intel.com> <87pnbus3du.fsf@nanos.tec.linutronix.de> <20200427221825.GF242333@romley-ivt3.sc.intel.com>
Date:   Tue, 28 Apr 2020 01:44:21 +0200
Message-ID: <87d07spk8a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua Yu <fenghua.yu@intel.com> writes:
> On Sun, Apr 26, 2020 at 04:55:25PM +0200, Thomas Gleixner wrote:
>> Fenghua Yu <fenghua.yu@intel.com> writes:
>> > + +#ifdef CONFIG_INTEL_IOMMU_SVM +	int pasid;
>> 
>> int? It's a value which gets programmed into the MSR along with the valid 
>> bit (bit 31) set.
>
> The pasid is defined as "int" in struct intel_svm and in 
> intel_svm_bind_mm() and intel_svm_unbind_mm(). So the pasid defined in this 
> patch follows the same type defined in those places.

Which are wrong to begin with.

>> ioasid_alloc() uses ioasid_t which is
>> 
>> typedef unsigned int ioasid_t;
>> 
>> Can we please have consistent types and behaviour all over the place?
>
> Should I just define "pasid", "pasid_max", "flags" as "unsigned int" for
> the new functions/code?
>
> Or should I also change their types to "unsigned int" in the original
> svm code (struct intel_svm, ...bind_mm(), etc)? I'm afraid that will be
> a lot of changes and should be in a separate preparation patch.

Yes, please. The existance of non-sensical code is not an excuse to
proliferate it.

Thanks,

        tglx
