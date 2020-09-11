Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D212C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9542078D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="UusFb+aT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgIKEDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKED1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 00:03:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCF0C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 21:03:26 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a12so8514388eds.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 21:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXglIxAgElc5JjCRgYm+CHHvgWMa69XLOEv6ewz6NfI=;
        b=UusFb+aTghNK80Ck3+ShuwAxKTlzIJ+xIFwzjJjt+k4IY0onVTpSnDt7SHAVOEug4r
         xGP1V6xP16jg2oH88ptXy2jSP1R90aUfjH0RQPxRm5YqPzaTxYut4jiJmiW3vE7A4ERn
         6FxLSdVy0vg1bAC8H8yXlKiOIY51tRrmsIpAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXglIxAgElc5JjCRgYm+CHHvgWMa69XLOEv6ewz6NfI=;
        b=exRkVoTFL4HrclgiAN/fprELvaNJ8aszWi0qz+M83b/lmC/QBizSfRattALBZS/qNd
         I1jSV75jCx9XLUz3b8jGsvcy23pn76+b7B4JbCC1yE4BkCf/4PXl6wBT/K7KLkMAkU0F
         R86VHFYcrYqVaRRFW6QyoUJW3rANqr6N6bbEmXdUECTKzHiIidtEKTItOMc3RivB1Xm/
         k24i0ppKdH70S1BK//IW8ZvSZRazCCxnGYiJUM8V3w3Zlmwkl7oVDbfsH+kJ3slXX8es
         GVKE6kULTgH3qWIDmjFY3LVWlhqoTwme8BKjGb7VIG0lSqZD/wBmroeXEJZYTnsCUNSC
         n/Mg==
X-Gm-Message-State: AOAM532LHM40z5ium5wSMytVMgVtzCqaYcYKT4W/EgnivvcQo42+gT14
        XJ3JIsmqklI1OsH8hFhu1SRiTtmRh9+1KGGl+Ro=
X-Google-Smtp-Source: ABdhPJzJKUM6X8Vqn2Bh8HF7DPndQmawbtKXMcUpYvj+R+0ipCkW4mPTs1IbtuqKuV2AY2IAR3Whe9cJEpT3LI60gk0=
X-Received: by 2002:a05:6402:18d:: with SMTP id r13mr15404edv.267.1599797003384;
 Thu, 10 Sep 2020 21:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
In-Reply-To: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 11 Sep 2020 04:03:11 +0000
Message-ID: <CACPK8XcYvUj3W-CPzXKugp3wx7rcLEJ_8f2-Bi6V7QHZpopBbA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Remove LPC register partitioning
To:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, Corey Minyard <minyard@acm.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        Cyril Bur <cyrilbur@gmail.com>,
        Robert Lippert <rlippert@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 11 Sep 2020 at 03:46, Chia-Wei, Wang
<chiawei_wang@aspeedtech.com> wrote:
>
> The LPC controller has no concept of the BMC and the Host partitions.
> The incorrect partitioning can impose unnecessary range restrictions
> on register access through the syscon regmap interface.
>
> For instance, HICRB contains the I/O port address configuration
> of KCS channel 1/2. However, the KCS#1/#2 drivers cannot access
> HICRB as it is located at the other LPC partition.
>
> In addition, to be backward compatible, the newly added HW control
> bits could be added at any reserved bits over the LPC addressing space.
>
> Thereby, this patch series aims to remove the LPC partitioning for
> better driver development and maintenance.

I support this cleanup. The only consideration is to be careful with
breaking the driver/device-tree relationship. We either need to ensure
the drivers remain compatible with  both device trees.

Another solution is to get agreement from all parties that for the LPC
device the device tree is always the one shipped with the kernel, so
it is okay to make incompatible changes.

While we are doing a cleanup, Andrew suggested we remove the detailed
description of LPC out of the device tree. We would have the one LPC
node, and create a LPC driver that creates all of the sub devices
(snoop, FW cycles, kcs, bt, vuart). Andrew, can  you elaborate on this
plan?

Cheers,

Joel


>
> Chia-Wei, Wang (4):
>   ARM: dts: Remove LPC BMC and Host partitions
>   soc: aspeed: Fix LPC register offsets
>   ipmi: kcs: aspeed: Fix LPC register offsets
>   pinctrl: aspeed-g5: Fix LPC register offsets
>
>  arch/arm/boot/dts/aspeed-g4.dtsi           |  74 +++++------
>  arch/arm/boot/dts/aspeed-g5.dtsi           | 135 +++++++++------------
>  arch/arm/boot/dts/aspeed-g6.dtsi           | 135 +++++++++------------
>  drivers/char/ipmi/kcs_bmc_aspeed.c         |  13 +-
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c |   2 +-
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c       |   6 +-
>  drivers/soc/aspeed/aspeed-lpc-snoop.c      |  11 +-
>  7 files changed, 162 insertions(+), 214 deletions(-)
>
> --
> 2.17.1
>
