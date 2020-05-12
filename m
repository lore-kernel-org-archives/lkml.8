Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5787C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CF420722
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589292726;
	bh=CXVcGy0r5V76DjIUep1E6c2r1ywoTMY1xMhHTd3xo7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TTI/bWGPMQrV3nLunr3T+Sbou8t/mnT5/vP1yQ2q2VLhgo8l/sEfrqOfHwJuB5NIg
	 GEEKS9fIuICHJK9iSQCIH/m7Fy2wNymC8wW2kox9g/BUugYkZdWl5R2htNZ3spESf8
	 v5WvmhDjKdK2FJW6sw8k5DCZMnMZBjse5OBgSdVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgELOMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbgELOMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:12:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E1B4206F5;
        Tue, 12 May 2020 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589292725;
        bh=CXVcGy0r5V76DjIUep1E6c2r1ywoTMY1xMhHTd3xo7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nf8pWzxiuwt2dwHad9Lk+gIThZ3yQSFyc76cjfDnA1Y8whchAW5/75evHqGirqsRw
         3x60E+22hbSGx47b2l4A2GB51ea7ZIOeOgaTXnP2dpUm6Vv8roxpOy1jpBdpLQmv23
         7+OZnoznGKW44AyGa64W2szoj1OUD8P7HHrjARoY=
Date:   Tue, 12 May 2020 15:12:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: cpufeature: Add "or" to mitigations for multiple
 errata
Message-ID: <20200512141200.GD3021@willie-the-truck>
References: <20200512124238.28792-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512124238.28792-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 02:42:38PM +0200, Geert Uytterhoeven wrote:
> Several actions are not mitigations for a single erratum, but for
> multiple errata.  However, printing a line like
> 
>     CPU features: detected: ARM errata 1165522, 1319367, 1530923
> 
> may give the false impression that all three listed errata have been
> detected.  This can confuse the user, who may think his Cortex-A57 is
> suddenly affected by Cortex-A76 and Cortex-A55 errata.
> 
> Add "or" to all descriptions for mitigations for multiple errata, to
> make it clear that only one or more of the errata printed are
> applicable, and not necessarily all of them.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm64/kernel/cpu_errata.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This seems to conflict with the other patch you sent to reorder the entries.
Please can you send another version, based on the arm64 for-next/kconfig
branch?

Will
