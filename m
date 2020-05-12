Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DDDCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E94E620714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPI7y3TO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgELSQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:16:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57834 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725554AbgELSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589307383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2HLgLWCk5D57HVZ+uvIcCpH1wB/HDmsVSoFETytPIJs=;
        b=EPI7y3TOQZGiIhkA74N8g5X6O8CZAhhbUwuuUo2kpieCgBwV57QvIPvL0p8k+5Kba+i9r9
        2eQyrvb0UQg153AY2/pTB0oE9BRr0GQdN7kj32MgRVtnoOSTb1KKVqGEXwtc5H3k7RLklU
        8KZN/FQ6QFD43Nr3OQcFAFlW7/Fw9Cc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-s-C7O4x3MOSW07VI1tNIlw-1; Tue, 12 May 2020 14:16:18 -0400
X-MC-Unique: s-C7O4x3MOSW07VI1tNIlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37C8C107ACF4;
        Tue, 12 May 2020 18:16:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4F0981CC;
        Tue, 12 May 2020 18:16:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 12 May 2020 20:16:16 +0200 (CEST)
Date:   Tue, 12 May 2020 20:16:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        paulmck@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] kernel/sys: only rely on rcu for getpriority(2)
Message-ID: <20200512181613.GD28621@redhat.com>
References: <20200512000353.23653-1-dave@stgolabs.net>
 <20200512000353.23653-2-dave@stgolabs.net>
 <20200512150936.GA28621@redhat.com>
 <20200512160915.n3plwrwwrlpfqyrs@linux-p48b>
 <20200512164130.GC28621@redhat.com>
 <20200512165824.t6ktwllqlvkiingv@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512165824.t6ktwllqlvkiingv@linux-p48b>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12, Davidlohr Bueso wrote:
>
> Right, but setting the flag is an indication that the tasklist_lock
> will be taken

Yes,

> and removed from the list,

Well no. If this task is not a group leader, or if it is traced this won't
happen "soon", this will happen when parent or debugger call wait().

But this doesn't matter. Lets suppose that the task is always removed from
the list right after it sets PF_EXITING. Now,

> and therefore we could
> optimistically avoid considering that task altogether

Why?? This is what I can't understand.

If sys_getpriority() sees PF_EXITING, we can pretend it was called before
this task has exited, or even right before this flag was set. Why should we
skip this task?

And otoh, this check can not help in any case, PF_EXITING can be set right
after the check.

So I still think this check can only add the unnecessary confusion, even if
we forget about change in behaviour.

And finally, whatever I missed, I do not understand how this connects to
"avoid the tasklist_lock". Whether we want it or not does not depend on
the locking, at all.

Oleg.

