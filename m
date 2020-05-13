Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24611CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E4C206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIKglLNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbgEMMFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:05:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25210 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728165AbgEMMFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589371505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTvNfxEcdBjM7+rUnpuyw83WRb+cCXiZfeWKdT61OtU=;
        b=jIKglLNnAY7dYXnkEMtQevHfd6EjBKJPbIYvYNaDTaWQ3Q7hjPcgfC1sWRGyfvEWgdSIjV
        T/31wDTZigE/KOlA6eb2KFG1ZGehLqCoyarKN+njKSnSQ/is3Qrd02HEDfo5keHCWXSJVi
        XgzLynsKG4mXMSRg24yDGqXeePZP+Xg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-PV_CE75mORq-Nt6Zud0-dw-1; Wed, 13 May 2020 08:05:03 -0400
X-MC-Unique: PV_CE75mORq-Nt6Zud0-dw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8666B1009447;
        Wed, 13 May 2020 12:05:01 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80CEC619C3;
        Wed, 13 May 2020 12:05:00 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] printk: replace ringbuffer
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
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200501094010.17694-1-john.ogness@linutronix.de>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <8981615b-314a-1e55-1635-d17e3cbc544e@redhat.com>
Date:   Wed, 13 May 2020 08:05:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200501094010.17694-1-john.ogness@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/20 5:40 AM, John Ogness wrote:
> Hello,
> 
> Here is a v2 for the first series to rework the printk subsystem. The
> v1 and history are here [0]. This first series only replaces the
> existing ringbuffer implementation. No locking is removed. No
> semantics/behavior of printk are changed.
> 
> The VMCOREINFO is updated. RFC patches for the external tools
> crash(8) [1] and makedumpfile(8) [2] have been submitted that allow
> the new ringbuffer to be correctly read.
> 
> This series is in line with the agreements [3] made at the meeting
> during LPC2019 in Lisbon, with 1 exception: support for dictionaries
> will not be discontinued [4]. Dictionaries are stored in a separate
> buffer so that they cannot interfere with the human-readable buffer.
> 

Hey John,

I tested this on two 128-cpu ppc64le power8 boxes, and a 64 core x86_64 box
using your prb-test testsuite with the latest upstream kernel.  The tests ran
successfully for ~16 hours without any problems.

P.

