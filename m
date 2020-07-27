Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E36C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D51D20738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgG0H05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgG0H0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:26:49 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46164C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:26:49 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BFWZv3Rl1z9sSP; Mon, 27 Jul 2020 17:26:47 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Finn Thain <fthain@telegraphics.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, Joshua Thompson <funaho@jurai.org>,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
Subject: Re: [PATCH 0/8] Mac ADB IOP driver fixes
Message-Id: <159583478164.602200.6100049166996515383.b4-ty@ellerman.id.au>
Date:   Mon, 27 Jul 2020 17:26:47 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020 09:17:03 +1000, Finn Thain wrote:
> The adb-iop driver was never finished. Some deficiencies have become
> apparent over the years. For example,
> 
>  - Mouse and/or keyboard may stop working if used together
> 
>  - SRQ autopoll list cannot be changed
> 
> [...]

Applied to powerpc/next.

[1/8] macintosh/adb-iop: Remove dead and redundant code
      https://git.kernel.org/powerpc/c/8384c82ab0860cd7db2ce4ec403e574f4ee54b6e
[2/8] macintosh/adb-iop: Correct comment text
      https://git.kernel.org/powerpc/c/ff785e179faf4bb06a2f73b8dcde6dabb66a83d2
[3/8] macintosh/adb-iop: Adopt bus reset algorithm from via-macii driver
      https://git.kernel.org/powerpc/c/303511edb859b1fbf48b3c1d1d53b33a6ebd2a2b
[4/8] macintosh/adb-iop: Access current_req and adb_iop_state when inside lock
      https://git.kernel.org/powerpc/c/aac840eca8fec02d594560647130d4e4447e10d9
[5/8] macintosh/adb-iop: Resolve static checker warnings
      https://git.kernel.org/powerpc/c/56b732edda96b1942fff974fd298ea2a2c543b94
[6/8] macintosh/adb-iop: Implement idle -> sending state transition
      https://git.kernel.org/powerpc/c/32226e81704398317e1cc5a82d24c0ef3cc25e5e
[7/8] macintosh/adb-iop: Implement sending -> idle state transition
      https://git.kernel.org/powerpc/c/e2954e5f727fad126258e83259b513988973c166
[8/8] macintosh/adb-iop: Implement SRQ autopolling
      https://git.kernel.org/powerpc/c/c66da95a39ec2bb95544c3def974d96e8c178f57

cheers
