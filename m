Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C194AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E6420748
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgDFVV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:21:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45702 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFVV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:21:27 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jLZBC-00012E-S3; Mon, 06 Apr 2020 23:21:15 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D5BEC100C47; Mon,  6 Apr 2020 23:21:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>,
        xiaoyao.li@intel.com
Cc:     philipp.eppelt@kernkonzept.com, bp@alien8.de, fenghua.yu@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, nivedita@alum.mit.edu, pbonzini@redhat.com,
        peterz@infradead.org, sean.j.christopherson@intel.com,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH 0/1] x86/split_lock: check split lock feature on initialization
In-Reply-To: <20200403174403.306363-1-benjamin.lamowski@kernkonzept.com>
References: <20200325030924.132881-1-xiaoyao.li@intel.com> <20200403174403.306363-1-benjamin.lamowski@kernkonzept.com>
Date:   Mon, 06 Apr 2020 23:21:13 +0200
Message-ID: <87369gl392.fsf@nanos.tec.linutronix.de>
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
> During regression testing of our hypervisor[1] with the current git tip,
> we got writes to the TEST_CTRL MSR on hardware that does not support
> split lock detection. While the original split_lock implementation does
> not exhibit this behavior, the reworked initialization from
> dbaba47085b0c unconditionally calls split_lock_verify_msr() from
> split_lock_init().
>
> After the elaborate checks in cpu_set_core_cap_bits() this seems like an
> oversight. The following simple patch fixes our regression by checking
> for X86_FEATURE_SPLIT_LOCK_DETECT before accessing the TEST_CTRL MSR.

No. It's not an oversight, it's a simplification and it's perfectly
legit. rdsmrl_safe() on a unimplemented MSR results in a #GP which is
caught and fixed up. Nothing to see here.

Thanks,

        tglx
