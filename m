Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6785C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBC220732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598005070;
	bh=5BAlCqvHy57rbwgICn/sFBOoeg182xLiB3y+Z3clJT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vvVvof/W/N5SNsxTBAOM59Y5c6g8M2xKg4nhUyxdmYmMwD9cr/o3U+Wv/8F7kdsLy
	 uMWH7uJbA8Z/nDXBCNY0P/I+tKFcdP/sBOxRiDK7hrscpL8tQ3f4mysZHQk8f+kSaz
	 IaTRpn7bB6Ze84pqwxSiBZe3t4P/Z33CVIxDxEbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgHUKRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgHUKRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:17:39 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D3B20732;
        Fri, 21 Aug 2020 10:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598005059;
        bh=5BAlCqvHy57rbwgICn/sFBOoeg182xLiB3y+Z3clJT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TuRM4rWAEXZya+O4G3npdmKG8oVkWUezk+wz4nqTVpJ2F3EL1SuL7rO4CoOORUbDF
         OXldTfml7s7fn6b/J4FW9+mXNxpwTCbhSD1ij9FZjJ1CONkKqIOfTYIegfcWZPDRR9
         UD1B40SrVa9tAKlA9rMyBZEoXOXzGlNvobcik8ts=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k9477-004prC-00; Fri, 21 Aug 2020 11:17:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Aug 2020 11:17:36 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Frank Wunderlich <wichtig@fw-web.de>,
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
In-Reply-To: <95ae0ae3-7798-d6d5-fc37-391862a0b4ca@collabora.com>
References: <20200819161907.1155110-1-enric.balletbo@collabora.com>
 <C9E59107-CE83-4554-9447-5DE5BEE09A3B@fw-web.de>
 <CAGETcx9_A-E5b-JxT2G142mGxqoo8xqFNEgT+CNWt=oOv0Z5+w@mail.gmail.com>
 <a23bac35d20eb002bdfb5263bf5dd213@kernel.org>
 <CAGETcx-NpRzzeXYN-UBP1eAsC3s_AofSQ9rXOEmCjhLhKLnxWg@mail.gmail.com>
 <14b8f4b9667d29ee25e25eb19c69e3f7@kernel.org>
 <95ae0ae3-7798-d6d5-fc37-391862a0b4ca@collabora.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <93debe6a0308b66d3f307af67ba7ec2c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: enric.balletbo@collabora.com, saravanak@google.com, wichtig@fw-web.de, linux-kernel@vger.kernel.org, kernel@collabora.com, linux@fw-web.de, matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org, hanks.chen@mediatek.com, jason@lakedaemon.net, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2020-08-21 10:20, Enric Balletbo i Serra wrote:
> Hi Marc,
> 
> On 20/8/20 16:53, Marc Zyngier wrote:
>> On 2020-08-20 09:07, Saravana Kannan wrote:
>>> On Thu, Aug 20, 2020 at 12:56 AM Marc Zyngier <maz@kernel.org> wrote:
>>>> 
>>>> On 2020-08-19 19:51, Saravana Kannan wrote:
>>>> > On Wed, Aug 19, 2020 at 9:52 AM Frank Wunderlich <wichtig@fw-web.de>
>>>> > wrote:
>>>> >>
>>>> >> hi,
>>>> >>
>>>> >> does the fix you've linked to my revert [1] not work in your case?
>>>> >>
>>>> >> [1] https://patchwork.kernel.org/patch/11718481/
>>>> >
>>>> > Thanks for pointing it out Frank. Also, might want to avoid top
>>>> > posting in the future.
>>>> >
>>>> > Enric, Can you please try that other fix and see if that solves your
>>>> > issue?
>>>> 
>>>> I think Enric was clear that the driver does probe correctly
>>>> (meaning that he has the fix in his tree). It is everything else
>>>> that breaks, because none of the drivers on the platform are
>>>> equipped to defer their own probing.
>>>> 
>>>> I think we need to change this works right now, meaning that we 
>>>> can't
>>>> blindly change the behaviour of *built-in* drivers. I'll see if I 
>>>> can
>>>> come up with something quickly, but I'll otherwise take Enric patch.
>>> 
>>> Sounds fair Marc.
>>> 
>>> Btw, Enric, out of curiosity, can you try adding "fw_devlink=on" to
>>> your kernel command line to see if it helps? It basically ensures
>>> proper probe ordering without depending on the drivers. There are 
>>> some
>>> corner cases where it still can't work properly (too much to explain
>>> for a late night email), but if the platforms don't have those corner
>>> cases it'll work perfectly.
>>> 
>>> I'm fine with the revert if Marc isn't able to find a quick fix to 
>>> the
>>> drivers, but this might also fix your problem right away.
>> 
>> I'm afraid there is no quick fix if we want to preserve the current
>> behavior with built-in drivers, and not having "fw_devlink=on" by
>> default makes it irrelevant for most people.
>> 
>> fw_devlink also prevents my test platforms from booting (my rk3399
>> doesn't find its PCI devices with it), while the same kernel boots
>> just fine without it. It could well be that the corner case is
>> likely to be more prevalent than you seem to expect.
>> 
>> I will probably end-up end-up queuing reverts for both mtk-sysirq,
>> mtk-cirq, and qcom-pdc (the first two can't be built as module with
>> mainline anyway, and I seem to remember that the latter caused some
>> controversy as well).
>> 
>> As an experiment, I have pushed out a branch[1] that implements
>> a "hybrid" probe, retaining the previous early probe mechanism when
>> the driver is built-in, and letting things rip when built as a
>> module (if you do that, you hopefully know what you are doing).
>> I'd welcome some testing on affected platforms (I don't have
>> anything I can run mainline on that'd be affected).
>> 
> 
> Unfortunately, my Kukui (MT8183) board doesn't boot at all with those 
> patches. I
> only did a quick test and I didn't dig further, please let me know if 
> you want I
> debug more the issue. IMHO, right now, the revert seems to be the 
> better
> solution for this cycle.

It'd be good if you could help with that, but I will definitely apply
the revert (below for the revert list). Any change is too invasive to
be added to this cycle.

920ecb8c35cb irqchip/mtk-cirq: Convert to a platform driver
f97dbf48ca43 irqchip/mtk-sysirq: Convert to a platform driver
5be57099d445 irqchip/qcom-pdc: Switch to using IRQCHIP_PLATFORM_DRIVER 
helper macros
95bf9305d2e3 irqchip/qcom-pdc: Allow QCOM_PDC to be loadable as a 
permanent module

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
