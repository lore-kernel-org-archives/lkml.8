Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E50AC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F9A2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgAOWTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:19:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49401 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgAOWTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:19:55 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irr0v-0002IC-V0; Wed, 15 Jan 2020 23:19:50 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0D22D101228; Wed, 15 Jan 2020 23:19:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     DavidWang@zhaoxin.com, CooperYan@zhaoxin.com,
        QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com
Subject: Re: [PATCH] x86/cpu: clear X86_BUG_SPECTRE_V2 on Zhaoxin family 7 CPUs
In-Reply-To: <1579075500-7065-1-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1579075500-7065-1-git-send-email-TonyWWang-oc@zhaoxin.com>
Date:   Wed, 15 Jan 2020 23:19:49 +0100
Message-ID: <87h80wxsze.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> writes:

> These CPUs are not affected by spectre_v2, so clear spectre_v2 bug flag
> in their specific initialization code.
>  
>  	if (cpu_has(c, X86_FEATURE_VMX))
>  		centaur_detect_vmx_virtcap(c);
> +
> +	if (c->x86 == 7) {
> +		setup_clear_cpu_cap(X86_BUG_SPECTRE_V2);
> +		clear_bit(X86_BUG_SPECTRE_V2, (unsigned long *)cpu_caps_set);

No. Please use cpu_vuln_whitelist. It exists for exactly this
purpose. You just need to extend it with a NO_SPECTRE_V2 bit.

Thanks,

        tglx


