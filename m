Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFFFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02764206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mr1ShgOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgGHFvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:51:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25445 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726278AbgGHFvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 01:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594187466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d0KhoKnMNC3+EgedwCLIMtHsloIf+grtGbdl24ZJeSg=;
        b=Mr1ShgOnppbnpJ4jjb2MtS2bHvPMmQc019agyCMCB0FkZFprjZ3iG82r8V3BvSADllM9b+
        ZL0dzus9/f9D0DxMAuGzu9Q0Bjd0i0MXqNxSDcJ3JUKxCbjImLuyDjcgFTDaf2BHlGoM5p
        7rOcR/tABM9L6V6kYttFfxuic7yv8+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-YK-WKQQfNGC_uf2jsFPfDg-1; Wed, 08 Jul 2020 01:51:02 -0400
X-MC-Unique: YK-WKQQfNGC_uf2jsFPfDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF83E87950F;
        Wed,  8 Jul 2020 05:51:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-13.pek2.redhat.com [10.72.13.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F02660CD1;
        Wed,  8 Jul 2020 05:50:55 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] printk: use the lockless ringbuffer
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <ba338fab-9e98-366b-8fd4-05d4daa14f6d@redhat.com>
 <87zh8imgs5.fsf@jogness.linutronix.de>
 <585a6a1b-931c-1034-e2cc-da2c4381751e@redhat.com>
 <87lfk0stiw.fsf@jogness.linutronix.de>
From:   lijiang <lijiang@redhat.com>
Message-ID: <0733578f-1f9d-bbd4-0c30-a8a124f5ffa8@redhat.com>
Date:   Wed, 8 Jul 2020 13:50:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87lfk0stiw.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020年07月03日 19:54, John Ogness 写道:
> On 2020-07-02, lijiang <lijiang@redhat.com> wrote:
>> About the VMCOREINFO part, I made some tests based on the kernel patch
>> v3, the makedumpfile and crash-utility can work as expected with your
>> patch(userspace patch), but, unfortunately, the
>> vmcore-dmesg(kexec-tools) can't correctly read the printk ring buffer
>> information, and get the following error:
>>
>> "Missing the log_buf symbol"
>>
>> The kexec-tools(vmcore-dmesg) should also have a similar patch, just like
>> in the makedumpfile and crash-utility.
> 
> A patched kexec-tools is available here [0].
> 
> I did not test using 32-bit dumps on 64-bit machines and vice versa. But
> it should work.
> 
> John Ogness
> 
> [0] https://github.com/Linutronix/kexec-tools.git (printk branch)
> 

After applying this patch, the vmcore-dmesg can work.

Thank you, John Ogness.

