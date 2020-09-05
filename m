Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0C0C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 12:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEDD2072D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 12:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgIEM6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 08:58:12 -0400
Received: from foss.arm.com ([217.140.110.172]:58840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgIEM6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 08:58:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29F4DD6E;
        Sat,  5 Sep 2020 05:58:10 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41F1E3F66F;
        Sat,  5 Sep 2020 05:58:09 -0700 (PDT)
References: <20200903183206.104838-1-maz@kernel.org> <20200903183206.104838-2-maz@kernel.org> <jhj4kodxrx5.mognet@arm.com> <878sdomv5i.wl-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: Re: [PATCH v2 1/4] genirq: Walk the irq_data hierarchy when resending an interrupt
In-reply-to: <878sdomv5i.wl-maz@kernel.org>
Date:   Sat, 05 Sep 2020 13:58:04 +0100
Message-ID: <jhj363wxtwj.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/09/20 10:26, Marc Zyngier wrote:
> <random>
> Maybe considering the irqchip stack along a vertical axis is the wrong
> thing to do, and that looking at it as a volume would be marginally
> better?
>
> How about innermost (close to the CPU) vs outermost (close to the
> device)?
> </random>
>

I guess this is fairly subjective, but the inner/outer thing does click
with me.

I think the "issue" with the top / bottom wording is that existing data
structures (domain / irq_data hierarchy) bias my interpretation of it, but
it's upside down from the irq_chip stack representation. That's not the
case of inner / outer where all I can think of is the actual chip layout
(i.e. as an image of the distance from the CPUs).

Anyway, that's enough psychoanalysis from me, the patches look fine - I
also reran my quick rtcwake test on GICv2 (tests the WAKEUP_ARMED
path). Feel free to add

  Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

to 1/4 & 3/4.

> Thanks,
>
>       M.
