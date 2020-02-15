Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAF3C7114D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 04:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4D52084E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 04:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSlZqTwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgBOEPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 23:15:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55295 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727705AbgBOEPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 23:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581740149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4v4KhDOUgaH2uZWdr53oizMCM+xuhnQJDym0U6qJWwY=;
        b=NSlZqTwG3Jx/v4ruDqU6h2zN0B/dfuE6keye3v5KTeuPL0xQ9qzzFct1TiBLE09JKKpEK5
        M9DwSb1+3CQ7bWyvuXg1Ol5O6MhC0/61jxtufF+Lsw6fgi4AfjHjVwAhUXSXfwncvwd9Cr
        PQRRLk7F1VHKoSNrc1Z0xKi1HkH/Iik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-Yt1oiaODPbya0oZ7OY3DAQ-1; Fri, 14 Feb 2020 23:15:46 -0500
X-MC-Unique: Yt1oiaODPbya0oZ7OY3DAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B64A86124F;
        Sat, 15 Feb 2020 04:15:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4097E5C1D8;
        Sat, 15 Feb 2020 04:15:36 +0000 (UTC)
Subject: Re: [PATCH 2/2] printk: use the lockless ringbuffer
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-3-john.ogness@linutronix.de>
 <ccbe1383-a4a4-41f8-3330-972f03c97429@redhat.com>
 <87zhdle0s5.fsf@linutronix.de>
From:   lijiang <lijiang@redhat.com>
Message-ID: <fade55ad-cefd-898b-6062-6fe45f17b94a@redhat.com>
Date:   Sat, 15 Feb 2020 12:15:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87zhdle0s5.fsf@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2020=E5=B9=B402=E6=9C=8814=E6=97=A5 21:50, John Ogness =E5=86=99=
=E9=81=93:
> Hi Lianbo,
>=20
> On 2020-02-14, lijiang <lijiang@redhat.com> wrote:
>>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>>> index 1ef6f75d92f1..d0d24ee1d1f4 100644
>>> --- a/kernel/printk/printk.c
>>> +++ b/kernel/printk/printk.c
>>> @@ -1062,21 +928,16 @@ void log_buf_vmcoreinfo_setup(void)
>>>  {
>>>  	VMCOREINFO_SYMBOL(log_buf);
>>>  	VMCOREINFO_SYMBOL(log_buf_len);
>>
>> I notice that the "prb"(printk tb static) symbol is not exported into
>> vmcoreinfo as follows:
>>
>> +	VMCOREINFO_SYMBOL(prb);
>>
>> Should the "prb"(printk tb static) symbol be exported into vmcoreinfo?
>> Otherwise, do you happen to know how to walk through the log_buf and
>> get all kernel logs from vmcore?
>=20
> You are correct. This will need to be exported as well so that the
> descriptors can be accessed. (log_buf is only the pure human-readable

Really agree, and I guess that there may be more structures and their off=
sets
to be exported, for example: struct prb_desc_ring, struct prb_data_ring, =
and
struct prb_desc, etc.

This makes sure that tools(such as makedumpfile and crash) can appropriat=
ely
access them.=20

> text.) I am currently hacking the crash tool to see exactly what needs
> to be made available in order to access all the data of the ringbuffer.
>=20
It makes sense and avoids exporting unnecessary symbols and offsets.

Thanks.
Lianbo


> John Ogness
>=20

