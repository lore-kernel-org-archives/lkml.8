Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6B2C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8242C2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587577417;
	bh=GKVeRNovN7Obk0/QIZ5ZrkitdmSCkes/oP/yb8NxlYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ChrTeJzvLFzsYtDEvxNkh216xGk0j7bbzQ8MteZwAHSBbmtOnmn+W/vi5nxMhXkes
	 T4cxT94Ra+musoWsBKdO5bPUZZ99cV4tIa2A1Uu5LI3dBFflHX/WGB47c1OuO9uKWc
	 n3kSB5SY8W2DiGUp716ylwyB//vjhpMb+uYKk1MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgDVRng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgDVRne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:43:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF5C02076E;
        Wed, 22 Apr 2020 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587577413;
        bh=GKVeRNovN7Obk0/QIZ5ZrkitdmSCkes/oP/yb8NxlYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ElNvhNTfCskVw6AaK9v+WlfpKssxKenLa3m1DmDTw4TqDUbQh+iCxY1wYHWhNgrgU
         Vlx/Xx0LKMTw5ZJdupehMz598ahh2mcR867bVsF5vs6oio7Vyk36GE9ZV2ATk2O5s9
         567isgI4CNdFQyeLZGcIBhgxm+6d9fUHAXgy6Go0=
Date:   Wed, 22 Apr 2020 18:43:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 02/12] scs: add accounting
Message-ID: <20200422174326.GA3121@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200421021453.198187-1-samitolvanen@google.com>
 <20200421021453.198187-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421021453.198187-3-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 07:14:43PM -0700, Sami Tolvanen wrote:
> This change adds accounting for the memory allocated for shadow stacks.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/base/node.c    |  6 ++++++
>  fs/proc/meminfo.c      |  4 ++++
>  include/linux/mmzone.h |  3 +++
>  kernel/scs.c           | 16 ++++++++++++++++
>  mm/page_alloc.c        |  6 ++++++
>  mm/vmstat.c            |  3 +++
>  6 files changed, 38 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Thanks!

Will
