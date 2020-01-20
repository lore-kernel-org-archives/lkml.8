Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1C2C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E0522314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgATTYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:24:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34165 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgATTYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:24:49 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1itcf6-0006Xb-98; Mon, 20 Jan 2020 20:24:36 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id ABF8A105BE6; Mon, 20 Jan 2020 20:24:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <maz@kernel.org>, John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Ming Lei <ming.lei@redhat.com>,
        "chenxiang \(M\)" <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Balance initial LPI affinity across CPUs
In-Reply-To: <7dc37b35d8ec6c78e75969d8c6c2d2e9@kernel.org>
References: <20200119190554.1002-1-maz@kernel.org> <5d04d904-d7ea-04ea-ac3b-8cdc90074a92@huawei.com> <afb60c5f9a176470449a83126db326a9@kernel.org> <83eb55b0-2f2d-3335-85cf-6d7ed379b3c7@huawei.com> <7dc37b35d8ec6c78e75969d8c6c2d2e9@kernel.org>
Date:   Mon, 20 Jan 2020 20:24:35 +0100
Message-ID: <87h80q2aoc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

Marc Zyngier <maz@kernel.org> writes:
> We're stuck between a rock and a hard place here:
>
> (1) We place all interrupts on the least loaded CPU that matches
>      the affinity -> results in performance issues on some funky
>      HW (like D05's SAS controller).
>
> (2) We place managed interrupts on the least loaded CPU that matches
>      the affinity -> we have artificial load on NUMA boundaries, and
>      reduced spread of overlapping managed interrupts.
>
> (3) We don't account for non-managed LPIs, and we run the risk of
>      unpredictable performance because we don't really know where
>      the *other* interrupts are.
>
> My personal preference would be to go for (1), as in my original post.
> I find (3) the least appealing, because we don't track things anymore.
> (2) feels like "the least of all evils", as it is a decent performance
> gain, seems to give predictable performance, and doesn't regress lesser
> systems...
>
> I'm definitely open to suggestions here.

The way x86 does it and that's mostly ok except for some really broken
setups is:

1) Non-managed interrupts:

   If the interrupt is bound to a node, then we try to find a target

     I)  in the intersection of affinity mask and node mask.

     II) in the nodemask itself

         Yes we ignore affinity mask there because that's pretty much
         the same as if the given affinity does not contain an online
         CPU.

     If all of that fails then we try the nodeless mode

   If the interrupt is not bound to a node, then we try to find a target

     I)  in the intersection of affinity mask and online mask.

     II) in the onlinemask itself

  Each step searches for the CPU in the searched mask which has the
  least number of total interrupts assigned.

2) Managed interrupts

  For managed interrupts we just search in the intersection of assigned
  mask and online CPUs for the CPU with the least number of managed
  interrupts.

  If no CPU is online then the interrupt is shutdown anyway, so no
  fallback required.

Don't know whether that's something you can map to ARM64, but I assume
the principle of trying to enforce NUMA locality plus balancing the
number of interrupts makes sense in general.

Thanks,

        tglx


