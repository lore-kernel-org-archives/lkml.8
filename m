Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3B1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC04E20644
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFtH0FfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390237AbgFYHUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:20:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50902 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727830AbgFYHUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593069614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CLq2MmgBkwQdA7tBKh8EL9y99OE4HABuSltrOHqVjaU=;
        b=NFtH0FfDW9lIokzFVIsAV4huztejLuGcoWBMjEsJ6Ldf/m0N6q4PAcM3/MJFVVakK1kFw0
        u9rpUK4xBqB5lhpR0hiN41mXwbCu6inEqrtnuR0NnQi/F982Wy4pGgczkid2UO3kmTMsrI
        rRC21J2nqmm3AgRRPATcL6Ih/OlkfDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282--pyD8tLvOte3n3CZzL4_Hw-1; Thu, 25 Jun 2020 03:20:10 -0400
X-MC-Unique: -pyD8tLvOte3n3CZzL4_Hw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FDD418FE860;
        Thu, 25 Jun 2020 07:20:08 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F28D5C1D4;
        Thu, 25 Jun 2020 07:20:03 +0000 (UTC)
Date:   Thu, 25 Jun 2020 15:19:59 +0800
From:   Dave Young <dyoung@redhat.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Paul McKenney <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 0/3] printk: replace ringbuffer
Message-ID: <20200625071959.GA18744@dhcp-128-65.nay.redhat.com>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618144919.9806-1-john.ogness@linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,
On 06/18/20 at 04:55pm, John Ogness wrote:
> Hello,
> 
> Here is a v3 for the first series to rework the printk
> subsystem. The v2 and history are here [0]. This first series
> only replaces the existing ringbuffer implementation. No locking
> is removed. No semantics/behavior of printk are changed.
> 
> Reviews on the ringbuffer are still ongoing, but I was asked to
> post this new version since several changes from v2 have been
> already agreed upon.
> 
> The series is based on v5.8-rc1.

Do you have the kdump userspace part link so that people can try
and do some testing?

Eg. some makedumpfile/crash tool git branch etc.

Thanks
Dave

