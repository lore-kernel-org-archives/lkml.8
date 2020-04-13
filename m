Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B5BC38A29
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD0E206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgDMINY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 04:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbgDMIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:10:58 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 983EAC00860B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 01:01:22 -0700 (PDT)
Received: from [192.168.1.41] ([90.126.162.40])
        by mwinf5d60 with ME
        id S7t9220070scBcy037tHSA; Mon, 13 Apr 2020 09:53:51 +0200
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 Apr 2020 09:53:51 +0200
X-ME-IP: 90.126.162.40
Subject: Re: [PATCH] net: mvneta: Fix a typo
To:     Joe Perches <joe@perches.com>, thomas.petazzoni@bootlin.com,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200412212034.4532-1-christophe.jaillet@wanadoo.fr>
 <6ecfa6cb686af1452101c0b727c9eb34d5582610.camel@perches.com>
 <eea1b700-4559-c8d1-1960-1858ed3d90ef@wanadoo.fr>
 <f1033e80969fce39d9cc97fb924f7d68e5f96f74.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <4b5efa7f-6bd9-c64c-e42f-20e76df2c3f5@wanadoo.fr>
Date:   Mon, 13 Apr 2020 09:53:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f1033e80969fce39d9cc97fb924f7d68e5f96f74.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/04/2020 à 09:15, Joe Perches a écrit :
> On Mon, 2020-04-13 at 08:56 +0200, Christophe JAILLET wrote:
>> Le 12/04/2020 à 23:35, Joe Perches a écrit :
>>> On Sun, 2020-04-12 at 23:20 +0200, Christophe JAILLET wrote:
>>>> s/mvmeta/mvneta/
>>> nice. how did you find this?
>> Hi,
>>
>> This is based on a bash script I've made a while ago (see [1])
>> I've slightly updated it, but the idea is still the same. I search
>> strings in a file with some variation on the file name (2 inverted
>> chars, 1 missing char or 1 modified char).
>>
>> The output is horrible, and a lot of filtering should be done.
>> It is much like noise, with MANY false positives. But I manage to dig
>> some interesting stuff out of it.
>>
>> If interested in the updated script, just ask, but except the concept
>> itself, I'm not sure than anything else worth anything and is should be
>> rewritten from scratch.
>>
>> The update includes some tweaks in order to search into Kconfig files
>> instead.
>>
>> CJ
>>
>> [1]: https://marc.info/?l=kernel-janitors&m=156382201306781&w=4
> Nice.
>
> I was wondering if you used levenshtein distance or something else.
>
> https://en.wikipedia.org/wiki/Levenshtein_distance
>
>
Well, kind of hand-written version :)

If of any interest:
https://marc.info/?l=linux-driver-devel&m=141798041130581&w=4

I don't remember having played with it myself, but it looks interesting.

CJ

