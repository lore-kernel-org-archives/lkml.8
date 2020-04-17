Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27448C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF5F21D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgDQKEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgDQKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:04:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0719C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:04:43 -0700 (PDT)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPNrR-0005qF-FJ; Fri, 17 Apr 2020 12:04:37 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 04063104096; Fri, 17 Apr 2020 12:04:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are not architectural
In-Reply-To: <20200416205754.21177-3-tony.luck@intel.com>
References: <20200416205754.21177-1-tony.luck@intel.com> <20200416205754.21177-3-tony.luck@intel.com>
Date:   Fri, 17 Apr 2020 12:04:36 +0200
Message-ID: <878siumnrf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Luck <tony.luck@intel.com> writes:
> +	m = x86_match_cpu(split_lock_cpu_ids);
> +	if (!m)
> +		return;
> +
> +	if (m->driver_data && cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
> {

This condition results in the following:

    driver_data     MSR_CORE_CAPS	 MSR_CORE_CAPS_SLD	SLD available

1       0             Don't care          Don't care               Y
2       1                N                Don't care               Y
3       1                Y                    Y                    Y
4       1                Y                    N                    N

#2 does not make any sense to me.

Thanks,

        tglx
