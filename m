Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2565C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E4020714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgCZMHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:07:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60721 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbgCZMG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:06:58 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48p3cw3lcxz9sT3; Thu, 26 Mar 2020 23:06:55 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 850507f30c38dff21ed557cb98ab16db26c32bbc
In-Reply-To: <20200318060004.10685-1-po-hsu.lin@canonical.com>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>,
        linux-kselftest@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        paulus@samba.org, shuah@kernel.org
Subject: Re: [PATCHv2] selftests/powerpc: Turn off timeout setting for benchmarks, dscr, signal, tm
Message-Id: <48p3cw3lcxz9sT3@ozlabs.org>
Date:   Thu, 26 Mar 2020 23:06:55 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-18 at 06:00:04 UTC, Po-Hsu Lin wrote:
> Some specific tests in powerpc can take longer than the default 45
> seconds that added in commit 852c8cbf34d3 ("selftests/kselftest/runner.sh:
> Add 45 second timeout per test") to run, the following test result was
> collected across 2 Power8 nodes and 1 Power9 node in our pool:
>   powerpc/benchmarks/futex_bench - 52s
>   powerpc/dscr/dscr_sysfs_test - 116s
>   powerpc/signal/signal_fuzzer - 88s
>   powerpc/tm/tm_unavailable_test - 168s
>   powerpc/tm/tm-poison - 240s
> 
> Thus they will fail with TIMEOUT error. Disable the timeout setting
> for these sub-tests to allow them finish properly.
> 
> https://bugs.launchpad.net/bugs/1864642
> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/850507f30c38dff21ed557cb98ab16db26c32bbc

cheers
