Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E167EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB420206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgFALca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:32:30 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:45807 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFALc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:32:29 -0400
Received: from [192.168.1.41] ([92.140.207.208])
        by mwinf5d35 with ME
        id lnXo2200Y4WJoZY03nXyvM; Mon, 01 Jun 2020 13:32:27 +0200
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 01 Jun 2020 13:32:27 +0200
X-ME-IP: 92.140.207.208
Subject: Re: [PATCH] pinctrl: pxa: pxa2xx: Remove 'pxa2xx_pinctrl_exit()'
 which is unused and broken
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel.janitors,gmane.linux.ports.arm.kernel,gmane.linux.kernel.gpio,gmane.linux.kernel
References: <20200531073716.593343-1-christophe.jaillet@wanadoo.fr>
 <87h7vvb1s3.fsf@belgarion.home>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <a2e34c9a-676f-d83f-f395-7428af038c16@wanadoo.fr>
Date:   Mon, 1 Jun 2020 13:31:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <87h7vvb1s3.fsf@belgarion.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/06/2020 à 10:58, Robert Jarzmik a écrit :
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:
>
>> Commit 6d33ee7a0534 ("pinctrl: pxa: Use devm_pinctrl_register() for pinctrl registration")
>> has turned a 'pinctrl_register()' into 'devm_pinctrl_register()' in
>> 'pxa2xx_pinctrl_init()'.
>> However, the corresponding 'pinctrl_unregister()' call in
>> 'pxa2xx_pinctrl_exit()' has not been removed.
>>
>> This is not an issue, because 'pxa2xx_pinctrl_exit()' is unused.
>> Remove it now to avoid some wondering in the future and save a few LoC.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Would be even a better patch with a :
> Fixes: 6d33ee7a0534 ("pinctrl: pxa: Use devm_pinctrl_register() for pinctrl registration")

I was wondering it was was needed in this case.
The patch does not really fix anything, as the function is unused. Or it 
fixes things on a theoretical point of view.

CJ


> Cheers.
>
> --
> Robert
>

