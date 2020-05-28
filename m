Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0CDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA895208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgE1JNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:13:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:36824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbgE1JNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:13:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C186EAA7C;
        Thu, 28 May 2020 09:13:52 +0000 (UTC)
Date:   Thu, 28 May 2020 11:13:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] powerpc/bpf: Enable bpf_probe_read{, str}() on powerpc
 again
Message-ID: <20200528091351.GE3529@linux-b0ei>
References: <20200527122844.19524-1-pmladek@suse.com>
 <87ftbkkh00.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftbkkh00.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-05-28 11:03:43, Michael Ellerman wrote:
> Petr Mladek <pmladek@suse.com> writes:
> > The commit 0ebeea8ca8a4d1d453a ("bpf: Restrict bpf_probe_read{, str}() only
> > to archs where they work") caused that bpf_probe_read{, str}() functions
> > were not longer available on architectures where the same logical address
> > might have different content in kernel and user memory mapping. These
> > architectures should use probe_read_{user,kernel}_str helpers.
> >
> > For backward compatibility, the problematic functions are still available
> > on architectures where the user and kernel address spaces are not
> > overlapping. This is defined CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
> >
> > At the moment, these backward compatible functions are enabled only
> > on x86_64, arm, and arm64. Let's do it also on powerpc that has
> > the non overlapping address space as well.
> >
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> This seems like it should have a Fixes: tag and go into v5.7?

Good point:

Fixes: commit 0ebeea8ca8a4d1d4 ("bpf: Restrict bpf_probe_read{, str}() only to archs where they work")

And yes, it should ideally go into v5.7 either directly or via stable.

Should I resend the patch with Fixes and
Cc: stable@vger.kernel.org #v45.7 lines, please?

Best Regards,
Petr
