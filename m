Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D620C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BAB22076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597910200;
	bh=1PlDm4wRWcH/RTMBQxxaAC1lHTDc0CkhAaxyMr2dXR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=p6dzmRdEuv7mlZGrXUinZ1u+1SPSzoDlCuaHNrSKePGeq77Rf2G8fVQWaaYkz1Jji
	 LNQcsby7AvNLK002zHIlgvQFlhS1PTxG/fofllfoYa0NzJnecvJz/tgo29uV6Xz32N
	 ceA3LW8fi+G2zCEfZAvI4c2aMTgMYpgurCyDVjyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHTH4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgHTH4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:56:37 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73FCA2076E;
        Thu, 20 Aug 2020 07:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597910196;
        bh=1PlDm4wRWcH/RTMBQxxaAC1lHTDc0CkhAaxyMr2dXR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rVWTd0wlUfO5Sdto2s314fZMXF0ky7uxabFPMbo9OLG22jZ6Qrj9eVZO5WKUnhcnJ
         GYUkApm3MI93J/dR2lUZ0BkF5dYu/b6+/9yH7s0EtrawaSNutAm+4EeyN4h/h5iA/U
         FGqRQT/2QB4hndYu6UQlbGKAnPEzfYh2H0HSGD1c=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k8fR4-004S5S-Vb; Thu, 20 Aug 2020 08:56:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Aug 2020 08:56:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Wunderlich <wichtig@fw-web.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] Revert "irqchip/mtk-sysirq: Convert to a platform driver"
In-Reply-To: <CAGETcx9_A-E5b-JxT2G142mGxqoo8xqFNEgT+CNWt=oOv0Z5+w@mail.gmail.com>
References: <20200819161907.1155110-1-enric.balletbo@collabora.com>
 <C9E59107-CE83-4554-9447-5DE5BEE09A3B@fw-web.de>
 <CAGETcx9_A-E5b-JxT2G142mGxqoo8xqFNEgT+CNWt=oOv0Z5+w@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <a23bac35d20eb002bdfb5263bf5dd213@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: saravanak@google.com, wichtig@fw-web.de, enric.balletbo@collabora.com, linux-kernel@vger.kernel.org, kernel@collabora.com, linux@fw-web.de, matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org, hanks.chen@mediatek.com, jason@lakedaemon.net, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-19 19:51, Saravana Kannan wrote:
> On Wed, Aug 19, 2020 at 9:52 AM Frank Wunderlich <wichtig@fw-web.de> 
> wrote:
>> 
>> hi,
>> 
>> does the fix you've linked to my revert [1] not work in your case?
>> 
>> [1] https://patchwork.kernel.org/patch/11718481/
> 
> Thanks for pointing it out Frank. Also, might want to avoid top
> posting in the future.
> 
> Enric, Can you please try that other fix and see if that solves your 
> issue?

I think Enric was clear that the driver does probe correctly
(meaning that he has the fix in his tree). It is everything else
that breaks, because none of the drivers on the platform are
equipped to defer their own probing.

I think we need to change this works right now, meaning that we can't
blindly change the behaviour of *built-in* drivers. I'll see if I can
come up with something quickly, but I'll otherwise take Enric patch.

         M.
-- 
Jazz is not dead. It just smells funny...
