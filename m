Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CABC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32F02064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392090AbgAPXq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:46:59 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57582 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390819AbgAPXV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:21:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 3828C29997;
        Thu, 16 Jan 2020 18:21:23 -0500 (EST)
Date:   Fri, 17 Jan 2020 10:21:26 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Sasha Levin <sashal@kernel.org>
cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH AUTOSEL 4.4 064/174] m68k: mac: Fix VIA timer counter
 accesses
In-Reply-To: <20200116174251.24326-64-sashal@kernel.org>
Message-ID: <alpine.LNX.2.21.1.2001170929550.255@nippy.intranet>
References: <20200116174251.24326-1-sashal@kernel.org> <20200116174251.24326-64-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Jan 2020, Sasha Levin wrote:

> From: Finn Thain <fthain@telegraphics.com.au>
> 
> [ Upstream commit 0ca7ce7db771580433bf24454f7a1542bd326078 ]
> 

This commit has been selected for 4.4, 4.9, 4.14 and 4.19. But this commit 
has questionable value without it's parent, commit 1efdd4bd2543 ("m68k: 
Call timer_interrupt() with interrupts disabled").

For all stable branches, I'd prefer you selected both commits or neither, 
because I periodically backport to a branch based on stable/linux-4.14.y.

Thanks.
