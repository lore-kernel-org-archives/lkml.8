Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E98CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C88C2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGTILL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTILL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:11:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B28C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:11:11 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jxQtA-0002Kt-Lk; Mon, 20 Jul 2020 10:11:08 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1jxQt8-0004RW-KW; Mon, 20 Jul 2020 10:11:06 +0200
Date:   Mon, 20 Jul 2020 10:11:06 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        j.neuschaefer@gmx.net
Subject: Re: [PATCH] mfd: rn5t618: Make restart handler atomic safe
Message-ID: <20200720081106.maraj6atkot5dbdf@pengutronix.de>
References: <20200718154737.18886-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718154737.18886-1-andreas@kemnade.info>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:48:10 up 247 days, 23:06, 251 users,  load average: 0.04, 0.05,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On 20-07-18 17:47, Andreas Kemnade wrote:
> The restart handler is executed during the shutdown phase which is
> atomic/irq-less. The i2c framework supports atomic transfers since
> commit 63b96983a5dd ("i2c: core: introduce callbacks for atomic
> transfers") to address this use case. Using i2c regmap in that
> situation is not allowed:

Nice catch. I had the same issue with a DA9062 device. I have oen minor
nit, pls see inline.

> [  165.177465] [ BUG: Invalid wait context ]
> [  165.181479] 5.8.0-rc3-00003-g0e9088558027-dirty #11 Not tainted
> [  165.187400] -----------------------------
> [  165.191410] systemd-shutdow/1 is trying to lock:
> [  165.196030] d85b4438 (rn5t618:170:(&rn5t618_regmap_config)->lock){+.+.}-{3:3}, at: regmap_update_bits_base+0x30/0x70
> [  165.206573] other info that might help us debug this:
> [  165.211625] context-{4:4}
> [  165.214248] 2 locks held by systemd-shutdow/1:
> [  165.218691]  #0: c131c47c (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x90/0x204
> [  165.227405]  #1: c131efb4 (rcu_read_lock){....}-{1:2}, at: __atomic_notifier_call_chain+0x0/0x118
> [  165.236288] stack backtrace:
> [  165.239174] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 5.8.0-rc3-00003-g0e9088558027-dirty #11
> [  165.248220] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
> [  165.254330] [<c0112110>] (unwind_backtrace) from [<c010bfa0>] (show_stack+0x10/0x14)
> [  165.262084] [<c010bfa0>] (show_stack) from [<c058093c>] (dump_stack+0xe8/0x120)
> [  165.269407] [<c058093c>] (dump_stack) from [<c01835a4>] (__lock_acquire+0x81c/0x2ca0)
> [  165.277246] [<c01835a4>] (__lock_acquire) from [<c0186344>] (lock_acquire+0xe4/0x490)
> [  165.285090] [<c0186344>] (lock_acquire) from [<c0c98638>] (__mutex_lock+0x74/0x954)
> [  165.292756] [<c0c98638>] (__mutex_lock) from [<c0c98f34>] (mutex_lock_nested+0x1c/0x24)
> [  165.300769] [<c0c98f34>] (mutex_lock_nested) from [<c07593ec>] (regmap_update_bits_base+0x30/0x70)
> [  165.309741] [<c07593ec>] (regmap_update_bits_base) from [<c076b838>] (rn5t618_trigger_poweroff_sequence+0x34/0x64)
> [  165.320097] [<c076b838>] (rn5t618_trigger_poweroff_sequence) from [<c076b874>] (rn5t618_restart+0xc/0x2c)
> [  165.329669] [<c076b874>] (rn5t618_restart) from [<c01514f8>] (notifier_call_chain+0x48/0x80)
> [  165.338113] [<c01514f8>] (notifier_call_chain) from [<c01516a8>] (__atomic_notifier_call_chain+0x70/0x118)
> [  165.347770] [<c01516a8>] (__atomic_notifier_call_chain) from [<c0151768>] (atomic_notifier_call_chain+0x18/0x20)
> [  165.357949] [<c0151768>] (atomic_notifier_call_chain) from [<c010a828>] (machine_restart+0x68/0x80)
> [  165.367001] [<c010a828>] (machine_restart) from [<c0153224>] (__do_sys_reboot+0x11c/0x204)
> [  165.375272] [<c0153224>] (__do_sys_reboot) from [<c0100080>] (ret_fast_syscall+0x0/0x28)
> [  165.383364] Exception stack(0xd80a5fa8 to 0xd80a5ff0)
> [  165.388420] 5fa0:                   00406948 00000000 fee1dead 28121969 01234567 73299b00
> [  165.396602] 5fc0: 00406948 00000000 00000000 00000058 be91abc8 00000000 be91ab60 004056f8
> [  165.404781] 5fe0: 00000058 be91aabc b6ed4d45 b6e56746
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rn5t618.c | 44 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> index 6b37dd479d71..2ef61b55cd4b 100644
> --- a/drivers/mfd/rn5t618.c
> +++ b/drivers/mfd/rn5t618.c
> @@ -81,7 +81,7 @@ static const struct regmap_irq_chip rc5t619_irq_chip = {
>  	.mask_invert = true,
>  };
>  
> -static struct rn5t618 *rn5t618_pm_power_off;
> +static struct i2c_client *rn5t618_pm_power_off;
>  static struct notifier_block rn5t618_restart_handler;
>  
>  static int rn5t618_irq_init(struct rn5t618 *rn5t618)
> @@ -114,13 +114,37 @@ static int rn5t618_irq_init(struct rn5t618 *rn5t618)
>  
>  static void rn5t618_trigger_poweroff_sequence(bool repower)
>  {
> +	int ret;
> +
>  	/* disable automatic repower-on */
> -	regmap_update_bits(rn5t618_pm_power_off->regmap, RN5T618_REPCNT,
> -			   RN5T618_REPCNT_REPWRON,
> -			   repower ? RN5T618_REPCNT_REPWRON : 0);
> -	/* start power-off sequence */

I would keep both comments.

Regards,
  Marco
