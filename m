Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224BCC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9423520709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="HER4T5u1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgAXI7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 03:59:02 -0500
Received: from mail.intenta.de ([178.249.25.132]:41319 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgAXI7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:59:02 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jan 2020 03:59:01 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=Tp/ScpeoKbLnxbH+JstXsTL0gsEEzyCFfak5/6i2le4=;
        b=HER4T5u1WlJkPuYOaju2hnnMy6VVvlARLBljloDNNNKYHLyUjPH7MfQkqlVl9kwRPrNS9hCr8gKaR2uMQAUS8ElOs/sp4G8fKyLJrAJnqN7JG8cTOueowH+FUfEOvstrw+xtWO8ECKLHnaMfK0s+POEkCQHdo0MMPirp4Lw9uAibjFa0GK04WqvPKiraN9LjacchWwGk7r1r8aYppVWC2ScIS0W0n5dMX4ugfcLBX7CwU/V3GRPSXJEwKsiDqs4hVDyfzkEbxx0Oo+9doCXylIkxnPfHPg6HtTM89Qc79wnSBenTqn3630v9B9WQkfl7+f7q7Jur9LoyDto5Jqs1cw==;
Date:   Fri, 24 Jan 2020 09:53:10 +0100
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mfd: da9062: enable being a system-power-controller
Message-ID: <20200124085310.GA27231@laureti-dev>
References: <20200107120559.GA700@laureti-dev>
 <AM6PR10MB226306BDE8575CED80071148800F0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <AM6PR10MB226306BDE8575CED80071148800F0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for reviewing the code.

On Thu, Jan 23, 2020 at 04:51:37PM +0100, Adam Thomson wrote:
> I have concerns about using regmap/I2C within the pm_power_off() callback
> function although I am aware there are other examples of this in the kernel. At
> the point that is called I believe IRQs are disabled so it would require a
> platform to have an atomic version of the I2C bus's xfer function. Don't know
> if there's a check to see if the bus supports this, but if not then maybe it's
> something worth adding? That way we can then only support the pm_power_off()
> approach on systems which can actually do it.

On arm, machine_power_off calls the pm_power_off callback after issuing
local_irq_disable() and smp_send_stop(). So I think your intuition is
correct that we are running with only one CPU left with IRQs disabled.

I have tested this code on a board with an i2c-cadence bus. This driver
seems to use IRQs for completion tracking with no fallback to polling.
I'm now puzzled as to why this works at all. Given that I'm using
regmap_update_bits on a volatile register, it would have to complete the
read before performing the relevant write. Nevertheless, it reliably
turns off here. So I'm starting to wonder whether there is a flaw in the
analysis.

I also looked into whether linux/i2c.h would tell us about the
availability of an atomic xfer function. Indeed, the i2c_algorithm
structure has a master_xfer_atomic specifically for this purpose. The
i2c core will automatically use this function when irqs are disabled.
Unfortunately, very few buses implement this function. In particular,
i2c-cadence lacks it.

So I could check for i2c_dev->adapter->algo->master_xfer_atomic != NULL
indeed. Possibly this could be wrapped in a central inline function.

I concur that quite a few other drivers use a regmap/i2c from their
pm_power_off hook. Examples include:
 * arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c (i2c without regmap)
 * drivers/mfd/axp20x.c (regmap without i2c)
 * drivers/mfd/dm355evm_msp.c (i2c without regmap)
 * drivers/mfd/max77620.c (regmap and i2c)
 * drivers/mfd/max8907.c (regmap and i2c)
 * drivers/mfd/palmas.c (regmap and i2c)
 * drivers/mfd/retu-mfd.c (regmap and i2c)
 * drivers/mfd/rn5t618.c (regmap and i2c)
 * drivers/mfd/tps6586x.c (regmap and i2c)
 * drivers/mfd/tps65910.c (regmap and i2c)
 * drivers/mfd/tps80031.c (regmap and i2c)
 * drivers/mfd/twl4030-power.c (i2c without regmap)
 * drivers/regulator/act8865-regulator.c (regmap and i2c)

For this reason, I think the practice of using regmap/i2c within
pm_power_off is well-established and should not be questioned for an
individual device. In addition, the relevant functionality must be
explicitly requested by modifying a board-specific device-tree. It can
be assumed that an integrator would test whether the mfd actually works
as a power controller when adding the relevant property. Given that we
turned off other CPUs and IRQs, the behaviour should be fairly reliable.

I think that requiring atomic transfers for pm_power_off would be
relatively easy to implement (for all mfds). However, I also think that
it would break a fair number of boards, because so few buses implement
atomic transfers. As such, I don't think we can actually require it
before requiring all buses to implement atomic transfers. At that point,
the check becomes useless, because the i2c core will automatically use
atomic transfers during pm_power_off.

Given these reasons (consistency with other drivers, testing and "don't
break"), I think that including the functionality without an additional
check is a reasonable thing to do.

Helmut
