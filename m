Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2D0C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22062082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYBfURMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgBEJhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:37:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44909 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgBEJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580895418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/sp7gj8I9qykKUt8ZuZBqOrNa3CqcXbspzOseC36ug=;
        b=KYBfURMR7tzd/Bapq8ENRUDYamNRfSIvAgVSEmHpR3RliAnHml1I4csgJBMyFR+QnQwtGi
        7ohEzi00XHdjzzu11yhxKVIdBMgyY0XFWYwIsMoT9n/HfAQ+i0l8ZqN66+QwoXKNubKjZh
        NpQjlkGJoz8ucXgdYGErguvO1mj3AMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-4b-Is73GMliMOV8ahgAwXg-1; Wed, 05 Feb 2020 04:36:52 -0500
X-MC-Unique: 4b-Is73GMliMOV8ahgAwXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE5BD1005F74;
        Wed,  5 Feb 2020 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B49EA5DA2C;
        Wed,  5 Feb 2020 09:36:44 +0000 (UTC)
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
 <20200205044848.GH41358@google.com> <20200205050204.GI41358@google.com>
 <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
 <20200205063640.GJ41358@google.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <05bdb038-46dc-2939-60e5-7fda2877fa2e@redhat.com>
Date:   Wed, 5 Feb 2020 17:36:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200205063640.GJ41358@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On (20/02/05 13:38), lijiang wrote:
>>> On (20/02/05 13:48), Sergey Senozhatsky wrote:
>>>> On (20/02/05 12:25), lijiang wrote:
> 
> [..]
> 
>>>>
>>>> So there is a General protection fault. That's the type of a problem that
>>>> kills the boot for me as well (different backtrace, tho).
>>>
>>> Do you have CONFIG_RELOCATABLE and CONFIG_RANDOMIZE_BASE (KASLR) enabled?
>>>
>>
>> Yes. These two options are enabled.
>>
>> CONFIG_RELOCATABLE=y
>> CONFIG_RANDOMIZE_BASE=y
> 
> So KASLR kills the boot for me. So does KASAN.
> 
For my side, after adding the option 'nokaslr' to kernel command line, I still have the
previously mentioned problem, finally, kernel failed to boot.

Thanks.

> John, do you see any of these problems on your test machine?
> 
> 	-ss
> 

