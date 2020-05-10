Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E201DC54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE29220731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ulu9azEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgEJIqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 04:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgEJIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 04:46:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1375EC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 01:46:35 -0700 (PDT)
Received: from zn.tnic (p200300EC2F286200C518754118B553FE.dip0.t-ipconnect.de [IPv6:2003:ec:2f28:6200:c518:7541:18b5:53fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F35A1EC02A1;
        Sun, 10 May 2020 10:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589100392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jq2xwbGufTibiBAB161r3csXP9B+3Tf4QyudVtZUfEk=;
        b=Ulu9azEvfxpYU8zObFzx87nWsa8Hv7EZGGsgY5dPm0iq7soB47M724n7gKJfQiPEfzPC7S
        0hbonqk6tw+y4kp5rIaNw/dDfD9Nk5P24QjU2hkoeivaK/k3900D1CktAddcYlHpf4whSS
        aM2c2AHrHBlY3dfIM1m4y8m/ERPf5gk=
Date:   Sun, 10 May 2020 10:46:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 09/10] x86/fpu/xstate: Preserve supervisor states for
 slow path of __fpu__restore_sig()
Message-ID: <20200510084625.GA19352@zn.tnic>
References: <20200328164307.17497-1-yu-cheng.yu@intel.com>
 <20200328164307.17497-10-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200328164307.17497-10-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 09:43:06AM -0700, Yu-cheng Yu wrote:
> The signal return code is responsible for taking an XSAVE buffer present
> in user memory and loading it into the hardware registers.  This
> operation only affects user XSAVE state and never affects supervisor state.
> 
> The fast path through this code simply points XRSTOR directly at the
> user buffer.  However, due to page faults, this XRSTOR can fail.  If it
			 ^^^^^^^^^^^^^^^^^^

"However, since user memory is not guaranteed to be always mapped, ... "

> fails, the signal return code falls back to a slow path which can
> tolerate page faults.
>
> That slow path copies the xfeatures one by one out of the user buffer
> into the task's fpu state area.  However, by being in a context where it
> can handle page faults, the code can also schedule.  That exposes us to
								    ^^
Pls use passive voice in your commit message: no "we" or "I", etc, and
describe your changes in imperative mood.

Fix this in all your commit messages pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
