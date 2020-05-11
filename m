Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801CFC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49DEE2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6vfjCtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbgEKRbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:31:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27597 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729698AbgEKRbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589218300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7lM8hUA0SbdYYpVAj09UaKq4AT4gRnDmZQFc7p0Moo=;
        b=i6vfjCtmOKlCvNoUHW62kMCslfaxoUwW4f7kWNkcUaGGZUI5th/6Xow5j5a26ggxKZ/kyw
        C4bOwF7rbSIYU9qp4b4vf2jfCiACEHAJfMqtEBsRR56Q33frfj9CoQTfR+1qVg1AdO0ZWG
        98jNM9D8dpcVU0Wj+ZIb/i+7xu0fTeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-gL6XFok0Oly971BA8NDF1Q-1; Mon, 11 May 2020 13:31:24 -0400
X-MC-Unique: gL6XFok0Oly971BA8NDF1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 851C819057A0;
        Mon, 11 May 2020 17:31:22 +0000 (UTC)
Received: from [10.10.116.128] (ovpn-116-128.rdu2.redhat.com [10.10.116.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC9E66606E;
        Mon, 11 May 2020 17:31:20 +0000 (UTC)
Subject: Re: INFO: task hung in do_read_cache_page (3)
To:     syzbot <syzbot+518c54e255b5031adde4@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, amir73il@gmail.com, axboe@kernel.dk,
        darrick.wong@oracle.com, jack@suse.cz, josef@toxicpanda.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, william.kucharski@oracle.com,
        willy@infradead.org
References: <000000000000dc82ac05a55f3005@google.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <c8f94666-3e55-2421-78c6-c2cdd0f24d16@redhat.com>
Date:   Mon, 11 May 2020 12:31:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <000000000000dc82ac05a55f3005@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/20 8:19 AM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 2da22da573481cc4837e246d0eee4d518b3f715e
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Tue Aug 13 16:39:52 2019 +0000
> 
>     nbd: fix zero cmd timeout handling v2
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d6ab14100000
> start commit:   e99332e7 gcc-10: mark more functions __init to avoid secti..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=13d6ab14100000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d6ab14100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8a96cf498e199d8b
> dashboard link: https://syzkaller.appspot.com/bug?extid=518c54e255b5031adde4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146e45ec100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164444a4100000
> 
> Reported-by: syzbot+518c54e255b5031adde4@syzkaller.appspotmail.com
> Fixes: 2da22da57348 ("nbd: fix zero cmd timeout handling v2")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

How do you adjust/modify what is expected from the test or what is
reported as an error?

The patch added back behavior that got removed. With the patch we expect
the hung task warnings, because we specifically want to hold onto
running commands for longer than 120/hung_task_timeout seconds

