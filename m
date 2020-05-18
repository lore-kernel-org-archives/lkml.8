Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB32C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57AC9207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589809955;
	bh=FoiYOz4QyATjVtvdKit+fH6+X62jW8zsWpf3orvuR0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hi9W8g5V2wlkCkpbbdn65vrvj8PL3QZuv9kzmUHBs11KB0NPHK676EafoR+2fQ6Mo
	 9cNKUjL8Joh2EN12X+ZhlAPko4wKh+lHF0BKkYAHcX+qE2pfe/SvKbwAwCbufEuu7Y
	 Dp11G0ItLEx/jQBHe56pQa1mUN693ppiMT7YqMiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgERNwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbgERNwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:52:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 359B620674;
        Mon, 18 May 2020 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589809953;
        bh=FoiYOz4QyATjVtvdKit+fH6+X62jW8zsWpf3orvuR0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAlJYXMMZPIGoj5i+W8MUJP0XoNSSMUHGxPeM8QWX0jg1p1dZCt0MNfdW6ku7MAv8
         y8r2GTZLOg48MhSu4Bag6l3x0GlK+TU0MFOj71N8O7J9FvkIYcM0H8NjXqv5qf2Tlp
         uctkHwR5+RSeZrcCawxBQYukK+AmCsmSqTaLFkhE=
Date:   Mon, 18 May 2020 14:52:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 0/6] Clean up Shadow Call Stack patches for 5.8
Message-ID: <20200518135228.GI32394@willie-the-truck>
References: <20200515172756.27185-1-will@kernel.org>
 <CABCJKucXmMD82mQ0rSMjfByXD42htTjkde3TsKTVP-jvuqkZwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKucXmMD82mQ0rSMjfByXD42htTjkde3TsKTVP-jvuqkZwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 01:42:40PM -0700, Sami Tolvanen wrote:
> On Fri, May 15, 2020 at 10:28 AM Will Deacon <will@kernel.org> wrote:
> > Will Deacon (6):
> >   arm64: scs: Store absolute SCS stack pointer value in thread_info
> >   scs: Move accounting into alloc/free functions
> >   arm64: scs: Use 'scs_sp' register alias for x18
> >   scs: Move scs_overflow_check() out of architecture code
> >   scs: Remove references to asm/scs.h from core code
> >   scs: Move DEFINE_SCS macro into core code
> >
> >  arch/Kconfig                         |  4 +--
> >  arch/arm64/include/asm/scs.h         | 29 ++++------------
> >  arch/arm64/include/asm/thread_info.h |  4 +--
> >  arch/arm64/kernel/asm-offsets.c      |  2 +-
> >  arch/arm64/kernel/entry.S            | 10 +++---
> >  arch/arm64/kernel/head.S             |  2 +-
> >  arch/arm64/kernel/process.c          |  2 --
> >  arch/arm64/kernel/scs.c              |  6 +---
> >  include/linux/scs.h                  | 16 +++++----
> >  kernel/sched/core.c                  |  3 ++
> >  kernel/scs.c                         | 52 +++++++++++++---------------
> >  11 files changed, 55 insertions(+), 75 deletions(-)
> >
> > --
> > 2.26.2.761.g0e0b3e54be-goog
> 
> Thanks, Will. I tested these on my SCS tree and didn't run into any
> issues. Looks good to me.

Cheers, Sami. Can I add your 'Tested-by' to the patches, please?

Will
