Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584F5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202C2206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589544833;
	bh=wO3WfBzz3sXFu/UmGn0py5JO3lUtLdiDwLGHsADKYzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WlqX/dtIX8wLrTrzFRFZ8YUNrDoQGiM/yNPn0BeaiRdyiR4cW65fvogJznf+clb+w
	 XWmE2OxsMhumtWBgrIDuxlA1rk5B3NVSux48urjOOTybcIirHhfKF3upIudAySYlDP
	 7z1oc7Fh91PqOeXE/pl8cC0zuuxfI+kRnP2k8MuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgEOMNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgEOMNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:13:52 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610E220657;
        Fri, 15 May 2020 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589544831;
        bh=wO3WfBzz3sXFu/UmGn0py5JO3lUtLdiDwLGHsADKYzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsxPPfg8b47Ez+Exn/r04LsRNi/MOD4RC8HIxKVhYoBXCknPhrB81UTnuY82bTnST
         xjZFUoU/z4q1C6LQ2OtKCL9UCkY8wFJqidpfGSwzLxp3GbF9pGYjx0i+hlHR1148wq
         h56oGW78rqtJVj2ZPA/uRZnJIASubirSvGrbrUtg=
Date:   Fri, 15 May 2020 13:13:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: PTRACE_SYSEMU behavior difference on arm64
Message-ID: <20200515121346.GA22919@willie-the-truck>
References: <CABV8kRyHrDMK4o=UZZZWJMuQNjPA8Xuoj-JFF-Lsx26fBTR0WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABV8kRyHrDMK4o=UZZZWJMuQNjPA8Xuoj-JFF-Lsx26fBTR0WA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keno,

On Fri, May 15, 2020 at 07:15:35AM -0400, Keno Fischer wrote:
> The behavior of PTRACE_SYSEMU on arm64
> appears to differ substantially from that of x86 and powerpc
> (the other two architectures on which this feature is implemented).
> In particular, after PTRACE_SYSEMU the syscall will always
> be skipped on x86 and powerpc, but executed on arm64 unless
> the syscall-entry stop was again continued using PTRACE_SYSEMU.
> The skipping behavior is also documented in the manpage,
> so I suspect this may just be a bug (the skipping behavior
> makes sense to me and is what I would expect).
> The reason this happens is that `syscall_trace_enter`
> re-checks TIF_SYSCALL_EMU after the ptrace stop, but at that
> point it may have already been superseded by a new ptrace
> request. x86 and power save the original value of the flag,
> rather than acting on the new value. I can submit a patch to
> fix this, but wanted to check first whether this was intentional.
> If it is, I can fix the man page instead.

Please send a patch, since this looks like a silly bug to me. But it also
means that nobody is using this on arm64, so we could also consider removing
it entirely. Did you spot this because you are trying to use it for
something or just by inspection/unit-testing?

Will
