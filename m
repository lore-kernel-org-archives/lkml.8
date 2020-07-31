Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCB3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156CE22B42
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbgGaRtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:32918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbgGaRtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:49:03 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECCBC21744;
        Fri, 31 Jul 2020 17:49:00 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     akpm@linux-foundation.org, mark.rutland@arm.com,
        Maninder Singh <maninder1.s@samsung.com>, will@kernel.org,
        james.morse@arm.com
Cc:     v.narang@samsung.com, 0x7f454c46@gmail.com, peterz@infradead.org,
        Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org,
        a.sahrawat@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: use IRQ_STACK_SIZE instead of THREAD_SIZE for irq stack
Date:   Fri, 31 Jul 2020 18:48:59 +0100
Message-Id: <159621773195.22678.10460254019899261504.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1596196190-14141-1-git-send-email-maninder1.s@samsung.com>
References: <CGME20200731121259epcas5p11248853c0578f2e426ab828310c9e855@epcas5p1.samsung.com> <1596196190-14141-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 17:19:50 +0530, Maninder Singh wrote:
> IRQ_STACK_SIZE can be made different from THREAD_SIZE,
> and as IRQ_STACK_SIZE is used while irq stack allocation,
> same define should be used while printing information of irq stack.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: use IRQ_STACK_SIZE instead of THREAD_SIZE for irq stack
      https://git.kernel.org/arm64/c/338c11e94e16

-- 
Catalin

