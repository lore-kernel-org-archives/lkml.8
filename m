Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E6AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9F120721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="N7bHxbLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgEDLRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:17:21 -0400
Received: from mout.web.de ([212.227.17.11]:48649 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEDLRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588591033;
        bh=sAXNeijFvunPjYnZmxoIOeGxMsw1emZbFQi51Hn/9OI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=N7bHxbLmxslktxH+FIHYgzSfh7t750F6uLm5uWYJZwy3PhRvClhxs9rZRmdaV2oFQ
         VMo0K6sdcBfWCGDuvA+jYdLQK7qGcifgAtTJ0bl8Tr6tiQCaRcSnXLEkiROS6o3H5x
         I63ieckN/RHeJaRGq8nGMeXlBXg72joc32RLaj4w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.152.69]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LpO4v-1izEwn3N9Z-00f7Wp; Mon, 04
 May 2020 13:17:12 +0200
Subject: Re: [v6] checkpatch: add support to check 'Fixes:' tag format
To:     Wang YanQing <udknight@gmail.com>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org
References: <20200504082002.GA29972@udknight>
 <38251b1f-e89b-7b3a-6045-f5ce1dc2596a@web.de>
 <20200504102242.GA13013@udknight>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Message-ID: <56a0219f-48c6-4b15-fd71-e8312079f7f2@web.de>
Date:   Mon, 4 May 2020 13:17:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504102242.GA13013@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:XAwsEEwAlE7naomLTM35kK20wop1IQdB5Aq6jB7QaJLWKhwGEKr
 LearugLNrqcIDUE736CiUYSnYnLSEhjr/+/5OTPhG2YbuKxdPOEOGD8SJQ1XKpRmWNqsh+k
 GEjXhaLggjnXZ5yLrKE58royIHv+/qz60UbjJmKnM5fiWyGvoLMiJ3nI7meKINdgJ4xMGSd
 pK4uHWVlqOvgRtTtuAb1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0s6EoQAqlRc=:YDozR03sPp9QqVNcmdZMT/
 r3hZ/Z5ThiBodFHaILXlKQIPkdXtZn+jsEL41j6mCoGQ0GjJdluZhcxbavw2zTQNyFq6g7DFa
 GDQ+pP+eaokoXY+1zrneIrEJNUqQDrtY9WV8At1BP6iH0JddQeZ4etaRwxR/IZWv2SOq3sEWX
 KG75hy63DSACqb+mAWanufFhJ3M3XfRKb/IM2hZ5d8rMXf7DmjwDIboZm05LNQDNB2dswNTuR
 sIdoiFBE73KtTXYQZmJxs4BwBYqbHVn016WDUsV194P3LDmy2nTyDmzvSH9bhjCYslZTmUFS/
 3hemXkeEBmqImKGQwV6fPWpQPKnAHJtXoUS0gc9HYOh/nVCXDmc6d7VRSmc2ynYIf5tuqLPPQ
 dI2PieAwaAb1bLhVq0BRmKzwUhncd4hsRn5KLE/WeV6srv1ovuuxySfzcU3VXajkAK8chTTWF
 AgoCzcxforYODcuf1nQJIYhHJ/YO7hsujDdoF3vwxjjca5F1PDH0rsqyzCvyFOgngFyO2mKOl
 6fd1PxAR8DB0Za2KJOAuVgm1YXKGScPisvGFMEIcqkL7ZVPhDYeBy555sDuWZy9A2IprhZIA9
 WYgcSexsK2H53Xl/0fmFIwiEzu0/wJxU9UJ/3DQ5JQZCv5LfUyo9FQ5e5KFwYkX0eUfriGpVl
 vf6vpnbJkBiR7ZL6Sqd9PAUGPj7N1sjV7JwNAfdHNzCcC061Km4aS3NiWkW8+LMMP7BM9bCcW
 hHefWNeDd0HPs3Fv9FS2qR5HFXC+Xahti3HjPUCBfC2WNhc3g7seQBPtXmLAV7KEafHSXnVUg
 tTkmPgi7/r/46labf6rqXfUs9hggND37PkXgvdsAmqvSUc5IPmwaKuye+CblsV7NFvCQFUyx6
 hYOSQZhtdEY8597Gdgt9VPlkdclXp3qs8w9otuvdD1YmLPFXVOrX04S+4pcDNVxcQINSjta6w
 KLmnH/ENd4IvqWBZdiSB4rdk8fwhw2LhyKv3CVDsNQxhpmgzEzSjznJVpU2DNTKH7OWuw2ubV
 3/YkONN+rDgWv88F1xeWAMxEN/Ha+3eHpWHnOfuapUKWLcaprnqDMOoqYRUgVPOuHNM0ilGmk
 PBmIp5iEnPa1zuDfnA2S+57DpsXQOyUYk3mohZZRcm39FX1cn8WfS5MwAuWXCItPwW7keC7Uz
 tAX7liGdy9eTCudYMXsMjue9YvFHn+aRfO25WFQgy2vhrV8eJIixfHgSAhjoOtyU1jgXFJRWy
 fT6opEV5KWZFItcCa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This feature is a side effect of missing right '")' detection, so I think
> it is acceptable to add it.

Will any more collateral evolution become helpful finally?


> But I agree with you, this patch is a little big,

I find such a view also interesting.


> I don't want to add more code into it.

The software can be extended as usual depending on some factor.

Will your contributions evolve into consistent patch series?

Regards,
Markus
