Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63B9C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB15521655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCJPIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:08:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:35562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJPIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:08:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E5900ADDD;
        Tue, 10 Mar 2020 15:08:41 +0000 (UTC)
Date:   Tue, 10 Mar 2020 16:08:45 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Thomas Voegtle <tv@lio96.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "H.J. Lu" <hjl.tools@gmail.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.9 62/88] x86/boot/compressed: Dont declare
 __force_order in kaslr_64.c
Message-ID: <20200310150845.GA16975@zn.tnic>
References: <20200310123606.543939933@linuxfoundation.org>
 <20200310123621.868809541@linuxfoundation.org>
 <alpine.LSU.2.21.2003101522120.20206@er-systems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LSU.2.21.2003101522120.20206@er-systems.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 03:33:57PM +0100, Thomas Voegtle wrote:
> This ends up for me in:
> 
> arch/x86/boot/compressed/pagetable.o: In function
> `initialize_identity_maps':
> pagetable.c:(.text+0x309): undefined reference to `__force_order'
> arch/x86/boot/compressed/pagetable.o: In function `finalize_identity_maps':
> pagetable.c:(.text+0x41a): undefined reference to `__force_order'
> 
> 
> pgtable_64.c doesn't exist in v4.9 for x86.
> 
> So I guess it's not correct to remove __force_order from pagetable.c?

Yes, the second __force_order thing was added by

08529078d8d9 ("x86/boot/compressed/64: Detect and handle 5-level paging at boot-time")

which is 4.14.

Greg, pls drop this patch from the 4.9 lineup.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
