Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74699C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDE620760
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKguYWN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgGBJnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:43:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29698 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726555AbgGBJnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593683016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ug+Cs+5MidriBBruTqDP+Dk7+JNAduJmDfJrU4PFZh0=;
        b=MKguYWN9aMdz6/j/fv3uGLhVmexm29R2QqNDXoIk8P0Um/abponBvo4lgG3GrTFdEdFcUy
        AtVopWSwEea0AGLTzeao9bz63YfKm1rRIyZU6Lhuc+1eY27N5YPr7+1faL4N9EtSlMryNh
        5jS5JZQmcmrq6auLu+IVojj81Win1Gw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-naC7fyKDMcq4qvGOvA9KGw-1; Thu, 02 Jul 2020 05:43:32 -0400
X-MC-Unique: naC7fyKDMcq4qvGOvA9KGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89553804001;
        Thu,  2 Jul 2020 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-175.pek2.redhat.com [10.72.12.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3827D5C1B0;
        Thu,  2 Jul 2020 09:43:24 +0000 (UTC)
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
From:   lijiang <lijiang@redhat.com>
Message-ID: <585a6a1b-931c-1034-e2cc-da2c4381751e@redhat.com>
Date:   Thu, 2 Jul 2020 17:43:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87zh8imgs5.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020年07月02日 17:02, John Ogness 写道:
> On 2020-07-02, lijiang <lijiang@redhat.com> wrote:
>> About the VMCOREINFO part, I made some tests based on the kernel patch
>> v3, the makedumpfile and crash-utility can work as expected with your
>> patch(userspace patch), but, unfortunately, the vmcore-dmesg(kexec-tools)
>> can't correctly read the printk ring buffer information, and get the
>> following error:
>>
>> "Missing the log_buf symbol"
>>
>> The kexec-tools(vmcore-dmesg) should also have a similar patch, just like
>> in the makedumpfile and crash-utility.
> 
> Yes, a patch for this is needed (as well as for any other related
> software floating around the internet).
> 
> I have no RFC patches for vmcore-dmesg. Looking at the code, I think it
> would be quite straight forward to port the makedumpfile patch. I will

Yes, it should be a similar patch.

> try to make some time for this.
> 
That would be nice. Thank you, John Ogness.

> I do not want to patch any other software for this. I think with 3
> examples (crash, makedumpfile, vmcore-dmesg), others should be able to

It's good enough to have the patch for the makedumpfile, crash and vmcore-dmesg,
which can ensure the kdump(userspace) work well.

Thanks.
Lianbo

> implement the changes to their software without needing my help.
> 
> John Ogness
> 

