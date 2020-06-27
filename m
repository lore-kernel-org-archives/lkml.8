Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FF0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD5E212CC
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgF0HLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 03:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgF0HLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 03:11:10 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2487BC03E979;
        Sat, 27 Jun 2020 00:11:10 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 18F98BC12F;
        Sat, 27 Jun 2020 07:11:05 +0000 (UTC)
Subject: Re: [PATCH v2] Replace HTTP links with HTTPS ones: Documentation/arm
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     mchehab+samsung@kernel.org, alexandre.belloni@bootlin.com,
        nicolas.ferre@microchip.com, robh@kernel.org,
        j.neuschaefer@gmx.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200626194408.61245-1-grandmaster@al2klimov.de>
 <20200626150911.3d4f9ca7@lwn.net>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <c5d49d66-7765-d6e3-003a-c17bdef1c6b0@al2klimov.de>
Date:   Sat, 27 Jun 2020 09:10:58 +0200
MIME-Version: 1.0
In-Reply-To: <20200626150911.3d4f9ca7@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 26.06.20 um 23:09 schrieb Jonathan Corbet:
> On Fri, 26 Jun 2020 21:44:08 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
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
>> ---
>>   Changes in v2:
>>   Undone all handhelds.org changes and 0 of 0 wearablegroup.org changes.
> 
> I wasn't asking that the changes be undone, I was asking that those links
> simply be removed.  They are actively harmful - much more so than any http:
> links - and shouldn't be there.  *Sigh*.  I guess I'll just do that.
You know what: I totally agree with you! They are actively harmful and 
shall not be there. End of story.

But *why* you don't let me work step-by-step and *focus on one task* at 
a time?

I.e. focus (for now) on HTTP links which shall stay in the kernel tree 
rather than on the ones which shall not.

IMAO both domains have literally nothing to do with e.g. the HTTPSified 
www.ti.com and ww1.microchip.com.

My trainers (employer) taught me to split commits (patches) per one 
thing I've done. (What you asked for is a legit thing, but it's another 
thing.)

Also *after* finishing my current todo list I'll think about automating 
the detection of such. (This would have a much larger coverage.)

> 
> jon
> 
