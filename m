Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F105C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2F520678
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwV3CvFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgHaRb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:31:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34439 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgHaRb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598895085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++Z2k1CLJJEQVr6+YJnUx3Ct7gk/6T5NuBj1uBEDRc4=;
        b=QwV3CvFhcq1r/5EbGcdfjKRZlBrYYfDQyxHi3v4KmqjDu/oV+j6R7pp+/Zuz5myu3QNlOo
        qgzO+4sen/ZwdHehLbhgqtfwmYdeU3UWR/LuVeoPMUH+LjdW2kBgvWFokU+bTlOB39CdXP
        4Capd5nSa+HUn+blvo+3HZCQD7pvJd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-DGeXKp-wN72HTGQ-3GHGgA-1; Mon, 31 Aug 2020 13:31:21 -0400
X-MC-Unique: DGeXKp-wN72HTGQ-3GHGgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46438190150A;
        Mon, 31 Aug 2020 17:31:19 +0000 (UTC)
Received: from treble (ovpn-114-37.rdu2.redhat.com [10.10.114.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A7135C22B;
        Mon, 31 Aug 2020 17:31:14 +0000 (UTC)
Date:   Mon, 31 Aug 2020 12:31:12 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Al Viro' <viro@zeniv.linux.org.uk>,
        'Will Deacon' <will@kernel.org>,
        'Dan Williams' <dan.j.williams@intel.com>,
        'Andrea Arcangeli' <aarcange@redhat.com>,
        'Waiman Long' <longman@redhat.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Andrew Cooper' <andrew.cooper3@citrix.com>,
        'Andy Lutomirski' <luto@kernel.org>,
        'Christoph Hellwig' <hch@lst.de>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200831173112.fjfnnup5cfc5t226@treble>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <20200828192911.ezqspexfb2gtvrr7@treble>
 <f54657f1b5e74ec99cef62228db50dee@AcuMS.aculab.com>
 <56488b800d044a7e81efd8b40198a527@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56488b800d044a7e81efd8b40198a527@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 07:31:20PM +0000, David Laight wrote:
> > Rereading the patch it looks like a lot of bloat (as well as a
> > lot of changes).
> > Does the array_mask even work on 32bit archs where the kernel
> > base address is 0xc0000000?

Why wouldn't it on work on 32-bit?  My patch does have a minor compile
bug on 32-bit, but otherwise it seems to work (i.e., the asm looks ok,
and it boots).

> > I'm sure there is something much simpler.
> > 
> > If access_ok() generates ~0u or 0 without a conditional then
> > the address can be masked with the result.
> > So you probably need to change access_ok() to take the address
> > of the user pointer - so the callers become like:
> > 	if (access_ok(&user_buffer, len))
> > 		return -EFAULT
> > 	__put_user(user_buffer, value);
> > 
> > It would be easier if NULL were guaranteed to be an invalid
> > user address (is it?).
> > Then access_ok() could return the modified pointer.
> > So you get something like:
> > 	user_buffer = access_ok(user_buffer, len);
> > 	if (!user_buffer)
> > 		return -EFAULT.
> > 
> > Provided the 'last' user page is never allocated (it can't
> > be on i386 due to cpu prefetch issues) something like:
> > (and with the asm probably all broken)
> > 
> > static inline void __user * access_ok(void __user *b, size_t len)
> > {
> > 	unsigned long x = (long)b | (long)(b + len);
> > 	unsigned long lim = 64_bit ? 1u << 63 : 0x40000000;
> > 	asm volatile (" add %1, %0\n"
> > 			" sbb $0, %0", "=r" (x), "r" (lim));
> > 	return (void __user *)(long)b & ~x);
> > }
> 
> Actually, thinking further, if:
> 1) the access_ok() immediately precedes the user copy (as it should).
> 2) the user-copies use a sensible 'increasing address' copy.
> and
> 3) there is a 'guard page' between valid user and kernel addresses.
> Then access_ok() only need check the base address of the user buffer.

Yes, it would make sense to put the masking in access_ok() somehow.  But
to do it properly, I think we'd first need to make access_ok() generic.
Maybe that's do-able, but it would be a much bigger patch set.

First I'd prefer to just fix x86, like my patch does.  Then we could do
an access_ok() rework.

-- 
Josh

