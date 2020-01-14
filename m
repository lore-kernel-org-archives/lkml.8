Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5FBC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09BE2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579022114;
	bh=FmYo1QnMZ+BRW2X7UNoRjYmUEyQPzFYiriNK4Qllzq8=;
	h=In-Reply-To:References:Subject:Cc:From:To:Date:List-ID:From;
	b=PTJ6HfyKqPu562XeHZH3u8HnP8ASqr5wxF6EMPBhrmEQmkSuHZKBhFCgiakrJF3OE
	 M6QHTJrUtk2O7k46aB89exDcIwrEUBuA4pWdNOD43zU+e4DLsI6ZwLwxKeHqMbblXo
	 kwlnWsM1wBlO79CIMHGv3BtAU3w8f78k8moGbH5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgANRPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:49078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgANRPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:15:13 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44CA024656;
        Tue, 14 Jan 2020 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579022112;
        bh=FmYo1QnMZ+BRW2X7UNoRjYmUEyQPzFYiriNK4Qllzq8=;
        h=In-Reply-To:References:Subject:Cc:From:To:Date:From;
        b=l55vGv9I6rct+66XuAmKoj8HwPhePEeTu7HRjD0vZM5dLmfxU3rQlkZJSY64gZONh
         KjYYBK2iO/4tgB1mN64DRgnKZPEwhz2rKGSnD5KqjaBmaFIj13OFkre+lMaC6srXur
         5WsUj+Prrjhs2epAiOFzXQE3d7mX0PBzhrQMd9yM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191118234229.54085-1-saravanak@google.com>
References: <20191118234229.54085-1-saravanak@google.com>
Subject: Re: [PATCH v1] clk: Keep boot clocks on for multiple consumers
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Saravana Kannan <saravanak@google.com>
User-Agent: alot/0.8.1
Date:   Tue, 14 Jan 2020 09:15:11 -0800
Message-Id: <20200114171512.44CA024656@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravana Kannan (2019-11-18 15:42:28)
> Clocks can turned on (by the hardware, bootloader, etc) upon a
> reset/boot of a hardware platform. These "boot clocks" could be clocking
> devices that are active before the kernel starts running. For example,
> clocks needed for the interconnects, UART console, display, CPUs, DDR,
> etc.

This has been a long standing issue with clk framework. Some clk
providers work around it by marking clks like UART as special and keep
them on whenever earlycon is present on the commandline. Mike tried to
do something about this too[1] but that patchset only merged the
critical clk part and not the handoff part. How does this compare with
what Mike attempted many years ago?

It may also be a good first step to merely detect that a clk is enabled
at boot and to inform the framework that the clk is enabled and
synchronize the state of the clk out of boot with the state that the
framework is tracking. Essentially try to avoid the "when to turn it
off" problem and fix the "what state is the clk in at boot" problem. We
have clk providers that want to know this detail and currently
workaround it by reading the state in their prepare/enable ops and bail
out early, or read the enable state in their set_rate method and try to
make the rate change go through. It's a mess.

[1] https://lkml.kernel.org/r/1455225554-13267-1-git-send-email-mturquette@=
baylibre.com

>=20
> When a boot clock is used by more than one consumer or multiple boot
> clocks share a parent clock, the boot clock (or the common parent) can
> be turned off when the first consumer probes. This can potentially crash
> the device or cause poor user experience.
>=20
> This patch fixes this by explicitly enabling the boot clocks during
> clock registration and then disabling them at late_initcall_sync(). This
> gives all the consumers until late_initcall() to put their "votes" in to
> keep any of the boot clocks on past late_initcall().

How do we know some consumer won't "put in their votes" after late init?
I suspect we should somehow scan the entire DT to determine what
consumers exist and then match those consumers up with the clks that
providers detect are on out of boot and then only remove the enable
state of a clk once all consumers have gotten and enabled their clks.


>=20
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---

Please mention something about the new clk flag introduced and why it is
introduced. Also talk about orphan clks and why they're special.

>  drivers/clk/clk.c            | 62 ++++++++++++++++++++++++++++++++++++
>  include/linux/clk-provider.h |  1 +
>  2 files changed, 63 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 1c677d7f7f53..a1b09c9f8845 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1300,6 +1302,36 @@ static int clk_disable_unused(void)
>  }
>  late_initcall_sync(clk_disable_unused);
> =20
> +static void clk_unprepare_disable_subtree(struct clk_core *core)
> +{
> +       struct clk_core *child;
> +
> +       lockdep_assert_held(&prepare_lock);
> +
> +       hlist_for_each_entry(child, &core->children, child_node)
> +               clk_unprepare_disable_subtree(child);
> +
> +       if (!core->state_held)
> +               return;
> +
> +       clk_core_disable_unprepare(core);
> +}
> +
> +static int clk_release_boot_state(void)
> +{
> +       struct clk_core *core;
> +
> +       clk_prepare_lock();
> +
> +       hlist_for_each_entry(core, &clk_root_list, child_node)
> +               clk_unprepare_disable_subtree(core);
> +
> +       clk_prepare_unlock();
> +
> +       return 0;
> +}
> +late_initcall_sync(clk_release_boot_state);
> +
>  static int clk_core_determine_round_nolock(struct clk_core *core,
>                                            struct clk_rate_request *req)
>  {
> @@ -1674,6 +1706,30 @@ static int clk_fetch_parent_index(struct clk_core =
*core,
>         return i;
>  }
> =20
> +static void clk_core_hold_state(struct clk_core *core)
> +{
> +       if (core->state_held || !core->boot_enabled ||
> +           core->flags & CLK_DONT_HOLD_STATE)
> +               return;
> +
> +       WARN(core->orphan, "%s: Can't hold state for orphan clk\n", core-=
>name);

Why are orphans special?

> +
> +       core->state_held =3D !clk_core_prepare_enable(core);
> +}
> +
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 2fdfe8061363..f0e522ea793f 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -32,6 +32,7 @@
>  #define CLK_OPS_PARENT_ENABLE  BIT(12)
>  /* duty cycle call may be forwarded to the parent clock */
>  #define CLK_DUTY_CYCLE_PARENT  BIT(13)
> +#define CLK_DONT_HOLD_STATE    BIT(14) /* Don't hold state */
> =20
