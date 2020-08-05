Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E9CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C8322B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZ5NjTMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgHEUMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:12:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35473 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726542AbgHEQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596644839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aTaUnitmoEeIEDUwyHCtIzCzP0qdhb1jpiKMzznBJEI=;
        b=NZ5NjTMH5aUAFnWvjTZLzjeBruxCd+/ReEyjS5f0OXoVm8VrOJR6F6DLAB8svAOF2WTtRZ
        1Yohi6xYGJdhuF/GHyJWPGNhaao8Uz/Ixix73hwSsfoZBbJwo2kcYOMoyZDPG4a50hiTS7
        ecn1AAMzTRFZ3FlSFNR7qgfDM68EJyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-5_qzgieNNLSzpICrC8eShQ-1; Wed, 05 Aug 2020 10:11:36 -0400
X-MC-Unique: 5_qzgieNNLSzpICrC8eShQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 337DD107BEF5;
        Wed,  5 Aug 2020 14:11:34 +0000 (UTC)
Received: from prarit.bos.redhat.com (dhcp16-222-232.7a2m.lab.eng.bos.redhat.com [10.16.222.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C47C5D9DC;
        Wed,  5 Aug 2020 14:11:32 +0000 (UTC)
Subject: Re: [PATCH V13] printk: Add monotonic, boottime, and realtime
 timestamps
To:     Petr Mladek <pmladek@suse.com>
Cc:     corbet@lwn.net, rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        chunyan.zhang@unisoc.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
References: <20200729114423.30606-1-zhang.lyra@gmail.com>
 <20200729122236.17418-1-prarit@redhat.com> <20200805140430.GI24529@alley>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <77c37735-e258-4933-f568-8450253a38ff@redhat.com>
Date:   Wed, 5 Aug 2020 10:11:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200805140430.GI24529@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/20 10:04 AM, Petr Mladek wrote:
> On Wed 2020-07-29 08:22:36, Prarit Bhargava wrote:
>>   Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>>> From: Prarit Bhargava <prarit@redhat.com>
>>>
>>> printk.time=1/CONFIG_PRINTK_TIME=1 adds a unmodified local hardware clock
>>> timestamp to printk messages.  The local hardware clock loses time each
>>> day making it difficult to determine exactly when an issue has occurred in
>>> the kernel log, and making it difficult to determine how kernel and
>>> hardware issues relate to each other in real time.
>>>
>>> Make printk output different timestamps by adding options for no
>>> timestamp, the local hardware clock, the monotonic clock, the boottime
>>> clock, and the real clock.  Allow a user to pick one of the clocks by
>>> using the printk.time kernel parameter.  Output the type of clock in
>>> /sys/module/printk/parameters/time so userspace programs can interpret the
>>> timestamp.
>>>
>> ISTR the reason that this was dropped was because of the a problem with
>> the way systemd read the kernel's timestamps.  It got the attention of
>> Linus, and it was then pulled from the tree.
>>
>> I need to go back and review the entire thread as it's been several years
>> since we had the discussion although ISTR someone mentioning that doing two
>> timestamps would not be a problem for systemd.
> 
> I guess that you talk about this thread
> https://lore.kernel.org/lkml/CA+55aFwUfA__6MgMgjENnx+_RYY2ZOOLiSx2ea1AvYhSZN+78A@mail.gmail.com/
> 
>> For example,
>>
>> [48551.015086]
>>
>> would be
>>
>> [48551.015086] m[xxxx.xxxx]
>>
>> for the monotonic clock timestamp, and
>>
>> [48551.015086] b[xxxx.xxxx]
>>
>> for the boottime clock, etc.
> 
> This approach has several drawbacks:
> 
>   + Too long prefix might make it hard to see the real messages
>     because of shrunken/wrapped lines.
> 
>   + Too long lines are problem with slow consoles.
> 
>   + More space will be necessary to store all the time stamps.
> 
>   + Userspace tools would need/want to parse the format. We would
>     need to maintain it forever.
> 
> 
> Linus had an interesting idea to print all timestamps regularly.
> The frequency might be configurable. It might print, for example,
> the following line every 10 minutes or once a day:
> 
>   [48551.015086] System alive: b[xxxx.xxxx] m[xxxx.xxxx]
> 
> It might be useful in general to see when the system was still alive
> before it froze.
> 
> Would it be enough to sort messages printed with different clock
> sources?

Hey Petr,

After reviewing the thread (it has been three years after all), I have asked
Orson and Lyra to look at the suggested changes by tglx and Linus and submit
those instead of "this" patch.

I should have updated this thread with that info.  Sorry 'bout that.

P.

