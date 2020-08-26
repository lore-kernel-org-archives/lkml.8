Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F35C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294A82078B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHZRaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgHZRaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:30:15 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665D72078B;
        Wed, 26 Aug 2020 17:30:13 +0000 (UTC)
Date:   Wed, 26 Aug 2020 18:30:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [mm] c566586818:
 BUG:kernel_hang_in_early-boot_stage,last_printk:Probing_EDD(edd=off_to_disable)...ok
Message-ID: <20200826173010.GD24545@gaia>
References: <34a960a0-ec0b-3c26-ec73-e415a8197757@intel.com>
 <9D9FBD8D-DF19-4DA9-B0B1-260BA72D3712@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D9FBD8D-DF19-4DA9-B0B1-260BA72D3712@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:02:40PM -0400, Qian Cai wrote:
> On Aug 25, 2020, at 8:44 PM, Rong Chen <rong.a.chen@intel.com> wrote:
> > I rebuilt the kernel on commit c566586818 but the error changed to
> > "RIP: 0010:clear_page_orig+0x12/0x40", and the error can be
> > reproduced on parent commit:
> 
> Catalin, any thought? Sounds like those early kmemleak allocations
> cause some sort of memory corruption?

I can't immediately see how but Rong implies that the error also happens
on the parent commit. Does it mean the bisection isn't entirely right?

-- 
Catalin
