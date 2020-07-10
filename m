Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF79C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8C020748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgGJTgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJTgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:36:10 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4DAC08C5DC;
        Fri, 10 Jul 2020 12:36:10 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id DE2C0BC116;
        Fri, 10 Jul 2020 19:36:04 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: USB MASS STORAGE
 DRIVER
To:     Stafford Horne <shorne@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200708095500.13694-1-grandmaster@al2klimov.de>
 <20200708103928.GC585606@kroah.com>
 <6b78a3fd-04b9-fc8e-b5c6-f03372a4cd31@al2klimov.de>
 <20200709061409.GA130260@kroah.com>
 <20200710103621.GA437393@lianli.shorne-pla.net>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <53342e1a-8430-2557-94c7-1da979a79e68@al2klimov.de>
Date:   Fri, 10 Jul 2020 21:36:03 +0200
MIME-Version: 1.0
In-Reply-To: <20200710103621.GA437393@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 10.07.20 um 12:36 schrieb Stafford Horne:
> On Thu, Jul 09, 2020 at 08:14:09AM +0200, Greg KH wrote:
>> On Wed, Jul 08, 2020 at 08:41:54PM +0200, Alexander A. Klimov wrote:
>>>
>>>
>>> Am 08.07.20 um 12:39 schrieb Greg KH:
>>>> On Wed, Jul 08, 2020 at 11:55:00AM +0200, Alexander A. Klimov wrote:
>>>>> Rationale:
>>>>> Reduces attack surface on kernel devs opening the links for MITM
>>>>> as HTTPS traffic is much harder to manipulate.
>>>>>
>>>>> Deterministic algorithm:
>>>>> For each file:
>>>>>     If not .svg:
>>>>>       For each line:
>>>>>         If doesn't contain `\bxmlns\b`:
>>>>>           For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>>>>> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>>>>>               If both the HTTP and HTTPS versions
>>>>>               return 200 OK and serve the same content:
>>>>>                 Replace HTTP with HTTPS.
>>>>>
>>>>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>>>>
>>>> Your subject lines are very odd compared to all patches for this
>>>> subsystem, as well as all other kernel subsystems.  Any reason you are
>>>> doing it this way and not the normal and standard method of:
>>>> 	USB: storage: replace http links with https
>>>>
>>>> That would look more uniform as well as not shout at anyone.
> 
> I would agree.  The OpenRISC patch for this series says:
>    "OPENRISC ARCHITECTURE:..."
> 
> Here it would just be "openrisc:..." I think fixing the whole series is needed.
> Greg is not the only on complaining.
> 
> Ideally, I think, it would be good to have this sent out as a series i.e [PATCH 3/55]
> rather than individual patches so this could be discussed as a whole.
1) To who? As right now? As right now plus Torvalds, KH, Miller, etc.?
    As right now, but all-to-all?
2) Apropos "series" and "as whole"... I stumbled over
    `git log --oneline |grep -Fwe treewide`
    and am wondering:
    *Shouldn't all of these patches even begin with "treewide: "?*
    E.g.: "treewide: Replace HTTP links with HTTPS ones: GCC PLUGINS"

> 
> -Stafford
> 
>>>> thanks,
>>>>
>>>> greg k-h
>>>>
>>> Hi,
>>>
>>> I'm very sorry.
>>>
>>> As Torvalds has merged 93431e0607e5 and many of you devs (including big
>>> maintainers like David Miller) just applied this stuff, I assumed that's OK.
>>>
>>> And now I've rolled out tens of patches via shell loop... *sigh*
>>>
>>> As this is the third (I think) change request like this, I assume this rule
>>> applies to all subsystems – right?
>>
>> Yes, you should try to emulate what the subsystem does, look at other
>> patches for the same files, but the format I suggested is almost always
>> the correct one.  If not, I'm sure maintainers will be glad to tell you
>> otherwise :)
> 
> 
