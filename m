Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B30C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 20:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D53821835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 20:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgAWUZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:25:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33778 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgAWUY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:24:58 -0500
Received: from localhost (unknown [62.209.224.147])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3403F14EACBEA;
        Thu, 23 Jan 2020 12:24:56 -0800 (PST)
Date:   Thu, 23 Jan 2020 21:24:54 +0100 (CET)
Message-Id: <20200123.212454.218301597333582741.davem@davemloft.net>
To:     fthain@telegraphics.com.au
Cc:     tsbogend@alpha.franken.de, chris@zankel.net, laurent@vivier.eu,
        geert@linux-m68k.org, eric.dumazet@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 00/12] Fixes for SONIC ethernet driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1579730846.git.fthain@telegraphics.com.au>
References: <cover.1579730846.git.fthain@telegraphics.com.au>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 23 Jan 2020 12:24:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Thu, 23 Jan 2020 09:07:26 +1100

> Various SONIC driver problems have become apparent over the years,
> including tx watchdog timeouts, lost packets and duplicated packets.
> 
> The problems are mostly caused by bugs in buffer handling, locking and
> (re-)initialization code.
> 
> This patch series resolves these problems.
> 
> This series has been tested on National Semiconductor hardware (macsonic),
> qemu-system-m68k (macsonic) and qemu-system-mips64el (jazzsonic).
> 
> The emulated dp8393x device used in QEMU also has bugs.
> I have fixed the bugs that I know of in a series of patches at,
> https://github.com/fthain/qemu/commits/sonic

Series applied, thank you.
