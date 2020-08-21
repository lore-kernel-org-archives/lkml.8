Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8CBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0982722B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgHUJUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHUJUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:20:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF2CC061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:20:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D96A029ADC8
Subject: Re: [PATCH] Revert "irqchip/mtk-sysirq: Convert to a platform driver"
To:     Marc Zyngier <maz@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Frank Wunderlich <wichtig@fw-web.de>,
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
References: <20200819161907.1155110-1-enric.balletbo@collabora.com>
 <C9E59107-CE83-4554-9447-5DE5BEE09A3B@fw-web.de>
 <CAGETcx9_A-E5b-JxT2G142mGxqoo8xqFNEgT+CNWt=oOv0Z5+w@mail.gmail.com>
 <a23bac35d20eb002bdfb5263bf5dd213@kernel.org>
 <CAGETcx-NpRzzeXYN-UBP1eAsC3s_AofSQ9rXOEmCjhLhKLnxWg@mail.gmail.com>
 <14b8f4b9667d29ee25e25eb19c69e3f7@kernel.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <95ae0ae3-7798-d6d5-fc37-391862a0b4ca@collabora.com>
Date:   Fri, 21 Aug 2020 11:20:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <14b8f4b9667d29ee25e25eb19c69e3f7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 20/8/20 16:53, Marc Zyngier wrote:
> On 2020-08-20 09:07, Saravana Kannan wrote:
>> On Thu, Aug 20, 2020 at 12:56 AM Marc Zyngier <maz@kernel.org> wrote:
>>>
>>> On 2020-08-19 19:51, Saravana Kannan wrote:
>>> > On Wed, Aug 19, 2020 at 9:52 AM Frank Wunderlich <wichtig@fw-web.de>
>>> > wrote:
>>> >>
>>> >> hi,
>>> >>
>>> >> does the fix you've linked to my revert [1] not work in your case?
>>> >>
>>> >> [1] https://patchwork.kernel.org/patch/11718481/
>>> >
>>> > Thanks for pointing it out Frank. Also, might want to avoid top
>>> > posting in the future.
>>> >
>>> > Enric, Can you please try that other fix and see if that solves your
>>> > issue?
>>>
>>> I think Enric was clear that the driver does probe correctly
>>> (meaning that he has the fix in his tree). It is everything else
>>> that breaks, because none of the drivers on the platform are
>>> equipped to defer their own probing.
>>>
>>> I think we need to change this works right now, meaning that we can't
>>> blindly change the behaviour of *built-in* drivers. I'll see if I can
>>> come up with something quickly, but I'll otherwise take Enric patch.
>>
>> Sounds fair Marc.
>>
>> Btw, Enric, out of curiosity, can you try adding "fw_devlink=on" to
>> your kernel command line to see if it helps? It basically ensures
>> proper probe ordering without depending on the drivers. There are some
>> corner cases where it still can't work properly (too much to explain
>> for a late night email), but if the platforms don't have those corner
>> cases it'll work perfectly.
>>
>> I'm fine with the revert if Marc isn't able to find a quick fix to the
>> drivers, but this might also fix your problem right away.
> 
> I'm afraid there is no quick fix if we want to preserve the current
> behavior with built-in drivers, and not having "fw_devlink=on" by
> default makes it irrelevant for most people.
> 
> fw_devlink also prevents my test platforms from booting (my rk3399
> doesn't find its PCI devices with it), while the same kernel boots
> just fine without it. It could well be that the corner case is
> likely to be more prevalent than you seem to expect.
> 
> I will probably end-up end-up queuing reverts for both mtk-sysirq,
> mtk-cirq, and qcom-pdc (the first two can't be built as module with
> mainline anyway, and I seem to remember that the latter caused some
> controversy as well).
> 
> As an experiment, I have pushed out a branch[1] that implements
> a "hybrid" probe, retaining the previous early probe mechanism when
> the driver is built-in, and letting things rip when built as a
> module (if you do that, you hopefully know what you are doing).
> I'd welcome some testing on affected platforms (I don't have
> anything I can run mainline on that'd be affected).
> 

Unfortunately, my Kukui (MT8183) board doesn't boot at all with those patches. I
only did a quick test and I didn't dig further, please let me know if you want I
debug more the issue. IMHO, right now, the revert seems to be the better
solution for this cycle.

Thanks,
 Enric


> Thanks,
> 
>         M.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/hybrid-probe
> 
