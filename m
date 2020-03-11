Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40069 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgCKP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:28:03 -0400
Received: by mail-vs1-f65.google.com with SMTP id c18so1580416vsq.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:28:02 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id g1sm9848514uak.5.2020.03.11.08.27.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 08:27:59 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id g21so877023uaj.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200306235951.214678-1-dianders@chromium.org>
 <20200306155707.RFT.2.Iaddc29b72772e6ea381238a0ee85b82d3903e5f2@changeid> <285d3315-7558-d9f6-fe65-24d8ad07949d@codeaurora.org>
In-Reply-To: <285d3315-7558-d9f6-fe65-24d8ad07949d@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 11 Mar 2020 08:27:44 -0700
Message-ID: <CAD=FV=W5RGwu=ywtM7aCv3H-EpJ1i23S0awgVc8QtOsXtige4w@mail.gmail.com>
Subject: Re: [RFT PATCH 2/9] drivers: qcom: rpmh-rsc: Document the register
 layout better
To: Maulik Shah <mkshah@codeaurora.org>
Cc: Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Wed, Mar 11, 2020 at 2:35 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi Doug,
>
> On 3/7/2020 5:29 AM, Douglas Anderson wrote:
> > Perhaps it's just me, it took a really long time to understand what
> > the register layout of rpmh-rsc was just from the #defines.
> i don't understand why register layout is so important for you to understand?
>
> besides, i think all required registers are properly named with #define
>
> for e.g.
> /* Register offsets */
> #define RSC_DRV_IRQ_ENABLE              0x00
> #define RSC_DRV_IRQ_STATUS              0x04
> #define RSC_DRV_IRQ_CLEAR               0x08
>
> now when you want to enable/disable irq in driver code, its pretty simple to figure out
> that we need to read/write at RSC_DRV_IRQ_ENABLE offset.

It's not the specific layout that's important to me.  It's the
relationships between everything.  In other words:

a) one rpmh-rsc contains some registers and then a whole bunch of TCS blocks

b) one TCS block contains some registers and space for up to 16 commands.

c) each command has a handful of registers

Nothing describes this in the existing code--you've gotta read through
all the code and figure out how it's reading/writing registers to
figure it out.


> this seems unnecessary change to me, can you please drop this when you spin v2?

In v2 I'll replace this with the prose below.  Personally I find this
inferior to the struct definitions which are easier to read
at-a-glance, but it seems like it would be less controversial...

/*
 * Here's a high level overview of how all the registers in RPMH work
 * together:
 *
 * - The main rpmh-rsc address is the base of a register space that can
 *   be used to find overall configuration of the hardware
 *   (DRV_PRNT_CHLD_CONFIG).  Also found within the rpmh-rsc register
 *   space are all the TCS blocks.  The offset of the TCS blocks is
 *   specified in the device tree by "qcom,tcs-offset" and used to
 *   compute tcs_base.
 * - TCS blocks come one after another.  Type, count, and order are
 *   specified by the device tree as "qcom,tcs-config".
 * - Each TCS block has some registers, then space for up to 16 commands.
 *   Note that though address space is reserved for 16 commands, fewer
 *   might be present.  See ncpt (num cmds per TCS).
 * - The first TCS block is special in that it has registers to control
 *   interrupts (RSC_DRV_IRQ_XXX).  Space for these registers is reserved
 *   in all TCS blocks to make the math easier, but only the first one
 *   matters.
 */

I'll also move the documentation of "irq_clear", "cmd_wait_for_cmpl",
"status", and "cmd_enable" next to the respective #defines.

