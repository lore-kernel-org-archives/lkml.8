Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E3DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC00206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbgIAQug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732283AbgIAQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:50:18 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDC7C2067C;
        Tue,  1 Sep 2020 16:50:04 +0000 (UTC)
Date:   Tue, 1 Sep 2020 17:50:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Chen Zhou <chenzhou10@huawei.com>, will@kernel.org,
        james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        John.P.donnelly@oracle.com, prabhakar.pkin@gmail.com,
        bhsharma@redhat.com, horms@verge.net.au, robh+dt@kernel.org,
        arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v11 2/5] x86: kdump: move reserve_crashkernel_low() into
 crash_core.c
Message-ID: <20200901165001.GJ5561@gaia>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-3-chenzhou10@huawei.com>
 <20200806133627.GB2077191@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806133627.GB2077191@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 03:36:27PM +0200, Ingo Molnar wrote:
> 
> * Chen Zhou <chenzhou10@huawei.com> wrote:
> 
> > In preparation for supporting reserve_crashkernel_low in arm64 as
> > x86_64 does, move reserve_crashkernel_low() into kernel/crash_core.c.
> > 
> > BTW, move x86_64 CRASH_ALIGN to 2M suggested by Dave. CONFIG_PHYSICAL_ALIGN
> > can be selected from 2M to 16M, move to the same as arm64.
> > 
> > Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> > ---
> >  arch/x86/include/asm/kexec.h | 24 ++++++++++
> >  arch/x86/kernel/setup.c      | 86 +++---------------------------------
> >  include/linux/crash_core.h   |  3 ++
> >  include/linux/kexec.h        |  2 -
> >  kernel/crash_core.c          | 74 +++++++++++++++++++++++++++++++
> >  kernel/kexec_core.c          | 17 -------
> >  6 files changed, 107 insertions(+), 99 deletions(-)
> 
> Since the changes are centered around arm64, I suppose the arm64 tree 
> will carry this patchset?
> 
> Assuming that this is a 100% invariant moving of code that doesn't 
> regress on x86:
> 
>   Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks Ingo. The only difference I see is that CRASH_ALIGN has been
reduced to 2M here from 16M for x86. Would this break configs that have
PHYSICAL_ALIGN > 2M?

-- 
Catalin
