Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA4C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5378F2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgA2Mbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:31:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51279 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgA2Mbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:31:36 -0500
Received: from konstanz.wlan.tk-bodensee.net ([185.80.169.68] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iwmVA-0000Vy-Pq; Wed, 29 Jan 2020 13:31:25 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0F5FC105CFD; Wed, 29 Jan 2020 13:31:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Luck\, Tony" <tony.luck@intel.com>
Cc:     Mark D Rustad <mrustad@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Christopherson\, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu\, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj\, Ashok" <ashok.raj@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v17] x86/split_lock: Enable split lock detection by kernel
In-Reply-To: <20200126200535.GB30377@agluck-desk2.amr.corp.intel.com>
References: <4E95BFAA-A115-4159-AA4F-6AAB548C6E6C@gmail.com> <C3302B2F-177F-4C39-910E-EADBA9285DD0@intel.com> <8CC9FBA7-D464-4E58-8912-3E14A751D243@gmail.com> <20200126200535.GB30377@agluck-desk2.amr.corp.intel.com>
Date:   Wed, 29 Jan 2020 13:31:24 +0100
Message-ID: <87d0b24f6r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:
> +static bool __sld_msr_set(bool on)
> +{
> +	u64 test_ctrl_val;
> +
> +	if (rdmsrl_safe(MSR_TEST_CTRL, &test_ctrl_val))
> +		return false;
> +
> +	if (on)
> +		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> +	else
> +		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> +
> +	return !wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val);
> +}
> +
> +static void split_lock_init(void)
> +{
> +	if (sld_state == sld_off)
> +		return;
> +
> +	if (__sld_msr_set(true))
> +		return;
> +
> +	/*
> +	 * If this is anything other than the boot-cpu, you've done
> +	 * funny things and you get to keep whatever pieces.
> +	 */
> +	pr_warn("MSR fail -- disabled\n");
> +	__sld_msr_set(sld_off);

This one is pretty pointless. If the rdmsrl or the wrmsrl failed, then
the next attempt is going to fail too. Aside of that sld_off would be not
really the right argument value here. I just zap that line.

Thanks,

        tglx
