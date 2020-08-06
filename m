Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87990C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73A9206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735760;
	bh=cUg8ko8OEiK/4qIbgfajwCnFYSLMbgT5cLNLiBOA0zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NMfhPeF3xMyqDeRxKqKblK+3wjae4pjDqTtBLA+ne+NZmSAtFZkQCHod7vIzCMOcQ
	 e21ZxUcOK2UE8NJcBI+tzTVjKWYtyysrDgc2cnchSy3byreRG6sSzoRXt9asKdMoB5
	 zL7qK2MFnnWendKd+Cmj/DTyv7eeP4VoFURwxU9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgHFRmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbgHFRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:31:43 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5FC523133;
        Thu,  6 Aug 2020 15:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596726754;
        bh=cUg8ko8OEiK/4qIbgfajwCnFYSLMbgT5cLNLiBOA0zc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AbFccKDJye+6TKEYkdO27Ltto8sfBzN9avARpUTzS2JIZOCnVJJvIiHQp6vOomQOC
         F8JNZCzIVobAp32SyKnSVXDA/lbtwWMtL78IWNpUC9RYHN0kLSqSvrU3xvklsMNxUQ
         acUSid/EZztAy2Hg3NFiZG8sWBd8qI54SF2roqnw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k3hZJ-000Iec-1O; Thu, 06 Aug 2020 16:12:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Aug 2020 16:12:32 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     alix.wu@mediatek.com, DTML <devicetree@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, yj.chiang@mediatek.com
Subject: Re: [PATCH 0/2] irqchip: irq-mt58xx: Add mt58xx series interrupt
In-Reply-To: <CAFr9PXkFJJKnqVkPBXgh1kqL_serK4DmrmJ73xU+ZMA+NuF-bA@mail.gmail.com>
References: <CAFr9PX=Gk9h6ASi6saBLhoZ45g-WqCzDQo2XWT033fJykFSY_g@mail.gmail.com>
 <20200806140739.31501-1-mark-pk.tsai@mediatek.com>
 <CAFr9PXkFJJKnqVkPBXgh1kqL_serK4DmrmJ73xU+ZMA+NuF-bA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <654a81dcefb3024d762ff338d4bd7f14@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: daniel@0x0f.com, mark-pk.tsai@mediatek.com, alix.wu@mediatek.com, devicetree@vger.kernel.org, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, yj.chiang@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-06 15:58, Daniel Palmer wrote:
> Hi Mark-PK,
> 
> On Thu, 6 Aug 2020 at 23:08, Mark-PK Tsai <mark-pk.tsai@mediatek.com> 
> wrote:
>> > Do you know if it would be possible to confirm if they are
>> > the
>> > same thing? MediaTek bought MStar a few years ago so it seems likely
>> > but I have no hard information.
>> >
>> 
>> Yes, it's for the same interrupt controller IP.
> 
> That's good news. :)
> 
>> > If they are the same thing could we work on making one series that
>> > supports both use cases?
>> 
>> Sure, and I think the irq controller driver should support both use 
>> cases.
>> So how about keep the MTK version driver?
> 
> I'm fine with that. Maybe you can push the MTK version and I can send
> a small patch after that to add the small bits I need?

In the interest of being vendor agnostic, please rename the properties
such as mediatek,irqs-map-range to something less brand-specific.
The compatible string should be enough.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
