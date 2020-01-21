Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A453AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F50920882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgAUM2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:28:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37162 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgAUM2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:28:48 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9374914EFC23E;
        Tue, 21 Jan 2020 04:28:46 -0800 (PST)
Date:   Tue, 21 Jan 2020 13:28:45 +0100 (CET)
Message-Id: <20200121.132845.2048607059303572209.davem@davemloft.net>
To:     nivedita@alum.mit.edu
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH RESEND] sparc/console: kill off obsolete declarations
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200115160749.GA3951901@rani.riverdale.lan>
References: <20200115160749.GA3951901@rani.riverdale.lan>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jan 2020 04:28:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Wed, 15 Jan 2020 11:07:50 -0500

> commit 09d3f3f0e02c ("sparc: Kill PROM console driver.") missed removing
> the declarations of the deleted prom_con structure and prom_con_init
> function from console.h. Kill them off now.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Applied, thank you.
