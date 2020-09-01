Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242B2C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E43206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLMe4tJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgIAOX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:23:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24983 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728378AbgIAOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598970130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Y0ZrteiNrJb6k9e4lpZ12PcWMNDgdGxzuWKbLR2EBY=;
        b=FLMe4tJCeW11SiDvUQ682bn4sOdJ9nznqtRQP3TvZUrHPOgsn+oWrmGwks/SrjrWQxv4Jd
        YZHU7Ad1tVciltzewwIRm6/CrORi6zYEN4zfpghWLTbsUC1GbZlZ7CoiP9BWa1v8X172ab
        c3XywtjZnMEJBHtDkxqTg/A15GXI+kU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-Yi8POD7EOZqQR6RiEyu6Cg-1; Tue, 01 Sep 2020 10:22:06 -0400
X-MC-Unique: Yi8POD7EOZqQR6RiEyu6Cg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAC821005E5B;
        Tue,  1 Sep 2020 14:22:04 +0000 (UTC)
Received: from treble (ovpn-113-168.rdu2.redhat.com [10.10.113.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25C9261983;
        Tue,  1 Sep 2020 14:22:00 +0000 (UTC)
Date:   Tue, 1 Sep 2020 09:21:58 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200901142158.fo7tecobgki5hffa@treble>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <20200901140208.GA95447@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901140208.GA95447@C02TD0UTHF1T.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 03:02:08PM +0100, Mark Rutland wrote:
> d instead do user pointer
> > masking, throughout the x86 uaccess code.  This is similar to what arm64
> > is already doing.
> > 
> > barrier_nospec() is now unused, and can be removed.
> 
> One thing to consider is whether you need a speculation barrier after
> set_fs(). Otherwise for code like:
> 
> | fs = get_fs();
> | if (cond)
> |	set_fs(KERNEL_DS);
> | copy_to_user(...)
> | set_fs(fs)
> 
> ... the set_fs() can occur speculatively, and may be able to satisfy
> the masking logic if forwarded within the cpu.
> 
> See arm64 commit:
> 
>   c2f0ad4fc089cff8 ("arm64: uaccess: Prevent speculative use of the current addr_limit")

Do you have any examples of that conditional set_fs(KERNEL_DS) pattern?
I wasn't able to find any.

-- 
Josh

