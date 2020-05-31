Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E356CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 12:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AABE1206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 12:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgEaMdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 08:33:05 -0400
Received: from elvis.franken.de ([193.175.24.41]:45604 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEaMdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 08:33:04 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jfN9A-00033I-00; Sun, 31 May 2020 14:33:00 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 277BDC0652; Sun, 31 May 2020 14:32:27 +0200 (CEST)
Date:   Sun, 31 May 2020 14:32:27 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     john@phrozen.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] MIPS: ralink: bootrom: mark a function as __init to save
 some memory
Message-ID: <20200531123227.GA6039@alpha.franken.de>
References: <20200531100603.597847-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531100603.597847-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 12:06:03PM +0200, Christophe JAILLET wrote:
> 'bootrom_setup()' is only called via 'postcore_initcall'.
> It can be marked as __init to save a few bytes of memory.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/mips/ralink/bootrom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
