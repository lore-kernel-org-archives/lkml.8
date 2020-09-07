Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52280C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3142078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgIGPgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbgIGPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:33:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43AAC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 08:33:37 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kFJ9E-0003uV-5K; Mon, 07 Sep 2020 17:33:36 +0200
Subject: Re: [PATCH] gpio: siox: indicate exclusive support of threaded IRQs
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thorsten Scherer <t.scherer@eckelmann.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200804091603.541-1-a.fatoum@pengutronix.de>
 <CACRpkdb9NBpS3yvvX+G8NWgVdSqR5vd6DxP2rT7GCuB0ObnvHg@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <157dbd0a-f102-3682-6122-7366c62ffaa1@pengutronix.de>
Date:   Mon, 7 Sep 2020 17:33:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb9NBpS3yvvX+G8NWgVdSqR5vd6DxP2rT7GCuB0ObnvHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On 8/28/20 12:55 AM, Linus Walleij wrote:
> Hi Ahmad,
> 
> On Tue, Aug 4, 2020 at 11:18 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> 
>> Generic GPIO consumers like gpio-keys use request_any_context_irq()
>> to request a threaded handler if irq_settings_is_nested_thread() ==
>> true or a hardirq handler otherwise.
>>
>> Drivers using handle_nested_irq() must be sure that the nested
>> IRQs were requested with threaded handlers, because the IRQ
>> is handled by calling action->thread_fn().
>>
>> The gpio-siox driver dispatches IRQs via handle_nested_irq,
>> but has irq_settings_is_nested_thread() == false.
>>
>> Set gpio_irq_chip::threaded to remedy this.
>>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> I think we concluded we want to apply this patch, but with
> a fixed commit text, can you send a V2? (Or ask Uwe if he wants
> to pick it up and write the text.)

Thanks for the reminder. This slipped through.
I just sent out v2 (<20200907153135.3307-1-a.fatoum@pengutronix.de>)

Cheers,
Ahmad

> 
> Yours,
> Linus Walleij
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
