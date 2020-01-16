Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD83C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 00:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD09222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 00:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgAPAi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 19:38:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49697 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAPAi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 19:38:56 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irtBR-0004Vs-3c; Thu, 16 Jan 2020 01:38:49 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 922B510121C; Thu, 16 Jan 2020 01:38:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mukesh Ojha <mojha@codeaurora.org>, mingo@kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH] irq_work: Fix comment for irq_work_run()
In-Reply-To: <0101016eeb1507c9-0db4e0b6-011c-4754-a34c-9ef0b078b23b-000000@us-west-2.amazonses.com>
References: <0101016eeb1507c9-0db4e0b6-011c-4754-a34c-9ef0b078b23b-000000@us-west-2.amazonses.com>
Date:   Thu, 16 Jan 2020 01:38:48 +0100
Message-ID: <87zheow7zb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mukesh Ojha <mojha@codeaurora.org> writes:

> hotplug_cfd() does not exist anymore, update the
> comment for irq_work_run() with smpcfd_dying_cpu().

That's only half of the truth. Just check the output of:

git grep irq_work_run

So even if the s/hotplug_cfd/smpcfd_dying_cpu/ change is correct, this
comment is actively misleading.

Thanks,

        tglx
