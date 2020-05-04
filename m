Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9234FC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596B520707
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588626258;
	bh=GInPiyiEF5930d8AKtyiPGs+zeaUkY2HSw0WrjCjsbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kj/v0GzGoO6wo5s/Up86g9b31P5i2Qk/LuBXADZJMbemAcdcLFhlVBOPmjyLkcsLq
	 EsrNFToYpGKik5UOzcCXk7y7JlDelPWcv+T9j/hJkeuTrfPilZVWe/wHOL95cqHxkB
	 1M1sRRIWPJQ3zQSxURUZ2lxbWkIDgnSV8eirkZ6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgEDVER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 17:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgEDVER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 17:04:17 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716EB206A5;
        Mon,  4 May 2020 21:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588626256;
        bh=GInPiyiEF5930d8AKtyiPGs+zeaUkY2HSw0WrjCjsbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjw826Kkg27NT5/RM0n98j6Vqmw1pzxK2JSbwyPVVQrNO/X/oC4fqRat/o8vOy9qA
         kBzsV7FyhF2a7WJ90gktpF6/tWbh2GLvtbuHvsM6wMQj8+EMn5aiPgEyqC8MLQONke
         G/SiqfkP2hQZm+2wpgadcKvGEG9zJ7UZSWl69qlg=
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpuinfo: Move device_initcall() near cpuinfo_regs_init()
Date:   Mon,  4 May 2020 22:04:09 +0100
Message-Id: <158861212065.39196.5531503127956521107.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1588595377-4503-1-git-send-email-anshuman.khandual@arm.com>
References: <1588595377-4503-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 17:59:37 +0530, Anshuman Khandual wrote:
> This moves device_initcall() near cpuinfo_regs_init() making the calling
> sequence clear. Besides it is a standard practice to have device_initcall()
> (any __initcall for that matter) just after the function it actually calls.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/cpuinfo: Move device_initcall() near cpuinfo_regs_init()
      https://git.kernel.org/arm64/c/da7bad98eebb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
