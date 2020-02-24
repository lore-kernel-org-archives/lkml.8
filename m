Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD9BC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61622080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hcEgrKvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBXMzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:55:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35136 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbgBXMzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:55:32 -0500
Received: from zn.tnic (p200300EC2F0C0F00754C15A63F97C369.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f00:754c:15a6:3f97:c369])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB8071EC06AC;
        Mon, 24 Feb 2020 13:55:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582548930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=k4n928txEUbCCPofMkDP3ZZra5z8ea63XGeucln+S9o=;
        b=hcEgrKvC8aJbZJKIXpSmPUbkuWPJ45GGTKMOlNBj45VcmRpraerbeolpRG2w4o3kEkyg++
        DXnbFAGNSGv5DBjumtWGw9p54RfLpnlOb1LYs5SFOmQN5F9vFsaH7Sq1vIq7FXP6FO6dI7
        we1Dw4v/wR+xNejudVWOfP4qnj9lTOc=
Date:   Mon, 24 Feb 2020 13:55:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] x86/mce/therm_throt: Handle case where
 throttle_active_work() is called on behalf of an offline CPU
Message-ID: <20200224125525.GA29318@zn.tnic>
References: <20200222162432.497201-1-srinivas.pandruvada@linux.intel.com>
 <20200222175151.GD11284@zn.tnic>
 <40989625ca5496a986ca3e595957da83723777f4.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40989625ca5496a986ca3e595957da83723777f4.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 04:25:59PM -0800, Srinivas Pandruvada wrote:
> If the condition is false, will it prevent offline CPU before executing
> next statement and reschedule on another CPU? Although It will not
> cause any error or crash but in rare circumstance may print premature
> warning/normal message based on the current CPU's state.

Why, offline CPU is offline CPU?

Btw, I'm asking whether you can do the simpler thing *instead* of your
patch. You basically don't run the workqueue callback on offlined CPUs:

	get_online_cpus();

	if (cpu_is_offline(smp_processor_id()))
		goto out;

	...


out:
	put_online_cpus();

Hmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
