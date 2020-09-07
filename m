Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B44C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FD92080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599494779;
	bh=Ld3Q0P90SqT/fcv53r3iy8A/rntUfRRJtF4KdDBpBWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Eqys+X+5Xar+oZkvZtIn5OaXGx1xmrVDic8duJ/621Usn/ynDr40H8i2Tv27r5op
	 tVYoH+5MyCQmDuflvRmAIIZXimSrW8z8zwgbfrZGLsx7G/1QBKvX6Ub69l6wRqVStd
	 jIItniL2+e2OCL1O18DqGEJjX8BEiGe0fouweXGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgIGQGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730005AbgIGQFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:05:53 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32488208C7;
        Mon,  7 Sep 2020 16:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599494753;
        bh=Ld3Q0P90SqT/fcv53r3iy8A/rntUfRRJtF4KdDBpBWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oPIHeo2fT5hs6wPbs+wpdFd3N+U1GDB1JVqha3q5rL9Hi4OAHIek4a1DqAcc6+Bcz
         aCsmL5J1DIr5MMFZBnAmexIWYhz38LmksYFK0fnWzL6UxCAslMyufb9yx6KZ7srjXZ
         jW/LzLS+Q+rIdDU0rz7KRtGYgCGDStQjZNRmb4ZQ=
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: perf: Add general hardware LLC events for PMUv3
Date:   Mon,  7 Sep 2020 17:05:34 +0100
Message-Id: <159947535838.560920.6785898612227287683.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200811053505.21223-1-leo.yan@linaro.org>
References: <20200811053505.21223-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 13:35:05 +0800, Leo Yan wrote:
> This patch is to add the general hardware last level cache (LLC) events
> for PMUv3: one event is for LLC access and another is for LLC miss.
> 
> With this change, perf tool can support last level cache profiling,
> below is an example to demonstrate the usage on Arm64:
> 
>   $ perf stat -e LLC-load-misses -e LLC-loads -- \
> 	  perf bench mem memcpy -s 1024MB -l 100 -f default
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] arm64: perf: Add general hardware LLC events for PMUv3
      https://git.kernel.org/will/c/ffdbd3d83553

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
