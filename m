Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08090C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD19E206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GbtVgFz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgD2Rce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbgD2Rcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:32:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8062BC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:32:33 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0B95002CAA38EA2C11A9F5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9500:2caa:38ea:2c11:a9f5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 435651EC0C77;
        Wed, 29 Apr 2020 19:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588181551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JcXwnixxYGT3e36wuw7d284nTypVpD50lEh4ZBqrpYM=;
        b=GbtVgFz+gY/z7rggzfXU4HNrpAlhOB408+EPRDXzU5R2cD9qxT/LNIgeA2GsFeP/gn6y/x
        zaHGXvhAZyNii+BFx4qEmPP5x72OdkCZML/sFU2VjaukzGyywb0p9wSYsaRCzubcqdsszi
        uuvUPfRAOJ3mYPnv7h5l5km0KuXBwoI=
Date:   Wed, 29 Apr 2020 19:32:24 +0200
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
Subject: Re: [PATCH v3 05/10] x86/fpu/xstate: Define new functions for
 clearing fpregs and xstates
Message-ID: <20200429173224.GD16407@zn.tnic>
References: <20200328164307.17497-6-yu-cheng.yu@intel.com>
 <20200429160644.28584-1-yu-cheng.yu@intel.com>
 <20200429163906.GC16407@zn.tnic>
 <1b43e3cc36dd707c0268e96b166eca4421d7c2e2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b43e3cc36dd707c0268e96b166eca4421d7c2e2.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 10:02:46AM -0700, Yu-cheng Yu wrote:
> It has been some time since Thomas commented on this tail comment.
> https://lore.kernel.org/lkml/alpine.DEB.2.21.1908161703010.1923@nanos.tec.linutronix.de/
> 
> I think why not fixing it while at it.

So "fixing it" means removing it or putting it *over* the line?

If you think the comment is obvious and superfluous, then say so in the
commit message "remove obvious side-comment in fpu__clear(), while at
it." to let readers know *why* you've done it, especially since it is a
side-change, not really related to what the patch is trying to do.

Otherwise, readers like me wonder: why is he doing that? What else is
he doing in that patch that doesn't belong here? Why isn't that patch
straightforward doing one thing and one thing only and doing other
stuff?

This certainly doesn't make review easier.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
