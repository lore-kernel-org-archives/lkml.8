Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D22C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 07:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E4720738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 07:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgGSHvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 03:51:07 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:55032 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgGSHvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 03:51:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 311A929B45;
        Sun, 19 Jul 2020 03:51:02 -0400 (EDT)
Date:   Sun, 19 Jul 2020 17:51:03 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
cc:     geert@linux-m68k.org, funaho@jurai.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Replace HTTP links with HTTPS ones
In-Reply-To: <d4c73203-56ed-820f-82ee-c239d7976d33@al2klimov.de>
Message-ID: <alpine.LNX.2.23.453.2007191659150.8@nippy.intranet>
References: <20200717184240.79799-1-grandmaster@al2klimov.de> <alpine.LNX.2.23.453.2007181258320.92@nippy.intranet> <d4c73203-56ed-820f-82ee-c239d7976d33@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020, Alexander A. Klimov wrote:

> *Sigh* ... yes, doing everything one nice day is better that doing just 
> something right now.

I wasn't saying "do everything possible or else do nothing". I was trying 
to point to the larger problem. The http links in the kernel source hardly 
seem to matter when nothing I read on HTTPS links is trustworthy.

> But doing just something right now is better that doing nothing at all.
> 

HTTPS is not new. MITM attack is as old as the Byzantian hills. Your 
rationale for doing "something right now" is apparently that you trust the 
people who maintain "kernel developers" browsers but mistrust the people 
who maintain some network links and switches. That's fine and you should 
set your policy accordingly. But you should not be surprised if others 
have different threat models -- especially when you fail to offer an 
actual case where this patch might have helped.
