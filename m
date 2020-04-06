Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FB6C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA732082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDFVZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:25:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45720 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFVZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:25:03 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jLZEl-000159-1j; Mon, 06 Apr 2020 23:24:55 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5ED7F100C47; Mon,  6 Apr 2020 23:24:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>,
        xiaoyao.li@intel.com
Cc:     bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        nivedita@alum.mit.edu, pbonzini@redhat.com, peterz@infradead.org,
        philipp.eppelt@kernkonzept.com, sean.j.christopherson@intel.com,
        tony.luck@intel.com, x86@kernel.org,
        Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
Subject: Re: [PATCH v3 1/1] x86/split_lock: check split lock support on initialization
In-Reply-To: <20200406161737.258840-1-benjamin.lamowski@kernkonzept.com>
References: <20200406160247.208004-1-benjamin.lamowski@kernkonzept.com> <20200406161737.258840-1-benjamin.lamowski@kernkonzept.com>
Date:   Mon, 06 Apr 2020 23:24:53 +0200
Message-ID: <87zhbojoii.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Lamowski <benjamin.lamowski@kernkonzept.com> writes:

> While the sld setup code is run only if the TEST_CTRL MSR is available,
> the current sld initialization code unconditionally resets it even on
> systems where this architectural MSR is not available.
>
> This commit introduces a new default sld state sld_unsupported, which is
> changed in split_lock_setup() only if sld is available; and checks for
> split lock detect support before initializing it.

What for? You explain what the patch is doing, but not WHY. See
Documentation/process and while at it please search for 'This patch' as
well.

> Fixes: dbaba47085b0c ("x86/split_lock: Rework the initialization flow
> of split lock detection")

That's blantantly wrong. It fixes your hypervisor which fails to raise a
#GP when an unknown MSR is accessed. 

Are we going to see that kind of 'fixes' everytime we decide to probe an
MSR for simplicity from now on?

Please fix the root cause and not the symptom.

Thanks,

        tglx
