Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18291C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF53A2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgHMI3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:29:47 -0400
Received: from mleia.com ([178.79.152.223]:34928 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHMI3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:29:45 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 4FD3D3FE512;
        Thu, 13 Aug 2020 08:29:44 +0000 (UTC)
Subject: Re: [PATCH v2 5/7] regulator: plug of_node leak in
 regulator_register()'s error path
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org
References: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
 <f5035b1b4d40745e66bacd571bbbb5e4644d21a1.1597195321.git.mirq-linux@rere.qmqm.pl>
 <cddd3d73-8666-d64b-34f5-d82a3b31cf36@mleia.com>
 <20200812140953.GA11200@qmqm.qmqm.pl>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <a57a8a4b-3715-8748-a638-f1550ab587fc@mleia.com>
Date:   Thu, 13 Aug 2020 11:29:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200812140953.GA11200@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20200813_082944_347084_7D4739B3 
X-CRM114-Status: GOOD (  10.65  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/20 5:09 PM, Michał Mirosław wrote:
> On Wed, Aug 12, 2020 at 09:29:12AM +0300, Vladimir Zapolskiy wrote:
>> On 8/12/20 4:31 AM, Michał Mirosław wrote:
> [...]
>>>  	config = kmemdup(cfg, sizeof(*cfg), GFP_KERNEL);
>>>  	if (config == NULL) {
>>> -		kfree(rdev);
>>>  		ret = -ENOMEM;
>>> -		goto rinse;
>>> +		goto clean;
> [...]
>>>  clean:
>>>  	if (dangling_of_gpiod)
>>>  		gpiod_put(config->ena_gpiod);
>>
>> And above 'config' NULL pointer could be dereferenced now, right?
> 
> If config is NULL, dangling_of_gpiod cannot be true.
> 

It's true, thanks. Probably to avoid the known if(false) it might be better
to add a new goto label.

Also it seems to me that it's safe to enter regulator_dev_release() before
doing an assignment to rdev->dev.of_node and incrementing an of_node counter.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
