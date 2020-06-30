Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14594C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD01E20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBUNJpi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbgF3SaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:30:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41941 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732246AbgF3SaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593541809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7OCgH8gBQ1PrIfBItQcZbl5DDSqpXuCS2ZxQUU3Vu/M=;
        b=TBUNJpi1yshZvtnVEBuzYTn8Zl50rEtrZoY6A6/BTjQE/M25DLzT3NssHUX9OW5pnwpaxT
        DzLNsCmbArxP3B44GF21d/PfpKEaUqGy8rql26KvCJq1Rk5khonaFOEcr3PpJA9MQTuLIP
        F5A7FCNoWwZar6FyZ9lN/wlvXKjeeBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-vUlTpLERMYC5hy90eKi4ZQ-1; Tue, 30 Jun 2020 14:30:07 -0400
X-MC-Unique: vUlTpLERMYC5hy90eKi4ZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10F468900B9;
        Tue, 30 Jun 2020 18:29:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.165])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7BF3860C81;
        Tue, 30 Jun 2020 18:29:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Jun 2020 20:29:37 +0200 (CEST)
Date:   Tue, 30 Jun 2020 20:29:34 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss
 wakeup?
Message-ID: <20200630182933.GC26512@redhat.com>
References: <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
 <1593396958.ydiznwsuu8.astroid@bobo.none>
 <20200629140245.GB20323@redhat.com>
 <1593482844.k3rh7s05o8.astroid@bobo.none>
 <20200630061708.GA21263@redhat.com>
 <1593505946.t0nxq8q8kj.astroid@bobo.none>
 <20200630105354.GB23871@redhat.com>
 <20200630113637.GC23871@redhat.com>
 <20200630115052.GD23871@redhat.com>
 <CAHk-=wgfjK_-Wfkb6yXYpB5WfOv5yP2NiFO68yQfBfnzRu4yYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgfjK_-Wfkb6yXYpB5WfOv5yP2NiFO68yQfBfnzRu4yYQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30, Linus Torvalds wrote:
>
> On Tue, Jun 30, 2020 at 4:51 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 06/30, Oleg Nesterov wrote:
> > >
> > > may be someting like this
> >
> > or this ...
>
> Guys, I'd suggest we either
>
>  (a) do the minimal ugly one-liner workaround
>
> or
>
>  (b) do something *much* more radical.

I agree, and let me repeat I think your one-liner is fine.

I just tried to discuss the possible alternatives to that on-liner for the
start.

>    the wake_page_function() would actually do

I swear, I too thought about changing wake_page_function() but got lost ;)

The very fact it returns -1 if test_bit() is true suggests it can do more.

Oleg.

