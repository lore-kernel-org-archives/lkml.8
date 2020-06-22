Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01170C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3366206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="rzTmBZJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgFVPT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbgFVPT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:19:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099EBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:19:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a2500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C8191EC02A1;
        Mon, 22 Jun 2020 17:19:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592839194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BWdA+xq9JRvg1a7OXQN17UwBPELe4wX4OCjC/dAV5FI=;
        b=rzTmBZJD5fx3naz0mJkVAy8qdbfaBPWlTMLhkwV98cE7WBWTGbGHEvoG9CoxJLyBHGauaj
        NevHO6yR9TKV/4oSE4QHvnih/ru3tn/cI6Ucu1cGYUEZxEl5xIcpVt627urjFRiAxbBLQW
        4TxoiounsB7kWLkozwm1en3RIAhGM/g=
Date:   Mon, 22 Jun 2020 17:19:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Gyan Gupta <gyan.gupta@intel.com>
Cc:     x86-ml <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH -v2] x86/msr: Filter MSR writes
Message-ID: <20200622151951.GF32200@zn.tnic>
References: <1592835748-4589-1-git-send-email-gyan.gupta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1592835748-4589-1-git-send-email-gyan.gupta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 07:52:28PM +0530, Gyan Gupta wrote:
> I am also working on a similar functionality where we allow specific
> MSRs(whitelisted MSRs) to be allowed to read & write. Additionally,
> writes are subjected to checks where only certain bits can be allowed
> to be modified. This is to increase security & safety of system.
>
> For example, MCi_CTL can be used to enable/disable error reporting
> of hw unit. So in our use case once error reporting is enabled, it
> must not be disabled. Also we want to have restrictions on rdmsr for
> security purposes.

IInstead of defining whitelists, you should design proper interfaces
through sysfs or so which control the functionality you want.

If you want to do some internal testing, you don't need the whitelists
either - you simply enable writing to all MSRs like it is the case now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
