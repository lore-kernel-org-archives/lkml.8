Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CD6C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D681620674
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6uQFYPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgBEKTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:19:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57973 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727231AbgBEKTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580897958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhG9+u+26CC0Y3oe69s3gSW9WPcu2HiE40iJD/rIxZs=;
        b=N6uQFYPswEzXIKycA70ggDJaUKfuGK3gpizWGNP1RTGdSFdKmFNu3gn0ohJzfIT5hZIIFD
        fjxhgKx55qfoG6PN96pv8pLAsz7N1JFmluzdc8+0NEYPWrgLqactwA8H9WayNgQnbZtjoN
        D0hOvUPgTDyyfuYocB5Plic4j75/TcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-VvRhE14-OxqVkDRRag5dSg-1; Wed, 05 Feb 2020 05:19:14 -0500
X-MC-Unique: VvRhE14-OxqVkDRRag5dSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92A2C2EDA;
        Wed,  5 Feb 2020 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77823857AF;
        Wed,  5 Feb 2020 10:19:05 +0000 (UTC)
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
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
 <20200205063640.GJ41358@google.com> <877e11h0ir.fsf@linutronix.de>
From:   lijiang <lijiang@redhat.com>
Message-ID: <cd7509a5-48fd-e652-90f4-1e0fe2311134@redhat.com>
Date:   Wed, 5 Feb 2020 18:19:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <877e11h0ir.fsf@linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2020-02-05, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>>>>> So there is a General protection fault. That's the type of a
>>>>> problem that kills the boot for me as well (different backtrace,
>>>>> tho).
>>>>
>>>> Do you have CONFIG_RELOCATABLE and CONFIG_RANDOMIZE_BASE (KASLR)
>>>> enabled?
>>>
>>> Yes. These two options are enabled.
>>>
>>> CONFIG_RELOCATABLE=y
>>> CONFIG_RANDOMIZE_BASE=y
>>
>> So KASLR kills the boot for me. So does KASAN.
> 
> Sergey, thanks for looking into this already!
> 
>> John, do you see any of these problems on your test machine?
> 
> For x86 I have only been using qemu. (For hardware tests I use arm64-smp
> in order to verify memory barriers.) With qemu-x86_64 I am unable to
> reproduce the problem.
> 
> Lianbo, thanks for the report. Can you share your boot args? Anything
> special in there (like log_buf_len=, earlyprintk, etc)?
> 
Thanks for your response. Here is my kernel command line:

Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.5.0-rc7+ root=/dev/mapper/intel--wildcatpass--07-root ro crashkernel=512M resume=/dev/mapper/intel--wildcatpass--07-swap rd.lvm.lv=intel-wildcatpass-07/root rd.lvm.lv=intel-wildcatpass-07/swap console=ttyS0,115200n81

BTW: Actually, I put the complete kernel log in my last email reply, you could check the attachment if needed.

> Also, could you share your CONFIG_LOG_* and CONFIG_PRINTK_* options?
> 
Sure. Please refer to it.

[root@intel-wildcatpass-07 linux]# grep -nr "CONFIG_LOG_" .config 
134:CONFIG_LOG_BUF_SHIFT=20
135:CONFIG_LOG_CPU_MAX_BUF_SHIFT=12

[root@intel-wildcatpass-07 linux]# grep -nr "CONFIG_PRINTK_" .config 
136:CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
207:CONFIG_PRINTK_NMI=y
7758:CONFIG_PRINTK_TIME=y
7759:# CONFIG_PRINTK_CALLER is not set

Do you have any suggestions about the size of CONFIG_LOG_* and CONFIG_PRINTK_* options by default?

Thanks.
Lianbo

> I will move to bare metal x86_64 and hopefully see it as well.
> 
> John
> 

