Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E6CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955A620775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594245783;
	bh=7g+oqaiT42I+utRAWiQbRFqd7sjs4A2NGxP3dWEzGJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nvTJtevYXMKrI+Z8aUjJivBLKeAmwebgfDArqes1eOJYMg2vGTi550sDw/gTb0peB
	 VWfD1BhIjyayX56UvTWKIhASxoF4O8/1St+cJq3ngnq46VqKViCcKo9qJ7IhBerF1F
	 z+FMeIr+Xqhig3BxVvwSat/tN16jagqbepZXH45U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGHWDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgGHWC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 18:02:59 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC9A02078B;
        Wed,  8 Jul 2020 22:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594245779;
        bh=7g+oqaiT42I+utRAWiQbRFqd7sjs4A2NGxP3dWEzGJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0C3meN65Bn8O/DvB07xt8UkV65zrEh92Gy23JLisClP16l/CX5AGjOSYofUhV+ph
         Am8RUAHTriJTHf8vP6SlYS/hH75TMyrSvIzmKFOARI162t6RhlNRzIYiwTEQkpnCra
         zR6TcfTdS4F3OVkVrpda9ENNp6WSiZE/ywmgAb4E=
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 0/4] arm64: Allow the compat vdso to be disabled at runtime
Date:   Wed,  8 Jul 2020 23:02:36 +0100
Message-Id: <159424187316.2038208.16959988193299607645.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706163802.1836732-1-maz@kernel.org>
References: <20200706163802.1836732-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 17:37:58 +0100, Marc Zyngier wrote:
> The relatively recent introduction of the compat vdso on arm64 has
> overlooked its interactions with some of the interesting errata
> workarounds, such as ARM64_ERRATUM_1418040 (and its older 1188873
> incarnation).
> 
> This erratum requires the 64bit kernel to trap 32bit accesses to the
> virtual counter and emulate it. When the workaround was introduced,
> the compat vdso simply wasn't a thing. Now that the patches have
> landed in mainline, we trap the CVTVCT accesses from the vdso.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/4] arm64: Introduce a way to disable the 32bit vdso
      https://git.kernel.org/arm64/c/97884ca8c292
[2/4] arm64: arch_timer: Allow an workaround descriptor to disable compat vdso
      https://git.kernel.org/arm64/c/c1fbec4ac0d7
[3/4] arm64: arch_timer: Disable the compat vdso for cores affected by ARM64_WORKAROUND_1418040
      https://git.kernel.org/arm64/c/4b661d6133c5
[4/4] arm64: Rework ARM_ERRATUM_1414080 handling
      https://git.kernel.org/arm64/c/dc802f2bc020

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
