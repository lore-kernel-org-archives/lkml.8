Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF920C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 18:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900BB20722
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 18:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgE3SOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 14:14:49 -0400
Received: from v6.sk ([167.172.42.174]:45050 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbgE3SOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 14:14:48 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 70FAD610D9;
        Sat, 30 May 2020 18:14:46 +0000 (UTC)
Date:   Sat, 30 May 2020 20:14:42 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] DT: Improve validation for Marvell SoCs
Message-ID: <20200530181442.GC2870@furthur.local>
References: <20200521091356.2211020-1-lkundrak@v3.sk>
 <20200528225244.GA815881@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528225244.GA815881@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:52:44PM -0600, Rob Herring wrote:
> On Thu, May 21, 2020 at 11:13:47AM +0200, Lubomir Rintel wrote:
> > Hi,
> > 
> > chained to this message is a second version of remaining patches from the
> > first spin of the "DT: Improve validation for Marvell SoCs" [1] patch set.
> > 
> > [1] https://lore.kernel.org/lkml/20200317093922.20785-1-lkundrak@v3.sk/
> > 
> > I've attempted to address the review of the v1, each patch includes a
> > detailed change log.
> > 
> > Compared to v1, wherever the license or maintainer information was
> > missing, I've filled in GPL-2.0-only and people listed in MAINTAINERS
> > file. As I've indicated in v1 cover letter, am not sure whether this is
> > the optimal course of action. However I've included the relevant people
> > in v1 Cc list and asked for clarifications, but didn't really get any
> > feedback to that.
> 
> Find someone that would care if the bindings are deleted. I'm fine 
> if you put yourself. Maybe subsystem maintainers are willing to take 
> orphans. I really only want my name on common things.

Thanks for clarification & fixups to the patches.

I'm wondering if Documentation/devicetree/writing-schema.rst could
perhaps be made a bit clearer about how the maintainer key in a binding
document is different from what is in the MAINTAINERS file.

> Rob

Lubo
