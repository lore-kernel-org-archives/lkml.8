Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF01C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB6620738
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iJP9lcVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgIHRcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:32:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60392 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729860AbgIHRb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:31:29 -0400
Received: from zn.tnic (p200300ec2f10bf0070b09dfd4356f225.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:bf00:70b0:9dfd:4356:f225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8168D1EC0489;
        Tue,  8 Sep 2020 19:31:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599586288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yRtJiQvTLZaPtk+RPwk6k5Jt+rFID7Ns/oQ86UrML8s=;
        b=iJP9lcVJcOyHAel/oWkGSXaP0GErNwXl6VSrOEf9ISsvhMmAZGwWpE8/uE7DCXMj7yaqlP
        lvn26zkv8fYCalX0O+s/4vImZEYbA/zJr1dJoF80yTli8TYPwDm3eoOZhz8ECsF42RtrVQ
        ewJ//YO+lNX4F/urn2duEr/bcda49Yw=
Date:   Tue, 8 Sep 2020 19:31:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Message-ID: <20200908173128.GH25236@zn.tnic>
References: <20200907094843.1949-1-Jason@zx2c4.com>
 <20200907100647.GB10657@zn.tnic>
 <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:10:17AM -0700, Srinivas Pandruvada wrote:
> > > -	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
> > > +	switch (reg) {
> > > +	case MSR_IA32_ENERGY_PERF_BIAS:
> There is already sysfs interface for it.

So someone needs to convert all those to it:

tools/power/cpupower/utils/helpers/msr.c:14:#define MSR_IA32_ENERGY_PERF_BIAS   0x1b0
tools/power/cpupower/utils/helpers/msr.c:84:    ret = read_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &val);
tools/power/cpupower/utils/helpers/msr.c:97:    ret = write_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, val);
tools/power/x86/turbostat/turbostat.8:222:cpu0: MSR_IA32_ENERGY_PERF_BIAS: 0x00000006 (balanced)
tools/power/x86/turbostat/turbostat.c:3652:     if (get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr))
tools/power/x86/turbostat/turbostat.c:3669:     fprintf(outf, "cpu%d: MSR_IA32_ENERGY_PERF_BIAS: 0x%08llx (%s)\n", cpu, msr, epb_string);
tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8:25:Policy in MSR_IA32_ENERGY_PERF_BIAS (EPB)
tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8:33:Note that MSR_IA32_ENERGY_PERF_BIAS is defined per CPU,
tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c:84:unsigned int has_epb;        /* MSR_IA32_ENERGY_PERF_BIAS */
tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c:755:            get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr);
tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c:1044:           get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr);
tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c:1045:           put_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, new_epb);

Any takers?

If there are none, it could be made into a small kernelnewbies
project...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
