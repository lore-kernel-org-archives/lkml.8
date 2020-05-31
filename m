Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16079C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 12:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36B8206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 12:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgEaMdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 08:33:04 -0400
Received: from elvis.franken.de ([193.175.24.41]:45601 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgEaMdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 08:33:04 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jfN9A-00033I-01; Sun, 31 May 2020 14:33:00 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A8153C0654; Sun, 31 May 2020 14:32:48 +0200 (CEST)
Date:   Sun, 31 May 2020 14:32:48 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mips@vger.kernel.org, John Crispin <john@phrozen.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ralink: drop ralink_clk_init for mt7621
Message-ID: <20200531123248.GB6039@alpha.franken.de>
References: <20200328041523.81229-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328041523.81229-1-gch981213@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 12:14:57PM +0800, Chuanhong Guo wrote:
> ralink_clk_init is only called in arch/mips/ralink/clk.c which isn't
> compiled for mt7621. And it doesn't export a proper cpu clock.
> Drop this unused function.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  arch/mips/ralink/mt7621.c | 43 ---------------------------------------
>  1 file changed, 43 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
