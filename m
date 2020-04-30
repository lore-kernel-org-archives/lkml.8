Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE04C8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A89D20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gRuGwUKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgD3J72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:59:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51570 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgD3J7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:59:21 -0400
Received: from zn.tnic (p200300EC2F0C300004BE574BBCE9717A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:3000:4be:574b:bce9:717a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09DD21EC0BFD;
        Thu, 30 Apr 2020 11:59:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588240760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5llhOqdG7t8hgBxhImnjOl/0n5PnW1ah5nvhkKR9F+E=;
        b=gRuGwUKCpwm12/refyf6+i7pVLGFXugCc9d4FB9ZpMQGAdOuJGGb0vF/3QuUxKbM9RQa/p
        GsthYR1290eaZ1j/rOoWLttxm9AyLCln+WmdYeQgsYuhj0ybh7CjukaQjpTAdMfzAZIKpo
        T1tLBCuvLhwrPL/AmTV31sQ9bk4ONvc=
Date:   Thu, 30 Apr 2020 11:59:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/resctrl: Support CPUID enumeration of MBM
 counter width
Message-ID: <20200430095913.GA3996@zn.tnic>
References: <cover.1585763047.git.reinette.chatre@intel.com>
 <76dc65631c373e0c1c9f3e8aaa768f022a2c989c.1585763047.git.reinette.chatre@intel.com>
 <20200429181149.GE16407@zn.tnic>
 <6fb58472-88f2-925b-3a4e-4692957a9582@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fb58472-88f2-925b-3a4e-4692957a9582@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:42:03AM -0700, Reinette Chatre wrote:
> This would essentially be resubmitting [1] though. Do you expect that
> this change would receive a different reception at this time?

Right, Thomas and I talked it over a bit last night. So the proper
thing to do is to read all that information *once* and put it in
boot_cpu_data. Because that information is replicated the same over
CPUID on each core. If there's per-CPU stuff, then it should remain
per-CPU but looking at how the RDT code uses boot_cpu_data, I'd say this
is global info.

So, it should be parsed once on the BSP during boot and put into
boot_cpu_data. And then silly stuff like x86_init_cache_qos() should go
away too.

If this info is needed on Intel only, then it should be parsed in
cpu/intel.c, in a ->c_bsp_init helper and if it is needed on AMD too,
then a function which does this should be called by the respective
c_bsp_init helper.

Then all its users can continue reading it out of boot_cpu_data and
future RDT hw info can be added there.

Makes sense?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
