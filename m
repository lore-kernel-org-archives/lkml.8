Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B6CC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA22A20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pC8Osfea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgD1RLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgD1RLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:11:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B06C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:11:19 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0EA500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7548A1EC08B1;
        Tue, 28 Apr 2020 19:11:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588093877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fj9s0PGCai8z0Zl6HkQgze+Ss5VBqYSUyC3ZhcMckuY=;
        b=pC8OsfeaHkGv8Cvq7ZCtmAt6oghQP/xqfPRVDnOIkKjbKqhHrH9nz5kutYRH94CFQrEo0E
        YYA53XgYO6f5JpUzi4WztIv5x3/0Crq2O2js6XhpYiCCe2+F+zmK8UyfVdnbgLrCKwHOhy
        +obFEo0x5Hm9g1h9T9rnWnRxfHkZwHA=
Date:   Tue, 28 Apr 2020 19:11:08 +0200
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
Subject: Re: [PATCH v3 01/10] x86/fpu/xstate: Rename validate_xstate_header()
 to validate_user_xstate_header()
Message-ID: <20200428171107.GC11272@zn.tnic>
References: <20200328164307.17497-1-yu-cheng.yu@intel.com>
 <20200328164307.17497-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200328164307.17497-2-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 09:42:58AM -0700, Yu-cheng Yu wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> The function validate_xstate_header() validates an xstate header coming
> from userspace (PTRACE or sigreturn).  To make it clear, rename it to
> validate_user_xstate_header().

For the next time: patch version history like this here:

> v3:
> - Change validate_xstate_header_from_user() to validate_user_xstate_header().

... goes ...

> 
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>
> ---

<--- ... here so that, when someone applies the patch, the version
history doesn't become part of the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
