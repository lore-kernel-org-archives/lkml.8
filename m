Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCACCC47259
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD56120721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnuwfUGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgEDTEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:04:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727828AbgEDTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588619043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UQThDJEUDr/92+sgwacANdF+cPlLZR5WZG2TjmvmO5M=;
        b=WnuwfUGrgjJc2w7ejIPJXSBueSKy39qIFQKNBmGAg2UHEhA5z+q2kOV+BfWwpqc50uSqz3
        Vg+3Fq855BuUWTMe1srRhdhp8pCROVTJ0xDQ6yr24GVquPXYdAuRM6viz/C0e7L27HXIZ3
        VzPRHQ3SDimxnEhnc+IgUi2wAuFWd1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-JW7jwDGzNVOEaAWa-UeBTw-1; Mon, 04 May 2020 15:03:55 -0400
X-MC-Unique: JW7jwDGzNVOEaAWa-UeBTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 846C5107ACF2;
        Mon,  4 May 2020 19:03:53 +0000 (UTC)
Received: from treble (ovpn-117-112.rdu2.redhat.com [10.10.117.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDDED63BBA;
        Mon,  4 May 2020 19:03:50 +0000 (UTC)
Date:   Mon, 4 May 2020 14:03:48 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     syzbot <syzbot+e73ceacfd8560cc8a3ca@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org, peterz@infradead.org,
        shile.zhang@linux.alibaba.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: BUG: stack guard page was hit in unwind_next_frame
Message-ID: <20200504190348.iphzmd7micvidh46@treble>
References: <0000000000005a8fe005a4b8a114@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000005a8fe005a4b8a114@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 11:36:11PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    8999dc89 net/x25: Fix null-ptr-deref in x25_disconnect
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=16004440100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b7a70e992f2f9b68
> dashboard link: https://syzkaller.appspot.com/bug?extid=e73ceacfd8560cc8a3ca
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e73ceacfd8560cc8a3ca@syzkaller.appspotmail.com

Infinite loop in network code.

#syz dup: BUG: stack guard page was hit in deref_stack_reg

-- 
Josh

