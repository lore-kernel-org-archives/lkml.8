Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B027AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829602076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgCZO4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:56:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50949 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgCZO4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:56:08 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jHTvF-0002bx-8i; Thu, 26 Mar 2020 15:55:53 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7644D10069D; Thu, 26 Mar 2020 15:55:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xiaoyao Li <xiaoyao.li@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v6 8/8] kvm: vmx: virtualize split lock detection
In-Reply-To: <1d98bddd-a6a4-2fcc-476b-c9b19f65c6b6@intel.com>
References: <20200324151859.31068-1-xiaoyao.li@intel.com> <20200324151859.31068-9-xiaoyao.li@intel.com> <87eethz2p6.fsf@nanos.tec.linutronix.de> <88b01989-25cd-90af-bfe8-c236bd5d1dbf@intel.com> <87d08zxtgl.fsf@nanos.tec.linutronix.de> <1d98bddd-a6a4-2fcc-476b-c9b19f65c6b6@intel.com>
Date:   Thu, 26 Mar 2020 15:55:52 +0100
Message-ID: <87a743xj0n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:
> On 3/26/2020 7:10 PM, Thomas Gleixner wrote:
> If the host has it disabled, !split_lock_detect_on() is true, it skips 
> following check due to ||
>
> if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK)) {
> 	inject #AC back to guest

That'd be a regular #AC, right?

> } else {
> 	if (guest_alignment_check_enabled() || guest_sld_on())
> 		inject #AC back to guest

Here is clearly an else path missing. 

> }

Thanks,

        tglx
