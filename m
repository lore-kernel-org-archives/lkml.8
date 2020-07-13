Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDE0C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C20320890
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGMWCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:02:54 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:50328 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGMWCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:02:54 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id BD571BC06E;
        Mon, 13 Jul 2020 22:02:50 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: kprobes
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     anil.s.keshavamurthy@intel.com, corbet@lwn.net,
        davem@davemloft.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>
References: <20200707194959.52487-1-grandmaster@al2klimov.de>
 <20200708184201.611d929ae6017c87ea98b114@kernel.org>
 <1594388442.4mjtjyic5z.naveen@linux.ibm.com>
 <20200713232011.da584d6f7147b54ba083556f@kernel.org>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <2b0d6f67-7844-644c-1806-5d795cb5093d@al2klimov.de>
Date:   Tue, 14 Jul 2020 00:02:49 +0200
MIME-Version: 1.0
In-Reply-To: <20200713232011.da584d6f7147b54ba083556f@kernel.org>
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



Am 13.07.20 um 16:20 schrieb Masami Hiramatsu:
> Hi Naveen and Alexander,
> 
> On Fri, 10 Jul 2020 19:14:47 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.ibm.com> wrote:
> 
>> Masami Hiramatsu wrote:
>>> On Tue,  7 Jul 2020 21:49:59 +0200
>>> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
>>>
>>>> Rationale:
>>>> Reduces attack surface on kernel devs opening the links for MITM
>>>> as HTTPS traffic is much harder to manipulate.
>>>>
>>>> Deterministic algorithm:
>>>> For each file:
>>>>    If not .svg:
>>>>      For each line:
>>>>        If doesn't contain `\bxmlns\b`:
>>>>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>>>>            If both the HTTP and HTTPS versions
>>>>            return 200 OK and serve the same content:
>>>>              Replace HTTP with HTTPS.
>>>
>>> OK, but it seems that some of them are disappeared :(
>>>
>>>   http://www-106.ibm.com/developerworks/library/l-kprobes.html?ca=dgr-lnxw42Kprobe
>>>
>>>   -> https://www.ibm.com/developerworks/library/l-kprobes/index.html
>>
>> That looks right.
>>
>>>
>>>   http://www.redhat.com/magazine/005mar05/features/kprobes/
>>>
>>>   -> I can not find that.
>>
>> Ditto, we should drop that.
>>
>>>
>>>>   - http://www-users.cs.umn.edu/~boutcher/kprobes/
>>>>   - http://www.linuxsymposium.org/2006/linuxsymposium_procv2.pdf (pages 101-115)
>>>
>>> Both are not found.
>>
>> It looks like the first link is gone, but there seems to be a copy in
>> the web archive:
>> https://web.archive.org/web/20061106154519/http://www-users.cs.umn.edu/~boutcher/kprobes/
>>
>> I suppose we can drop that link.
>>
>>>
>>> (OT, it seems http://www.linuxsymposium.org/ has been left from historical
>>>   Linux Symposium, we must remove it asap)
>>
>> Indeed, I think that link pointed to the Kprobes paper:
>> https://www.kernel.org/doc/ols/2006/ols2006v2-pages-109-124.pdf
> 
> Ah, there is.
> Thank you for the confirmation.
> Alexander, can you update other urls instead of just replacing the http with https?
Sry, but I don't steal others' work (on principle).

If I didn't the work (e.g. searched the replacement URL), I don't 
deserve to author the respective commit.

Also my HTTPSifying task is not done yet.

> 
>>
>>
>> - Naveen
>>
> 
> 
