Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96601C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CB62098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="g1VyvLou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgDVQrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgDVQrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:47:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E68C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:47:09 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0DC10099981D244BC6B235.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c100:9998:1d24:4bc6:b235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE4FB1EC0D53;
        Wed, 22 Apr 2020 18:47:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587574027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L/jcch1ERCY9r/gPK3XdKvpbttP84XCrGMsNvSSDSMk=;
        b=g1VyvLouJW/dqb9hQWoBKXZ8udZBQx++uKD/VeAMcyxTyrlRz9oae3EHmDtDimus2D1Qv3
        ZFBdHw8zWhD89NIfc87zLv4Q4XCGZi4cvha7MOuyQrrNgqDqrgfJ2wn6wHNG3qUbWJ1Et/
        kWaa/wJrkDvnrUsimdFWnF4zUrJYsqQ=
Date:   Wed, 22 Apr 2020 18:47:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and
 pgprot_large_2_4k()"
Message-ID: <20200422164703.GD26846@zn.tnic>
References: <20200422161757.GC26846@zn.tnic>
 <59604C7F-696A-45A3-BF4F-C8913E09DD4C@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59604C7F-696A-45A3-BF4F-C8913E09DD4C@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:35:08PM -0400, Qian Cai wrote:
> The config has a few extra memory debugging options enabled like
> KASAN, debug_pagealloc, debug_vm etc.

How about you specify exactly which CONFIG_ switches and cmdline options
you have enabled deliberately? I can rhyme up the rest from the .config
file.

Full dmesg would be good too, sent privately's fine too.

"etc." is not good enough.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
