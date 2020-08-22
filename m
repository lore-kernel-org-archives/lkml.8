Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D46C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D51020825
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WJOHVij+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHVJB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:01:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36974 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgHVJB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:01:28 -0400
Received: from zn.tnic (p200300ec2f215f00ad099a9b0ccc7b9f.dip0.t-ipconnect.de [IPv6:2003:ec:2f21:5f00:ad09:9a9b:ccc:7b9f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 025F41EC0298;
        Sat, 22 Aug 2020 11:01:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598086887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pSeYwwV3HQHPmOgj4qLYOmAyNKBbGEZxCXuAhcC8GYk=;
        b=WJOHVij+YjvcG0ZhBKbNvO4Bw/BSD96PAM2BdM5j16d69CJW3G2A0ETW1COvVV/6+IJLPH
        vLl9Hl9v1Ysd8aTmVLJsn4fMR2f4YtkzHdAKPE+ZUmVR0HzI3xncB51bqaH/1RSsMhosgP
        Qxf9Wset5WMw2RlN2LN0AizGOlvNnuU=
Date:   Sat, 22 Aug 2020 11:01:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/resctrl: Enable user to view thread or core
 throttling mode
Message-ID: <20200822090123.GA31906@zn.tnic>
References: <1598034317-122771-1-git-send-email-fenghua.yu@intel.com>
 <1598034317-122771-3-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1598034317-122771-3-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:25:17AM -0700, Fenghua Yu wrote:
> Early Intel hardware implementations of Memory Bandwidth Allocation (MBA)
> could only control bandwidth at the processor core level. This meant that
> when two processes with different bandwidth allocations ran simultaneously
> on the same core the hardware had to resolve this difference. It did so by
> applying the higher throttling value (lower bandwidth) to both processes.
> 
> Newer implementations can apply different throttling values to each
> thread on a core.
> 
> Introduce a new resctrl file, "thread_throttle_mode", on Intel systems
> that shows to the user how throttling values are allocated, per-core or
> per-thread.
> 
> On systems that support per-core throttling, the file will display "max".
> On newer systems that support per-thread throttling, the file will display
> "per-thread".
> 
> AMD confirmed in
> https://lore.kernel.org/lkml/18d277fd-6523-319c-d560-66b63ff606b8@amd.com
> that AMD bandwidth allocation is already at thread level but that the AMD
> implementation does not use a memory delay throttle mode. So to avoid
> confusion the thread throttling mode would be UNDEFINED on AMD systems
> and the "thread_throttle_mode" file will not be visible.
> 
> Originally-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Change log:
> v2:
> - Rename "arch_throttle_mode" to "throttle_mode" and
>   "rdtgroup_rftype_by_name()" to "rdtgroup_rftype_get_by_name()" (Boris).

But you didn't call it that. You called it:

get_rdtgroup_rftype_get_by_name

Two "get" and the prefix doesn't come first. So take this string
verbatim:

"rdtgroup_get_rftype_by_name"

and paste it everywhere where the function name is.

How about you slow down, do it right and then send it? It is not a
competition where the first to send, wins.

Also, pls redo the patches ontop of tip:x86/cache because there's James'
stuff there now and this one doesn't apply.

And test them again and *then* resend.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
