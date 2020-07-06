Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EEEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E191206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgGFUtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGFUtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:49:43 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED988C08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 13:49:42 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id B2F76BC140;
        Mon,  6 Jul 2020 20:49:39 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: IPv*
To:     David Miller <davem@davemloft.net>
References: <20200706173850.19304-1-grandmaster@al2klimov.de>
 <20200706.132319.1942886313658107601.davem@davemloft.net>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <33dfc84d-89ef-c449-2534-a4ba96638ad3@al2klimov.de>
Date:   Mon, 6 Jul 2020 22:49:39 +0200
MIME-Version: 1.0
In-Reply-To: <20200706.132319.1942886313658107601.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 06.07.20 um 22:23 schrieb David Miller:
> From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> Date: Mon,  6 Jul 2020 19:38:50 +0200
> 
>> Rationale:
>> Reduces attack surface on kernel devs opening the links for MITM
>> as HTTPS traffic is much harder to manipulate.
>>
>> Deterministic algorithm:
>> For each file:
>>    If not .svg:
>>      For each line:
>>        If doesn't contain `\bxmlns\b`:
>>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>>            If both the HTTP and HTTPS versions
>>            return 200 OK and serve the same content:
>>              Replace HTTP with HTTPS.
>>
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> 
> Applied to net-next, thank you very much for doing this. >
Hi,

apropos "doing this": I've stumbled over ...

https://lkml.org/lkml/2005/7/11/336

... and am wondering:

*What exact timespan do you mean with "at once"?*

Srsly, I mean... just look at the last few patches of mine at the (main) 
mailing list. I'm going to submit (at least) about 120 (!) more[1] of 
them. How long shall I wait after each one not to kill your 
infrastructure and not to be locked out?

Best,
AK


[1] Amount of maintainers of only one subsystem which is affected by a 
such patch of mine. (Easier for me to split by subsystem.)
