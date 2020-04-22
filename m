Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59033C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364222077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ocFtZn2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgDVWFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgDVWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:05:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F4C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:05:18 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0DC10034799E0EEF8349F9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c100:3479:9e0e:ef83:49f9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0981E1EC0D66;
        Thu, 23 Apr 2020 00:05:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587593117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hR0OWELozgYes+SCcKL8kMuliprtW69y8+TArTclptg=;
        b=ocFtZn2S71ijNkLHoqiEKRfBm5aETIjGgGqV/UDhlEZsZqRjMPyRrtJK0/4k7EM1wF1kSW
        bai8q/nqMTySOcG0tcjjSQA268Rujl/3FaJxQCVj0kbZ5A/FheI+SfJk3CHwVcEKqBeADO
        74SMW5n0nwn19UBC2I6xG2PDAADAa2A=
Date:   Thu, 23 Apr 2020 00:05:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and
 pgprot_large_2_4k()"
Message-ID: <20200422220512.GK26846@zn.tnic>
References: <20200422214751.GJ26846@zn.tnic>
 <462564C5-1F0F-4635-AAB8-7629A6379425@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <462564C5-1F0F-4635-AAB8-7629A6379425@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:57:09PM -0400, Qian Cai wrote:
> I thought Christ is going to send some minor updates anyway, so it may
> be better for him to include this one together? Otherwise, I am fine to
> send this one standalone.

You mean Christoph.

Ok, I'll let you guys hash it out.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
