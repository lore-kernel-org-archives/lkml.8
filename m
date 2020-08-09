Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBADC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 22:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49585206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 22:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHIW6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 18:58:51 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:55466 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgHIW6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 18:58:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 07F1129B87;
        Sun,  9 Aug 2020 18:58:44 -0400 (EDT)
Date:   Mon, 10 Aug 2020 08:58:43 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Laurent Vivier <lvivier@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] macintosh/via-macii: Poll the device most likely to
 respond
In-Reply-To: <20200809185541.GA133779@roeck-us.net>
Message-ID: <alpine.LNX.2.23.453.2008100844450.8@nippy.intranet>
References: <cover.1593318192.git.fthain@telegraphics.com.au> <5836f80886ebcfbe5be5fb7e0dc49feed6469712.1593318192.git.fthain@telegraphics.com.au> <20200809185541.GA133779@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Aug 2020, Guenter Roeck wrote:

> Hi,
> 
> On Sun, Jun 28, 2020 at 02:23:12PM +1000, Finn Thain wrote:
> > Poll the most recently polled device by default, rather than the lowest
> > device address that happens to be enabled in autopoll_devs. This improves
> > input latency. Re-use macii_queue_poll() rather than duplicate that logic.
> > This eliminates a static struct and function.
> > 
> > Fixes: d95fd5fce88f0 ("m68k: Mac II ADB fixes") # v5.0+
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> With this patch applied, the qemu "q800" emulation no longer works and 
> is stuck in early boot. Any idea why that might be the case, and/or how 
> to debug it ?
> 

The problem you're seeing was mentioned in the cover letter,
https://lore.kernel.org/linux-m68k/cover.1593318192.git.fthain@telegraphics.com.au/

Since this series was merged, Linus' tree is no longer compatible with 
long-standing QEMU bugs.

The best way to fix this is to upgrade QEMU (latest is 5.1.0-rc3). Or use 
the serial console instead of the framebuffer console.

I regret the inconvenience but the alternative was worse: adding code to 
Linux to get compatibility with QEMU bugs (which were added to QEMU due to 
Linux bugs).

My main concern is correct operation on actual hardware, as always. But 
some QEMU developers are working on support for operating systems besides 
Linux.

Therefore, I believe that both QEMU and Linux should aim for compatibility 
with actual hardware and not bug compatibility with each other.
