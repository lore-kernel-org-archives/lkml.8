Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463A4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F0A20721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgE2NVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:21:22 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48343 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgE2NVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:21:21 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 072C74000B;
        Fri, 29 May 2020 13:21:18 +0000 (UTC)
Date:   Fri, 29 May 2020 15:21:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: atmel-tcb: convert bindings to
 json-schema
Message-ID: <20200529132118.GF3972@piout.net>
References: <20200506080554.283177-1-alexandre.belloni@bootlin.com>
 <20200506080554.283177-2-alexandre.belloni@bootlin.com>
 <20200529101314.2ueuhgnrqq3a764f@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529101314.2ueuhgnrqq3a764f@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/05/2020 12:13:14+0200, Sebastian Andrzej Siewior wrote:
> Rob, could you please bless the DT parts of this series? Daniel Lezcano
> asked for the blessing in:
>   https://lkml.kernel.org/r/f0feb409-11fb-08de-cc06-216a16de994a@linaro.org
> 

There is actually one comment I need to address that Rob made on another
series that was also including this patch. I'll send a new version
today.

> On 2020-05-06 10:05:46 [+0200], Alexandre Belloni wrote:
> > Convert Atmel Timer Counter Blocks bindings to DT schema format using
> > json-schema.
> > 
> > Also move it out of mfd as it is not and has never been related to mfd.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> > Cc: Rob Herring <robh+dt@kernel.org>
> > 
> > Changes in v3:
> >  - Moved the child node documentation to the parent documentation
> > 
> > Changes in v2:
> >  - Rebased on v5.7-rc1
> >  - Moved the binding documentation to its proper place
> >  - Added back the atmel,tcb-timer child node documentation
> > 
> > 
> >  .../devicetree/bindings/mfd/atmel-tcb.txt     |  56 --------
> >  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 126 ++++++++++++++++++
> 
> Sebastian

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
