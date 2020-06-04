Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E10C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890C320872
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591291561;
	bh=+YGZBT+L5I64bnBefLQhWP3bXKiB90McJIuhcQd/wJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=htge41VOWPmUMbKfI68BgNTVDgA93Svo3NJv36dl9U6uUS8vVPWjRFDCCrJrlmxw5
	 zMuVrclFF9DAuT03yWEBEgkdLiu5bRp7aoDot4Xqf5kgL2cOuZUA014S4UAwzzJYl0
	 WX2N8Eb9+FqItG6JRZVjwprSswnB+vmc0hawdz1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgFDR0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730014AbgFDR0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:26:00 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EABB206C3;
        Thu,  4 Jun 2020 17:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591291560;
        bh=+YGZBT+L5I64bnBefLQhWP3bXKiB90McJIuhcQd/wJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SR1UcK+KmcithgQoOZkzGUjPXVF3HupyIu1ldz0F90jAIJDBBiG8kgWvpdcabiPbV
         L5CJLRcrl+EMx8FSg/4x0ToGjphfdfhv0UsGdoSVT+qCCmXaKHFhoZEncxBnjtZPCD
         dkjpPXfyyOJrcHf1Em7jp8SncjQaEAKdZsylReGk=
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com, mhiramat@kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gregkh@linuxfoundation.org, paulmck@kernel.org, tglx@linutronix.de,
        dianders@chromium.org
Cc:     Will Deacon <will@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: debug: mark a function as __init to save some memory
Date:   Thu,  4 Jun 2020 18:25:41 +0100
Message-Id: <159128408989.162070.15969733421063303923.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200531110015.598607-1-christophe.jaillet@wanadoo.fr>
References: <20200531110015.598607-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020 13:00:15 +0200, Christophe JAILLET wrote:
> 'debug_monitors_init()' is only called via 'postcore_initcall'.
> It can be marked as __init to save a few bytes of memory.

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: debug: mark a function as __init to save some memory
      https://git.kernel.org/arm64/c/5311ebfb612f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
