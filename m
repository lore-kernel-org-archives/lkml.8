Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666BCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33253207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590525915;
	bh=KSSDjXavc4Cfkda/YtwTNNTYhwmx7H7cHFjcR7WMiM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jWK1IsB9G9u2F9m2Zr/cgcLfB7C8FLDXWeFQfIChay8ex8mCIelKE9pRtYZTr6GEM
	 0cP+eE1b/FsP8lv+ZWNesQFPCN1oQTkn+C60NC8K2VdTZezJGA/8IVJyrqH8Q6OJBh
	 9yDs5PAVH2rJotiEihVO0NHosniIRTCTlXQnsDUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403894AbgEZUpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389486AbgEZUpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:45:13 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3BF7207CB;
        Tue, 26 May 2020 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590525913;
        bh=KSSDjXavc4Cfkda/YtwTNNTYhwmx7H7cHFjcR7WMiM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p56PlHM9Ux3eBLXiMitWDjCOX3x2l3RjHhy0jti/3zxxyc0uyd/jM9Skc42ZjzsfK
         ZC8xnZ5C0I1Q8exv5+co6FBVZQbyQMG02U3fQgN9hAGMhNUEZcNkyIep/EvRF06qJj
         kju0MB5feQ7fSPec8l+SyhwoCLVOBWlZNUl8apwQ=
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Manoj Gupta <manojgupta@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Luis Lozano <llozano@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@google.com>
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
Date:   Tue, 26 May 2020 21:45:05 +0100
Message-Id: <159052247565.23781.7800427985507723263.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526173117.155339-1-ndesaulniers@google.com>
References: <20200526173117.155339-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 10:31:14 -0700, Nick Desaulniers wrote:
> Custom toolchains that modify the default target to -mthumb cannot
> compile the arm64 compat vdso32, as
> arch/arm64/include/asm/vdso/compat_gettimeofday.h
> contains assembly that's invalid in -mthumb.  Force the use of -marm,
> always.

Applied to arm64 (for-next/vdso), thanks!

[1/1] arm64: vdso32: force vdso32 to be compiled as -marm
      https://git.kernel.org/arm64/c/20363b59ad4f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
