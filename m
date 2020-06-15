Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A45C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104372078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbgFOQcv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgFOQcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:32:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680B7C061A0E;
        Mon, 15 Jun 2020 09:32:51 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jks2T-0007R0-Dg; Mon, 15 Jun 2020 18:32:49 +0200
Date:   Mon, 15 Jun 2020 18:32:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200615163249.kofrsl274aotcdz7@linutronix.de>
References: <87imfyh6yx.fsf@gmx.net>
 <87wo4dligz.fsf@gmx.net>
 <20200612110122.jossn5zrktcvpbpm@linutronix.de>
 <87tuzdrgm5.fsf@gmx.net>
 <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
 <874krcsquv.fsf@gmx.net>
 <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
 <87tuzcqqul.fsf@gmx.net>
 <20200615155846.nd5n32qggusakxl7@linutronix.de>
 <87pna0qp2x.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87pna0qp2x.fsf@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-15 18:19:18 [+0200], Stephen Berman wrote:
> It's there, 196 lines above the Start ffff8d7aa8758a80 line:
> 
> Jun 15 08:56:58 strobe-jhalfs kernel: [  106.275356] acpi_os_execute(1109) Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa84e70a0 <ffff8d7aa8758a80>

So compared with 
| [  193.321242] acpi_os_execute_deferred_notify(851) Start  ffff8d7aa8758a80 acpi_ev_notify_dispatch+0x0/0x55(ffff8d7aa84e70a0)

it took ~87 seconds for the item to start since it was enqueued.
Assuming that workqueue still makes progress on shutdown it may just a
long time to flush all worker on shutdown. I still have no idea how the
commit in question is responsible for that behaviour…

> Steve Berman

Sebastian
