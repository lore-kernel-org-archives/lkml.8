Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205A22078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgH1MdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729362AbgH1Mbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:31:35 -0400
Received: from localhost.localdomain (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C11902078A;
        Fri, 28 Aug 2020 12:31:33 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        Frank van der Linden <fllinden@amazon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: vdso32: make vdso32 install conditional
Date:   Fri, 28 Aug 2020 13:31:31 +0100
Message-Id: <159861787904.27651.5104242927513392169.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827234012.19757-1-fllinden@amazon.com>
References: <20200827234012.19757-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 23:40:12 +0000, Frank van der Linden wrote:
> vdso32 should only be installed if CONFIG_COMPAT_VDSO is enabled,
> since it's not even supposed to be compiled otherwise, and arm64
> builds without a 32bit crosscompiler will fail.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: vdso32: make vdso32 install conditional
      https://git.kernel.org/arm64/c/5d28ba5f8a0c

-- 
Catalin

