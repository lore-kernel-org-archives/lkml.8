Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D34C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DDB22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595246183;
	bh=kiM6xMfehVEfecKw4+hAdRIWugd3GJbh8ANcQA1rzIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mnnNSZ9as+GzUADHiC7fhff3sZgqxbfc3t1FbPibF3f1k4nT7E9wfr+ny6H+DdsQz
	 G5jwtlwF07kOTFUK8C8VakoNbZ7MMwLdWK8bakM60KFG0mc4VDm+RY2QC7vIL+Gfd6
	 aUK5thXRc8cP09x4ejAMsmdgGLRxWdThbIyP8SLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgGTL4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728524AbgGTL4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:56:20 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63D552070A;
        Mon, 20 Jul 2020 11:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595246179;
        bh=kiM6xMfehVEfecKw4+hAdRIWugd3GJbh8ANcQA1rzIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wSqsuHTwHxJl8kln8dfKXMRoRtFElqWOfhc72T5E7rm/3rdfc/4CmNmWBLkzyLxz1
         xKBNCxXHZB3AA/D+tCn9yi9gWo+y5+UMzWVCiORP24wyteZ1U+vdJNMAozvR7rXsFy
         VGXVuMyOXqZauzvhoa8eZ4CjAU2n+QMCP7W2D1pM=
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/7] arm64: perf: Proper cap_user_time* support
Date:   Mon, 20 Jul 2020 12:56:08 +0100
Message-Id: <159524224815.3493066.352647020593379203.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200716051130.4359-1-leo.yan@linaro.org>
References: <20200716051130.4359-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 13:11:23 +0800, Leo Yan wrote:
> This patch set is rebased for Peter's patch set to support
> cap_user_time/cap_user_time_short ABI for Arm64, and export Arm arch
> timer counter related parameters from kernel to Perf tool.
> 
> After get feedback from Ahmed, this patch set contains Ahmed's new patch
> to refine sched clock data accessing with raw_read_seqcount_latch().
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/7] sched_clock: Expose struct clock_read_data
      https://git.kernel.org/will/c/1b86abc1c645
[2/7] time/sched_clock: Use raw_read_seqcount_latch()
      https://git.kernel.org/will/c/aadd6e5caaac
[3/7] arm64: perf: Implement correct cap_user_time
      https://git.kernel.org/will/c/950b74ddefc4
[4/7] arm64: perf: Only advertise cap_user_time for arch_timer
      https://git.kernel.org/will/c/279a811eb520
[5/7] perf: Add perf_event_mmap_page::cap_user_time_short ABI
      https://git.kernel.org/will/c/6c0246a4588d
[6/7] arm64: perf: Add cap_user_time_short
      https://git.kernel.org/will/c/c8f9eb0d6eba
[7/7] tools headers UAPI: Update tools's copy of linux/perf_event.h
      https://git.kernel.org/will/c/5271d915a99c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
