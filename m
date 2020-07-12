Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587FAC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 06:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355D420672
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 06:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgGLGkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 02:40:32 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:42735 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgGLGkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 02:40:32 -0400
Received: from [192.168.42.210] ([93.22.148.52])
        by mwinf5d56 with ME
        id 26gV23002183tQl036gVjA; Sun, 12 Jul 2020 08:40:30 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 12 Jul 2020 08:40:30 +0200
X-ME-IP: 93.22.148.52
Subject: Re: [PATCH] net: sky2: switch from 'pci_' to 'dma_' API
To:     Joe Perches <joe@perches.com>, mlindner@marvell.com,
        stephen@networkplumber.org, davem@davemloft.net, kuba@kernel.org,
        hch@infradead.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200711204944.259152-1-christophe.jaillet@wanadoo.fr>
 <2181026e68d2948c396cc7a7b6bfb7146c1cd5f6.camel@perches.com>
 <8a3e5514-9cc9-18f3-9a98-81007419a20a@wanadoo.fr>
 <866325009f9ae73b3a563dd745f901260a372242.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <a0d0ad2b-8b21-3842-cf2b-1d46274bbe7a@wanadoo.fr>
Date:   Sun, 12 Jul 2020 08:40:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <866325009f9ae73b3a563dd745f901260a372242.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/07/2020 à 08:32, Joe Perches a écrit :
> On Sun, 2020-07-12 at 08:29 +0200, Christophe JAILLET wrote:
>> Le 11/07/2020 à 23:20, Joe Perches a écrit :
>>> On Sat, 2020-07-11 at 22:49 +0200, Christophe JAILLET wrote:
>>>> The wrappers in include/linux/pci-dma-compat.h should go away.
>>> why?
>>>
>>>
>>   From Christoph Hellwig
>> https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> There's no why there.
> There's just an assertion a wrapper should "go away".
>
> "the wrappers in include/linux/pci-dma-compat.h should go away"
>
> wrappers aren't all bad.
>
>
Adding Christoph Hellwig to shed some light.

CJ

