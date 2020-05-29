Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7919EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5216B2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590750655;
	bh=7sAH5Q45SSZ5h/+VQ6sNe8Zzwnwl+WDutlBrtkbM3pY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KFpzpbuTfW/A4jNCSxVRyxcAs2T8YXxqT2zUAKDBZnbjxIevOCzd+YLQdeu0EI62z
	 lpC3MLNXWNTnWquY68TVcbCMKRit2XaY+4fJTkhrH8VoqGe446Pqh9v6j2i2ey5Ucu
	 ClrUDH+sPWMTity6pNpDfMaMjnDQCapo5HoFMmVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgE2LKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgE2LKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:10:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91FFB206E2;
        Fri, 29 May 2020 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590750650;
        bh=7sAH5Q45SSZ5h/+VQ6sNe8Zzwnwl+WDutlBrtkbM3pY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HRSm1UVDjEXhxcM4AYUshIjsvg+h6LpIgL9pfCP9PBNYjM6O4bcDvIDnTyth01CWO
         Z2bBWl2YzHy8r2ctznmpfv/d+Ub8ih1P0UnDareE6ov4DskZ9ZflGTsivy8oocOtFb
         hYuBdgf0ZbYIug9lV3/XrY63b5qwxXtqPxuTRfao=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jecuX-00GFga-1a; Fri, 29 May 2020 12:10:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 12:10:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/6] irqchip: RISC-V per-HART local interrupt
 controller driver
In-Reply-To: <CAAhSdy1uRzsF7w_GMaPhfyNnRkhRNqT2edL0+96gwocWiXNpOA@mail.gmail.com>
References: <20200521133301.816665-1-anup.patel@wdc.com>
 <20200521133301.816665-4-anup.patel@wdc.com>
 <140c6fa723225ff138e8b39c4f16c9c0@kernel.org>
 <CAAhSdy1uRzsF7w_GMaPhfyNnRkhRNqT2edL0+96gwocWiXNpOA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <40251a7764fc23ed19426df0adf0fc4d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup@brainfault.org, anup.patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, daniel.lezcano@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, atish.patra@wdc.com, Alistair.Francis@wdc.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-29 11:45, Anup Patel wrote:
> On Fri, May 29, 2020 at 3:39 PM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2020-05-21 14:32, Anup Patel wrote:

[...]

>> > +/* Get the OF device node used by INTC irq domain */
>> > +struct device_node *riscv_of_intc_domain_node(void)
>> > +{
>> > +     return intc_domain_node;
>> > +}
>> > +EXPORT_SYMBOL_GPL(riscv_of_intc_domain_node);
>> 
>> Why do you need this? Why can't the timer node refer to its
>> interrupt-parent? The irqchip shouldn't be in the business of
>> working around DT issues.
>> 
>> At worse, use the default irqdomain if you must, but please
>> avoid this kind of construct.
> 
> Even, I don't like exporting riscv_of_intc_domain_node().
> 
> Thanks for your suggestion, I will certainly use the default irqdomain.

This should be a last resort solution. The irqdomain should
naturally come from the parent interrupt controller, accessible
from the device (the timer in this case) node.

Use it to for backward compatibility if you *really* must,
but this is generally a very bad idea as it allows all kind
of bizarre fallbacks and hides bugs.

Thanks,

          M.
-- 
Jazz is not dead. It just smells funny...
