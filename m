Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6937FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F312205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9C1i1hA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCXUIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:08:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42187 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgCXUIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585080534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cg1bshNNHRW3ykUec2v3AUO161Bty/S1WfQKMJCHQyI=;
        b=J9C1i1hARCM2HQhAvU/lVhNKMaY4KPJDLrQ+svoZYP/p2KRoO/S81oskf0+lumLNqoTRIR
        LbBYD71/d3spV/VFbM5JkcNcsPIVd/4Zo3AN7nDKU7bvfWguuHLN3vjUvImw8KF7g6o3P0
        6S9B5nOKPDYN4c85pQk1ZLywW/Gm+K8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-n8jB7OycMCCZE-IjZu-niw-1; Tue, 24 Mar 2020 16:08:52 -0400
X-MC-Unique: n8jB7OycMCCZE-IjZu-niw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DBF9800D53;
        Tue, 24 Mar 2020 20:08:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.27])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8467390A13;
        Tue, 24 Mar 2020 20:08:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 24 Mar 2020 21:08:50 +0100 (CET)
Date:   Tue, 24 Mar 2020 21:08:46 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/mqueue.c: change __do_notify() to bypass
 check_kill_permission()
Message-ID: <20200324200846.GA24230@redhat.com>
References: <20200322110901.GA25108@redhat.com>
 <87lfnsh3tm.fsf@x220.int.ebiederm.org>
 <20200322202929.GA1614@redhat.com>
 <87imivc92n.fsf@x220.int.ebiederm.org>
 <20200323191214.81a60c4ae1a59fdbd5c5d46d@linux-foundation.org>
 <87bloma29h.fsf@x220.int.ebiederm.org>
 <20200324115212.GA10095@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324115212.GA10095@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meanwhile, let me send V2. I added the comment and updated the changelog.

On 03/24, Oleg Nesterov wrote:
>
> On 03/23, Eric W. Biederman wrote:
> >
> > So far what we have is a report Oleg has read somewhere that some
> > program doing something regressed, and his patch to fix that specific
> > program.  This problem was not noticed for several years.
>
> Yes, this was reported on bugzilla.redhat.com, I'll add you to CC list.
>
> > Presumably the problem is that a message queue was written to by one
> > user and was read by another user to cause check_kill_permission to
> > fail. Can someone tell me if that was the case?
>
> I do not know. Yoji, did you hit this bug or did you find it by code
> inspection ?
>
> > So I am looking for something that makes it clear we are not removing
> > a permission checking and backporting a security hole.
>
> Yes, I thought about this too. I can be easily wrong, please correct me,
> but I came to conclusion the old behaviour (no permission check) is fine
> security-wise.
>
> > Further even if in the common case it is the right thing to do to remove
> > the permission check, the handling around exec looks bad enough that we
> > will be backporting a security hole if we don't fix that and backport
> > that at the same time.
>
> could you explain what exactly you do not like wrt mq_notify/exec ?
> I must have missed something.
>
> > p.s. I am grouchy as temporary fixes in this part of the code base
> >      don't tend to be temporary  and the entire signal/exec/ptrace world
> >      is bordering on unmaintainble and incomprehensible as a result.
>
> Eric, please feel free to make another fix you like more. I know that
> I can't convince you anyway, I won't argue.
> Oleg.

