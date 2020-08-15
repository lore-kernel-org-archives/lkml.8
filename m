Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2CFC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0857204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgHOVzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:55:53 -0400
Received: from disco-boy.misterjones.org ([51.254.78.96]:53374 "EHLO
        disco-boy.misterjones.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbgHOVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:55:50 -0400
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@misterjones.org>)
        id 1k6xBl-002LGO-TT; Sat, 15 Aug 2020 15:29:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 15 Aug 2020 15:29:41 +0100
From:   Marc Zyngier <maz@misterjones.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/affinity: show managed irq affinity correctly
In-Reply-To: <877du355o1.fsf@nanos.tec.linutronix.de>
References: <b55d8b8c-8afc-0046-44b6-514ad012936f@huawei.com>
 <877du355o1.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <11bb7a215cd8757f298d9f9608ed125c@misterjones.org>
X-Sender: maz@misterjones.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, yeyunfeng@huawei.com, hushiyuan@huawei.com, hewenliang4@huawei.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-13 09:08, Thomas Gleixner wrote:
> Yunfeng Ye <yeyunfeng@huawei.com> writes:

[...]

> You are looking at the wrong file. /proc/irq/$IRQ/smp_affinity* is the
> possible mask. If you want to know to which CPU an interrupt is affine
> then look at /proc/irq/$IRQ/effective_affinity*
> 
> If effective_affinity* is not showing the correct value, then the irq
> chip affinity setter is broken and needs to be fixed.

In order to reassure myself that nothing was untoward in GIC-land,
I went in and looked at an ITS-based VM running whatever is in
Linus' tree today. I see the effective affinity being correctly
setup, and being as expected a subset of the affinity. This is
without isolcpu though.

In any case, I'd be interested in understanding what this patch is
trying to solve, really.

         M.
-- 
Who you jivin' with that Cosmik Debris?
