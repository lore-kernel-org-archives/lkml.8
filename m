Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366DCC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11922206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCWPUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:20:13 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:50870 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCWPUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:20:12 -0400
Received: from [192.168.42.210] ([93.22.39.252])
        by mwinf5d27 with ME
        id HrL62200S5SRGh103rL7CS; Mon, 23 Mar 2020 16:20:10 +0100
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Mar 2020 16:20:10 +0100
X-ME-IP: 93.22.39.252
Subject: Re: [PATCH] perf cpumap: Use scnprintf instead of snprintf
To:     David Laight <David.Laight@ACULAB.COM>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "zhe.he@windriver.com" <zhe.he@windriver.com>,
        "dzickus@redhat.com" <dzickus@redhat.com>,
        "jstancek@redhat.com" <jstancek@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.janitors
References: <20200322172523.2677-1-christophe.jaillet@wanadoo.fr>
 <c0441e54a07e424f9646ca232d44e9d8@AcuMS.aculab.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <8bb4696a-3470-6613-50ce-a002fbce6b23@wanadoo.fr>
Date:   Mon, 23 Mar 2020 16:20:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c0441e54a07e424f9646ca232d44e9d8@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/03/2020 à 16:11, David Laight a écrit :
> From: Christophe JAILLET
>> Sent: 22 March 2020 17:25
>> 'scnprintf' returns the number of characters written in the output buffer
>> excluding the trailing '\0', instead of the number of characters which
>> would be generated for the given input.
>>
>> Both function return a number of characters, excluding the trailing '\0'.
>> So comparaison to check if it overflows, should be done against max_size-1.
>> Comparaison against max_size can never match.
> NACK.
> Since snprintf() returns the number of characters it would have
> written to an infinite buffer the comparison can 'match'.
>
> However it should test for (ret >= PATH_MAX).

Agreed. I'll send a V2.

CJ

> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
>

