Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABFFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5D82071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598946486;
	bh=hMj2e4wFJknK1lax5LtgwDFzrkKqm76QV+xaVk0tjYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AWOlTcwDGsxFqnVuuDd7Rh5If99AVxqUwkcWnUchDpCcmEF4XV7ScBM29noC+Ir6I
	 eIMhxmCmr6HmCF5jcumZZ3X11g0ms6qa1zUvuTWiWhL16nN36Aburc0OGRwTdZZjj7
	 I7hwomZCBv9oXI4IaGCvZ6z3TWwSPlGvj6cO1GXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgIAHsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgIAHsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:48:04 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15FA62068E;
        Tue,  1 Sep 2020 07:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598946484;
        bh=hMj2e4wFJknK1lax5LtgwDFzrkKqm76QV+xaVk0tjYs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lek3gwvlMfsPNSTpoieF5oIDAXBYQImxjW7gBuyg3spxlvPpK7q8N8LYcyKGhroIf
         uBTxZiGzlmfOo3FXbZ9Gq5n+/hnxmT2Ro3Ax4AR05ZP/ANygw4p3v6Ysir+w6+SYSE
         EU6ev0NuxKHr+tY0/L+xM51dH82ocKHKsl/j+hgs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD11O-008D4p-Fr; Tue, 01 Sep 2020 08:48:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Sep 2020 08:48:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: Adjust interrupt Priority for ARM64 GIC
In-Reply-To: <5a6e65cf-d2fe-0107-2318-0e3c81d57000@huawei.com>
References: <5a6e65cf-d2fe-0107-2318-0e3c81d57000@huawei.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <51146530616bb8fdf23c637ff5bee44e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gengdongjiu@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjiu,

In the future, please use my kernel.org address, as I don't work
for ARM anymore, and would have missed this email if I wasn't pointed
to it.

On 2020-08-14 18:10, Dongjiu Geng wrote:
> Hi Marc,
>    In the Linux kernel, we can not adjust the  interrupt Priority, For
> all the interrupts, the interrupt Priority are fixed to 0xa0.
> In some scenarios, it needs to change the Priority. so I want to
> upstream a serie patch to support to change the Priority through
> procfs. do you agree I upstream this feature? thanks~

No, that's not something I would ever consider, and for multiple
reasons:

- Linux only supports a single priority, meaning that interrupts are
   themselves aren't preemptable. Dealing with things like (pseudo) NMI
   is invasive enough, and I can't see a good reason to relax the
   single priority requirement.

- Building on top of the above, the whole scheduler and locking model
   relies on the non-preemptable property of an interrupt.

- I cannot see a good reason to leave the priority control to userspace.
   That's a sure recipe for userspace-controlled livelocks.

Now, I'm sure you want to introduce this for a reason, and you are not
explaining it ("some scenarios" doesn't quite cut it). If you care to
explain these "scenarios", maybe there is something we can do.

But please don't waste time implementing any sort of priority change,
there is no way I'll consider it as such.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
