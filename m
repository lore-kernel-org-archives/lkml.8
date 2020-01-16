Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876A4C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A9B2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199102;
	bh=Uvn4io9HRoCWehKj5QlRdjNGEEGcA1mRcdpz3dLBqGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rrrDkAAZtZ5GOifW8loudoaL4uy2+BIRaeVOmJ1kiHqRhLSJ4QB8JyrN08+3xyTHV
	 bBWRE9/bdsjYKhFadRUZj4AXZE/duUAkx4s9xlMv6mRoc06vpS/Hwbdcobz7Qa787P
	 XMqhl+UTPSM8iPgJnLGH45DNlf8c9PCvDEjK4VQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436642AbgAPSY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:24:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392408AbgAPSY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:24:56 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F20320684;
        Thu, 16 Jan 2020 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579199096;
        bh=Uvn4io9HRoCWehKj5QlRdjNGEEGcA1mRcdpz3dLBqGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0CKqRrAnK+geRIGoLgKnBDxnHagxynAqskFtIRJ9DfMZWKYtbc1dCbzt1+SfM2sjc
         hnVnjWETX8zzmlDO2rucuD7erQEPcfSJVahwFRoGLWRtDIXk5QdfPs8irawGcLG9X7
         3jkFCB+/ojXqzQSHWy0dF/yM2x/Ww6byyiuTepeA=
Date:   Thu, 16 Jan 2020 18:24:50 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/15] add support for Clang's Shadow Call Stack
Message-ID: <20200116182449.GD22420@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191206221351.38241-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206221351.38241-1-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 02:13:36PM -0800, Sami Tolvanen wrote:
> This patch series adds support for Clang's Shadow Call Stack
> (SCS) mitigation, which uses a separately allocated shadow stack
> to protect against return address overwrites. More information
> can be found here:
> 
>   https://clang.llvm.org/docs/ShadowCallStack.html

I've queued the first four via arm64.

Will
