Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B66C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0AC42166E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588281165;
	bh=4N+XVeWe5iq04Af3epw8kMsGp1IN/CYN912qwCpTA+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g74cQm5DqEL7biOORQDA4EMRQm7ZdN3ij0roPS+mKcdc5xaEHvq5bFhVCWlYeBm6D
	 9uwb839RioxvAHPVwGOW8UVReJMvzMhWtUM3PpptzNL3VNObp8CGP3L1eF8JgVq+83
	 0oOFzUSfdlIBtVDPXR9WHoXwYnriYA9RzhKaO5rU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgD3VMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgD3VMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:12:43 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F12721582;
        Thu, 30 Apr 2020 21:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588281163;
        bh=4N+XVeWe5iq04Af3epw8kMsGp1IN/CYN912qwCpTA+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4TMXZERpTTWLYGfiFF4kOPedHTqdRmFawNiSLOe7so1vvLn+x+o19bMQ2FYZSrCa
         bet803u2jgYcax7efa5uXbVq9owjsehp1vSmheGnZJJEgTzZMwy4D5oBu+l0naC3Uj
         fdYNL+IXBVDztIrZvJ9fn28omeJLKgBw8Yo1PwXk=
From:   Will Deacon <will@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>, mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf:arm_spe:Avoid duplicate printouts
Date:   Thu, 30 Apr 2020 22:12:26 +0100
Message-Id: <158827977305.123274.1505711753559195244.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402120330.19468-1-tangbin@cmss.chinamobile.com>
References: <20200402120330.19468-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020 20:03:30 +0800, Tang Bin wrote:
> Because platform_get_irq() has dev_err(),so this place
> should be removed.

Applied to arm64 (for-next/perf), thanks!

[1/1] drivers/perf: arm_spe_pmu: Avoid duplicate printouts
      https://git.kernel.org/arm64/c/1f0d97bb7082

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
