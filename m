Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248A8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA568206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgIDHxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:53:19 -0400
Received: from mail.thorsis.com ([92.198.35.195]:59306 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbgIDHxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:53:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 2AD1B3DE3;
        Fri,  4 Sep 2020 09:53:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8-Cjt87alBaX; Fri,  4 Sep 2020 09:53:11 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 0BB554128; Fri,  4 Sep 2020 09:53:10 +0200 (CEST)
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-leds@vger.kernel.org
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Alexander Dahl <post@lespocky.de>, devicetree@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] leds: pwm: Make automatic labels work
Date:   Fri, 04 Sep 2020 09:53:03 +0200
Message-ID: <2019500.FJf2EgCAKA@ada>
In-Reply-To: <a8f9068b-d78d-3ba5-6747-f79ed8e641bd@gmail.com>
References: <20200831210232.28052-1-post@lespocky.de> <a8f9068b-d78d-3ba5-6747-f79ed8e641bd@gmail.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

Am Dienstag, 1. September 2020, 23:08:09 CEST schrieb Jacek Anaszewski:
> Hi Alexander,
> 
> Thanks for the v2.
> 
> On 8/31/20 11:02 PM, Alexander Dahl wrote:
> > Hei hei,
> > 
> > for leds-gpio you can use the properties 'function' and 'color' in the
> > devicetree node and omit 'label', the label is constructed
> > automatically.  This is a common feature supposed to be working for all
> > LED drivers.  However it did not yet work for the 'leds-pwm' driver.
> > This series fixes the driver and takes the opportunity to update the
> > dt-bindings accordingly.
> > 
> > v1: based on v5.9-rc2, backport on v5.4.59 tested and working
> > 
> > v2: based on v5.9-rc3, added the dt-bindings update patch
> > 
> > Greets
> > Alex
> > 
> > Alexander Dahl (2):
> >    leds: pwm: Allow automatic labels for DT based devices
> >    dt-bindings: leds: Convert pwm to yaml
> >   
> >   .../devicetree/bindings/leds/leds-pwm.txt     | 50 -----------
> >   .../devicetree/bindings/leds/leds-pwm.yaml    | 85 +++++++++++++++++++
> >   drivers/leds/leds-pwm.c                       |  9 +-
> >   3 files changed, 93 insertions(+), 51 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/leds/leds-pwm.txt
> >   create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm.yaml
> 
> For both patches:
> 
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

I'd like to make a v3 and change the license of the .yaml file to "(GPL-2.0-
only OR BSD-2-Clause)" as suggested by checkpatch and [1].  Can I keep your 
Acked-by for that?

Besides: those suggestions are obviously valid for new bindings.  What about 
old bindings (.txt), which had no explicit SPDX tag or license note before?  
What license would apply there?  Is the .yaml file technically new, when it 
was mostly just converted from .txt?

Greets
Alex

[1] https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html



