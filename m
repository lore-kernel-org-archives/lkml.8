Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2221AC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D0C222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="V7lVfKWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgBUONR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:13:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42736 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgBUONR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:13:17 -0500
Received: from zn.tnic (p200300EC2F090A006DBA3D6338540E70.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:a00:6dba:3d63:3854:e70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC49D1EC0249;
        Fri, 21 Feb 2020 15:13:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582294395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l0IPVkd245PgHO+2EPJiKBuLEnIMI4owo58BCZBQ0cg=;
        b=V7lVfKWH00igm4/ZhQw7NtALyqgTyLNGfFi+F6w+nq+wvCBOGSX2WDc6MpRLjDjzVItWeg
        /rLn3CH7ttDsiujK1d5vPoIFzAYsMy6s+sLv3N2h9p2mFbka+QgrcfdK9veuZKyOHKYN2D
        ywENllhRnQXTcp5Xbai3ST9NltXsEW8=
Date:   Fri, 21 Feb 2020 15:13:16 +0100
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
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2 5/8] x86/fpu/xstate: Rename validate_xstate_header()
 to validate_xstate_header_from_user()
Message-ID: <20200221141316.GG25747@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
 <20200121201843.12047-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121201843.12047-6-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 12:18:40PM -0800, Yu-cheng Yu wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> The function validate_xstate_header() validates an xstate header coming
> from userspace (PTRACE or sigreturn).  To make it clear, rename it to
> validate_xstate_header_from_user().

Or simply:

validate_user_xstate_header()

Also, make that patch the first in your series.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
