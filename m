Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEE5C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6CA206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="en4NwJSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgBFJMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:12:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41012 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728325AbgBFJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580980347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUh0i0ZHsQ/jsDj5YBvsMi9/L1YBCsjN7m5EaFUvBaI=;
        b=en4NwJSKB3nOkorZ0pwYAflgRNlNOevmEKR4jtwN88Z1nlsK533wDQyIAMKQUCuJvLsamM
        bUq2BLrzQQ5kOZubKlwkNEgcG/Sr3EVGQw6zZ/wROSXLOoZnZK7DpaPYwJ7RXKTl2Ms8XR
        mxKZUK3onaM5Ryr/v/p9UzDqs8s/oF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-0GWQdRIOOyejgzXG6QsyEQ-1; Thu, 06 Feb 2020 04:12:25 -0500
X-MC-Unique: 0GWQdRIOOyejgzXG6QsyEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8FE4DB2D;
        Thu,  6 Feb 2020 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7617660C05;
        Thu,  6 Feb 2020 09:12:18 +0000 (UTC)
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
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
 <cd7509a5-48fd-e652-90f4-1e0fe2311134@redhat.com>
 <87sgjp9foj.fsf@linutronix.de>
From:   lijiang <lijiang@redhat.com>
Message-ID: <990f0076-7df2-c956-6181-fd222c1023f6@redhat.com>
Date:   Thu, 6 Feb 2020 17:12:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87sgjp9foj.fsf@linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2020-02-05, lijiang <lijiang@redhat.com> wrote:
>> Do you have any suggestions about the size of CONFIG_LOG_* and
>> CONFIG_PRINTK_* options by default?
> 
> The new printk implementation consumes more than double the memory that
> the current printk implementation requires. This is because dictionaries
> and meta-data are now stored separately.
> 
> If the old defaults (LOG_BUF_SHIFT=17 LOG_CPU_MAX_BUF_SHIFT=12) were
> chosen because they are maximally acceptable defaults, then the defaults
> should be reduced by 1 so that the final size is "similar" to the
> current implementation.
> 
> If instead the defaults are left as-is, a machine with less than 64 CPUs
> will reserve 336KiB for printk information (128KiB text, 128KiB
> dictionary, 80KiB meta-data).
> 
> It might also be desirable to reduce the dictionary size (maybe 1/4 the
> size of text?). However, since the new printk implementation allows for
> non-intrusive dictionaries, we might see their usage increase and start
> to be as large as the messages themselves.
> 
> John Ogness
> 

Thanks for the explanation in detail.

Lianbo

