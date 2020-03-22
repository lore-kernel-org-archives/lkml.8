Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966A6C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667CF20753
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584877873;
	bh=4L+US9oyt6r1I7CpRdSaSOrHJKplo8D3RFAXhA3hdMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EUiMdKREXwADlLy86g3FKslrsw0yj20Tcf8+FPEfHoKpHemKMdcCKt75oAxumCOae
	 KoSMwZWJNoRzP1JduSt19yXU9hnwYiNFt6+dk1OACpRZx21bmscDletIBvUyt9dIKD
	 eDXFHjbKQbntEiwRwg0J5v1cZVPVBvhGitqJ4pQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgCVLvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgCVLvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:51:11 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4178F20732;
        Sun, 22 Mar 2020 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584877871;
        bh=4L+US9oyt6r1I7CpRdSaSOrHJKplo8D3RFAXhA3hdMo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R0BqIzrd/qCI/exH8dYpR45RGV/pyISkZIgqN7y2yAXCqvYqhd8Vf/qEKtoxxD0VO
         HcJciWvxoDtlyvS9WwhU6zu6Q1GxV5/58aTbT8GWbIn+CXbBQ5hP7iqrjWWgQhR7Zt
         bLXMWyxFZcJRkFdeVFgNmDJxl8quAtU6aW2ZalJY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jFz8H-00Efyv-IX; Sun, 22 Mar 2020 11:51:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 22 Mar 2020 11:51:09 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sungbo Eo <mans0n@gorani.run>, linux-oxnas@groups.io,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] irqchip/versatile-fpga: Apply clear-mask earlier
In-Reply-To: <CACRpkdYvoVF_q1Re_v_sJCYVDOhte0NpdU91UtYB2SpHH60-jg@mail.gmail.com>
References: <20200321133842.2408823-1-mans0n@gorani.run>
 <CACRpkdYvoVF_q1Re_v_sJCYVDOhte0NpdU91UtYB2SpHH60-jg@mail.gmail.com>
Message-ID: <b333772bbc3037c47060cf1af1fff3e8@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linus.walleij@linaro.org, mans0n@gorani.run, linux-oxnas@groups.io, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, narmstrong@baylibre.com, daniel@makrotopia.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-22 11:45, Linus Walleij wrote:
> On Sat, Mar 21, 2020 at 2:40 PM Sungbo Eo <mans0n@gorani.run> wrote:
> 
>> Clear its own IRQs before the parent IRQ get enabled, so that the
>> remaining IRQs do not accidentally interrupt the parent IRQ 
>> controller.
>> 
>> This patch also fixes a reboot bug on OX820 SoC, where the remaining
>> rps-timer IRQ raises a GIC interrupt that is left pending. After that,
>> the rps-timer IRQ is cleared during driver initialization, and there's
>> no IRQ left in rps-irq when local_irq_enable() is called, which evokes
>> an error message "unexpected IRQ trap".
>> 
>> Fixes: bdd272cbb97a ("irqchip: versatile FPGA: support cascaded 
>> interrupts from DT")
>> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Cc: Daniel Golle <daniel@makrotopia.org>
> 
> Good catch!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Marc: Cc stable?

Sure, I'll add that.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
